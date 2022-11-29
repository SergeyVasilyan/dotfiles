" A tab produces a 4-space indentation
set softtabstop=4
set shiftwidth=4
set tabstop=4
set expandtab
set hlsearch
set modeline
set incsearch
set spell
set ignorecase
"set mouse=a
"set number
" show a visual line under the cursor's current line
set cursorline
" show the matching part of the pair for [] {} and ()
set showmatch
" enable all Python syntax highlighting features
let python_highlight_all = 1

" Lines longer than 80 columns.
2mat ErrorMsg '\%101v.'
" Highlight trailing whitespace and lines longer than 80 columns.
highlight LongLine ctermbg=DarkYellow guibg=DarkYellow
highlight WhitespaceEOL ctermbg=DarkYellow guibg=DarkYellow
if v:version >= 702
  " Lines longer than 80 columns.
  "au BufWinEnter * let w:m0=matchadd('LongLine', '\%>80v.\+', -1)

  " Whitespace at the end of a line. This little dance suppresses
  " whitespace that has just been typed.
  au BufWinEnter * let w:m1=matchadd('WhitespaceEOL', '\s\+$', -1)
  au InsertEnter * call matchdelete(w:m1)
  au InsertEnter * let w:m2=matchadd('WhitespaceEOL', '\s\+\%#\@<!$', -1)
  au InsertLeave * call matchdelete(w:m2)
  au InsertLeave * let w:m1=matchadd('WhitespaceEOL', '\s\+$', -1)
else
  au BufRead,BufNewFile * syntax match LongLine /\%>80v.\+/
  au InsertEnter * syntax match WhitespaceEOL /\s\+\%#\@<!$/
  au InsertLeave * syntax match WhitespaceEOL /\s\+$/
endif

" Enable filetype detection
filetype on

" Optional
" C/C++ programming helpers
augroup csrc
  au!
  autocmd FileType *      set nocindent smartindent
  autocmd FileType c,cpp  set cindent
augroup END
" Set a few indentation parameters. See the VIM help for cinoptions-values for
" details.
set cinoptions=:0,g0,(0,Ws,l1
" Add and delete spaces in increments of `shiftwidth' for tabs
set smarttab

" Highlight syntax in programming languages
syntax on

augroup filetype
  au! BufRead,BufNewFile *makefile* set filetype=make
augroup END

" In Makefiles, don't expand tabs to spaces, since we need the actual tabs
set modeline
"
if has("autocmd")
  au BufReadPost * if line("'\"") > 1 && line("'\"") <= line("$") | exe "normal! g'\"" | endif
endif

let g:loaded_logipat = 1

"" VIM Configuration File
"" Description: Optimized for C/C++ development, but useful also for other things.
"" Author: Gerhard Gappmeier
""
"
"" set UTF-8 encoding
"set enc=utf-8
"set fenc=utf-8
"set termencoding=utf-8
"    " disable vi compatibility (emulation of old bugs)
"set nocompatible
"    " use indentation of previous line
"set autoindent
"    " use intelligent indentation for C
"set smartindent
"    " configure tabwidth and insert spaces instead of tabs
"set shiftwidth=4     " indent also with 4 spaces
"set expandtab        " expand tabs to spaces
"" wrap lines at 120 chars. 80 is somewaht antiquated with nowadays displays.
""set textwidth=80
"" turn syntax highlighting on
"set t_Co=256
"syntax on
"" colorscheme wombat256
"" turn line numbers on
""set number
"" highlight matching braces
"set showmatch
"" intelligent comments
"set comments=sl:/*,mb:\ *,elx:\ */
"
"" Install OmniCppComplete like described on
""http://vim.wikia.com/wiki/C++_code_completion
"" This offers intelligent C++ completion when typing ‘.’ ‘->’ or <C-o>
"" Load standard tag files
"set tags+=~/.vim/tags/cpp
"set tags+=~/.vim/tags/gl
"set tags+=~/.vim/tags/sdl
"set tags+=~/.vim/tags/qt4
"
"" Install DoxygenToolkit from
""http://www.vim.org/scripts/script.php?script_id=987
""let g:DoxygenToolkit_authorName="John Doe <john@doe.com>"

" Enhanced keyboard mappings
"
autocmd BufNewFile,BufReadPost *.icpp set filetype=cpp

nmap <F8> :set mouse=a<CR>
nmap <F9> :set mouse=r<CR>
nmap <F6> :e<CR>
nmap <F2> :w<CR>
imap <F2> <ESC>:w<CR>
map <F4> :e %:p:s,.h$,.X123X,:s,.cpp$,.h,:s,.X123X$,.cpp,<CR>
" recreate tags file with F5
"map <F5> :!ctags -R –c++-kinds=+p –fields=+iaS –extra=+q .<CR>
map <F6> :Dox<CR>
map <F7> :make<CR>
map <S-F7> :make clean all<CR>
" goto definition with F12
"map <F12> <C-]>
" in diff mode we use the spell check keys for merging
"if &diff
"    ” diff settings
"    map <M-Down> ]c
"    map <M-Up> [c
"    map <M-Left> do
"    map <M-Right> dp
"    map <F9> :new<CR>:read !svn diff<CR>:set syntax=diff
"    buftype=nofile<CR>gg
"else
"    " spell settings
"    :setlocal spell spelllang=en
"    " set the spellfile - folders must exist
"    set spellfile=~/.vim/spellfile.add
"    map <M-Down> ]s
"    map <M-Up> [s
"endif
"


" CtrlP settings
let g:ctrlp_match_window = 'bottom,order:ttb'
let g:ctrlp_switch_buffer = 0
let g:ctrlp_working_path_mode = 0
let g:ctrlp_user_command = 'ag %s -l --nocolor --hidden -g ""'

"set nocompatible              " be iMproved, required
"filetype off                  " required
"
"" set the runtime path to include Vundle and initialize
"set rtp+=~/.vim/bundle/Vundle.vim
"call vundle#begin()
"" alternatively, pass a path where Vundle should install plugins
""call vundle#begin('~/some/path/here')
"
"" let Vundle manage Vundle, required
"Plugin 'VundleVim/Vundle.vim'
"Plugin 'Valloric/YouCompleteMe'
"
"" All of your Plugins must be added before the following line
"call vundle#end()            " required
"filetype plugin indent on    " required
"" To ignore plugin indent changes, instead use:
""filetype plugin on
""
"" Brief help
"" :PluginList       - lists configured plugins
"" :PluginInstall    - installs plugins; append `!` to update or just :PluginUpdate
"" :PluginSearch foo - searches for foo; append `!` to refresh local cache
"" :PluginClean      - confirms removal of unused plugins; append `!` to auto-approve removal
""
"" see :h vundle for more details or wiki for FAQ
"" Put your non-Plugin stuff after this line
"let g:ycm_use_clangd = 0
