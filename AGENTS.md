# AGENTS.md

This is a **chezmoi dotfiles repository** for managing personal system configuration
across macOS and Linux. It contains shell scripts (Bash/Zsh), Neovim config (Lua),
and tool configuration files (YAML/TOML/JSON/INI). No templating is used; all cross-platform logic is handled at runtime via bash/zsh conditionals.

## Project Structure

```
bin/                    # Utility shell scripts (deployed to ~/bin/)
  dot_common            # Shared bash library sourced by all scripts
  executable_*          # Executable scripts (chezmoi prefix convention)
dot_config/             # Maps to ~/.config/
  git/                  # Git config (config, aliases, ignore via [include])
  nvim/                 # Neovim/LazyVim config (Lua) + stylua.toml
  zsh/                  # Zsh config (.zshrc, .zprofile, aliases, globalalias)
  ghostty/              # Terminal emulator config
  lazygit/              # LazyGit TUI config
  mise/                 # mise tool version manager config
  oh-my-posh/           # Shell prompt theme
  xh/                   # xh HTTP client config
docs/                   # macOS tips
dot_zshenv              # Maps to ~/.zshenv (XDG dirs, ZDOTDIR, PATH, LANG)
```

Chezmoi naming: `dot_` maps to `.` in target, `executable_` marks files executable.
No templating (`.tmpl`), `.chezmoiignore`, or `.chezmoiexternal` files are used.

## Build / Apply / Lint Commands

There is no traditional build system. This repo is managed by **chezmoi**.

```bash
chezmoi apply                             # Apply dotfiles to home directory
chezmoi diff                              # Preview pending changes
chezmoi edit <target-path>                # Edit source file (applies on save)
shellcheck bin/executable_*               # Lint all scripts
shellcheck bin/dot_common                 # Lint common library
shellcheck bin/executable_update          # Lint a single script
shfmt -w bin/executable_* bin/dot_common  # Format shell scripts
stylua dot_config/nvim/                   # Format Lua files
```

There are no tests, CI/CD, or pre-commit hooks. Linting and formatting are manual.

## Code Style Guidelines

### Shell Scripts (Bash)

#### File Structure

Every bash script must follow this exact order:
1. Shebang: `#!/usr/bin/env bash`
2. Header block with `=` borders containing script name, description, usage
3. Strict mode: `set -euo pipefail`
4. Source common library: `source "$(dirname "$0")/.common" || exit 1`
5. Constants/globals, then script-local helper functions, then main logic

```bash
#!/usr/bin/env bash
# =============================================================================
# script-name: Short description
# =============================================================================
# Description: Detailed explanation
# Usage: script-name [options]
# =============================================================================
set -euo pipefail
source "$(dirname "$0")/.common" || exit 1
```

When a script intentionally needs lenient error handling (e.g., must continue
past individual failures), comment out the line as `# set -euo pipefail` to signal
the omission was deliberate.

#### Naming Conventions

| Element          | Convention                        | Examples                              |
|------------------|-----------------------------------|---------------------------------------|
| File names       | lowercase, hyphen-separated       | `git-up`, `rm-ansi`, `update`         |
| Functions        | `snake_case`, grouped by prefix   | `msg_ok`, `err_exit`, `upgrade_brew`  |
| Constants        | `SCREAMING_SNAKE_CASE`            | `DRY_RUN`, `CACHE_FILE`, `DISTRO`    |
| Local variables  | `local lowercase_snake_case`      | `local msg`, `local fill_len`         |
| Color constants  | 3-letter uppercase abbreviations  | `BLK`, `RED`, `GRE`, `YEL`, `RST`    |

Function prefix groups: `msg_*` (output), `err_*` (errors), `upgrade_*` (updaters),
`is_*`/`in_*` (boolean checks), `only_*` (guard clauses that exit on failure).

#### Error Handling

Use the layered error handling system from `dot_common`:

```bash
require_cmd "fzf"                                    # exit if command missing
only_git 2 1                                         # exit if not in git repo
[[ ! -d "$DIRECTORY" ]] && err_exit "Not found"      # single-line guard
err_exit "File not found"                             # exit with code 1
err_return "Skipping item"                            # return from function
err_do "Bad input" exit 2                             # exit with custom code
cmd_exist brew && upgrade_brew                        # soft feature detection
source "$(dirname "$0")/.common" || exit 1            # hard fail on source
```

#### Common Patterns

- **Argument parsing**: `while [[ $# -gt 0 ]]; do case "$1" in ... esac; done`
- **Booleans**: String values (`DRY_RUN=false`), used as `$DRY_RUN && ...`
- **OS dispatch**: `case $OSTYPE in darwin*) ... ;; linux*) ... ;; esac`
- **Trap for cleanup**: `trap 'cd - >/dev/null' EXIT`
- **Safe arrays**: `mapfile -t arr < <(command)`
- **Script-local helpers**: Short wrappers defined after sourcing `.common`

#### Formatting

- **Indentation**: 2 spaces (never tabs); **Line width**: 120 characters max
- **Quoting**: Always double-quote variable expansions (`"$var"`, `"${arr[@]}"`)
- **Parameter expansion**: Use defaults via `${var:-default}`
- **File headers**: `# ===...===` borders; **Section dividers**: `######################################`
- **Function docs**: `# Description`, `# Usage:`, `# Parameters:` block above function
- **Inline comments**: End of line, aligned when in a group

### Lua (Neovim Config)

- Follows **LazyVim** conventions: `init.lua` -> `config/lazy.lua` -> `config/*.lua` -> `plugins/*.lua`
- **Indentation**: 2 spaces; **Line width**: 120 chars (configured in `stylua.toml`)
- **Formatter**: StyLua (`indent_type = "Spaces"`, `indent_width = 2`, `column_width = 120`)
- Use `---@param`, `---@class`, `---@type` LuaDoc annotations for type hints
- Plugin specs return tables from `plugins/*.lua` files
- Use `-- stylua: ignore` pragma to suppress formatting on specific lines

### Zsh Configuration

- **Loading order**: `dot_zshenv` (all shells) -> `dot_zprofile` (login) -> `dot_zshrc` (interactive)
- **Plugin manager**: [Zap](https://www.zapzsh.com/) (auto-installs)
- Zsh redefines helpers (`cmd_exist`, `source_if`, `eval_if`) since `.common` is bash-only
- **Section headers**: `# ----------[ Section Name ]------------------------------------------------`
- **Alias naming**: 1-2 char mnemonics; lowercase for safe ops (`ml`, `mi`),
  uppercase for destructive/info ops (`mD`, `mO`)
- **Global aliases**: UPPERCASE mnemonics (`G`, `C`, `NE`, `NIL`, `V`)
- Tool-specific alias blocks wrapped in `if cmd_exist <tool>; then ... fi`

### Other Config Files

- **Git config**: Split into `config`, `aliases`, `ignore` (via `[include]`).
  Modeline: `# vim: set ft=gitconfig ts=2 sw=2:`. Git config uses `########` section borders;
  aliases file uses emoji section headers (`### 📝 Cambios`). GPG signing enabled.
- **YAML**: Schema reference as first line: `# yaml-language-server: $schema=<url>`
- **TOML**: Schema reference (may be commented): `#schema = "<url>"`
- **All config files**: 2-space indent

## Cross-Platform Support

Scripts must handle both macOS and Linux. Use the helpers from `dot_common`:

```bash
in_linux && ...    # true on Linux
in_mac && ...      # true on macOS
only_linux         # exits if not Linux
only_mac           # exits if not macOS
get_distro         # returns: ubuntu, debian, fedora, arch, rhel, macos
```

## Git Conventions

- Default branch: `master`
- Commit messages: lowercase, imperative, concise
- Pull strategy: rebase (`pull.rebase = true`)
- Push: `autoSetupRemote = true`, prefer `--force-with-lease` over `--force`
- Fetch: `prune = true`
- Merge conflict style: `diff3`
- Rerere: enabled
- LazyGit branch prefix: `iax7/`
