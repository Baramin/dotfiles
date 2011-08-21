
fun! MySys()
  if has("win32")
    return "windows"
  else
    return "unix"
  endif
endfun

source $HOME/.vim/vimrc-vundle

filetype plugin indent on
"
" Sets how many lines of history VIM has to remember
set history=300

set modelines=0

" Set to auto read when a file is changed from the outside
set autoread

" With a map leader it's possible to do extra key combinations
" like <leader>w saves the current file
let mapleader = ","

" Fast editing of the .vimrc
map <leader>E :e! ~/.vimrc<cr>

" When vimrc is edited, reload it
autocmd! bufwritepost .vimrc source ~/.vimrc
autocmd! bufwritepost _vimrc source ~/_vimrc

if has("gui")
  set guioptions-=m
  set guioptions-=T
  set guioptions-=e
endif


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
set t_Co=256
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

" Close all the buffers
map <leader>ba :1,300 bd!<cr>

" Use the arrows to something usefull
"map <right> :bn<cr>
"map <left> :bp<cr>
map <C-right> <ESC>:bn<CR>
map <C-left> <ESC>:bp<CR>

" When pressing <leader>cd switch to the directory of the open buffer
map <leader>cd :cd %:p:h<cr>

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
    let curdir = substitute(getcwd(), '/home/ace/', "~/", "g")
    return curdir
endfunction

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
map <leader>N :cp<cr>


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

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Omni complete functions
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
autocmd FileType css set omnifunc=csscomplete#CompleteCSS


"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Spell checking
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"Pressing ,ss will toggle and untoggle spell checking
map <leader>ss :setlocal spell!<cr>

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
nnoremap <leader>= yypVr=

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
"set listchars=tab:▸\ ,eol:¬
set listchars=tab:▸\ 

let g:ackprg="ack-grep -H --nocolor --nogroup --column"

" Supprime les espaces en trop en fin de ligne
nnoremap <leader>W :%s/\s\+$//<cr>:let @/=''<CR>
" acces rapide a Ack avec ,a
nnoremap <leader>a :Ack

" Trie les proprietes CSS avec ,S
nnoremap <leader>S ?{<CR>jV/^\s*\}?$<CR>k:sort<CR>:noh<CR>

"I have a ,v mapping to reselect the text that was just pasted so I can perform commands (like indentation) on it:
nnoremap <leader>v V`]

" equivalent de ESC rapide en mode insertion : jj
inoremap jj <ESC>

" Pour gundo plugin
nnoremap <F5> :GundoToggle<CR>

let g:EasyMotion_leader_key = '<Leader>m'
"let g:EasyMotion_do_mapping=0
let g:EasyMotion_do_shade = 1

" Permet de renseigner le répertoire du fichier courant dans la ligne de commande
cnoremap %% <C-R>=expand('%:h').'/'<cr>

" cree un fold autour d'un tag avec ,f
au FileType html setlocal foldmethod=manual
au FileType html nnoremap <leader>f Vatzf
au FileType xhtml setlocal foldmethod=manual
au FileType xhtml nnoremap <leader>f Vatzf

" deplace la fin de la ligne depuis le curseur au debut de la ligne suivante
nnoremap K h/[^ ]<cr>"zd$jyyP^v$h"zpJk:s/\v +$//<cr>:noh<cr>j^

" Make horizontal scrolling less horrible.
set sidescroll=1
set sidescrolloff=10

" ouvre l'aide a droite et non au dessus
au FileType help wincmd L

" remplace la selection avec le resultat du calcul
" ex: 1+3+5, select le tout et (g=) => 9
vnoremap g= "xc<C-r>=<C-r>x<CR><ESC>
" en insertion (calcule depuis le dernier espace ou début de ligne) :
inoremap <C-B> <C-O>yiW<End>=<C-R>=<C-R>0<CR>

" ajoute un objet "In next (" :
" s'utilise ainsi :
" din( : delete in next ()
" vin( : select in next ()
" cin( : change in next ()
vnoremap <silent> in( :<C-U>normal! f(vi(<cr>
onoremap <silent> in( :<C-U>normal! f(vi(<cr>

" Command-T accessible via ,tt ,TT (flush) et ,TB (buffers ouverts)
nnoremap <silent> <leader>tt :CommandT<CR>
nnoremap <silent> <leader>TT :CommandTFlush<CR>
nnoremap <silent> <leader>tb :CommandTBuffer<CR>

" from Miek article about Go from Vim
" folding settings
" zM close all folds
" zR open all folds
" za toggle fold under cursor
" zA toggle fold under cursor recursively
" zo open fold under cursor
" zO open fold under cursor recursively
" zc close fold under cursor
" zC close fold under cursor recursively
set foldmethod=indent
set foldnestmax=10
set nofoldenable
set foldlevel=0

" toggle swiches
set pastetoggle=<F7>

" search hilight
map     <F8>   :nohlsearch<CR>
imap    <F8>   <ESC>:nohlsearch<CR>a
vmap    <F8>   <ESC>:nohlsearch<CR>gv

" numbering
map     <F10>   :set nu!<CR>
imap    <F10>   <ESC>:set nu!<CR>i
vmap    <F10>   <ESC>:set nu!<CR>gv

" toggle cursorline
map     <F9>   :set cursorline!<CR>
imap    <F9>   <ESC>:set cursorline!<CR>

