# Vibe Coding Fundamentals & Terminology Guide

> **Purpose**: This guide explains all the key concepts, tools, and terminology you'll encounter in the vibe coding lab. Read this before starting Lab 1 to build your foundational knowledge.

---

## Table of Contents

1. [What is Vibe Coding?](#what-is-vibe-coding)
2. [Core Concepts](#core-concepts)
3. [VS Code Terminology](#vs-code-terminology)
4. [GitHub Copilot Concepts](#github-copilot-concepts)
5. [Git & GitHub Terminology](#git--github-terminology)
6. [CI/CD Pipeline Terms](#cicd-pipeline-terms)
7. [Development Environment Terms](#development-environment-terms)
8. [Web Development Basics](#web-development-basics)
9. [Cloud & Deployment Terms](#cloud--deployment-terms)

---

## What is Vibe Coding?

**Vibe coding** is a development approach where you describe what you want to build in natural language, and AI (like GitHub Copilot) generates the code for you. Instead of typing code manually, you:

1. **Describe** your intent ("Create a dashboard with user profile cards")
2. **Review** the AI-generated code
3. **Iterate** by providing feedback ("Make the cards blue instead of gray")
4. **Test** the results in your browser

```mermaid
graph LR
    YOU[You: Describe Intent] --> AI[AI: Generate Code]
    AI --> REVIEW[You: Review Code]
    REVIEW --> TEST[You: Test in Browser]
    TEST --> ITERATE{Works?}
    ITERATE -->|No| FEEDBACK[You: Give Feedback]
    FEEDBACK --> AI
    ITERATE -->|Yes| DONE[Ship It!]

    style YOU fill:#2ECC71,color:#fff
    style AI fill:#6e40c9,color:#fff
    style DONE fill:#E67E22,color:#fff
```

### Traditional Coding vs. Vibe Coding

| Traditional Coding | Vibe Coding |
|---|---|
| You write every line of code manually | AI writes code based on your descriptions |
| Years of learning syntax required | Focus on describing what you want |
|ググググ→ Stack Overflow → Copy code | Explain in plain English |
| Slow iteration cycles | Rapid prototyping and iteration |
| Must remember APIs and patterns | AI suggests patterns from training data |

**Important**: You still need to **read and understand** the generated code. You're the architect—AI is your junior developer.

---

## Core Concepts

### Agent Mode vs. Chat Mode

GitHub Copilot has two primary interaction modes:

```mermaid
graph TD
    COPILOT[GitHub Copilot]
    COPILOT --> CHAT[Chat Mode]
    COPILOT --> AGENT[Agent Mode]

    CHAT --> C1[Answer questions]
    CHAT --> C2[Explain code]
    CHAT --> C3[Suggest fixes]
    CHAT --> C4[Generate snippets]

    AGENT --> A1[Edit multiple files]
    AGENT --> A2[Run terminal commands]
    AGENT --> A3[Create full features]
    AGENT --> A4[Fix errors automatically]

    style CHAT fill:#4A90D9,color:#fff
    style AGENT fill:#2ECC71,color:#fff
```

**Chat Mode**: Ask questions, get code snippets, receive explanations
**Agent Mode**: Describe a feature, Copilot autonomously implements it across files

### The Development Loop

```mermaid
graph LR
    WRITE[Write/Edit Code] --> SAVE[Save File]
    SAVE --> BUILD[Build Project]
    BUILD --> RUN[Run in Browser]
    RUN --> TEST[Test Functionality]
    TEST --> DEBUG{Issues?}
    DEBUG -->|Yes| FIX[Fix & Iterate]
    FIX --> WRITE
    DEBUG -->|No| COMMIT[Git Commit]
    COMMIT --> PUSH[Push to GitHub]

    style WRITE fill:#2ECC71,color:#fff
    style RUN fill:#E67E22,color:#fff
    style COMMIT fill:#6e40c9,color:#fff
```

---

## VS Code Terminology

### The Interface

```
┌─────────────────────────────────────────────────────────┐
│  File  Edit  Selection  View  Go  Run  Terminal  Help  │ ← Menu Bar
├───┬─────────────────────────────────────────────────┬───┤
│ E │                                                 │ C │
│ x │          Editor Area                            │ o │
│ p │          (Where you write code)                 │ p │
│ l │                                                 │ i │
│ o │                                                 │ l │
│ r │                                                 │ o │
│ e │                                                 │ t │
│ r │                                                 │   │
│   │                                                 │ C │
│ S │                                                 │ h │
│ i │                                                 │ a │
│ d │                                                 │ t │
│ e │                                                 │   │
│ b │─────────────────────────────────────────────────│───│
│ a │          Terminal / Output Panel                │   │
│ r │          (Command line and logs)                │   │
└───┴─────────────────────────────────────────────────┴───┘
  ↑                                                      ↑
File Tree                                          Copilot Chat
Extensions                                         GitHub Integration
Search                                             Debugger
Source Control
```

### Key VS Code Terms

| Term | What It Means | Example |
|------|---------------|---------|
| **Workspace** | The folder containing your project files | `my-vibe-app/` |
| **Explorer** | File tree sidebar showing all project files | Left panel with folders/files |
| **Editor** | The main area where you write code | Center panel with tabs |
| **Terminal** | Command-line interface built into VS Code | Bottom panel for running commands |
| **Extension** | Add-on that gives VS Code new capabilities | GitHub Copilot, ESLint, Prettier |
| **Command Palette** | Search menu for all VS Code commands (Ctrl+Shift+P) | "Git: Commit", "Format Document" |
| **IntelliSense** | Auto-complete suggestions as you type | Type `con` → suggests `console.log` |
| **Snippet** | Reusable code template | Type `for` → expands to full for-loop |

### Important Keyboard Shortcuts

| Shortcut | Action | When to Use |
|----------|--------|-------------|
| `Ctrl+Shift+P` | Open Command Palette | Run any VS Code command |
| `Ctrl+`` | Toggle terminal | Open/close command line |
| `Ctrl+Shift+I` | Open Copilot Chat | Ask AI for help |
| `Ctrl+I` | Inline Copilot | Edit code in place with AI |
| `Ctrl+S` | Save file | Save your changes |
| `Ctrl+P` | Quick file open | Jump to a file by name |
| `Ctrl+Shift+F` | Search across files | Find text in entire project |
| `Ctrl+/` | Toggle comment | Comment/uncomment selected code |

**Screenshot Placeholder**: *VS Code interface with labeled sections*

---

## GitHub Copilot Concepts

### How Copilot Works

```mermaid
graph TD
    YOU[You type code or ask question] --> CONTEXT[Copilot reads:<br/>- Current file<br/>- Open files<br/>- Project structure<br/>- Custom instructions]
    CONTEXT --> AI[AI Model<br/>Trained on billions<br/>of lines of code]
    AI --> SUGGEST[Suggestions appear<br/>in real-time]
    SUGGEST --> ACCEPT{Accept?}
    ACCEPT -->|Tab| INSERTED[Code inserted]
    ACCEPT -->|Esc| DISMISS[Dismissed]
    INSERTED --> KEEP{Good code?}
    KEEP -->|Yes| DONE[Keep it]
    KEEP -->|No| EDIT[Edit or regenerate]

    style AI fill:#6e40c9,color:#fff
    style DONE fill:#2ECC71,color:#fff
```

### Copilot Modes & Features

| Feature | What It Does | How to Access |
|---------|-------------|---------------|
| **Inline Completions** | Suggests code as you type | Appears automatically (gray text) |
| **Chat Mode** | Conversational AI help | `Ctrl+Shift+I` or click chat icon |
| **Agent Mode** | Autonomous multi-file editing | Switch mode in Copilot Chat dropdown |
| **Slash Commands** | Quick actions like `/explain`, `/fix` | Type `/` in Copilot Chat |
| **Custom Instructions** | Project-specific guidance for AI | `.github/copilot-instructions.md` |
| **Prompt Files** | Reusable command templates | `.github/prompts/*.prompt.md` |

### Custom Instructions Hierarchy

Copilot reads instructions in this priority order:

```mermaid
graph TD
    U[Your Personal Settings<br/><i>Highest priority</i>] --> R[Repository Instructions<br/><i>.github/copilot-instructions.md</i>]
    R --> P[Path-Specific Instructions<br/><i>.github/instructions/*.instructions.md</i>]
    P --> O[Organization Policies<br/><i>Lowest priority</i>]

    style U fill:#E67E22,color:#fff
    style R fill:#2ECC71,color:#fff
    style P fill:#4A90D9,color:#fff
```

**Example**: If you tell Copilot "always use functional components" in your personal settings, and the repository says "use class components," Copilot follows *your* personal preference.

### Understanding MCP Servers

**MCP (Model Context Protocol)** servers are plugins that give Copilot access to external tools and services.

```mermaid
graph LR
    COPILOT[GitHub Copilot] --> MCP[MCP Protocol]
    MCP --> DOCS[Microsoft Learn<br/><i>Official docs</i>]
    MCP --> LIB[Context7<br/><i>Library docs</i>]
    MCP --> AZURE[Azure MCP<br/><i>Manage cloud</i>]
    MCP --> GH[GitHub MCP<br/><i>Repos & PRs</i>]
    MCP --> PW[Playwright<br/><i>Browser testing</i>]

    style COPILOT fill:#6e40c9,color:#fff
```

Think of MCP servers as Copilot's "tools":
- Without MCP: Copilot only knows what you type and what it was trained on
- With MCP: Copilot can fetch live docs, manage Azure resources, read your GitHub repos, etc.

### Troubleshooting Errors with Copilot Chat

When you encounter build errors, TypeScript errors, or runtime issues, GitHub Copilot Chat can help you fix them quickly. The workflow is simple:

**The Error Resolution Workflow**:

```mermaid
graph LR
    ERROR[See Error in Terminal] --> COPY[Copy Error Text]
    COPY --> PASTE[Paste into Copilot Chat]
    PASTE --> AI[Copilot Analyzes Error]
    AI --> FIX[Copilot Suggests Fix]
    FIX --> REVIEW[Review Changes]
    REVIEW --> ACCEPT{Keep or Undo?}
    ACCEPT -->|Keep| DONE[Test Again]
    ACCEPT -->|Undo| ITERATE[Refine Request]
    ITERATE --> PASTE

    style ERROR fill:#E74C3C,color:#fff
    style AI fill:#6e40c9,color:#fff
    style DONE fill:#2ECC71,color:#fff
```

**Step-by-Step**:

1. **Run your build** — Execute `npm run build` or `npm run dev` in the terminal
2. **Error appears** — See red error messages with file paths and line numbers
3. **Copy the error** — Select and copy the error text (Ctrl+C)
4. **Open Copilot Chat** — Press `Ctrl+Shift+I` to open the chat panel
5. **Paste the error** — Just paste it (Ctrl+V) and press Enter — no need to add extra context
6. **Copilot analyzes** — Copilot reads your project files and identifies the issue
7. **Review the fix** — Copilot shows suggested changes with "Keep" and "Undo" buttons
8. **Accept or reject** — Click "Keep" to apply changes, or "Undo" to try a different approach

![Terminal showing TypeScript build errors](images/typescript-build-errors.png)
*Example: Terminal showing build errors that can be copied and pasted into Copilot Chat*

![Copilot code review interface with Keep and Undo buttons](images/copilot-review-interface.png)
*Copilot shows proposed changes with clear Keep/Undo options before applying them*

**Important**: Copilot has full context of your project, so you don't need to explain the error or provide additional details. Just paste the error text directly, and Copilot will understand it in the context of your codebase.

**Common Errors Copilot Can Fix**:
- TypeScript type errors ("Type 'string' is not assignable to type 'number'")
- Missing imports ("Cannot find module 'react'")
- Build configuration issues (Vite, Webpack, tsconfig problems)
- Syntax errors (missing brackets, incorrect JSX)
- Dependency conflicts (version mismatches, peer dependencies)
- Runtime errors (null reference, undefined variables)

---

## Git & GitHub Terminology

### What is Git?

**Git** is version control software that tracks changes to your code over time. Think of it like "Track Changes" in Microsoft Word, but for entire projects.

```mermaid
graph LR
    V1[Version 1<br/>Initial code] --> V2[Version 2<br/>Added login]
    V2 --> V3[Version 3<br/>Fixed bug]
    V3 --> V4[Version 4<br/>New feature]

    V3 -.-> OOPS[Made mistake?<br/>Go back to V2!]

    style V4 fill:#2ECC71,color:#fff
    style OOPS fill:#E67E22,color:#fff
```

### GitHub vs. Git

| Git | GitHub |
|-----|--------|
| Software on your computer | Website (github.com) |
| Tracks changes locally | Stores code in the cloud |
| Works offline | Requires internet |
| Command-line tool | Web interface + collaboration |

Think of it like:
- **Git** = Microsoft Word's save/undo features
- **GitHub** = OneDrive where you back up and share Word docs

### Key Git Terms

```mermaid
graph TD
    WD[Working Directory<br/><i>Your files on disk</i>] --> |git add| STAGE[Staging Area<br/><i>Changes ready to commit</i>]
    STAGE --> |git commit| LOCAL[Local Repository<br/><i>Committed history</i>]
    LOCAL --> |git push| REMOTE[Remote Repository<br/><i>GitHub.com</i>]
    REMOTE --> |git pull| LOCAL
    REMOTE --> |git clone| NEW[New Copy<br/><i>On another machine</i>]

    style WD fill:#4A90D9,color:#fff
    style REMOTE fill:#2ECC71,color:#fff
```

| Term | Definition | Command Example |
|------|-----------|-----------------|
| **Repository (Repo)** | A project folder tracked by Git | `git init` creates one |
| **Commit** | A snapshot of your code at a point in time | `git commit -m "Add login"` |
| **Branch** | A parallel version of your code | `git branch feature-login` |
| **main/master** | The primary branch (default) | Auto-created |
| **Staging** | Marking files to include in next commit | `git add myfile.js` |
| **Push** | Send commits to GitHub | `git push` |
| **Pull** | Get latest code from GitHub | `git pull` |
| **Clone** | Download a repository from GitHub | `git clone https://...` |
| **Fork** | Copy someone else's repo to your account | Click "Fork" on GitHub |
| **Pull Request (PR)** | Propose changes to a repository | Created on GitHub.com |
| **Merge** | Combine two branches | `git merge feature-login` |

### Git Workflow

```mermaid
sequenceDiagram
    participant You
    participant Git
    participant GitHub

    You->>Git: git add .
    Note over You,Git: Stage all changed files
    You->>Git: git commit -m "Add feature"
    Note over You,Git: Create snapshot locally
    You->>Git: git push
    Git->>GitHub: Upload commits
    Note over GitHub: Code now on github.com
    GitHub-->>You: Visible to team
```

**Screenshot Placeholder**: *GitHub interface showing repository, commits, and branches*

---

## CI/CD Pipeline Terms

### What is CI/CD?

**CI/CD** stands for **Continuous Integration / Continuous Deployment**. It's automation that tests and deploys your code every time you push changes.

```mermaid
graph LR
    PUSH[You push code<br/>to GitHub] --> CI[CI: Continuous Integration<br/><i>Test & Validate</i>]
    CI --> LINT[Run Linter<br/><i>Check code style</i>]
    CI --> TYPE[Type Check<br/><i>Verify TypeScript</i>]
    CI --> TEST[Run Tests<br/><i>Unit + Integration</i>]
    TEST --> PASS{All Pass?}
    PASS -->|Yes| CD[CD: Continuous Deployment<br/><i>Deploy to Cloud</i>]
    PASS -->|No| FAIL[Build Fails<br/><i>Fix needed</i>]
    CD --> AZURE[Azure Static Web Apps]
    AZURE --> LIVE[Live on Internet!]

    style PUSH fill:#4A90D9,color:#fff
    style PASS fill:#E67E22,color:#fff
    style LIVE fill:#2ECC71,color:#fff
    style FAIL fill:#E74C3C,color:#fff
```

### CI/CD Vocabulary

| Term | What It Means | Example |
|------|---------------|---------|
| **Pipeline** | Automated sequence of steps | Lint → Test → Build → Deploy |
| **Build** | Compile your code for production | `npm run build` |
| **Artifact** | Output files from a build | `dist/` folder with compiled code |
| **Job** | A set of steps in a pipeline | "test" job, "deploy" job |
| **Workflow** | The entire CI/CD process | GitHub Actions `.yml` file |
| **Trigger** | Event that starts a pipeline | Push to `main` branch |
| **Runner** | Server that executes pipeline steps | GitHub's cloud servers |
| **Environment** | Deployment target | `production`, `staging`, `dev` |
| **Gate** | Checkpoint that must pass | Tests must pass before deploy |
| **Rollback** | Revert to previous version | If new deploy breaks |

### GitHub Actions Components

```mermaid
graph TD
    WORKFLOW[Workflow<br/><i>.github/workflows/deploy.yml</i>] --> EVENT[Triggered by Event<br/><i>push, pull_request, schedule</i>]
    EVENT --> RUNNER[Runs on Runner<br/><i>ubuntu-latest, windows, mac</i>]
    RUNNER --> JOB1[Job: Test]
    RUNNER --> JOB2[Job: Build]
    RUNNER --> JOB3[Job: Deploy]

    JOB1 --> STEP1A[Step: Install dependencies]
    JOB1 --> STEP1B[Step: Run tests]

    JOB2 --> STEP2A[Step: Build project]
    JOB2 --> STEP2B[Step: Create artifact]

    JOB3 --> STEP3A[Step: Download artifact]
    JOB3 --> STEP3B[Step: Deploy to Azure]

    style WORKFLOW fill:#6e40c9,color:#fff
    style JOB1 fill:#4A90D9,color:#fff
    style JOB2 fill:#2ECC71,color:#fff
    style JOB3 fill:#E67E22,color:#fff
```

**Example Workflow**:

```yaml
name: Deploy to Azure

on:
  push:
    branches: [main]  # Trigger: push to main branch

jobs:
  test:  # Job 1
    runs-on: ubuntu-latest  # Runner
    steps:
      - uses: actions/checkout@v3  # Step: Get code
      - run: npm install           # Step: Install deps
      - run: npm test              # Step: Run tests

  deploy:  # Job 2 (runs after test passes)
    needs: test
    runs-on: ubuntu-latest
    steps:
      - run: npm run build
      - run: az staticwebapp deploy  # Deploy to Azure
```

**Screenshot Placeholder**: *GitHub Actions workflow run showing green checkmarks for passing steps*

---

## Development Environment Terms

### Terminal / Command Line

The **terminal** (also called **command line** or **shell**) is a text interface for running commands on your computer.

```
$ npm install        ← You type this
... installing...    ← Output appears
Done!
```

| Term | Definition |
|------|------------|
| **Shell** | The program interpreting your commands (Bash, Zsh, PowerShell) |
| **Bash** | Linux/Mac default shell |
| **PowerShell** | Windows shell |
| **WSL** | Windows Subsystem for Linux (Linux shell on Windows) |
| **Command** | An instruction you type (`ls`, `cd`, `npm install`) |
| **Flag/Option** | Modifies a command (`-y`, `--save`, `--version`) |
| **Path** | File location (`/home/user/project/file.js`) |
| **Current Directory** | Folder you're "in" right now (`pwd` shows it) |
| **Root Directory** | Top-level folder (`/` on Linux, `C:\` on Windows) |

### Common Commands

```bash
# Navigate
cd my-app          # Change directory
ls                 # List files
pwd                # Print working directory

# File operations
mkdir new-folder   # Make directory
rm file.txt        # Remove file
cp old.txt new.txt # Copy file
mv old.txt new.txt # Move/rename file

# Node.js / npm
npm install        # Install dependencies
npm run dev        # Start dev server
npm run build      # Build for production
node script.js     # Run JavaScript file

# Git
git status         # Show changed files
git add .          # Stage all changes
git commit -m "msg"# Create commit
git push           # Push to GitHub
```

### WSL (Windows Subsystem for Linux)

```mermaid
graph TD
    WIN[Windows 11] --> WSL[WSL 2]
    WSL --> UBUNTU[Ubuntu Linux]
    UBUNTU --> BASH[Bash Shell]
    UBUNTU --> TOOLS[Linux Tools<br/>git, npm, node]
    UBUNTU --> FILES[Access Windows Files<br/>/mnt/c/Users/...]

    style WSL fill:#E95420,color:#fff
    style BASH fill:#4A90D9,color:#fff
```

**Why WSL?**
- Professional developers use Linux/Mac
- Better compatibility with Node.js tools
- Faster file operations
- You get Linux power without dual-boot

---

## Web Development Basics

### Frontend vs. Backend

```mermaid
graph LR
    USER[User's Browser] --> FRONTEND[Frontend<br/><i>HTML, CSS, JavaScript</i><br/><i>What users see</i>]
    FRONTEND --> HTTP[HTTP Requests]
    HTTP --> BACKEND[Backend<br/><i>Node.js, Python, etc.</i><br/><i>Server logic</i>]
    BACKEND --> DB[(Database<br/><i>Store data</i>)]

    style FRONTEND fill:#2ECC71,color:#fff
    style BACKEND fill:#4A90D9,color:#fff
    style DB fill:#E67E22,color:#fff
```

| | Frontend | Backend |
|---|----------|---------|
| **Runs** | In user's browser | On a server |
| **Languages** | HTML, CSS, JavaScript | Node.js, Python, C#, etc. |
| **Purpose** | User interface | Business logic, data |
| **Examples** | Buttons, forms, animations | Login, payments, database |

**This lab focuses on**: Frontend only (Vite + React + TypeScript)

### Key Technologies in This Lab

```mermaid
graph TD
    TS[TypeScript<br/><i>Typed JavaScript</i>] --> REACT[React<br/><i>UI Components</i>]
    REACT --> VITE[Vite<br/><i>Build Tool</i>]
    VITE --> TW[Tailwind CSS<br/><i>Styling</i>]
    TW --> BROWSER[Browser<br/><i>Your app running</i>]

    style TS fill:#3178C6,color:#fff
    style REACT fill:#61DAFB,color:#000
    style VITE fill:#646CFF,color:#fff
    style TW fill:#06B6D4,color:#fff
```

| Technology | What It Does | Why We Use It |
|------------|--------------|---------------|
| **TypeScript** | JavaScript with types (catches errors early) | Prevents bugs, better autocomplete |
| **React** | Build UIs with reusable components | Industry standard, huge ecosystem |
| **Vite** | Fast build tool and dev server | Instant hot reload, optimized builds |
| **Tailwind CSS** | Utility-first CSS framework | No custom CSS, just add classes |
| **Axios** | HTTP client for API calls | Cleaner than `fetch()` |

### TypeScript vs. JavaScript: Which Should You Use?

**The Short Answer**: TypeScript is JavaScript with type safety. Every TypeScript file is valid JavaScript plus optional type annotations. TypeScript code compiles down to plain JavaScript before running in the browser.

```mermaid
graph LR
    JS[JavaScript<br/><i>Dynamic, flexible</i>] --> TS[TypeScript<br/><i>JavaScript + Types</i>]
    TS --> COMPILE[TypeScript Compiler]
    COMPILE --> OUTPUT[JavaScript<br/><i>Runs in browser</i>]

    style JS fill:#F7DF1E,color:#000
    style TS fill:#3178C6,color:#fff
    style OUTPUT fill:#F7DF1E,color:#000
```

#### How They Compare

| Aspect | JavaScript | TypeScript |
|--------|-----------|------------|
| **Type System** | Dynamic (types checked at runtime) | Static (types checked before code runs) |
| **Error Detection** | Find errors when code runs | Find errors while writing code |
| **Learning Curve** | Easier to start | Steeper initial learning curve |
| **Tooling** | Basic autocomplete | Advanced IntelliSense, refactoring |
| **Build Step** | No compilation needed | Must compile to JavaScript |
| **File Extension** | `.js`, `.jsx` | `.ts`, `.tsx` |
| **Code Verbosity** | Less code to write | More annotations, but clearer intent |
| **Browser Support** | Runs directly in browsers | Must be compiled first |

#### Pros and Cons

**JavaScript Pros** ✅:
- No compilation step — write and run immediately
- Smaller learning curve for beginners
- More flexible (duck typing, dynamic properties)
- No type syntax to learn
- Works everywhere without setup
- Faster prototyping for small scripts

**JavaScript Cons** ❌:
- Errors only appear at runtime (crashes in production)
- Harder to refactor large codebases
- Limited autocomplete and IntelliSense
- Typos in property names go unnoticed until runtime
- Function parameters can be anything (easy to pass wrong types)
- Difficult to understand code intent without reading implementation

**TypeScript Pros** ✅:
- Catch errors before code runs (typos, type mismatches, missing properties)
- Exceptional autocomplete and IntelliSense (Copilot works better with types)
- Self-documenting code (types describe what functions expect)
- Safe refactoring (rename variables across hundreds of files)
- Better for large codebases and teams
- Prevents entire categories of bugs (null reference errors, undefined is not a function)
- Easier to onboard new developers (types explain the codebase)

**TypeScript Cons** ❌:
- Requires build step (compilation adds complexity)
- More verbose code (type annotations take space)
- Learning curve (generics, utility types, complex types)
- Configuration overhead (tsconfig.json)
- Some libraries lack TypeScript definitions
- Can feel restrictive when prototyping quickly

#### Example: Same Code in Both Languages

**JavaScript** (runtime error):
```javascript
function calculateTotal(price, quantity) {
  return price * quantity;
}

// This runs without error until you test it
calculateTotal("50", 3); // Returns "505050" instead of 150
// Bug discovered when user complains
```

**TypeScript** (compile-time error):
```typescript
function calculateTotal(price: number, quantity: number): number {
  return price * quantity;
}

// TypeScript editor shows red squiggle immediately
calculateTotal("50", 3);
// Error: Argument of type 'string' is not assignable to parameter of type 'number'
// Bug caught before code even runs
```

#### When to Use JavaScript

Choose **JavaScript** when:
- Building quick prototypes or proof-of-concepts
- Writing simple scripts or automation tasks
- Learning web development for the first time
- Working on small projects (< 1,000 lines)
- You need maximum flexibility and speed
- You're contributing to a JavaScript-only codebase
- You're writing code that won't be maintained long-term

**Real-world scenarios**:
- Personal website with a few interactive features
- Quick data visualization script
- Browser extension with minimal logic
- Learning React basics before adding TypeScript complexity

#### When to Use TypeScript

Choose **TypeScript** when:
- Building production applications
- Working on team projects (types document code)
- Creating large codebases (> 1,000 lines)
- You want GitHub Copilot to generate more accurate code
- The project will be maintained for years
- You need safe refactoring capabilities
- Integrating with APIs (types prevent API contract errors)
- Building reusable libraries or components

**Real-world scenarios**:
- SaaS application dashboard
- E-commerce platform
- Enterprise business applications
- Any app that handles user data
- APIs with complex request/response shapes
- Design systems and component libraries

#### Deciding Factors

```mermaid
graph TD
    START{Starting a new project?} --> SIZE{Project size?}
    SIZE -->|Small script<br/>< 500 lines| JS[Use JavaScript]
    SIZE -->|Medium-Large app<br/>> 500 lines| TEAM{Team project?}
    TEAM -->|Solo| MAINTAIN{Long-term<br/>maintenance?}
    TEAM -->|Team| TS[Use TypeScript ✅]
    MAINTAIN -->|Quick prototype| JS
    MAINTAIN -->|Production app| TS

    style JS fill:#F7DF1E,color:#000
    style TS fill:#3178C6,color:#fff
```

**Key Decision Questions**:
1. **Will this be maintained beyond 6 months?** → TypeScript
2. **Will more than one person work on it?** → TypeScript
3. **Does it handle important user data?** → TypeScript
4. **Is it a learning project or throwaway code?** → JavaScript
5. **Will you need to refactor often?** → TypeScript
6. **Do you want better Copilot suggestions?** → TypeScript

#### Migration Path

You can start with JavaScript and migrate to TypeScript incrementally:

1. **Rename** `.js` → `.ts` and `.jsx` → `.tsx` (one file at a time)
2. **Allow implicit any** in `tsconfig.json` initially
3. **Add types gradually** as you touch files
4. **Strict mode later** when comfortable

Many projects use both: TypeScript for application code, JavaScript for build scripts.

#### Why This Lab Uses TypeScript

This lab teaches TypeScript because:
- **Industry standard** for React in 2026 (most companies use TypeScript)
- **Better Copilot results** (types give Copilot more context)
- **Prevents common mistakes** while learning (typos, wrong property names)
- **Self-documenting code** (easier to follow along)
- **Real-world preparation** (matches what you'll use professionally)

You can apply the same vibe coding techniques to JavaScript — just remove the type annotations.

### How a React App Works

```mermaid
graph LR
    SRC[src/ folder<br/>Your .tsx files] --> VITE[Vite Build Tool]
    VITE --> BUNDLE[dist/ folder<br/>Optimized bundle.js]
    BUNDLE --> BROWSER[Browser]
    BROWSER --> DOM[Rendered UI]

    DEV[Dev Mode:<br/>npm run dev] -.-> LIVE[Live Preview<br/>localhost:5173]
    PROD[Prod Mode:<br/>npm run build] -.-> BUNDLE

    style SRC fill:#2ECC71,color:#fff
    style BUNDLE fill:#E67E22,color:#fff
```

**Development**: Files auto-reload when you save
**Production**: Minified, optimized for speed

---

## Cloud & Deployment Terms

### What is "The Cloud"?

The **cloud** just means "someone else's computer" — servers you rent to run your app.

```mermaid
graph TD
    YOU[Your Code<br/>on GitHub] --> CLOUD[Cloud Provider]
    CLOUD --> AZURE[Azure<br/><i>Microsoft</i>]
    CLOUD --> AWS[AWS<br/><i>Amazon</i>]
    CLOUD --> GCP[GCP<br/><i>Google</i>]

    AZURE --> SWA[Static Web Apps<br/><i>Your app hosted</i>]
    SWA --> INTERNET[Internet<br/><i>Accessible worldwide</i>]

    style AZURE fill:#0078D4,color:#fff
    style SWA fill:#2ECC71,color:#fff
```

### Azure Terminology

| Term | What It Means |
|------|---------------|
| **Azure** | Microsoft's cloud platform |
| **Static Web App** | Hosting for frontend apps (HTML/JS/CSS) |
| **Resource Group** | Container for related cloud resources |
| **Subscription** | Your billing account |
| **Environment** | Deployment target (dev, staging, production) |
| **Custom Domain** | Your own URL (myapp.com vs. myapp.azurestaticapps.net) |

### Deployment Process

```mermaid
sequenceDiagram
    participant You
    participant GitHub
    participant Actions
    participant Azure

    You->>GitHub: git push
    GitHub->>Actions: Trigger workflow
    Actions->>Actions: Run tests
    Actions->>Actions: npm run build
    Actions->>Azure: Deploy to Static Web App
    Azure-->>Internet: App live at URL
    Internet-->>You: Visit your app!
```

---

## Quick Reference: Common Acronyms

| Acronym | Full Name | What It Means |
|---------|-----------|---------------|
| **AI** | Artificial Intelligence | Computer programs that learn and adapt |
| **API** | Application Programming Interface | How programs talk to each other |
| **CLI** | Command Line Interface | Text-based way to run commands |
| **CI/CD** | Continuous Integration/Deployment | Automated testing and deployment |
| **CSS** | Cascading Style Sheets | Language for styling web pages |
| **DOM** | Document Object Model | Browser's representation of web page |
| **HTML** | HyperText Markup Language | Structure of web pages |
| **HTTP** | HyperText Transfer Protocol | How browsers request web pages |
| **IDE** | Integrated Development Environment | Code editor with extra tools |
| **JSON** | JavaScript Object Notation | Data format (like XML but simpler) |
| **LTS** | Long Term Support | Stable version maintained for years |
| **MCP** | Model Context Protocol | Plugin system for AI assistants |
| **NPM** | Node Package Manager | Tool to install JavaScript libraries |
| **PR** | Pull Request | Propose code changes on GitHub |
| **SDK** | Software Development Kit | Tools to build with a platform |
| **SPA** | Single Page Application | Web app that doesn't reload pages |
| **SSH** | Secure Shell | Encrypted connection to remote computers |
| **UI/UX** | User Interface / User Experience | How apps look and feel |
| **URL** | Uniform Resource Locator | Web address (https://...) |
| **VM** | Virtual Machine | Simulated computer inside your computer |
| **WSL** | Windows Subsystem for Linux | Linux environment on Windows |
| **YAML** | YAML Ain't Markup Language | Configuration file format |

---

## Visual Learning: The Complete Picture

```mermaid
graph TD
    subgraph "Your Computer"
        WIN[Windows 11]
        WSL[WSL 2 Ubuntu]
        VSC[VS Code Insiders]
    end

    subgraph "Development"
        CODE[Write Code<br/>TypeScript/React]
        COPILOT[GitHub Copilot<br/>AI Assistant]
        GIT[Git<br/>Version Control]
    end

    subgraph "Testing"
        LOCAL[localhost:5173<br/>Preview in Browser]
        TESTS[Automated Tests<br/>Vitest]
    end

    subgraph "Deployment"
        GH[GitHub.com<br/>Code Repository]
        ACTIONS[GitHub Actions<br/>CI/CD Pipeline]
        AZURE[Azure Static Web Apps<br/>Production Hosting]
    end

    WIN --> WSL
    WIN --> VSC
    VSC --> CODE
    VSC --> COPILOT
    VSC --> GIT
    CODE --> LOCAL
    CODE --> TESTS
    GIT --> GH
    GH --> ACTIONS
    ACTIONS --> AZURE
    AZURE -.-> USERS[Users Access Your App]

    style COPILOT fill:#6e40c9,color:#fff
    style AZURE fill:#0078D4,color:#fff
    style USERS fill:#2ECC71,color:#fff
```

---

## Next Steps

Now that you understand the fundamentals, you're ready to start **Lab 1: Install WSL 2**.

**Pro Tip**: Keep this guide open in a browser tab as you work through the labs. Ctrl+F to search for any term you don't recognize!

---

*Last updated: February 2026*
