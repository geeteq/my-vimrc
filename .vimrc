" ============================================================================
" ~/.vimrc — sensible defaults, syntax colors, custom statusline
" No external plugins required.
" ============================================================================

" --- Core behavior ----------------------------------------------------------
set nocompatible                " disable vi compatibility
filetype plugin indent on       " filetype detection + plugins + indent
syntax enable                   " syntax highlighting on
set encoding=utf-8
set fileencodings=ucs-bom,utf-8,default,latin1
set hidden                      " allow switching buffers w/o saving
set autoread                    " reload files changed outside vim
set backspace=indent,eol,start  " sane backspace
set mouse=                      " mouse off — let the terminal handle selection/copy
set clipboard^=unnamed,unnamedplus
set ttyfast
set lazyredraw                  " don't redraw while executing macros
set updatetime=300
set timeoutlen=500
set history=1000
set undolevels=1000
set undofile
set undodir=~/.vim/undo//
set backupdir=~/.vim/backup//
set directory=~/.vim/swap//

" Create those dirs if missing
for s:dir in ['~/.vim/undo', '~/.vim/backup', '~/.vim/swap']
  if !isdirectory(expand(s:dir))
    call mkdir(expand(s:dir), 'p')
  endif
endfor

" --- UI ---------------------------------------------------------------------
set number                      " line numbers
set norelativenumber            " absolute line numbers (no jitter on cursor move)
set cursorline                  " highlight current line
set ruler                       " show cursor position
set showcmd                     " show pending command
set showmatch                   " highlight matching brackets
set wildmenu                    " command-line completion menu
set wildmode=longest:full,full
set wildignore+=*.o,*.obj,*.pyc,*.class,*.swp,.git,.DS_Store,node_modules
set scrolloff=8                 " keep 8 lines visible above/below cursor
set sidescrolloff=8
set numberwidth=3               " tight number column (shifts numbers left)
set signcolumn=yes              " always show sign column (used as separator bar)
set splitbelow splitright       " more natural split positions
set termguicolors               " 24-bit color
set background=dark
set noerrorbells novisualbell
set shortmess+=cI               " no intro, no completion-menu noise
set laststatus=2                " always show statusline
set noshowmode                  " statusline shows mode, hide default

" Hidden whitespace off by default — toggle with <leader>l
let g:show_list = 0
set nolist
set listchars=eol:¬,tab:▸\ ,trail:·,nbsp:␣,extends:»,precedes:«
augroup ForceList
  autocmd!
  autocmd BufWinEnter,WinEnter * if &buftype ==# ''
        \ | execute 'setlocal ' . (get(g:, 'show_list', 1) ? 'list' : 'nolist')
        \ | endif
augroup END
function! ToggleList() abort
  let g:show_list = !get(g:, 'show_list', 1)
  windo if &buftype ==# '' | execute 'setlocal ' . (g:show_list ? 'list' : 'nolist') | endif
  echo 'listchars ' . (g:show_list ? 'shown' : 'hidden — clean copy mode')
endfunction
" Dim the listchars so they don't drown out the code
highlight NonText    guifg=#3a3a3a guibg=NONE
highlight SpecialKey guifg=#3a3a3a guibg=NONE
highlight Whitespace guifg=#3a3a3a guibg=NONE

" --- Search -----------------------------------------------------------------
set ignorecase smartcase        " case-insensitive unless capital used
set incsearch hlsearch          " incremental + highlighted search

" --- Indentation ------------------------------------------------------------
set autoindent smartindent
set expandtab                   " spaces, not tabs
set tabstop=4 softtabstop=4 shiftwidth=4
set shiftround
set smarttab

" Per-language overrides
augroup IndentByFiletype
  autocmd!
  autocmd FileType yaml,json,html,css,scss,javascript,typescript,vue,jsx,tsx,ruby,lua
        \ setlocal tabstop=2 softtabstop=2 shiftwidth=2
  autocmd FileType make,go setlocal noexpandtab
augroup END

" --- Colors -----------------------------------------------------------------
" High-contrast base scheme
silent! colorscheme habamax
if !exists('g:colors_name') || g:colors_name ==# ''
  silent! colorscheme desert
endif

" Pure-black background, near-white text — maximum contrast
highlight Normal        guibg=#000000 guifg=#f8f8f2
highlight NonText       guibg=#000000 guifg=#3a3a3a
highlight EndOfBuffer   guibg=#000000 guifg=#3a3a3a
highlight SignColumn    guibg=#000000
highlight VertSplit     guibg=#000000 guifg=#444444

" Syntax — saturated, high-contrast palette
highlight Comment       cterm=italic gui=italic guifg=#9a9a9a
highlight Constant      guifg=#ff9d5c
highlight String        guifg=#5cff8f
highlight Number        guifg=#ffb86c
highlight Boolean       guifg=#ff79c6 gui=bold
highlight Identifier    guifg=#82e9ff
highlight Function      guifg=#82e9ff gui=bold
highlight Statement     guifg=#ff79c6 gui=bold
highlight Conditional   guifg=#ff79c6 gui=bold
highlight Repeat        guifg=#ff79c6 gui=bold
highlight Operator      guifg=#ffffff
highlight Keyword       guifg=#ff79c6 gui=bold
highlight PreProc       guifg=#ffd866
highlight Type          guifg=#ffe066 gui=bold
highlight Special       guifg=#ff5cf0
highlight Todo          guibg=#ffea00 guifg=#000000 gui=bold

" UI chrome
highlight LineNr        guibg=#000000 guifg=#6e6e6e
highlight CursorLineNr  guibg=#1a1a1a guifg=#ffea00 gui=bold
" Subtle cyan vertical separator bar between line numbers and text
highlight SignColumn    guibg=#003a52 guifg=#003a52
highlight CursorLine    guibg=#1a1a1a
highlight Visual        guibg=#005f87 guifg=#ffffff
highlight MatchParen    guibg=#ffea00 guifg=#000000 gui=bold
highlight Search        guibg=#ffea00 guifg=#000000 gui=bold
highlight IncSearch     guibg=#ff5f00 guifg=#000000 gui=bold
highlight Pmenu         guibg=#1a1a1a guifg=#ffffff
highlight PmenuSel      guibg=#005faf guifg=#ffffff gui=bold
highlight Folded        guibg=#1a1a1a guifg=#cccccc
highlight ColorColumn   guibg=#1a1a1a

" Diff
highlight DiffAdd       guibg=#003f00 guifg=#a8ff60
highlight DiffChange    guibg=#003f5c guifg=#ffffff
highlight DiffDelete    guibg=#5f0000 guifg=#ff6b6b
highlight DiffText      guibg=#005f87 guifg=#ffffff gui=bold

" Trailing whitespace highlight
highlight ExtraWhitespace guibg=#ff0000
match ExtraWhitespace /\s\+$/
augroup TrailingWhitespace
  autocmd!
  autocmd BufWinEnter,InsertLeave * match ExtraWhitespace /\s\+$/
  autocmd InsertEnter * match ExtraWhitespace /\s\+\%#\@<!$/
  autocmd BufWinLeave * call clearmatches()
augroup END

" --- Statusline -------------------------------------------------------------
function! StatusMode() abort
  let l:m = mode()
  let l:map = {
        \ 'n':  'NORMAL', 'i': 'INSERT', 'v': 'VISUAL',
        \ 'V':  'V-LINE', "\<C-v>": 'V-BLOCK',
        \ 'c':  'COMMAND', 'R': 'REPLACE', 't': 'TERMINAL', 's': 'SELECT' }
  return get(l:map, l:m, l:m)
endfunction

function! StatusGitBranch() abort
  if exists('*FugitiveHead')
    let l:b = FugitiveHead()
    return empty(l:b) ? '' : ' ' . l:b . ' '
  endif
  let l:head = ''
  let l:dir = finddir('.git', expand('%:p:h') . ';')
  if !empty(l:dir)
    let l:headfile = l:dir . '/HEAD'
    if filereadable(l:headfile)
      let l:line = readfile(l:headfile, '', 1)
      if !empty(l:line) && l:line[0] =~# '^ref: '
        let l:head = ' ' . substitute(l:line[0], '^ref: refs/heads/', '', '') . ' '
      endif
    endif
  endif
  return l:head
endfunction

function! StatusFileSize() abort
  let l:b = getfsize(expand('%:p'))
  if l:b <= 0 | return '' | endif
  if l:b < 1024 | return l:b . 'B' | endif
  if l:b < 1048576 | return printf('%.1fK', l:b / 1024.0) | endif
  return printf('%.1fM', l:b / 1048576.0)
endfunction

" Statusline color groups — high contrast
highlight StlMode        guibg=#00afff guifg=#000000 gui=bold
highlight StlModeInsert  guibg=#00ff5f guifg=#000000 gui=bold
highlight StlModeVisual  guibg=#ff5fff guifg=#000000 gui=bold
highlight StlModeReplace guibg=#ff3333 guifg=#000000 gui=bold
highlight StlModeCommand guibg=#ffea00 guifg=#000000 gui=bold
highlight StlBranch      guibg=#1a1a1a guifg=#ffea00 gui=bold
highlight StlFile        guibg=#0d0d0d guifg=#ffffff gui=bold
highlight StlInfo        guibg=#1a1a1a guifg=#f0f0f0
highlight StlPercent     guibg=#00afff guifg=#000000 gui=bold
highlight StlLine        guibg=#00ff5f guifg=#000000 gui=bold

function! StatusModeColor() abort
  let l:m = mode()
  if l:m ==# 'i'                    | return '%#StlModeInsert#'
  elseif l:m =~# "^[vV\<C-v>]$"     | return '%#StlModeVisual#'
  elseif l:m ==# 'R'                | return '%#StlModeReplace#'
  elseif l:m ==# 'c'                | return '%#StlModeCommand#'
  endif
  return '%#StlMode#'
endfunction

function! BuildStatusline() abort
  let l:s = ''
  let l:s .= '%{StatusModeColor()} ' . StatusMode() . ' '
  let l:s .= '%#StlBranch#%{StatusGitBranch()}'
  let l:s .= '%#StlFile# %f %m%r '
  let l:s .= '%='
  let l:s .= '%#StlInfo# %{&filetype} | %{&fileencoding?&fileencoding:&encoding} | %{&fileformat} '
  let l:s .= '%#StlInfo# %{StatusFileSize()} '
  let l:s .= '%#StlPercent# %p%% '
  let l:s .= '%#StlLine# %l:%c '
  return l:s
endfunction

set statusline=%!BuildStatusline()

augroup StatuslineRedraw
  autocmd!
  autocmd ModeChanged,BufEnter,WinEnter * redrawstatus
augroup END

" --- Tabline ----------------------------------------------------------------
set showtabline=2
highlight TabLineSel  guibg=#00afff guifg=#000000 gui=bold
highlight TabLine     guibg=#1a1a1a guifg=#cccccc gui=NONE
highlight TabLineFill guibg=#000000 guifg=#000000

" --- Netrw (built-in file explorer) -----------------------------------------
let g:netrw_banner    = 0
let g:netrw_liststyle = 3       " tree view
let g:netrw_winsize   = 22
let g:netrw_browse_split = 4

" --- Key mappings -----------------------------------------------------------
let mapleader = ' '

" Quick save / quit
nnoremap <leader>w :w<CR>
nnoremap <leader>q :q<CR>
nnoremap <leader>Q :qa!<CR>

" Clear search highlight
nnoremap <silent> <leader><space> :nohlsearch<CR>

" Toggle listchars display (for clean text copy)
nnoremap <silent> <leader>l :call ToggleList()<CR>

" Better window navigation
" <C-l> intentionally NOT remapped — reserved for redraw + :nohlsearch below.
" Use <C-w>l for window-right (vim default).
nnoremap <C-h> <C-w>h
nnoremap <C-j> <C-w>j
nnoremap <C-k> <C-w>k

" Ctrl-L: redraw screen and clear search highlight (vim's default + :nohl)
nnoremap <silent> <C-l> :nohlsearch<bar>diffupdate<CR><C-l>

" Resize splits
nnoremap <silent> <C-Up>    :resize +2<CR>
nnoremap <silent> <C-Down>  :resize -2<CR>
nnoremap <silent> <C-Left>  :vertical resize -2<CR>
nnoremap <silent> <C-Right> :vertical resize +2<CR>

" Buffer navigation (avoid mapping <Tab> — it collides with <C-i> jump-forward)
nnoremap <silent> ]b :bnext<CR>
nnoremap <silent> [b :bprevious<CR>
nnoremap <silent> <leader>x :bdelete<CR>

" Stay in visual mode after indent
vnoremap < <gv
vnoremap > >gv

" Move selected lines up/down
vnoremap J :m '>+1<CR>gv=gv
vnoremap K :m '<-2<CR>gv=gv

" Toggle file explorer
nnoremap <silent> <leader>e :Lexplore<CR>

" Yank to end of line behaves like D and C
nnoremap Y y$

" Keep cursor centered on big jumps
nnoremap n nzzzv
nnoremap N Nzzzv
nnoremap <C-d> <C-d>zz
nnoremap <C-u> <C-u>zz

" --- Useful misc ------------------------------------------------------------
" Restore cursor position on file open
augroup RestoreCursor
  autocmd!
  autocmd BufReadPost *
        \ if line("'\"") > 1 && line("'\"") <= line("$") && &filetype !~# 'commit'
        \ |   execute "normal! g`\""
        \ | endif
augroup END

" Strip trailing whitespace on save (toggle with :let g:strip_ws=0)
" Skipped for filetypes where trailing whitespace is meaningful
let g:strip_ws = 1
let g:strip_ws_skip_ft = ['markdown', 'diff', 'patch', 'mail', 'gitcommit']
function! StripTrailingWhitespace() abort
  if get(g:, 'strip_ws', 1) == 0 | return | endif
  if index(g:strip_ws_skip_ft, &filetype) >= 0 | return | endif
  let l:save = winsaveview()
  keeppatterns %s/\s\+$//e
  call winrestview(l:save)
endfunction
augroup StripWS
  autocmd!
  autocmd BufWritePre * call StripTrailingWhitespace()
augroup END
