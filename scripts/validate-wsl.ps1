param(
    [string]$DistroName,
    [switch]$RunWslUpdate,
    [switch]$TestAptUpdate,
    [switch]$InstallDevTools,
    [switch]$InstallExtensions,
    [string]$ExpectedNodeMajor = '24'
)

$ErrorActionPreference = 'Stop'
$results = New-Object System.Collections.Generic.List[object]

function Add-Check {
    param(
        [string]$Name,
        [string]$Status,
        [string]$Details
    )

    $results.Add([PSCustomObject]@{
        Check   = $Name
        Status  = $Status
        Details = $Details
    }) | Out-Null
}

function Add-Pass {
    param([string]$Name, [string]$Details)
    Add-Check -Name $Name -Status 'PASS' -Details $Details
}

function Add-Fail {
    param([string]$Name, [string]$Details)
    Add-Check -Name $Name -Status 'FAIL' -Details $Details
}

function Add-Warn {
    param([string]$Name, [string]$Details)
    Add-Check -Name $Name -Status 'WARN' -Details $Details
}

function Test-CommandExists {
    param([string]$Name)
    return $null -ne (Get-Command $Name -ErrorAction SilentlyContinue)
}

function Invoke-WingetInstall {
    param(
        [string]$PackageId,
        [string]$FriendlyName
    )

    if (-not (Test-CommandExists -Name 'winget')) {
        Add-Fail -Name "Install $FriendlyName" -Details 'winget not found on this machine'
        return
    }

    try {
        $installOutput = & winget install --id $PackageId --exact --silent --accept-package-agreements --accept-source-agreements 2>&1
        if ($LASTEXITCODE -eq 0) {
            Add-Pass -Name "Install $FriendlyName" -Details "Installed or already present ($PackageId)"
        }
        else {
            Add-Fail -Name "Install $FriendlyName" -Details (($installOutput | Select-Object -First 3) -join ' | ')
        }
    }
    catch {
        Add-Fail -Name "Install $FriendlyName" -Details $_.Exception.Message
    }
}

function Invoke-Wsl {
    param(
        [string]$Command,
        [string]$TargetDistro
    )

    if ($TargetDistro) {
        return & wsl.exe -d $TargetDistro -- bash -lc $Command 2>&1
    }

    return & wsl.exe -- bash -lc $Command 2>&1
}

try {
    $os = Get-CimInstance Win32_OperatingSystem
    $build = [int]$os.BuildNumber
    $isSupported = $build -ge 19041
    if ($isSupported) {
        Add-Pass -Name 'Windows build supports modern WSL install' -Details "Build $build (requires 19041+)"
    }
    else {
        Add-Fail -Name 'Windows build supports modern WSL install' -Details "Build $build (requires 19041+)"
    }
}
catch {
    Add-Fail -Name 'Windows build supports modern WSL install' -Details $_.Exception.Message
}

try {
    $cpu = Get-CimInstance Win32_Processor | Select-Object -First 1
    $virt = [bool]$cpu.VirtualizationFirmwareEnabled
    if ($virt) {
        Add-Pass -Name 'Virtualization enabled in firmware' -Details "VirtualizationFirmwareEnabled=$virt"
    }
    else {
        Add-Fail -Name 'Virtualization enabled in firmware' -Details "VirtualizationFirmwareEnabled=$virt"
    }
}
catch {
    Add-Fail -Name 'Virtualization enabled in firmware' -Details $_.Exception.Message
}

$hasWsl = $false
try {
    $wslVersionOutput = & wsl.exe --version 2>&1
    $hasWsl = $LASTEXITCODE -eq 0
    if ($hasWsl) {
        Add-Pass -Name 'WSL command available' -Details (($wslVersionOutput | Select-Object -First 1) -join '')
    }
    else {
        Add-Fail -Name 'WSL command available' -Details (($wslVersionOutput | Select-Object -First 2) -join ' | ')
    }
}
catch {
    Add-Fail -Name 'WSL command available' -Details $_.Exception.Message
}

if ($InstallDevTools) {
    if (-not $hasWsl) {
        try {
            $installWslOutput = & wsl.exe --install 2>&1
            if ($LASTEXITCODE -eq 0) {
                Add-Warn -Name 'Install WSL' -Details 'wsl --install ran. A reboot is usually required before continuing.'
            }
            else {
                Add-Fail -Name 'Install WSL' -Details (($installWslOutput | Select-Object -First 3) -join ' | ')
            }
        }
        catch {
            Add-Fail -Name 'Install WSL' -Details $_.Exception.Message
        }
    }

    Invoke-WingetInstall -PackageId 'Microsoft.VisualStudioCode.Insiders' -FriendlyName 'VS Code Insiders'
}

$wslStatusSucceeded = $false
try {
    $statusOutput = & wsl.exe --status 2>&1
    $wslStatusSucceeded = $LASTEXITCODE -eq 0
    if ($wslStatusSucceeded) {
        Add-Pass -Name 'wsl --status succeeds' -Details (($statusOutput | Select-Object -First 2) -join ' | ')
    }
    else {
        Add-Fail -Name 'wsl --status succeeds' -Details (($statusOutput | Select-Object -First 2) -join ' | ')
    }
}
catch {
    Add-Fail -Name 'wsl --status succeeds' -Details $_.Exception.Message
}

$distros = @()
$selectedDistro = $null
try {
    $listOutput = & wsl.exe --list --verbose 2>&1
    if ($LASTEXITCODE -ne 0) {
        Add-Fail -Name 'wsl --list --verbose succeeds' -Details (($listOutput | Select-Object -First 2) -join ' | ')
    }
    else {
        Add-Pass -Name 'wsl --list --verbose succeeds' -Details 'Distro list retrieved'

        foreach ($line in $listOutput) {
            if ($line -match '^\s*NAME\s+STATE\s+VERSION\s*$') { continue }
            if ($line -match '^\s*-+\s*$') { continue }

            $clean = ($line -replace '^\s*\*?\s*', '').Trim()
            if ([string]::IsNullOrWhiteSpace($clean)) { continue }

            $parts = $clean -split '\s{2,}'
            if ($parts.Count -ge 3 -and $parts[-1] -match '^[12]$') {
                $distros += [PSCustomObject]@{
                    Name    = $parts[0]
                    State   = $parts[1]
                    Version = [int]$parts[2]
                }
            }
        }

        if ($distros.Count -eq 0) {
            Add-Fail -Name 'At least one distro installed' -Details 'No distros found in wsl --list --verbose output'
        }
        else {
            Add-Pass -Name 'At least one distro installed' -Details ($distros.Name -join ', ')

            if ($DistroName) {
                $selectedDistro = $distros | Where-Object { $_.Name -eq $DistroName } | Select-Object -First 1
                if ($null -ne $selectedDistro) {
                    Add-Pass -Name 'Requested distro exists' -Details "Requested: $DistroName"
                }
                else {
                    Add-Fail -Name 'Requested distro exists' -Details "Requested: $DistroName"
                }
            }

            if (-not $selectedDistro) {
                $selectedDistro = $distros | Select-Object -First 1
            }

            if ($selectedDistro) {
                if ($selectedDistro.Version -eq 2) {
                    Add-Pass -Name 'Selected distro is WSL 2' -Details "$($selectedDistro.Name): VERSION $($selectedDistro.Version)"
                }
                else {
                    Add-Fail -Name 'Selected distro is WSL 2' -Details "$($selectedDistro.Name): VERSION $($selectedDistro.Version)"
                }
            }
        }
    }
}
catch {
    Add-Fail -Name 'wsl --list --verbose succeeds' -Details $_.Exception.Message
}

if ($RunWslUpdate) {
    try {
        $updateOutput = & wsl.exe --update 2>&1
        if ($LASTEXITCODE -eq 0) {
            Add-Pass -Name 'wsl --update succeeds' -Details (($updateOutput | Select-Object -First 2) -join ' | ')
        }
        else {
            Add-Fail -Name 'wsl --update succeeds' -Details (($updateOutput | Select-Object -First 2) -join ' | ')
        }
    }
    catch {
        Add-Fail -Name 'wsl --update succeeds' -Details $_.Exception.Message
    }
}

if ($selectedDistro) {
    if ($InstallDevTools) {
        try {
            $nvmInstall = Invoke-Wsl -TargetDistro $selectedDistro.Name -Command "curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.40.1/install.sh | bash"
            if ($LASTEXITCODE -eq 0) {
                Add-Pass -Name 'Install nvm in WSL distro' -Details (($nvmInstall | Select-Object -First 2) -join ' | ')
            }
            else {
                Add-Fail -Name 'Install nvm in WSL distro' -Details (($nvmInstall | Select-Object -First 3) -join ' | ')
            }
        }
        catch {
            Add-Fail -Name 'Install nvm in WSL distro' -Details $_.Exception.Message
        }

        try {
            $nodeInstallCmd = "source \$HOME/.nvm/nvm.sh && nvm install --lts && node --version && npm --version"
            $nodeInstall = Invoke-Wsl -TargetDistro $selectedDistro.Name -Command $nodeInstallCmd
            if ($LASTEXITCODE -eq 0) {
                Add-Pass -Name 'Install Node.js LTS via nvm in WSL distro' -Details (($nodeInstall | Select-Object -First 3) -join ' | ')
            }
            else {
                Add-Fail -Name 'Install Node.js LTS via nvm in WSL distro' -Details (($nodeInstall | Select-Object -First 3) -join ' | ')
            }
        }
        catch {
            Add-Fail -Name 'Install Node.js LTS via nvm in WSL distro' -Details $_.Exception.Message
        }

        try {
            $gitInstall = Invoke-Wsl -TargetDistro $selectedDistro.Name -Command "sudo apt update && sudo apt install git -y && git --version"
            if ($LASTEXITCODE -eq 0) {
                Add-Pass -Name 'Install Git in WSL distro' -Details (($gitInstall | Select-Object -Last 1) -join '')
            }
            else {
                Add-Fail -Name 'Install Git in WSL distro' -Details (($gitInstall | Select-Object -First 3) -join ' | ')
            }
        }
        catch {
            Add-Fail -Name 'Install Git in WSL distro' -Details $_.Exception.Message
        }

        try {
            $ghInstall = Invoke-Wsl -TargetDistro $selectedDistro.Name -Command "sudo apt install gh -y && gh --version"
            if ($LASTEXITCODE -eq 0) {
                Add-Pass -Name 'Install GitHub CLI in WSL distro' -Details (($ghInstall | Select-Object -First 1) -join '')
            }
            else {
                Add-Fail -Name 'Install GitHub CLI in WSL distro' -Details (($ghInstall | Select-Object -First 3) -join ' | ')
            }
        }
        catch {
            Add-Fail -Name 'Install GitHub CLI in WSL distro' -Details $_.Exception.Message
        }

        try {
            $azInstall = Invoke-Wsl -TargetDistro $selectedDistro.Name -Command "curl -sL https://aka.ms/InstallAzureCLIDeb | sudo bash && az --version"
            if ($LASTEXITCODE -eq 0) {
                Add-Pass -Name 'Install Azure CLI in WSL distro' -Details 'Azure CLI installed and version command succeeded'
            }
            else {
                Add-Fail -Name 'Install Azure CLI in WSL distro' -Details (($azInstall | Select-Object -First 3) -join ' | ')
            }
        }
        catch {
            Add-Fail -Name 'Install Azure CLI in WSL distro' -Details $_.Exception.Message
        }

        if ($InstallExtensions) {
            if (Test-CommandExists -Name 'code-insiders') {
                $extensionIds = @(
                    'GitHub.copilot',
                    'GitHub.copilot-chat',
                    'ms-vscode-remote.remote-wsl',
                    'GitHub.vscode-pull-request-github',
                    'ms-vscode.vscode-node-azure-pack',
                    'ms-azuretools.vscode-azure-github-copilot',
                    'dbaeumer.vscode-eslint',
                    'esbenp.prettier-vscode',
                    'bradlc.vscode-tailwindcss',
                    'antfu.vite'
                )

                foreach ($extensionId in $extensionIds) {
                    try {
                        $extInstall = & code-insiders --install-extension $extensionId 2>&1
                        if ($LASTEXITCODE -eq 0) {
                            Add-Pass -Name "Install VS Code extension $extensionId" -Details 'Installed or already present'
                        }
                        else {
                            Add-Fail -Name "Install VS Code extension $extensionId" -Details (($extInstall | Select-Object -First 2) -join ' | ')
                        }
                    }
                    catch {
                        Add-Fail -Name "Install VS Code extension $extensionId" -Details $_.Exception.Message
                    }
                }
            }
            else {
                Add-Fail -Name 'Install VS Code extensions' -Details 'code-insiders command not found in PATH'
            }
        }
    }

    try {
        $nodeCheckCmd = "source \$HOME/.nvm/nvm.sh 2>/dev/null; node --version"
        $nodeVersion = Invoke-Wsl -TargetDistro $selectedDistro.Name -Command $nodeCheckCmd
        if ($LASTEXITCODE -eq 0) {
            $versionLine = (($nodeVersion | Select-Object -First 1) -join '').Trim()
            if ($versionLine -match '^v(\d+)\.') {
                $major = $Matches[1]
                if ($major -eq $ExpectedNodeMajor) {
                    Add-Pass -Name "Node major version matches lab expectation (v$ExpectedNodeMajor)" -Details $versionLine
                }
                else {
                    Add-Warn -Name "Node major version matches lab expectation (v$ExpectedNodeMajor)" -Details "Found $versionLine"
                }
            }
            else {
                Add-Warn -Name "Node major version matches lab expectation (v$ExpectedNodeMajor)" -Details "Could not parse: $versionLine"
            }
        }
        else {
            Add-Fail -Name "Node major version matches lab expectation (v$ExpectedNodeMajor)" -Details 'node --version failed in WSL distro'
        }
    }
    catch {
        Add-Fail -Name "Node major version matches lab expectation (v$ExpectedNodeMajor)" -Details $_.Exception.Message
    }

    if ($TestAptUpdate) {
        try {
            $aptOutput = Invoke-Wsl -TargetDistro $selectedDistro.Name -Command "sudo apt update"
            if ($LASTEXITCODE -eq 0) {
                Add-Pass -Name 'apt update in distro succeeds' -Details (($aptOutput | Select-Object -First 2) -join ' | ')
            }
            else {
                Add-Fail -Name 'apt update in distro succeeds' -Details (($aptOutput | Select-Object -First 2) -join ' | ')
            }
        }
        catch {
            Add-Fail -Name 'apt update in distro succeeds' -Details $_.Exception.Message
        }
    }

    try {
        $gitVersion = Invoke-Wsl -TargetDistro $selectedDistro.Name -Command "git --version"
        if ($LASTEXITCODE -eq 0) {
            Add-Pass -Name 'git --version works in WSL distro' -Details (($gitVersion | Select-Object -First 1) -join '')
        }
        else {
            Add-Fail -Name 'git --version works in WSL distro' -Details (($gitVersion | Select-Object -First 1) -join '')
        }
    }
    catch {
        Add-Fail -Name 'git --version works in WSL distro' -Details $_.Exception.Message
    }

    try {
        $ghVersion = Invoke-Wsl -TargetDistro $selectedDistro.Name -Command "gh --version"
        if ($LASTEXITCODE -eq 0) {
            Add-Pass -Name 'gh --version works in WSL distro' -Details (($ghVersion | Select-Object -First 1) -join '')
        }
        else {
            Add-Warn -Name 'gh --version works in WSL distro' -Details 'GitHub CLI not installed yet (run -InstallDevTools)'
        }
    }
    catch {
        Add-Warn -Name 'gh --version works in WSL distro' -Details 'GitHub CLI not installed yet (run -InstallDevTools)'
    }

    try {
        $azVersion = Invoke-Wsl -TargetDistro $selectedDistro.Name -Command "az --version"
        if ($LASTEXITCODE -eq 0) {
            Add-Pass -Name 'az --version works in WSL distro' -Details 'Azure CLI available'
        }
        else {
            Add-Warn -Name 'az --version works in WSL distro' -Details 'Azure CLI not installed yet (run -InstallDevTools)'
        }
    }
    catch {
        Add-Warn -Name 'az --version works in WSL distro' -Details 'Azure CLI not installed yet (run -InstallDevTools)'
    }
}
else {
    Add-Fail -Name 'Select distro for in-WSL validation' -Details 'No WSL distro available; complete Lab 1 first'
}

if (-not (Test-CommandExists -Name 'code-insiders')) {
    Add-Warn -Name 'code-insiders command available in Windows PATH' -Details 'Install VS Code Insiders and ensure Add to PATH is enabled'
}
else {
    Add-Pass -Name 'code-insiders command available in Windows PATH' -Details 'VS Code Insiders CLI detected'
}

Add-Warn -Name 'Manual step required: GitHub Copilot sign-in' -Details 'Complete in VS Code UI (cannot be fully validated non-interactively)'
Add-Warn -Name 'Manual step required: SSH key add + auth test' -Details 'Run ssh-keygen and add key in github.com/settings/keys, then ssh -T git@github.com'
Add-Warn -Name 'Manual step required: az login / gh auth login' -Details 'Browser-based auth required; validate manually in VM session'

$results | Format-Table -AutoSize

$failed = ($results | Where-Object Status -eq 'FAIL').Count
$warned = ($results | Where-Object Status -eq 'WARN').Count

if ($failed -gt 0) {
    Write-Host "`nValidation failed: $failed check(s) failed, $warned warning(s)." -ForegroundColor Red
    exit 1
}

if ($warned -gt 0) {
    Write-Host "`nValidation passed with warnings: $warned warning(s)." -ForegroundColor Yellow
    exit 0
}

Write-Host "`nValidation passed." -ForegroundColor Green
exit 0
