# Personal Utilities Collection

A comprehensive collection of development tools, scripts, and configurations for software development, research, and system administration tasks.

## 📁 Directory Structure

### `dev/` - Development Environment

- **Neovim Configuration**: `dev/dotfiles/.config/nvim` (see below for setup)
  - Copilot integration, code completion, linting
  - LaTeX snippets for mathematical note-taking
  - Custom keymaps and autocmds
- **Docker Environment**: Development container with customizable IP configuration
- **Tools**:
  - `fetch_github_issue.py`: Download GitHub issues with comments for offline viewing
  - `fetch_github_copilot_models.sh`: Retrieve GitHub Copilot model information

### `dev/dotfiles/` - Configuration Files

- **Neovim config**: `dev/dotfiles/.config/nvim`
- **Vim config**: `dev/dotfiles/.vimrc`
- **Shell, git, npm, and other configs**: All personal configuration files are organized under this directory.
- **Aider config**: `.aider.conf.yml` and `.aider.model.settings.yml` are in `dev/dotfiles/`

### `figure/` - Academic Figure Processing

- **LaTeX to SVG Conversion**: Convert mathematical expressions to scalable graphics
- **PDF Processing**: Crop and optimize PDF figures for publications
- **Gnuplot Integration**: Generate publication-quality plots and charts
- **Prerequisites**: Requires `texlive-extra-utils` and `pdftk`

### `research/` - Research Tools

- **Paper Discovery**: Search and retrieve academic papers from DBLP
- **Text Processing**: Remove revision marks and process academic documents
- **LaTeX Macros**: Common macros for academic writing

### `gist/` - Legacy Scripts  

- Historical utility scripts and quick automation tools
- Application data management utilities

### `windows/` - Windows Utilities

- System maintenance scripts for Windows environments
- Drive cleanup and management tools

## 🚀 Featured Tools

### GitHub Issue Fetcher

Download complete GitHub issues with all comments for offline reference and analysis.

```bash
python dev/tools/fetch_github_issue.py https://github.com/owner/repo/issues/123
```

**Features**:

- Handles API pagination automatically
- Supports GitHub token authentication for higher rate limits
- Chronological comment ordering
- Rich text formatting preservation

**Output**: `issue_owner_repo_123.txt` with complete issue thread

### Neovim Development Environment

Modern Vim configuration optimized for coding and academic writing.

**Setup**:

```bash
ln -s dev/dotfiles/.config/nvim ~/.config/nvim
```

**Key Features**:

- LazyVim plugin management
- GitHub Copilot integration
- LaTeX snippet support for mathematical notation
- Custom autocmds and keymaps for productivity

### Figure Processing Pipeline

Streamlined workflow for academic figure preparation.

**LaTeX to SVG**:

```bash
./figure/latex2svg.sh <a-compilable-latex-file>
```

**PDF Cropping**:

```bash
./figure/pdfcrop_inplace.sh document.pdf
```

### Research Paper Discovery

Search academic databases efficiently.

```bash
bash research/find_papers.sh 
```

## 🛠️ Installation & Setup

### Prerequisites

```bash
# For figure processing
apt-get install texlive-extra-utils pdftk

# For GitHub tools (optional)
export GITHUB_TOKEN="your_github_token"
```

### Quick Start

1. Clone the repository
2. Link configurations: `ln -s dev/dotfiles/.config/nvim ~/.config/nvim`
3. Install required packages based on tools you plan to use
4. Set environment variables as needed
