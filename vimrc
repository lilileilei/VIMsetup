execute pathogen#infect()

syntax on                 " syntax coloring
colorscheme desert        " sets default color scheme
set nu                    " show line numbers

" If using a dark background within the editing area and syntax highlighting
" turn on this option as well
if has('gui_running')
set background=dark
colorscheme solarized
endif

let g:Powerline_colorscheme='solarized256'

" auto reload files after 4 sec
set autoread
au CursorHold * checktime

set expandtab               " replace tabs with spaces
set tabstop=4               " how many columns a tab counts for
set shiftwidth=4           " control how many columns text is indented with the reindent operations

" highlight column
set colorcolumn=120
highlight ColorColumn ctermbg=darkgray

set history=50              " keep 50 lines of command line history
set hlsearch                " highlight searched text
set incsearch               " do incremental searching
set laststatus=2            " always show status line

set mouse=a                 " don't copy line numbers when marking in noGUI

set ruler                   " show the cursor position all the time
set showcmd                 " display incomplete commands
set showmatch               " cursor will briefly jump to the matching brace when you insert one

set guioptions-=T           " hide tools
"set guioptions-=m           " hide menus

set smartindent              " automatically inserts one extra level of indentation in some cases, and works for C-like files
set so=5                    " scrolls the text so that there are always at least five lines visible above the cursor

set guifont=Monospace\ 10        " set GUI font

" highlight ExtraWhitespace at end of line, remove them at save buffer ######################
highlight ExtraWhitespace ctermbg=red guibg=red
match ExtraWhitespace /\s\+$/
autocmd BufWinEnter * match ExtraWhitespace /\s\+$/
autocmd InsertEnter * match ExtraWhitespace /\s\+\%#\@<!$/
autocmd InsertLeave * match ExtraWhitespace /\s\+$/
autocmd BufWinLeave * call clearmatches()

function! TrimWhiteSpace()
    %s/\s\+$//e
endfunction

autocmd BufWritePre     *.cpp :call TrimWhiteSpace()
autocmd BufWritePre     *.hpp :call TrimWhiteSpace()
autocmd BufWritePre     *.ttcn3 :call TrimWhiteSpace()
" ###########################################################################################

filetype plugin indent on   " automatically finds and load specific plugin or indent file for known files

" function for switching between cpp and hpp files ##########################################
function! Switch_HPP_CPP()
    if match(expand("%"),'\.cpp') > 0
        let s:flipname = substitute(expand("%"),'\.cpp\(.*\)','\.hpp\1',"")
        let s:flipname = substitute(s:flipname, 'Source','Include',"")
    else
        let s:flipname = substitute(expand("%"),'\.hpp\(.*\)','\.cpp\1',"")
        let s:flipname = substitute(s:flipname, 'Include', 'Source', "")
    endif
    exe ":e " s:flipname
endfun
" ###########################################################################################

" tab hint
set wildchar=<TAB> wildmenu wildmode=full
set wildcharm=<C-Z>
nnoremap <TAB> :b <C-Z>

"################################# KLAWISZOLOGIA ######################################

map     <F6> :split<CR>                     " horizontal split
map     <F7> :vsplit<CR>                    " vertical split
map     <F8> :only<CR>                      " back to one window
map     <F9> :set wrap!<CR>                 " toggle line wrapping
"map     <F9> :set number!<CR>               " toggling line numbers
map     <F5> :TagbarToggle<CR>
map     <F10> :call Switch_HPP_CPP()<CR>    " calling function for switching cpp-hpp

let g:tagbar_width = 40       "设置宽度，默认为40
"autocmd VimEnter * nested :call tagbar#autoopen(1)    "打开vim时自动打开
"tagbarlet g:tagbar_left = 1         "在左侧"  
let g:tagbar_right = 1        "在右侧

" Make shift-insert work like in Xterm:
map     <S-Insert>      <MiddleMouse>
map!    <S-Insert>      <MiddleMouse>

for tagfile in split(globpath('$PWD/.tags/', '*'), '\n')
    let &tags .= ',' . tagfile
endfor

map <F3> <C-]> 
map <F2> <C-T>

nmap <F4> :NERDTreeToggle<CR>

"" ctrlp
" Setup some default ignores
let g:ctrlp_custom_ignore = {
    \ 'dir':  '\v[\/](\.(git|hg|svn)|\_site)$',
    \ 'file': '\v\.(exe|so|dll|class|png|jpg|jpeg)$',
    \}

" Use the nearest .git directory as the cwd
" This makes a lot of sense if you are working on a project that is in version
" control. It also supports works with .svn, .hg, .bzr.
let g:ctrlp_working_path_mode = 'r'

" Use a leader instead of the actual named binding
nmap <leader>p :CtrlP<cr>

" Easy bindings for its various modes
nmap <leader>bb :CtrlPBuffer<cr>
nmap <leader>bm :CtrlPMixed<cr>
nmap <leader>bs :CtrlPMRU<cr>

"uncomment if you want to launch Ctrl-P in regexp and file-name mode automatically
let g:ctrlp_regexp = 1
let g:ctrlp_by_filename = 1
let g:ctrlp_max_files = 0


"" airline
" Enable the list of buffers
let g:airline#extensions#tabline#enabled = 1

" Show just the filename
let g:airline#extensions#tabline#fnamemod = ':t'

" This allows buffers to be hidden if you've modified a buffer.
" This is almost a must if you wish to use buffers in this way.
set hidden

" To open a new empty buffer
" This replaces :tabnew which I used to bind to this mapping
nmap <leader>T :enew<cr>

" Move to the next buffer
nmap <leader>l :bnext<CR>

" Move to the previous buffer
nmap <leader>h :bprevious<CR>

" Close the current buffer and move to the previous one
" This replicates the idea of closing a tab
nmap <leader>bq :bp <BAR> bd #<CR>

" Show all open buffers and their status
nmap <leader>bl :ls<CR>

""nerdcomment
map <F12> <leader>ci<CR>

au BufNewFile,BufRead *.k3.txt setf log
au BufNewFile,BufRead *.LOG,*.out setf out


