  " BUNDLE: git://github.com/astashov/vim-ruby-debugger.git
  " BUNDLE: git://github.com/msanders/snipmate.vim.git
  " BUNDLE: git://github.com/scrooloose/nerdtree.git
  " BUNDLE: git://github.com/timcharper/textile.vim.git
  " BUNDLE: git://github.com/tpope/vim-cucumber.git
  " BUNDLE: git://github.com/tpope/vim-fugitive.git
  " BUNDLE: git://github.com/tpope/vim-git.git
  " BUNDLE: git://github.com/tpope/vim-haml.git
  " BUNDLE: git://github.com/tpope/vim-markdown.git
  " BUNDLE: git://github.com/tpope/vim-rails.git
  " BUNDLE: git://github.com/tpope/vim-surround.git
  " BUNDLE: git://github.com/tpope/vim-repeat.git
  " BUNDLE: git://github.com/tpope/vim-ragtag.git
  " BUNDLE: git://github.com/tpope/vim-vividchalk.git
  " BUNDLE: git://github.com/tsaleh/vim-align.git
  " BUNDLE: git://github.com/tsaleh/vim-shoulda.git
  " BUNDLE: git://github.com/tsaleh/vim-supertab.git
  " BUNDLE: git://github.com/tsaleh/vim-tcomment.git
  " BUNDLE: git://github.com/vim-ruby/vim-ruby.git
  " BUNDLE: git://github.com/mileszs/ack.vim.git
  " BUNDLE: git://github.com/scrooloose/nerdcommenter.git
  " BUNDLE: git://github.com/mattn/zencoding-vim.git
  " BUNDLE: git://github.com/sjl/gundo.vim.git
  "
  " BUNDLE: git://github.com/vim-scripts/vibrantink.git
  " BUNDLE: git://github.com/vim-scripts/MRU.git
  " BUNDLE: git://github.com/vim-scripts/jQuery.git
  " BUNDLE: git://github.com/vim-scripts/IndexedSearch.git
  " BUNDLE: git://github.com/vim-scripts/Command-T.git
  "

" Sets how many lines of history VIM has to remember
set history=300

filetype off
call pathogen#helptags()
call pathogen#runtime_append_all_bundles()
filetype plugin indent on

set nocompatible

set modelines=0

" Set to auto read when a file is changed from the outside
set autoread

" With a map leader it's possible to do extra key combinations
" like <leader>w saves the current file
let mapleader = ","

" Fast saving
nmap <leader>w :w!<cr>

" Fast editing of the .vimrc
map <leader>e :e! ~/.vimrc<cr>

" When vimrc is edited, reload it
autocmd! bufwritepost .vimrc source ~/.vimrc


"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => VIM user interface
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
set cmdheight=1 "The commandbar height

set hid "Change buffer - without saving

" Set backspace config
set backspace=eol,start,indent
set whichwrap+=<,>,h,l

" No sound on errors
set noerrorbells
set visualbell
set t_vb=
set ttyfast
set ruler
set cursorline
set showmode
set showcmd
set wildmenu
set wildmode=list:longest
colorscheme vividchalk


"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Colors and Fonts
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
syntax enable "Enable syntax hl

set gfn=Monaco\ 10
set shell=/bin/bash

set encoding=utf8
try
    lang fr_FR
catch
endtry

set ffs=unix,dos,mac "Default file types


"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Files and backups
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Turn backup off, since most stuff is in SVN, git anyway...
set nobackup
set nowb
set noswapfile


"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Text, tab and indent related
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
set expandtab
set shiftwidth=2
set tabstop=2
set softtabstop=2
set smarttab

set scrolloff=3
set lbr
set tw=500

set autoindent "Auto indent
set smartindent "Smart indet
set wrap "Wrap lines

map <leader>t2 :setlocal shiftwidth=2<cr>
map <leader>t4 :setlocal shiftwidth=4<cr>
map <leader>t8 :setlocal shiftwidth=8<cr>


"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Command mode related
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Smart mappings on the command line
cno $h e ~/
cno $d e ~/Desktop/
cno $j e ./
cno $c e <C-\>eCurrentFileDir("e")<cr>

" Bash like keys for the command line
cnoremap <C-A>		<Home>
cnoremap <C-E>		<End>
cnoremap <C-K>		<C-U>

func! Cwd()
  let cwd = getcwd()
  return "e " . cwd
endfunc

func! CurrentFileDir(cmd)
  return a:cmd . " " . expand("%:p:h") . "/"
endfunc

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Moving around, tabs and buffers
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Map space to / (search) and c-space to ? (backgwards search)
map <space> /
map <c-space> ?
map <silent> <leader><space> :noh<cr>

" Smart way to move btw. windows
map <C-j> <C-W>j
map <C-k> <C-W>k
map <C-h> <C-W>h
map <C-l> <C-W>l

" split verticalement et passe sur la deuxieme fenetre
nnoremap <leader>w <C-w>v<C-w>l

" Close the current buffer
map <leader>bd :Bclose<cr>

" Close all the buffers
map <leader>ba :1,300 bd!<cr>

" Use the arrows to something usefull
"map <right> :bn<cr>
"map <left> :bp<cr>
map <C-right> <ESC>:bn<CR>
map <C-left> <ESC>:bp<CR>

" Tab configuration
map <leader>tn :tabnew %<cr>
map <leader>te :tabedit
map <leader>tc :tabclose<cr>
map <leader>tm :tabmove

" When pressing <leader>cd switch to the directory of the open buffer
map <leader>cd :cd %:p:h<cr>

command! Bclose call <SID>BufcloseCloseIt()
function! <SID>BufcloseCloseIt()
   let l:currentBufNum = bufnr("%")
   let l:alternateBufNum = bufnr("#")

   if buflisted(l:alternateBufNum)
     buffer #
   else
     bnext
   endif

   if bufnr("%") == l:currentBufNum
     new
   endif

   if buflisted(l:currentBufNum)
     execute("bdelete! ".l:currentBufNum)
   endif
endfunction

" Specify the behavior when switching between buffers
try
  set switchbuf=usetab
  set stal=2
catch
endtry

""""""""""""""""""""""""""""""
" => Statusline
""""""""""""""""""""""""""""""
" Always hide the statusline
set laststatus=2

" Format the statusline
set statusline=\ %F%m%r%h\ %w\ \ CWD:\ %r%{CurDir()}%h\ \ \ Line:\ %l/%L:%c

function! CurDir()
    let curdir = substitute(getcwd(), '/Users/amir/', "~/", "g")
    return curdir
endfunction


"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Parenthesis/bracket expanding
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
vnoremap $1 <esc>`>a)<esc>`<i(<esc>
vnoremap $2 <esc>`>a]<esc>`<i[<esc>
vnoremap $3 <esc>`>a}<esc>`<i{<esc>
vnoremap $$ <esc>`>a"<esc>`<i"<esc>
vnoremap $q <esc>`>a'<esc>`<i'<esc>
vnoremap $e <esc>`>a"<esc>`<i"<esc>

" Map auto complete of (, ", ', [
inoremap $1 ()<esc>i
inoremap $2 []<esc>i
inoremap $3 {}<esc>i
inoremap $4 {<esc>o}<esc>O
inoremap $q ''<esc>i
inoremap $e ""<esc>i


"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => General Abbrevs
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
iab xdate <c-r>=strftime("%d/%m/%y %H:%M:%S")<cr>


"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Editing mappings
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"Remap VIM 0
map 0 ^

"Move a line of text using ALT+[jk] or Comamnd+[jk] on mac
nmap <M-j> mz:m+<cr>`z
nmap <M-k> mz:m-2<cr>`z
vmap <M-j> :m'>+<cr>`<my`>mzgv`yo`z
vmap <M-k> :m'<-2<cr>`>my`<mzgv`yo`z

"Delete trailing white space, useful for Python ;)
func! DeleteTrailingWS()
  exe "normal mz"
  %s/\s\+$//ge
  exe "normal `z"
endfunc
autocmd BufWrite *.py :call DeleteTrailingWS()


"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Cope
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Do :help cope if you are unsure what cope is. It's super useful!
map <leader>cc :botright cope<cr>
map <leader>n :cn<cr>
map <leader>p :cp<cr>


""""""""""""""""""""""""""""""
" => bufExplorer plugin
""""""""""""""""""""""""""""""
let g:bufExplorerDefaultHelp=0
let g:bufExplorerShowRelativePath=1


""""""""""""""""""""""""""""""
" => Minibuffer plugin
""""""""""""""""""""""""""""""
let g:miniBufExplModSelTarget = 1
let g:miniBufExplorerMoreThanOne = 2
let g:miniBufExplModSelTarget = 0
let g:miniBufExplUseSingleClick = 1
let g:miniBufExplMapWindowNavVim = 1
let g:miniBufExplVSplit = 25
let g:miniBufExplSplitBelow=1

let g:bufExplorerSortBy = "name"

autocmd BufRead,BufNew :call UMiniBufExplorer

map <leader>u :TMiniBufExplorer<cr>:TMiniBufExplorer<cr>


"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Omni complete functions
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
autocmd FileType css set omnifunc=csscomplete#CompleteCSS


"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Spell checking
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"Pressing ,ss will toggle and untoggle spell checking
map <leader>ss :setlocal spell!<cr>

"Shortcuts using <leader>
map <leader>sn ]s
map <leader>sp [s
map <leader>sa zg
map <leader>s? z=



""""""""""""""""""""""""""""""
" => JavaScript section
"""""""""""""""""""""""""""""""
au FileType javascript call JavaScriptFold()
au FileType javascript setl fen
au FileType javascript setl nocindent

au FileType javascript imap <c-t> AJS.log();<esc>hi
au FileType javascript imap <c-a> alert();<esc>hi

au FileType javascript inoremap <buffer> $r return
au FileType javascript inoremap <buffer> $f //--- PH ----------------------------------------------<esc>FP2xi

function! JavaScriptFold()
    setl foldmethod=syntax
    setl foldlevelstart=1
    syn region foldBraces start=/{/ end=/}/ transparent fold keepend extend

    function! FoldText()
    return substitute(getline(v:foldstart), '{.*', '{...}', '')
    endfunction
    setl foldtext=FoldText()
endfunction


""""""""""""""""""""""""""""""
" => Fuzzy finder
""""""""""""""""""""""""""""""
"try
    "call fuf#defineLaunchCommand('FufCWD', 'file', 'fnamemodify(getcwd(), ''%:p:h'')')
    "map <leader>t :FufCWD **/<CR>
"catch
"endtry

"map <C-t> <ESC>:FuzzyFinderTextMate<CR>

""""""""""""""""""""""""""""""
" => Vim grep
""""""""""""""""""""""""""""""
let Grep_Skip_Dirs = 'RCS CVS SCCS .svn generated .git'
set grepprg=/bin/grep\ -nH


"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => MISC
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Remove the Windows ^M - when the encodings gets messed up
noremap <Leader>m mmHmt:%s/<C-V><cr>//ge<cr>'tzt'm

"Quickly open a buffer for scripbble
map <leader>q :e ~/buffer<cr>

" Quickly show/hide NerdTree
map <leader>p :NERDTreeToggle<CR>

" Souligne la ligne en cours avec des signes '='
nnoremap <leader>1 yypVr=

" dompte les recherches
" mode escape perl par defaut
nnoremap / /\v
vnoremap / /\v
set ignorecase
set smartcase
set incsearch
set showmatch
set hlsearch
set magic "Set magic on, for regular expressions

set mat=2 "How many tenths of a second to blink

" gestion des longues lignes
set wrap
set textwidth=79
set formatoptions=qrn1
nnoremap j gj
nnoremap k gk

inoremap <F1> <ESC>
nnoremap <F1> <ESC>
vnoremap <F1> <ESC>


set list
set listchars=tab:▸\ ,eol:¬


let g:ackprg="ack-grep -H --nocolor --nogroup --column"

" Supprime les espaces en trop en fin de ligne
nnoremap <leader>W :%s/\s\+$//<cr>:let @/=''<CR>
" acces rapide a Ack avec ,a
nnoremap <leader>a :Ack

" pour HTML : fold tag sur ,ft
nnoremap <leader>ft Vatzf

" Trie les proprietes CSS avec ,S
nnoremap <leader>S ?{<CR>jV/^\s*\}?$<CR>k:sort<CR>:noh<CR>

"This next mapping imitates TextMates Ctrl+Q function to re-hardwrap paragraphs of text:
nnoremap <leader>q gqip

"I have a ,v mapping to reselect the text that was just pasted so I can perform commands (like indentation) on it:
nnoremap <leader>v V`]

" equivalent de ESC rapide en mode insertion : jj
inoremap jj <ESC>

" Pour gundo plugin
nnoremap <F5> :GundoToggle<CR>

