" Hello stranger. Please use `za` to toggle folds

  "" GENERIC
  set fileencodings=ucs-bom,utf-8,latin1 " Encoding for existing files
  scriptencoding UTF-8           " Character encodfing use in the script
  
  if has('vim')                  " Only in vim, ignore in nvim
    set shell=/usr/bin/zsh       " Set default shell to zsh
    set ttyfast                  " Improves smoothness on fast terminals
    set nocompatible             " Do not run in compatible mode (vi))
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
  
  set history=50      " keep 50 lines of command line history
  
  set relativenumber  " Show relative line numbers
  set number          " Show absolute line number on current line
  syntax on           " Enable syntax highlighting
  
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

  "" PLUGINS
  " Specify a directory for plugins
  " - Avoid using standard Vim directory names like 'plugin'
  call plug#begin('~/.vim/plugged')
  
  " FuzzyFinder
  Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --bin' }
  Plug 'junegunn/fzf.vim'
  
  " vim-airline: status and tabline
  Plug 'vim-airline/vim-airline'
  Plug 'vim-airline/vim-airline-themes'
  
  " Tagbar
  Plug 'git://github.com/majutsushi/tagbar'
  
  " VCS gutter
  Plug 'mhinz/vim-signify'
  
  " base16 colorscheme
  Plug 'chriskempson/base16-vim'
  "Plug 'morhetz/gruvbox'
  
  " Auto-pairs
  "Plug 'jiangmiao/auto-pairs'
  
  " Coloresque
  "Plug 'ap/vim-css-color'
  
  " Arduino
  "Plug 'stevearc/vim-arduino'
  
  " vim-sandwich (vim-suround alternative)
  Plug 'machakann/vim-sandwich'
  
  " ALE (asynchronous linting)
  "Plug 'dense-analysis/ale'
  
  Plug 'Yilin-Yang/vim-markbar'
  Plug 'junegunn/vim-peekaboo'
  
  Plug 'nelsyeung/twig.vim'
  
  " Fern
  Plug 'lambdalisue/fern.vim'
  Plug 'lambdalisue/nerdfont.vim'
  Plug 'lambdalisue/fern-renderer-nerdfont.vim'
  Plug 'antoinemadec/FixCursorHold.nvim'
  
  " Drupal 8
  "Plug 'https://git.drupalcode.org/project/vimrc.git', { 'branch': '8.x-1.x', 'rtp': 'bundle/vim-plugin-for-drupal' }
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
  colorscheme base16-default-dark
  hi Error guibg=#282828 guifg=#ab4642
  hi Error guibg=#282828 guifg=#fba922
  "set t_Co=256  " In case $TERM is not set correctly, this tells vim to use 256 colors
  "let base16colorspace=256

  "" ALE
  let g:ale_completion_enabled = 1
  let g:ale_lint_on_enter = 0
  let g:ale_lint_on_save = 1
  let g:ale_sign_error = '●'
  let g:ale_sign_warning = '.'

  "" CURSOR
  " Change cursor in Insert and Replace modes
  if exists('$TMUX')
  " tmux will only forward escape sequences to the terminal if surrounded by a
  " DCS sequence
    let &t_SI = "\<Esc>Ptmux;\<Esc>\<Esc>]50;CursorShape=1\x7\<Esc>\\"
    let &t_EI = "\<Esc>Ptmux;\<Esc>\<Esc>]50;CursorShape=0\x7\<Esc>\\"
    "let &t_SR .= "\<Esc>Ptmux;\<Esc>\<Esc>[4 q\<Esc>\\"
    "let &t_EI .= "\<Esc>Ptmux;\<Esc>\<Esc>[2 q\<Esc>\\"
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
  inoremap jk <ESC>
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

  " Fern
  noremap <Leader>t :Fern . -drawer -toggle<CR>
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
  
  " Autoclose
  inoremap ' ''<left>
  inoremap " ""<left>
  inoremap ` ``<left>
  inoremap ( ()<left>
  inoremap [ []<left>
  inoremap { {}<left>
  " Autoclose with ; at the end
  inoremap '; '';<left><left>
  inoremap `; ``;<left><left>
  inoremap "; "";<left><left>
  inoremap (; ();<left><left>
  inoremap [; [];<left><left>
  inoremap {; {};<left><left>
  " Autoclose with Enter
  inoremap {<CR> {<CR>}<ESC>O<Tab>
  inoremap {;<CR> {<CR>};<ESC>O<Tab>
  
  " FZF
  nnoremap <Leader>f :Files<CR>
  nnoremap <Leader>b :Buffers<CR>
  nnoremap <Leader>h :History<CR>
  " Ripgrep - Search in files
  nnoremap <leader><space> :Rg<CR>
  
  " Omni completion
  inoremap <C-Space> <C-x><C-o>
  " VIMDIFF
  if &diff
    nmap <C-j> ]c " Go to next change
    nmap <C-k> [c " Go to prevous change
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
  " NETRW
  let g:netrw_banner = 0 " Hode banner
  let g:netrw_altv = 1
  let g:netrw_winsize = 25
  
  " Bubble single lines
  "nmap <C-S-k> :m .-2<CR>
  "nmap <C-S-j> :m  .+1<CR>
  
  "W to save file with sudo
  "command W w !sudo tee > /dev/null %
  "command W :execute ':silent w sudo tee % > /dev/null' | :edit!
  " Open File manager
  " map <F2> :Vex<CR>

" vim:foldmethod=expr:foldexpr=getline(v\:lnum)=~'^\\s\\s'
