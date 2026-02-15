# Essential VS Code Extensions Checklist

> **Purpose**: Use this checklist to verify you have all necessary VS Code extensions installed in your WSL environment for vibe coding with TypeScript, React, and Azure.

---

## Quick Verification

Open VS Code Extensions panel: **Ctrl+Shift+X**

![VS Code Extensions panel showing LOCAL vs WSL installed extensions](images/vscode-extensions-panel.png)

**Important**: When connected to WSL, verify extensions are installed in **"WSL: UBUNTU - INSTALLED"**, not "LOCAL - INSTALLED".

---

## Core Development Extensions

### ✅ GitHub Copilot Suite (Required)
- [ ] **GitHub Copilot** — AI code completion and generation
- [ ] **GitHub Copilot Chat** — Conversational AI assistance
- [ ] **GitHub Actions** — CI/CD workflow management

**Why**: These are the foundation of vibe coding. Copilot generates code, Chat handles questions and debugging, Actions manages deployment.

---

### ✅ Language Support (Required)
- [ ] **TypeScript and JavaScript Language Features** (Built-in, verify enabled)
- [ ] **ESLint** — Code quality and error detection
- [ ] **Prettier - Code formatter** — Consistent code formatting

**Why**: TypeScript powers your type safety, ESLint catches errors before runtime, Prettier keeps code readable.

**How to Verify**:
```bash
# In VS Code terminal
npx eslint --version
npx prettier --version
```

---

### ✅ Framework & Build Tools (Required)
- [ ] **Vite** — Modern build tool support (syntax highlighting for vite.config.ts)
- [ ] **Tailwind CSS IntelliSense** — Autocomplete for Tailwind classes
- [ ] **ES7+ React/Redux/React-Native snippets** — React component snippets

**Why**: Vite extension helps with config files, Tailwind IntelliSense shows class previews, React snippets speed up component creation.

---

### ✅ Azure & Cloud (Required for Deployment)
- [ ] **Azure Account** — Sign in to Azure services
- [ ] **Azure Resources** — Manage Azure resources from VS Code
- [ ] **Azure Static Web Apps** — Deploy and manage Static Web Apps

**Why**: Deploy your vibe-coded apps directly to Azure from VS Code without leaving your editor.

**How to Verify**:
```bash
# In VS Code terminal
az --version
```

---

### ✅ Git & Version Control (Required)
- [ ] **GitLens** — Enhanced Git capabilities (blame, history, compare)
- [ ] **Git History** — View file and line history
- [ ] **GitHub Pull Requests and Issues** — Manage PRs directly in VS Code

**Why**: GitLens shows who changed what and when, Git History helps track file evolution, GitHub extension integrates PR workflows.

---

### ✅ Testing & Quality (Recommended)
- [ ] **Vitest** — Test runner integration (if using Vitest)
- [ ] **Jest Runner** — Alternative if using Jest
- [ ] **Error Lens** — Inline error highlighting

**Why**: See test results inline, run specific tests quickly, spot errors without opening Problems panel.

---

## Optional But Helpful Extensions

### 🔧 Productivity Enhancers
- [ ] **Auto Rename Tag** — Automatically rename paired HTML/JSX tags
- [ ] **Bracket Pair Colorizer 2** — Color-matched bracket pairs
- [ ] **Path Intellisense** — Autocomplete file paths in imports
- [ ] **Import Cost** — Show size of imported packages

**Why**: Auto Rename Tag saves time on refactors, Bracket Pair makes nested code readable, Path Intellisense reduces typos, Import Cost prevents bloated bundles.

---

### 📦 MCP Servers (Advanced)
- [ ] **MCP Server: Microsoft Learn** — Access Microsoft documentation
- [ ] **MCP Server: Context7** — Library documentation integration
- [ ] **MCP Server: Azure** — Azure resource management
- [ ] **MCP Server: GitHub** — GitHub API integration
- [ ] **MCP Server: Playwright** — Browser testing automation

**Why**: MCP servers give Copilot access to live documentation and external tools, making suggestions more accurate and context-aware.

**How to Verify**: Check the **"MCP SERVERS"** section in your Extensions panel (see screenshot above).

---

## Installation Commands

If you're missing extensions, install them from the terminal:

```bash
# GitHub Copilot Suite
code --install-extension GitHub.copilot
code --install-extension GitHub.copilot-chat
code --install-extension GitHub.vscode-github-actions

# Language Support
code --install-extension dbaeumer.vscode-eslint
code --install-extension esbenp.prettier-vscode

# Framework Tools
code --install-extension antfu.vite
code --install-extension bradlc.vscode-tailwindcss
code --install-extension dsznajder.es7-react-js-snippets

# Azure Tools
code --install-extension ms-vscode.azure-account
code --install-extension ms-azuretools.vscode-azureresourcegroups
code --install-extension ms-azuretools.vscode-azurestaticwebapps

# Git Tools
code --install-extension eamodio.gitlens
code --install-extension donjayamanne.githistory
code --install-extension GitHub.vscode-pull-request-github

# Testing (choose one or both)
code --install-extension ZixuanChen.vitest-explorer
code --install-extension Orta.vscode-jest

# Productivity
code --install-extension formulahendry.auto-rename-tag
code --install-extension CoenraadS.bracket-pair-colorizer-2
code --install-extension christian-kohler.path-intellisense
code --install-extension wix.vscode-import-cost
```

**Note**: These commands work in both Windows and WSL terminal. When connected to WSL, extensions install directly into WSL.

---

## Verification Checklist

After installation, verify everything works:

### ✅ Copilot Verification
1. Open any `.ts` or `.tsx` file
2. Type `function hello` and wait
3. **Expected**: Gray suggestion appears (Copilot inline completion)
4. Press **Tab** to accept

### ✅ Copilot Chat Verification
1. Press **Ctrl+Shift+I** to open Copilot Chat
2. Type: "Explain what vibe coding is"
3. **Expected**: Copilot responds with an explanation

### ✅ Tailwind IntelliSense Verification
1. Open any `.tsx` file
2. Type `<div className="bg-` and wait
3. **Expected**: Color-coded class suggestions appear

### ✅ ESLint Verification
1. Open any `.ts` file
2. Type `const x = 5` and save (without using `x`)
3. **Expected**: Yellow warning appears: "x is assigned a value but never used"

### ✅ Azure CLI Verification
1. Open VS Code terminal
2. Run: `az --version`
3. **Expected**: Version number displays (e.g., "azure-cli 2.57.0")

### ✅ MCP Servers Verification
1. Open Copilot Chat (**Ctrl+Shift+I**)
2. Click the **paperclip icon** (attach context)
3. **Expected**: See MCP server options (Microsoft Learn, Context7, Azure, GitHub, Playwright)

---

## Common Issues

### Extensions Not Showing in WSL
**Problem**: Extensions installed on Windows (LOCAL) but not available in WSL.

**Solution**:
1. Open Extensions panel (**Ctrl+Shift+X**)
2. Find the extension in "LOCAL - INSTALLED"
3. Click **"Install in WSL: Ubuntu"** button

### Copilot Not Suggesting Code
**Problem**: No gray suggestions appear when typing.

**Solution**:
1. Check Copilot status icon (bottom-right status bar)
2. If red or yellow, click it and sign in again
3. Verify: **Ctrl+Shift+P** → type "Copilot: Sign In"

### Tailwind Classes Not Autocompleting
**Problem**: No class suggestions when typing `className=`.

**Solution**:
1. Verify `tailwind.config.ts` exists in project root
2. Restart VS Code (**Ctrl+Shift+P** → "Developer: Reload Window")
3. Check "Tailwind CSS IntelliSense" is enabled

### MCP Servers Not Appearing
**Problem**: MCP servers section is empty or missing.

**Solution**:
1. Verify MCP servers are configured in `.github/copilot-instructions.md`
2. Restart Copilot: **Ctrl+Shift+P** → "Copilot: Restart Extension Host"
3. Check Lab 4 setup instructions

---

## Next Steps

Once you've verified all essential extensions:

1. ✅ **Proceed to Lab 4** — Configure MCP servers
2. ✅ **Proceed to Lab 5** — Customize Copilot instructions
3. ✅ **Proceed to Lab 6** — Start vibe coding your first project

---

## Extension Management Tips

### Keep Extensions Updated
```bash
# Update all extensions
code --update-extensions
```

### Disable Unused Extensions (Performance)
1. Open Extensions panel (**Ctrl+Shift+X**)
2. Right-click extension → **"Disable"**
3. Only keep what you actively use

### Workspace-Specific Extensions
1. Open Extensions panel
2. Right-click extension → **"Add to Workspace Recommendations"**
3. Creates `.vscode/extensions.json` for team sharing

---

**Last Updated**: February 15, 2026
**Compatibility**: VS Code 1.85+, WSL 2, Ubuntu 22.04+
