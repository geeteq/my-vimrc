# my-vimrc

My personal `~/.vimrc` — zero plugins, just sensible defaults, high-contrast colors, and a custom statusline.

## Install

```sh
# Back up your existing config first
cp ~/.vimrc ~/.vimrc.bak 2>/dev/null

# Drop this one in
curl -fsSL https://raw.githubusercontent.com/geeteq/my-vimrc/main/.vimrc -o ~/.vimrc
```

Open vim — directories for undo/swap/backup are auto-created on first launch.

## What's in it

### Core behavior
- `nocompatible`, filetype detection + indent plugins, syntax on
- `hidden` buffers, `autoread`, system clipboard integration
- **Mouse off** by default — terminal handles native text selection (so macOS Cmd-C works on selected text)
- Persistent undo, swap, and backup files in `~/.vim/{undo,swap,backup}` (auto-created)

### UI
- Absolute line numbers (no relative-number jitter as the cursor moves)
- Tight `numberwidth=3` so numbers sit closer to the code
- `cursorline` highlighting current line
- Always-on signcolumn rendered as a subtle dim-cyan vertical separator bar between line numbers and code
- 24-bit color (`termguicolors`), dark background, no bells
- `scrolloff=8` keeps 8 lines of context above/below the cursor
- Splits open below and to the right (more natural)

### Search
- `ignorecase` + `smartcase` (case-insensitive unless you type a capital)
- `incsearch` + `hlsearch`
- `<leader><space>` clears highlights

### Indentation
- 4 spaces by default, `expandtab`, `smartindent`
- 2 spaces for: yaml, json, html, css, scss, javascript, typescript, vue, jsx, tsx, ruby, lua
- Real tabs for: make, go

### Colors
- Base: `habamax` (built-in), pure-black background, near-white text
- Saturated, high-contrast syntax palette:
  - cyan functions/identifiers
  - hot-pink keywords
  - neon green strings
  - bright orange numbers
  - yellow types
- Diff colors with deep saturated backgrounds
- Trailing whitespace highlighted in red, auto-stripped on save (toggle: `:let g:strip_ws=0`; skipped for `markdown`, `diff`, `patch`, `mail`, `gitcommit`)

### Hidden whitespace display
Off by default for clean copy-paste. Toggle with `<leader>l` to show:

| Marker | Means              |
|--------|--------------------|
| `¬`    | end of line        |
| `▸`    | tab character      |
| `·`    | trailing space     |
| `␣`    | non-breaking space |
| `»` `«`| line overflow      |

Markers are dim grey so they don't compete with code.

### Statusline (custom, no plugins)
Color-coded by mode:

| Mode    | Color   |
|---------|---------|
| NORMAL  | cyan    |
| INSERT  | green   |
| VISUAL  | magenta |
| REPLACE | red     |
| COMMAND | yellow  |

Shows: mode · git branch · filename + modified/readonly flags · filetype · encoding · fileformat · file size · cursor percent · line:col

Git branch detection works without any plugin — reads `.git/HEAD` directly. Uses `FugitiveHead()` if [vim-fugitive](https://github.com/tpope/vim-fugitive) happens to be installed.

### Tabline
Always visible (`showtabline=2`), styled to match the statusline.

### File explorer
Built-in netrw, configured as a tree view. Toggle with `<leader>e`.

## Key mappings

Leader key: `<Space>`

| Mapping             | Action                          |
|---------------------|---------------------------------|
| `<leader>w`         | Save                            |
| `<leader>q`         | Quit                            |
| `<leader>Q`         | Quit all (force)                |
| `<leader><space>`   | Clear search highlight          |
| `<leader>l`         | Toggle hidden whitespace display|
| `<leader>e`         | Toggle file explorer (netrw)    |
| `<leader>x`         | Delete buffer                   |
| `<C-h/j/k/l>`       | Navigate splits                 |
| `<C-Up/Down/L/R>`   | Resize splits                   |
| `]b` / `[b`         | Next / previous buffer          |
| `Y`                 | Yank to end of line (like D, C) |
| `n` / `N`           | Search next/prev, centered      |
| `<C-d>` / `<C-u>`   | Half-page scroll, centered      |
| `J` / `K` (visual)  | Move selected lines down/up     |
| `<` / `>` (visual)  | Indent and stay in visual mode  |

## Misc

- Cursor position restored when reopening a file
- Trailing whitespace auto-stripped on save
- Wildmenu with sensible ignores (`.git`, `node_modules`, `*.pyc`, etc.)
