# Vibe Coding in TypeScript: Complete YouTube Tutorial Transcript

> **Optimized for**: ElevenLabs Text-to-Speech API
> **Voice Recommendation**: Conversational, energetic, friendly (e.g., "Adam" or "Antoni")
> **Estimated Runtime**: ~4-5 hours (segmented into chapters)
> **Video Format**: Screen recording + narration walkthrough

---

## Transcript Conventions

- `[VISUAL: description]` — Insert screen recording or screenshot
- `[PAUSE]` — Natural pause for pacing (1-2 seconds)
- `[SECTION BREAK]` — Chapter marker for video editing
- `**emphasis**` — Slight vocal emphasis
- Numbers/commands spoken naturally (e.g., "Node.js twenty-four" not "Node.js two four")

---

## [INTRO SEGMENT - 0:00 to 2:30]

### Opening (Energetic, welcoming)

Hey there! Welcome to the complete vibe coding tutorial. I'm going to show you how to build real, professional web applications using artificial intelligence — specifically, GitHub Copilot — even if you've never written a single line of code before.

[PAUSE]

By the end of this tutorial, you'll have a fully deployed web app running on Microsoft Azure, with automated testing, continuous deployment, and even the option to publish it to Power Apps. And here's the best part: **you're going to describe what you want in plain English**, and the AI will write the code for you.

[PAUSE]

Now, this isn't magic. You'll still need to understand what's happening. You'll read the code, test it, and guide the AI — think of yourself as the architect, and GitHub Copilot as your junior developer. But instead of memorizing syntax and fighting with Stack Overflow, you'll be building and shipping real apps.

[VISUAL: Show final deployed app running on Azure]

[PAUSE]

This tutorial is broken into nine labs. You can follow along at your own pace, pause whenever you need to, and come back to sections as needed. Here's what we're going to cover:

[VISUAL: Show lab roadmap diagram]

Lab one: Setting up Windows Subsystem for Linux, which gives you the professional developer environment on Windows.

Lab two: Installing Visual Studio Code Insiders and all the extensions you need.

Lab three: Getting GitHub set up with Git, SSH keys, and the command line tools.

Lab four: Configuring five MCP servers — these are like plugins that supercharge Copilot with access to documentation, Azure, and more.

Lab five: This is where it gets really good. We'll customize Copilot with instruction files that teach it your project's conventions and patterns.

Lab six: Vibe coding your first project — describing features in plain English and watching GitHub Copilot build them.

Lab seven: Deploying to Azure Static Web Apps so your app is live on the internet.

Lab eight: Setting up continuous integration and continuous deployment with GitHub Actions — automated testing and deployment every time you push code.

And lab nine is optional: Publishing your app to Power Platform as a code app with enterprise features.

[PAUSE]

Alright, let's get started!

[SECTION BREAK]

---

## [LAB 1 SEGMENT - 2:30 to 15:00]

### Lab 1 Introduction

Lab one is all about setting up Windows Subsystem for Linux — or WSL for short.

[PAUSE]

Now, you might be wondering, "Why do I need Linux on Windows? I'm building a web app, not a server." Great question. Here's the thing: professional developers overwhelmingly use Linux or Mac because the tools just work better. Node.js, Git, build tools — they all run faster and more reliably on Linux.

[VISUAL: Show diagram of Windows → WSL → Ubuntu → Developer tools]

WSL Two gives you a full Ubuntu Linux environment running inside Windows Eleven. You get the power and compatibility of Linux, without dual-booting or running a virtual machine. It's fast, it's integrated, and once you set it up, you'll never think about it again.

[PAUSE]

### Prerequisites Check

Before we start, make sure you have Windows Eleven, or Windows Ten version twenty oh four or newer. You'll also need administrator access to run PowerShell commands. And virtualization needs to be enabled in your BIOS — most modern computers have this on by default, but if WSL doesn't install, that's the first thing to check.

[PAUSE]

### Step 1.1: Installing WSL

Alright, let's do this. Press the Windows key, type "PowerShell," **right-click it**, and select "Run as administrator." This is important — you need admin privileges.

[VISUAL: Screen recording of opening PowerShell as admin]

Once PowerShell opens, you'll see a blue window with a command prompt. Now type exactly this:

```
wsl --install
```

That's W-S-L space dash dash install. Hit Enter.

[VISUAL: Screen recording of running wsl --install command]

[PAUSE]

You'll see Windows downloading and installing WSL Two, along with Ubuntu Linux. This takes a few minutes, so just let it run. You'll see progress indicators as it downloads the Ubuntu distribution and sets everything up.

[PAUSE]

When it's done, you'll see a message that says "The operation completed successfully." Now here's the critical step: **restart your computer**. WSL won't work until you reboot. Go ahead and restart now.

[PAUSE - Extended for user to restart]

### Step 1.2: First Boot and User Setup

[After restart segment]

Okay, you're back from the restart. When Windows boots up, Ubuntu should launch automatically in a terminal window. If it doesn't, just press the Windows key, type "Ubuntu," and open it.

[VISUAL: Screen recording of Ubuntu first launch]

The first time Ubuntu runs, it needs to do some setup. You'll see it say "Installing, this may take a few minutes." Just wait for it.

[PAUSE]

After installation finishes, Ubuntu will ask you to create a username. This is your Linux user — it's completely separate from your Windows login. Pick something simple, like your first name in lowercase. No spaces, no special characters. Type it in and press Enter.

[VISUAL: Show entering username]

Next, it'll ask for a password. **Type carefully** — you won't see anything as you type, no dots or asterisks, nothing. This is a Linux security feature. Type your password, press Enter, then type it again to confirm.

[PAUSE]

Got it? Great. Now you have a Linux terminal. This is where a lot of our work will happen. Don't be intimidated by the command line — I'll walk you through every single command.

### Step 1.3: Updating Ubuntu

First thing we do in any new Linux system: update the package lists. Type this command:

```
sudo apt update && sudo apt upgrade -y
```

Let me break that down. "Sudo" means "super user do" — it gives you admin privileges. "Apt" is the package manager. "Update" refreshes the list of available software. "Upgrade" installs any updates. And that "dash y" at the end just says "yes" to all the prompts automatically.

[VISUAL: Screen recording of apt update command running]

Press Enter and let it run. You might be asked for your password — the one you just created. Type it in (again, you won't see it) and press Enter.

[PAUSE]

This'll take a minute or two. You'll see a bunch of text scrolling by — that's totally normal. Linux is just being verbose about what it's doing.

### Step 1.4: Verifying WSL Version

Alright, updates are done. Now let's verify you're actually running WSL Two and not WSL One. Go back to PowerShell — you can leave Ubuntu open, just open a new PowerShell window.

In PowerShell, type:

```
wsl --list --verbose
```

That's W-S-L space dash dash list space dash dash verbose. Hit Enter.

[VISUAL: Screen recording of wsl --list --verbose output]

You should see a table showing "Ubuntu" and under "VERSION," it should say **two**. If it says one, we need to convert it. Copy the name exactly as it appears — it might say "Ubuntu" or "Ubuntu-22.04" — and run this command:

```
wsl --set-version Ubuntu 2
```

Replace "Ubuntu" with whatever name you saw. This conversion takes a few minutes.

[PAUSE]

Once it's done, run `wsl --list --verbose` again to confirm it now says version two.

### Lab 1 Checkpoint

Perfect! Let's recap what you've accomplished:

[VISUAL: Show checklist with green checkmarks]

✓ WSL Two is installed and running
✓ Ubuntu Linux is set up with your user account
✓ System packages are updated
✓ You've confirmed you're on WSL version two

[PAUSE]

You now have a professional developer environment on Windows. This is the same setup used by developers at Microsoft, Google, and startups around the world. You should feel good about this — you just leveled up your computer.

[SECTION BREAK]

---

## [LAB 2 SEGMENT - 15:00 to 30:00]

### Lab 2 Introduction

Lab two is all about Visual Studio Code Insiders — the code editor where you'll spend most of your time. Now, you might've heard of "Visual Studio Code" or "VS Code." We're using **VS Code Insiders**, which is the preview version that gets new features early.

[PAUSE]

Why does that matter? Because GitHub Copilot features land in Insiders weeks or even months before the stable version. We want the latest and greatest AI tools, so we're using Insiders.

[VISUAL: Show VS Code Insiders logo and interface]

### Step 2.1: Downloading and Installing

Open your web browser and go to code dot visual studio dot com slash insiders. That's:

```
code.visualstudio.com/insiders
```

[VISUAL: Screen recording of navigating to download page]

Click the big download button for Windows. The installer is about seventy megabytes, so it downloads quickly.

[PAUSE]

Once it's downloaded, run the installer. During setup, you'll see some checkboxes. **This is important** — make sure you check these boxes:

- Add "Open with Code - Insiders" to the file context menu
- Add "Open with Code - Insiders" to the directory context menu
- Add to PATH

[VISUAL: Show installer with checkboxes highlighted]

That last one, "Add to PATH," lets you launch VS Code from the command line. Super useful.

Click Next, Next, Install, and let it run.

[PAUSE]

### Step 2.2: Connecting VS Code to WSL

Alright, VS Code Insiders is installed. Launch it — you'll see a welcome screen. Now here's the magic: we're going to connect VS Code to your WSL Ubuntu environment.

Press `Control plus Shift plus P`. This opens the **Command Palette** — think of it as a search bar for every single thing VS Code can do.

[VISUAL: Show Command Palette opening]

Type "WSL" and you'll see "WSL: Connect to WSL." Click it.

[VISUAL: Screen recording of connecting to WSL]

VS Code will reload, and you'll see "WSL: Ubuntu" in the bottom-left corner. That means you're now editing files inside your Linux environment. This is huge — you get the power of Linux with the comfort of a graphical Windows app.

### Step 2.3: Installing Extensions

Now for the fun part: extensions. Extensions are plugins that give VS Code superpowers. We're installing ten extensions. I'll go through them one by one, but you can also use the command line to install them all at once.

Let me show you both ways.

#### Manual Extension Install

Click the Extensions icon on the left sidebar — it looks like four squares. Or press `Control plus Shift plus X`.

[VISUAL: Show Extensions panel]

In the search bar at the top, type "GitHub Copilot" and hit Enter. You'll see "GitHub Copilot" by GitHub — the purple icon. Click **Install**.

[PAUSE]

Repeat this for:

- GitHub Copilot Chat
- WSL
- GitHub Pull Requests and Issues
- Azure Tools
- GitHub Copilot for Azure
- ESLint
- Prettier
- Tailwind CSS IntelliSense
- Vite

[VISUAL: Show each extension installing with quick cuts]

#### Fast Command-Line Install

Or, if you want to speed this up, open the VS Code terminal — press Control plus backtick, that's the key above Tab — and paste these commands:

```bash
code-insiders --install-extension GitHub.copilot
code-insiders --install-extension GitHub.copilot-chat
code-insiders --install-extension ms-vscode-remote.remote-wsl
code-insiders --install-extension GitHub.vscode-pull-request-github
code-insiders --install-extension ms-vscode.vscode-node-azure-pack
code-insiders --install-extension ms-azuretools.vscode-azure-github-copilot
code-insiders --install-extension dbaeumer.vscode-eslint
code-insiders --install-extension esbenp.prettier-vscode
code-insiders --install-extension bradlc.vscode-tailwindcss
code-insiders --install-extension antfu.vite
```

[VISUAL: Screen recording of running install commands]

Just paste them in, hit Enter, and let them install. Takes about thirty seconds total.

### Understanding Your Extensions

Now let me show you something important about how extensions work in VS Code when you're connected to WSL.

[VISUAL: **INSERT SCREENSHOT - vscode-extensions-panel.png**]

Open the Extensions panel — click that puzzle piece icon on the left sidebar, or press Control plus Shift plus X.

[PAUSE]

Notice how extensions are organized into sections. You've got "LOCAL - INSTALLED" at the top with twenty-four extensions. These run on Windows. Below that, "WSL: UBUNTU - INSTALLED" with fifty-five extensions. These run inside Linux.

[PAUSE]

Here's the key thing: **when you're connected to WSL**, which you should be whenever you're coding, you want your development extensions in the WSL section, not LOCAL.

Why? Because these extensions need to access your project files. Your project files are in Linux. If an extension runs on Windows (LOCAL), it has to go through translation layers to read Linux files. That's slow and sometimes doesn't work right.

[VISUAL: Highlight the "WSL: UBUNTU - INSTALLED" section with 55 extensions]

So when you install GitHub Copilot, ESLint, Prettier, any development tool — make sure you're connected to WSL first. That way it installs in the right place.

[PAUSE]

Now, scroll down to the bottom. See that "MCP SERVERS - INSTALLED" section?

[VISUAL: Zoom in on the MCP SERVERS section showing Azure MCP Server and Context7]

These are the Model Context Protocol servers we'll install in Lab Four. Azure MCP Server gives GitHub Copilot access to your Azure cloud resources. Context7 lets GitHub Copilot fetch the latest documentation for any programming library.

You can click the gear icon next to each one to configure settings or verify they're running.

[PAUSE]

The "RECOMMENDED" section in the middle? That's VS Code being smart. It looks at your project files and suggests extensions that might help. You don't have to install these, but they're often useful. Git History, GitLens, edge tools — all solid choices.

[PAUSE]

Alright, so now you understand how the Extensions panel works, how to tell where extensions are installed, and what those MCP servers are at the bottom.

### Step 2.4: Signing Into GitHub Copilot

Extensions installed? Great. Now let's activate GitHub Copilot. Look in the bottom-left corner of VS Code — you'll see a little account icon. Click it.

[VISUAL: Show account icon location]

Select "Sign in with GitHub to use GitHub Copilot." A browser window will open asking you to authorize VS Code. Click "Authorize."

[PAUSE]

Now, here's the thing: **GitHub Copilot requires a subscription**. There's a free tier with limited completions, or Copilot Pro for unlimited access at ten dollars a month. If you're serious about vibe coding, the Pro tier is worth every penny. You can sign up at github dot com slash features slash copilot.

[VISUAL: Show Copilot pricing page]

Once you're signed in, you should see a Copilot icon in the bottom-right of VS Code. If you see it, you're good to go.

### Lab 2 Checkpoint

Let's recap:

[VISUAL: Checklist with checkmarks]

✓ VS Code Insiders installed
✓ Connected to WSL Ubuntu
✓ Ten extensions installed
✓ Signed in to GitHub Copilot

You now have a professional code editor with AI pair programming built right in. This is the same setup professional developers use, and you just configured it yourself. Nice work!

[SECTION BREAK]

---

## [LAB 3 SEGMENT - 30:00 to 50:00]

### Lab 3 Introduction

Lab three covers Node.js, Git, GitHub, and all the command-line tools we'll need. This is where we turn your environment from "empty Linux box" into "professional development machine."

[PAUSE]

Don't worry if you're not familiar with the command line. I'll explain every command, and by the end of this lab, you'll feel comfortable navigating in the terminal.

### Step 3.1: Installing Node.js via nvm

First up: Node.js. This is the JavaScript runtime that lets us run JavaScript outside of a web browser. But instead of installing Node directly, we're using **nvm** — Node Version Manager. This lets you switch between different Node versions easily.

[PAUSE]

In your Ubuntu terminal (you can open it from VS Code with Control plus backtick), paste this command:

```bash
curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.40.1/install.sh | bash
```

[VISUAL: Screen recording of nvm install command]

Let me break this down. "Curl" downloads files from the internet. We're downloading the nvm install script and piping it directly to "bash," which runs it. Hit Enter and let it install.

[PAUSE]

When it's done, **close and reopen your terminal**. This is important — nvm needs a fresh terminal session to work. Close the terminal tab and open a new one.

Now, install Node.js LTS — that stands for "Long Term Support," the most stable version:

```bash
nvm install --lts
```

[VISUAL: Show Node.js installing]

This downloads and installs Node.js version twenty-four, which is the latest LTS release as of February twenty twenty-six. Takes about a minute.

[PAUSE]

When it's done, verify it worked:

```bash
node --version
npm --version
```

You should see version numbers like "v24" and "10 point something." If you do, perfect! Node and npm are installed.

### Step 3.2: Installing and Configuring Git

Next: Git. Git is already installed on Ubuntu, but let's make sure it's up to date and configured with your identity.

Update Git:

```bash
sudo apt install git -y
git --version
```

[VISUAL: Show Git version output]

Good. Now configure Git with your name and email. Use your real name and the email associated with your GitHub account:

```bash
git config --global user.name "Your Name"
git config --global user.email "you@example.com"
git config --global init.defaultBranch main
```

[VISUAL: Show entering git config commands]

Replace "Your Name" with your actual name in quotes, and "you at example dot com" with your email. That last command sets "main" as the default branch name — this is the modern standard, replacing the old "master" terminology.

### Step 3.2b: Using Git in VS Code

Now, before we move on, let me show you something cool. You don't always have to use Git from the command line. VS Code has a built-in Git interface.

[VISUAL: **INSERT SCREENSHOT PROVIDED BY USER - vscode-git-source-control.png**]
[Show VS Code Source Control panel with the sidebar icon, changes list, commit message box, and blue Commit button]

See that Source Control icon on the left sidebar? That little branch icon with a number badge? Click it.

[PAUSE]

This opens the Source Control panel. Here's what you're looking at:

The number badge shows how many files have changed since your last commit. Right now it might show zero because we haven't created a project yet, but when you have changes, they'll appear in the "Changes" section.

To commit changes visually:

One: Review your changed files under "Changes."
Two: Type a commit message in the message box — describe what you changed.
Three: Click the blue "Commit" button.
Four: Click "Sync Changes" to push to GitHub.

[PAUSE]

This does the same thing as typing `git add`, `git commit`, and `git push` in the terminal. Use whichever you prefer — I'll show you both methods throughout this tutorial.

[VISUAL: Highlight the commit message box and blue Commit button on the screenshot]

### Step 3.3: Creating or Verifying Your GitHub Account

Alright, next: GitHub. If you already have a GitHub account, great — just make sure you're signed in at github dot com. If you don't have one, go to github dot com slash signup and create a free account.

[VISUAL: Show GitHub signup page]

Use the same email you configured in Git. Pick a username you'll be happy with — this becomes part of your project URLs, like github dot com slash your username.

[PAUSE]

Follow the signup flow, verify your email, and you're in.

### Step 3.4: Setting Up SSH Keys

Now, SSH keys. This lets you push code to GitHub without typing your password every time. It's also more secure than password authentication.

In your terminal, run:

```bash
ssh-keygen -t ed25519 -C "you@example.com"
```

[VISUAL: Show ssh-keygen command]

Replace "you at example dot com" with your actual email. Hit Enter.

It'll ask where to save the key — just press Enter to accept the default.

It'll ask for a passphrase — for simplicity, just press Enter twice to skip this. In a production environment, you'd use a passphrase, but for learning, we're keeping it simple.

[PAUSE]

Now, display your public key:

```bash
cat ~/.ssh/id_ed25519.pub
```

[VISUAL: Show public key output]

You'll see a long string starting with "ssh-ed25519." Copy the entire thing — select it with your mouse and press Control plus Shift plus C to copy.

[PAUSE]

Now, go to github dot com slash settings slash keys. Click "New SSH key."

[VISUAL: Screen recording of adding SSH key on GitHub]

Give it a title like "WSL Ubuntu," paste your public key into the big box, and click "Add SSH key."

Done! Now test the connection:

```bash
ssh -T git@github.com
```

[VISUAL: Show successful SSH test]

It'll ask "Are you sure you want to continue connecting?" Type "yes" and press Enter. If you see "Hi [your username]! You've successfully authenticated," you're golden.

### Step 3.5: Installing Azure CLI

Almost done with lab three. Let's install the Azure CLI:

```bash
curl -sL https://aka.ms/InstallAzureCLIDeb | sudo bash
```

[VISUAL: Show Azure CLI installing]

This takes a minute or two. When it's done, verify:

```bash
az --version
```

Now log in to Azure:

```bash
az login
```

[VISUAL: Show browser opening for Azure login]

A browser window will open. Sign in with your Azure account. If you don't have one, you can create a free account at azure dot microsoft dot com slash free — it comes with two hundred dollars in credits.

### Step 3.6: Installing GitHub CLI

Last tool: GitHub CLI. This lets you create repositories, manage pull requests, and more, all from the terminal.

```bash
sudo apt install gh -y
gh auth login
```

[VISUAL: Show gh auth login prompts]

It'll ask a series of questions:

- "What account do you want to log into?" → Choose "GitHub dot com"
- "What is your preferred protocol?" → Choose "SSH"
- "Upload your SSH public key?" → Choose "Yes" (this links the key you already created)
- "How would you like to authenticate?" → Choose "Login with a web browser"

[PAUSE]

It'll give you a code. Copy it, press Enter, and a browser window opens. Paste the code and authorize.

Done! GitHub CLI is authenticated.

### Lab 3 Checkpoint

Alright, let's review what you just accomplished:

[VISUAL: Checklist]

✓ Node.js twenty-four LTS installed via nvm
✓ Git installed and configured with your identity
✓ GitHub account created or verified
✓ SSH key added to GitHub
✓ Azure CLI installed and logged in
✓ GitHub CLI installed and authenticated

You now have all the core development tools. Your machine is ready to build, test, and deploy real applications. That's a huge milestone!

[SECTION BREAK]

---

## Lab 6: Troubleshooting Errors with Copilot Chat

[50:00]

Alright, we've covered the setup and tools. Now let's talk about one of the most practical skills you'll use constantly: fixing errors with GitHub Copilot Chat.

[PAUSE]

Here's the reality of coding: you're going to see error messages. Lots of them. TypeScript errors, build errors, import errors. This is completely normal. What's changed with vibe coding is how quickly you can fix them.

### The Simple Error-to-Fix Workflow

[VISUAL: **INSERT SCREENSHOT - typescript-build-errors.png**]

Let me show you a real example. Here's what it looks like when you run `npm run build` and hit a TypeScript error.

[PAUSE]

You'll see red error messages in your terminal — file paths, line numbers, type mismatches. It might look intimidating, but here's the beautiful part: you don't need to understand it all yourself.

[PAUSE]

Here's what you do:

**Step one**: Select the entire error output in your terminal. Everything. The whole error message from top to bottom.

**Step two**: Copy it. Control plus C.

**Step three**: Open GitHub Copilot Chat. Press Control plus Shift plus I.

**Step four**: Paste the error. Control plus V. Then press Enter.

[PAUSE]

That's it. No explanation needed. No extra context. Just paste the raw error text.

### What Happens Next

[VISUAL: **INSERT SCREENSHOT - copilot-review-interface.png**]

GitHub Copilot analyzes your entire project. It reads your custom instructions, looks at the files involved in the error, understands your TypeScript config, and figures out what's wrong.

[PAUSE]

Then it shows you exactly what it wants to change. You'll see the proposed fix with two buttons: "Keep" and "Undo."

[PAUSE]

This is important — Copilot doesn't just apply the fix automatically. It shows you the changes first. You're in control. You review it. If it looks right, click "Keep." If not, click "Undo" and try a different approach.

### Common Errors Copilot Handles

Here are the types of errors GitHub Copilot can fix for you:

**TypeScript type errors** — like "Type string is not assignable to type number." Copilot will fix the type annotations.

**Missing imports** — "Cannot find module react." Copilot adds the import statement.

**Syntax errors** — missing brackets, typos in JSX. Copilot corrects them.

**Build configuration problems** — issues in vite dot config or tsconfig. Copilot knows the right settings.

**Dependency conflicts** — version mismatches or missing packages. Copilot updates your package dot json.

**Runtime errors** — null references, undefined variables. Copilot adds the safety checks.

[PAUSE]

### The Iteration Loop

If Copilot's first fix doesn't work, paste the *new* error message. Copilot will iterate. It'll try a different approach. This back-and-forth usually takes just two or three rounds before you're running clean.

[PAUSE]

### Why You Don't Need to Add Context

You might be tempted to write something like: "I'm getting this error in my React component when I try to build." Don't bother.

[PAUSE]

Copilot already has full access to your entire codebase. It can see which file the error came from, what libraries you're using, your custom instructions, your TypeScript configuration. It has all the context it needs.

[PAUSE]

Just paste the error. Let Copilot do its job.

### Lab 6 Checkpoint

[VISUAL: Checklist]

✓ Understand the copy-paste-fix workflow
✓ Know when to use "Keep" vs "Undo"
✓ Recognize that iteration is normal
✓ Trust Copilot to have full project context

This simple workflow will save you hours of searching Stack Overflow or reading documentation. When you see an error, you now have an expert debugging partner built right into VS Code.

[SECTION BREAK]

---

## [TO BE CONTINUED - PLACEHOLDER FOR REMAINING LABS]

**Note**: This transcript will continue for Labs 4, 5, 7, 8, and 9. Each lab follows the same conversational, step-by-step format with visual cues and natural pacing.

---

## [METADATA FOR ELEVENLABS PRODUCTION]

### Recommended Voice Settings

**Voice**: Antoni or Adam (conversational, clear)
**Stability**: 0.5-0.6 (allows natural variation)
**Clarity**: 0.75 (crisp pronunciation)
**Style Exaggeration**: 0.3 (subtle emphasis on key points)

### Segmentation for API Calls

Break into chapters for ElevenLabs API:
- **Intro**: 0:00 - 2:30 (one call)
- **Lab 1**: 2:30 - 15:00 (one call)
- **Lab 2**: 15:00 - 30:00 (one call)
- **Lab 3**: 30:00 - 50:00 (one call)
- Continue pattern for remaining labs

This keeps each API call under the character limit while maintaining natural flow.

### Post-Processing Notes

- Add subtle background music (low volume, non-intrusive)
- Insert screen recordings at [VISUAL] markers
- Add chapter markers at [SECTION BREAK] points
- Include on-screen text for commands as they're spoken
- Add progress indicator showing current lab

---

*This transcript is continuously updated as new content, screenshots, and sections are added to the vibe coding lab.*

**Last Updated**: February 15, 2026
**Current Coverage**: Introduction + Labs 1-3 (Partial)
**Total Estimated Runtime**: 4-5 hours when complete
