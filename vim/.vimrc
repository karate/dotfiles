" Hello stranger. Please use `za` to toggle folds



"" GENERIC
set fileencodings=ucs-bom,utf-8,latin1 " Encoding for existing files
scriptencoding UTF-8           " Character encodfing use in the script

if has('vim')                  " Only in vim, ignore in nvim
  set shell=/usr/bin/zsh       " Set default shell to zsh
  set ttyfast                  " Improves smoothness on fast terminals
endif

set list                       " Show tabs and trailing spaces
set listchars=tab:→\ ,trail:⋅  " Define characters for tabs and trailing spaces
set nowrap                     " No word wrapping"

set exrc            " Enable per-project .vimrc files
set secure          " Disable shell and write commands in .exrc files
set modelineexpr    " Allow expressions in modeline

set hidden          " Enable hidden buffers

set hlsearch        " Highlight previous search matches
set incsearch       " Show search matches as you type
set ignorecase      " Ignore case in search patters
set smartcase       " Ignore case only if search pattern is lowercase

set noswapfile      " Disable swap file
set history=50      " keep 50 lines of command line history

set relativenumber  " Show relative line numbers
set number          " Show absolute line number on current line
set scrolloff=4     " Keep 4 lines visible around the curson line
syntax on           " Enable syntax highlighting
set noshowmode      " Disable Mode display on the last line

set wildmenu        " Command-line completion
set wildmode=longest:full,full

" Indent is 2 spaces.
set tabstop=2 softtabstop=2 expandtab shiftwidth=2 autoindent smartindent
" For python files, set indent to 4 spaces
augroup python_settings
  autocmd!
  let g:python_recommended_style=0
  autocmd FileType python setlocal tabstop=4 softtabstop=4 expandtab shiftwidth=4
augroup END
" For js files, set indent to 2 spaces
augroup javasrcript_settings
  autocmd!
  autocmd FileType javascript setlocal tabstop=2 softtabstop=2 noexpandtab shiftwidth=2
augroup END
" Recognize .drush and .module files as php
augroup drupal_drush_filetype
  au!
  autocmd BufNewFile,BufRead *.drush set filetype=php
  autocmd BufNewFile,BufRead *.module set filetype=php
augroup END
" Show cursorcolumn (vertical line at cursor position) in HTML files
augroup html_cursorcolumn
  au!
  autocmd BufNewFile,BufRead *.html set cursorcolumn
augroup END


"" PLUGINS
call plug#begin('~/.vim/plugged')
Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --bin' }
Plug 'junegunn/fzf.vim'
Plug 'chengzeyi/fzf-preview.vim'
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
Plug 'preservim/tagbar'
Plug 'mhinz/vim-signify'
Plug 'chriskempson/base16-vim'
Plug 'morhetz/gruvbox'
Plug 'jiangmiao/auto-pairs'
Plug 'aserebryakov/vim-todo-lists'
"Plug 'Yilin-Yang/vim-markbar'
Plug 'junegunn/vim-peekaboo'
Plug 'machakann/vim-sandwich'
" Fern
Plug 'lambdalisue/fern.vim'
Plug 'lambdalisue/nerdfont.vim'
Plug 'lambdalisue/fern-renderer-nerdfont.vim'
Plug 'antoinemadec/FixCursorHold.nvim'
"Plug 'ap/vim-css-color'
"Plug 'stevearc/vim-arduino'
"Plug 'https://git.drupalcode.org/project/vimrc.git', { 'branch': '8.x-1.x', 'rtp': 'bundle/vim-plugin-for-drupal' }

" Code completion and linting. Please chose one.
"Plug 'dense-analysis/ale'
"Plug 'Valloric/YouCompleteMe'
Plug 'neoclide/coc.nvim', {'branch': 'release'}
" Treesitter highlighting
Plug 'nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate'}
call plug#end()


"" AIRLINE-VIM
" Only load the following extentions
let g:airline_extentions = ['default', 'tabline']
let g:airline#extensions#disable_rtp_load = 1
let g:airline#extensions#tabline#enabled = 1


"" VIM-SIGNIFY
let g:signify_vcs_list = [ 'git', 'svn' ]


"" COLORS
set termguicolors " Enable 24-bit color in the TUI
colorscheme base16-gruvbox-dark-medium
hi Error guibg=#282828 guifg=#ab4642
hi Error guibg=#282828 guifg=#fba922
"set t_Co=256  " In case $TERM is not set correctly, this tells vim to use 256 colors
"let base16colorspace=256


"" ALE
"let g:ale_completion_enabled = 1
"let g:ale_lint_on_enter = 0
"let g:ale_lint_on_save = 1
"let g:ale_sign_error = '●'
"let g:ale_sign_warning = '.'


"" CURSOR
" Change cursor in Insert and Replace modes
if exists('$TMUX')
" tmux will only forward escape sequences to the terminal if surrounded by a
" DCS sequence
  "let &t_SI = "\<Esc>Ptmux;\<Esc>\<Esc>]50;CursorShape=1\x7\<Esc>\\"
  "let &t_EI = "\<Esc>Ptmux;\<Esc>\<Esc>]50;CursorShape=0\x7\<Esc>\\"
  let &t_SR .= "\<Esc>Ptmux;\<Esc>\<Esc>[4 q\<Esc>\\"
  let &t_EI .= "\<Esc>Ptmux;\<Esc>\<Esc>[2 q\<Esc>\\"
  "let &t_SI .= "\e[=1c"
  "let &t_EI .= "\e[=2c"
else
  let &t_SI = "\<Esc>[6 q"
  let &t_SR = "\<Esc>[4 q"
  let &t_EI = "\<Esc>[2 q"
endif

" Set cursorline in Normal and Visual mode
autocmd InsertEnter * set nocul
autocmd InsertLeave * set cul


"" KEY MAPS
" Leave insert mode
"inoremap jk <ESC>

" Next/Previous window (split)
nmap <Tab> <C-W>w
nmap <S-Tab> <C-W>W
" Make windows (splits) equal
nmap = <C-W>=
nnoremap <Leader>. :vertical resize +10<CR>
nnoremap <Leader>, :vertical resize -10<CR>

" Leader key
let mapleader = ' '
" Next/Previous Buffer
nmap <Leader>j :bn!<CR>
nmap <Leader>k :bp!<CR>
" Update Buffer (save only if changed)
nmap <Leader>w :up<CR>
" Quit
nmap <Leader>q :q<CR>
" Close buffer
nnoremap <Leader>d :bd!<CR>

" Fern
noremap <Leader>t :Fern . -drawer -toggle -width=60 -reveal=%<CR>
let g:fern#renderer = "nerdfont"

" F8 to clear drupal cache
if has('nvim')
  nmap <silent> <F8> :! echo -e "[`date +\%H:\%M:\%S`] Clearing cache..."; drush cc all<CR>
else
  nmap <F8> :execute 'silent !echo -e "\n[`date +\\%H:\\%M:\\%S`] Clearing cache..."; drush cc all' \| redraw!<CR>
endif

" F9 to open Tagbar
nmap <F9> :TagbarOpenAutoClose<CR>

" Shame user for using ESC in vain
if has('nvim')
  nnoremap <Esc> :silent exec "!date >> ~/.vim_shame"<CR>
endif
" Scroll one line up/down
nnoremap <C-j> <C-e>
nnoremap <C-k> <C-y>

"" Autoclose
"inoremap ' ''<left>
"inoremap " ""<left>
"inoremap ` ``<left>
"inoremap ( ()<left>
"inoremap [ []<left>
"inoremap { {}<left>
"" Autoclose with ; at the end
"inoremap '; '';<left><left>
"inoremap `; ``;<left><left>
"inoremap "; "";<left><left>
"inoremap (; ();<left><left>
"inoremap [; [];<left><left>
"inoremap {; {};<left><left>
"" Autoclose with Enter
"inoremap {<CR> {<CR>}<ESC>O<Tab>
"inoremap {;<CR> {<CR>};<ESC>O<Tab>

" fzf-preview
nnoremap <Leader>f :Files<CR>
nnoremap <Leader>b :Buffers<CR>
nnoremap <Leader>h :History<CR>
" Use fzf-preview
nnoremap <Leader>m :FZFMarks<CR>
" Ripgrep - Search in files
" Use fzf-preview
nnoremap <leader><space> :FZFRg<CR>

" Omni completion
inoremap <C-Space> <C-x><C-o>

" vimdiff
if &diff
  nmap <C-j> ]c " Go to next change
  nmap <C-k> [c " Go to prevous change
  nmap <F1> :qa<CR> " Close both splits
endif
" Copy to system clipboard
nnoremap <leader>y "+y
vnoremap <leader>y "+y
" Paste from system clipboad
nnoremap <leader>p "+p
vnoremap <leader>p "+p

" change working directory
nnoremap <leader>cd :lcd %:p:h<CR>:pwd<CR>

" Clear search highlight
map <leader>/ :nohlsearch<CR>

" Select pasted text
nnoremap gp `[v`]
nmap gd <Plug>(coc-definition)

" Treesitter
if has('nvim')
  lua <<EOF
  require'nvim-treesitter.configs'.setup {
    highlight = {
      enable = true
    },
    incremental_selection = {
      enable = true,
      keymaps = {
        init_selection = "gnn",
        node_incremental = "grn",
        scope_incremental = "grc",
        node_decremental = "grm",
      },
    },
  }
EOF
endif

" Bubble single lines
"nmap <C-S-k> :m .-2<CR>
"nmap <C-S-j> :m  .+1<CR>

"W to save file with sudo
"command W w !sudo tee > /dev/null %
"command W :execute ':silent w sudo tee % > /dev/null' | :edit!
" Open File manager
" map <F2> :Vex<CR>


"" NETRW
let g:netrw_banner = 0 " Hide banner
let g:netrw_altv = 1
let g:netrw_winsize = 25


" Automatically fold on two empty lines
" vim:foldmethod=expr:foldexpr=getline(v\:lnum)=~'^$'&&getline(v\:lnum+1)=~'^$'?'<1'\:1
