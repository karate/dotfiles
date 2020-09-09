" Hello stranger. Please use `za` to toggle folds

  "" ENCODING
  if v:lang =~ "utf8$" || v:lang =~ "UTF-8$"
    set fileencodings=ucs-bom,utf-8,latin1
  endif
  
  set encoding=UTF-8
  scriptencoding utf-8
  set shell=/usr/bin/zsh

  "" GENERIC
  " enable per-project .vimrc files
  set exrc
  set secure
  set modelineexpr
  
  " Enable hidden buffers
  set hidden
  
  set incsearch     " show search matches as you type
  set nocompatible  " Use Vim defaults (much better!)
  " read/write a .viminfo file, don't store more
  " than 50 lines of registers
  set viminfo='20,\"50
  
  set history=50    " keep 50 lines of command line history
  set ruler         " show the cursor position all the time
  let mapleader = "\<Space>"
  
  syntax on
  set hlsearch
  
  " Command suggestions
  set wildmenu
  set wildmode=longest:full,full
  
  " Indent is 2 spaces.
  set tabstop=2 softtabstop=2 expandtab shiftwidth=2 autoindent smartindent
  
  " Show line numbers
  set number
  " Show relative line numbers
  set relativenumber
  
  " Show tabs and trailing spaces
  set list
  set listchars=tab:→\ ,trail:⋅
  set nowrap
  
  set lazyredraw
  set ttyfast
  
  " hide coc warning on nvim version
  " let g:coc_disable_startup_warning = 1
  " Onmi completion: do not select the first match, and show the popup
  " even when there's only one match.
  set completeopt=longest,menuone

  "" PLUGINS
  " Specify a directory for plugins
  " - Avoid using standard Vim directory names like 'plugin'
  call plug#begin('~/.vim/plugged')
  
  " COC
  " Plug 'neoclide/coc.nvim', {'branch': 'release'}
  
  " FuzzyFinder
  Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --bin' }
  Plug 'junegunn/fzf.vim'
  
  " vim-airline: lean & mean status/tabline for vim that's light as air
  Plug 'vim-airline/vim-airline'
  Plug 'vim-airline/vim-airline-themes'
  
  " Tagbar
  Plug 'git://github.com/majutsushi/tagbar'
  
  " VCS gutter
  Plug 'mhinz/vim-signify'
  
  " VDebug
  "Plug 'vim-vdebug/vdebug'
  
  " base16 colorscheme
  Plug 'chriskempson/base16-vim'
  
  " Auto-pairs
  Plug 'jiangmiao/auto-pairs'
  
  " dadbod (DB interface)
  "Plug 'tpope/vim-dadbod'
  
  " vim-sandwich (vim-suround alternative)
  Plug 'machakann/vim-sandwich'
  call plug#end()

  "" AIRLINE-VIM
  " Only load the following extentions
  let g:airline_extentions = ['default', 'tagbar', 'tabline']
  let g:airline#extensions#disable_rtp_load = 1
  let g:airline#extensions#tabline#enabled = 1

  "" VIM-SIGNIFY
  let g:signify_vcs_list = [ 'git', 'svn' ]

  "" COLORS
  set t_Co=256
  set termguicolors
  let base16colorspace=256
  colorscheme base16-default-dark
  let g:airline_theme='base16_default'

  "" CURSOR
  " Change cursor in Insert and Replace modes
  if exists('$TMUX')
  " tmux will only forward escape sequences to the terminal if surrounded by a
  " DCS sequence
    let &t_SI .= "\<Esc>Ptmux;\<Esc>\<Esc>[6 q\<Esc>\\"
    let &t_SR .= "\<Esc>Ptmux;\<Esc>\<Esc>[4 q\<Esc>\\"
    let &t_EI .= "\<Esc>Ptmux;\<Esc>\<Esc>[2 q\<Esc>\\"
  else
    let &t_SI = "\<Esc>[6 q"
    let &t_SR = "\<Esc>[4 q"
    let &t_EI = "\<Esc>[2 q"
  endif
  
  " Set cursorline in Normal and Visual mode
  autocmd InsertEnter * set nocul
  autocmd InsertLeave * set cul

  "" KEY MAPS
  " Leader key
  let mapleader = " "
  " Cycle through windows (splits) with TAB and Shift-TAB
  nmap <Tab> <C-W>w
  nmap <S-Tab> <C-W>W
  
  " resize windows (splits) to make them equal
  nmap = <C-W>=
  
  " Cycle through buffers with Control-PageUp and Control-PageDown
  " For urxvt
  "set <PageUp>=^[[5~
  "set <PageDown>=^[[4~
  
  nmap <C-PageUp> :bp!<CR>
  "nmap ^[[5^ :bp!<CR>
  nmap <C-PageDown> :bn!<CR>
  "nmap ^[[6^ :bn!<CR>
  
  " Bubble single lines
  "nmap <C-S-k> :m .-2<CR>
  "nmap <C-S-j> :m  .+1<CR>
  
  " jk to enter normal mode
  inoremap jk <ESC>
  
  "W to save file with sudo
  "command W w !sudo tee > /dev/null %
  "command W :execute ':silent w sudo tee % > /dev/null' | :edit!
  " Open File manager
  map <F2> :Vex<CR>
  
  " F8 to clear drupal cache
  if has('nvim')
    nmap <silent> <F8> :! echo -e "[`date +\\%H:\\%M:\\%S`] Clearing cache..."; drush cc all<CR>
  else
    nmap <F8> :execute 'silent !echo -e "\n[`date +\\%H:\\%M:\\%S`] Clearing cache..."; drush cc all' \| redraw!<CR>
  endif
  
  " F9 to open Tagbar
  nmap <F9> :TagbarToggle<CR>
  
  " Shame user for using ESC in vain
  if has('nvim')
    nnoremap <Esc> :silent exec "!date >> ~/.vim_shame"<CR>
  else
    " nmap <Esc> :silent !date >> ~/.vim_shame'<CR>:redraw!<CR>
  endif
  
  nnoremap <C-k> <C-y>
  nnoremap <C-j> <C-e>
  " Window resize
  "nnoremap <C-.> :vertical resize +10<CR>
  "nnoremap <C-,> :vertical resize -10<CR>
  
  " Using auto-pairs.vim instead
  "inoremap " ""<left>
  "inoremap ' ''<left>
  "inoremap ( ()<left>
  "inoremap [ []<left>
  "inoremap { {}<left>
  "inoremap {<CR> {<CR>}<ESC>O<Tab>
  "inoremap {;<CR> {<CR>};<ESC>O<Tab>
  
  nnoremap <C-P> :Files<CR>
  nnoremap <C-B> :Buffers<CR>
  nnoremap <C-H> :History<CR>
  " Ripgrep - Search in files
  nnoremap <leader><space> :Rg<CR>
  
  " Omni completion
  inoremap <C-Space> <C-x><C-o>
  inoremap <C-@> <C-Space>
  " VIMDIFF
  if &diff
    " Next/previous diff
    nmap <C-j> ]c
    nmap <C-k> [c
  endif
  
  " Disable arrow keys
  nnoremap <Up> <Nop>
  nnoremap <Down> <Nop>
  nnoremap <Left> <Nop>
  nnoremap <Right> <Nop>
  
  " Copy to system clipboard
  nnoremap <leader>y "+y
  vnoremap <leader>y "+y
  " Paste from system clipboad
  nnoremap <leader>p "+p
  
  " change working directory
  nnoremap <leader>cd :lcd %:p:h<CR>:pwd<CR>
  
  " Clear search highlight
  map <leader>/ :nohlsearch<CR>
  " Go to next function definition
  nnoremap <Leader>f ]m
  " Go to previous function definition
  nnoremap <Leader>F [m
  " Replace word under cursor
  nmap <Leader>s :%s/\<<C-r><C-w>\>//gI<Left><Left><Left>

  " NETRW
  let g:netrw_banner = 0
  let g:netrw_liststyle = 0
  " 0 - open files in the same window  (default))
  " 1 - open files in a new horizontal split
  " 2 - open files in a new vertical split
  " 3 - open files in a new tab
  " 4 - open in previous window
  let g:netrw_browse_split = 0
  "=0: re-using the same window  (default)
  "=1: horizontally splitting the window first
  "=2: vertically   splitting the window first
  "=3: open file in new tab
  "=4: act like "P"
  
  let g:netrw_altv = 1
  let g:netrw_winsize = 25

" vim:foldmethod=expr:foldexpr=getline(v\:lnum)=~'^\\s\\s'
