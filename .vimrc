"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Base on vimrc maintained by Amix, refer www.amix.dk/vim/vimrc.html
"        __
"       |  \
"       |_ /
"       | \
"       |  \
"
" Version: 1.0
" LastChange: Dec 05, 2009 
"
" date: Jan 11, 2010
" add cscope and lookupfile support
"
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

" about hangul support, refer to hangulin.txt for further infomation
if v:lang =~ "utf8$" || v:lang =~ "UTF-8$"
   set fileencodings=utf-8,gb18030,latin1
endif

set nocompatible	" Use Vim defaults (much better!)
set bs=indent,eol,start	" allow backspacing over everything in insert mode
"set ai			" always set autoindenting on
"set backup		" keep a backup file
set viminfo='20,\"50	" read/write a .viminfo file, don't store more
			" than 50 lines of registers
set history=50		" keep 50 lines of command line history
set ruler		" show the cursor position all the time
set nu

" In many terminal emulators the mouse works just fine, thus enable it.
if has('mouse')
  set mouse=a
endif

color torte
set vb			" turn off the annoying beep sound
set ai
set cindent
set incsearch		" do incremental searching
filetype plugin indent on

let showmarks_marks = "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ"

" Enable ShowMarks
let showmarks_enable = 1
" Show which marks
let showmarks_include = "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ"
" Ignore help, quickfix, non-modifiable buffers
let showmarks_ignore_type = "hqm"
" Hilight lower & upper marks
let showmarks_hlline_lower = 1
let showmarks_hlline_upper = 1

set tags=tags

let Tlist_Ctags_Cmd = '/usr/local/bin/ctags'
let Tlist_Show_One_File = 1	"list tags for current file only
let Tlist_Exit_OnlyWindow = 1
let Tlist_Right_Window = 1
"let Tlist_Use_SingleClick = 1
"let Tlist_Auto_Open = 1

" Only do this part when compiled with support for autocommands
if has("autocmd")
  " In text files, always limit the width of text to 78 characters
  autocmd BufRead *.txt set tw=78
  " When editing a file, always jump to the last cursor position
  autocmd BufReadPost *
  \ if line("'\"") > 0 && line ("'\"") <= line("$") |
  \   exe "normal! g'\"" |
  \ endif
endif


" Switch syntax highlighting on, when the terminal has colors
" Also switch on highlighting the last used search pattern.
if &t_Co > 2 || has("gui_running")
  syntax on
  set hlsearch
endif

if &term=="xterm"
     set t_Co=8
     set t_Sb=[4%dm
     set t_Sf=[3%dm
endif


"Highlight current
if has("gui_running")
  set cursorline
  hi cursorline guibg=#333333
  hi CursorColumn guibg=#333333
endif

"Set mapleader
let mapleader = ","
let g:mapleader = ","

"Fast reloading of the .vimrc
map <leader>s :source ~/.vimrc<cr>
"Fast editing of .vimrc
map <leader>e :e! ~/.vimrc<cr>
"When .vimrc is edited, reload it
autocmd! bufwritepost .vimrc source ~/.vimrc

"Highlight current
if has("gui_running")
  set cursorline
  hi cursorline guibg=#333333
  hi CursorColumn guibg=#333333
endif

"make highlighting disappear
nmap <silent> <leader><cr> :noh<cr>

" open quickfix when csoping
" NOTE: when setting the cscopequickfix C-RightClick(C-t) is not usable
set cscopequickfix=s-,g-,c-,t-,e-,f-,i-,d-
nmap ff :cw<cr>

""""""""""""""""""""""""""""""
" Visual
""""""""""""""""""""""""""""""
" From an idea by Michael Naumann
function! VisualSearch(direction) range
  let l:saved_reg = @"
  execute "normal! vgvy"
  let l:pattern = escape(@", '\\/.*$^~[]')
  let l:pattern = substitute(l:pattern, "\n$", "", "")
  if a:direction == 'b'
    execute "normal ?" . l:pattern . "^M"
  else
    execute "normal /" . l:pattern . "^M"
  endif
  let @/ = l:pattern
  let @" = l:saved_reg
endfunction

"Basically you press * or # to search for the current selection !! Really useful
vnoremap <silent> * :call VisualSearch('f')<CR>
vnoremap <silent> # :call VisualSearch('b')<CR>

"Taglist key binding
map <silent> <leader>tl :TlistToggle<cr> 
"BTW what's the meaning of silent here
nmap tl :Tlist<cr>

"Quik close and save
map <leader>q :q<cr>
map <leader>a :qa<cr>
map <leader>x :x<cr>
map <leader>w :w<cr>

"Tab configuration
"nmap <F5> <Esc>:tabnew<cr>
"imap <F5> <Esc>:tabnew<cr>i
" the following four line cannot work, currently I don't know why?
nmap <M-1> <Esc>:tabpre<cr>
imap <M-1> <Esc>:tabpre<cr>i
nmap <M-2> <Esc>:tabnext<cr>
imap <M-2> <Esc>:tabnext<cr>i

map <leader>tn :tabnew 
map <leader>te :tabedit 
map <leader>tc :tabclose<cr>
map <leader>tm :tabmove 
map <leader>to :tabonly<cr>
map <leader>tf :tabfirst<cr>
"map <leader>tl :tablast<cr>
try
  set switchbuf=usetab
  set stal=2
catch
endtry

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Parenthesis/bracket expanding
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
vnoremap $1 <esc>`>a)<esc>`<i(<esc>
")
vnoremap $2 <esc>`>a]<esc>`<i[<esc>
vnoremap $3 <esc>`>a}<esc>`<i{<esc>
vnoremap $$ <esc>`>a"<esc>`<i"<esc>
vnoremap $q <esc>`>a'<esc>`<i'<esc>
vnoremap $w <esc>`>a"<esc>`<i"<esc>

"Map auto complete of (, ", ', [
inoremap $1 ()<esc>:let leavechar=")"<cr>i
inoremap $2 []<esc>:let leavechar="]"<cr>i
inoremap $4 {<esc>o}<esc>:let leavechar="}"<cr>O
inoremap $3 {}<esc>:let leavechar="}"<cr>i
inoremap $q ''<esc>:let leavechar="'"<cr>i
inoremap $w ""<esc>:let leavechar='"'<cr>i

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" General Abbrevs
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"My information
iab xdate <c-r>=strftime("%d/%m/%y %H:%M:%S")<cr>
iab xname Amir Salihefendic

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" MISC
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"Remove the Windows ^M
noremap <Leader>m mmHmt:%s/<C-V><cr>//ge<cr>'tzt'm

"Paste toggle - when pasting something in, don't indent.
set pastetoggle=<F3>

"Remove indenting on empty lines
map <F2> :%s/\s*$//g<cr>:noh<cr>''

"Super paste
inoremap <C-v> <esc>:set paste<cr>mui<C-R>+<esc>mv'uV'v=:set nopaste<cr>

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Statusline
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"set laststatus=2
"or set ls=1

function! CurDir()
   let curdir = substitute(getcwd(), '/Users/amir/', "~/", "g")
   return curdir
endfunction

"Format the statusline
"Please notice that if you wanna add a white space, you should always insert a
"backslash(\) before the space, see below as a example

"set statusline=\ %F%m%r%h\ %w\ PWD:%{CurDir()}%h\ \ \ \ \ FORMAT=%{&ff}\ TYPE=%Y\ \ ASCII=\%03.3b[0x%02.2B]\ \ POS=%l,%v\ %p%%\ Line=%L


"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Lookupfile
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
let g:Lookupfile_MinPatLength=2
let g:Lookupfile_PreserveLastPattern=0
let g:Lookupfile_preservePatternHistory=1
let g:Lookupfile_AlwaysAcceptFirst=1
let g:Lookupfile_AllowNewFiles=0
if filereadable("./filenametags")
	let g:LookupFile_TagExpr="./filenametags"
endif
nmap <silent> <leader>lk <Plug>LookupFile<cr>
nmap <silent> <leader>ll :LUBufs<cr>
nmap <silent> <leader>lw :LUWalk<cr>

"Lookup file ignoring case
function! LookupFile_IgnoreCaseFunc(pattern)
	let _tags=&tags
	try
		let &tags=eval(g:LookupFile_TagExpr)
		let newpattern='\c' . a:pattern
		let tags=taglist(newpattern)
	catch
		echohl ErrorMsg |echo "Exception:" . v:exception | echohl NONE
		return ""
	finally
		let &tags=_tags
	endtry

	"Show the matches for what is typed so far
	let files=map(tags, 'v:val["filename"]')
	return files
endfunction
let g:Lookupfile_LookupFunc='LookupFile_IgnoreCaseFunc'


" open(close) fold code through SPACE bar
"set foldenable
"set foldmethod=manual
"nnoremap <space> @=((foldclosed(line('.'))<0)?'zc':'zo')<cr>


"resolve supertab key binding confliction with code_complete.vim
let g:completekey = "<F12>" 

let g:SuperTabRetainCompletionType=2
let g:SuperTabDefaultCompletionType="<c-p>"
"let g:SuperTabContextDefaultCompletionType

