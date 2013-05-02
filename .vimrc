:filetype plugin on

let g:C_AuthorName = 'Kanterov Gleb'
let g:C_AuthorRef = ''
let g:C_Email = 'gleb@kanterov.ru'
let g:alternateNoDefaultAlternate = 1

set sidescroll=5
set listchars+=precedes:<,extends:>
set ignorecase
set incsearch

nmap <F4> :tabnext<CR>
imap <F4> <ESC> :tabnext<CR>
nmap <F3> :tabprev<CR>
imap <F3> <ESC> :tabprev<CR>

syntax enable

set tabstop=4
set shiftwidth=4
set autoindent
set expandtab
set nu

if exists("+showtabline")
     function! MyTabLine()
         let s = ''
         let t = tabpagenr()
         let i = 1
         while i <= tabpagenr('$')
             let buflist = tabpagebuflist(i)
             let winnr = tabpagewinnr(i)
             let s .= (i != 1 ? '%#TabLine# | ' : '')
             let s .= (i == t ? '%#TabLineSel#' : '%#TabLine#')
             let s .= ' '
             let file = substitute(simplify(bufname(buflist[winnr - 1])), $HOME, '~', '')
             if file == ''
                 let file = '[No Name]'
             endif
             let s .= (getbufvar(buflist[winnr - 1], "&mod") ? '*' : '')
             let s .= file
             let s .= ' '
             let i = i + 1
         endwhile
         let s .= '%T%#TabLineFill#%='
         return s
     endfunction

     set stal=2
     set tabline=%!MyTabLine()
endif

filetype plugin indent on

map <C-k> <C-w><Up>
map <C-j> <C-w><Down>
map <C-l> <C-w><Right>
map <C-h> <C-w><Left>

set keymap=russian-jcukenwin    " настраиваем переключение раскладок клавиатуры по C-^
set iminsert=0                  " раскладка по умолчанию для ввода - английская
set imsearch=0                  " раскладка по умолчанию для поиска - английская

" переключение на русскую/английскую раскладку по ^f (Ctrl + F)
cmap <silent> <C-F> <C-^>
imap <silent> <C-F> <C-^>X<Esc>:call MyKeyMapHighlight()<CR>a<C-H>
nmap <silent> <C-F> a<C-^><Esc>:call MyKeyMapHighlight()<CR>
vmap <silent> <C-F> <Esc>a<C-^><Esc>:call MyKeyMapHighlight()<CR>gv

" Переключение раскладок и индикация выбранной в данный момент раскладки -->
" При английской раскладке статусная строка текущего окна будет синего цвета, а при русской - красного
function! MyKeyMapHighlight()
    if &iminsert == 0
        hi StatusLine ctermfg=DarkBlue guifg=DarkBlue
    else
        hi StatusLine ctermfg=DarkRed guifg=DarkRed
    endif
endfunction
" Вызываем функцию, чтобы она установила цвета при запуске Vim'a
call MyKeyMapHighlight()
" При изменении активного окна будет выполняться обновление индикации текущей раскладки
au WinEnter * :call MyKeyMapHighlight()

" My colorscheme
colorscheme molokai

" MacVim gui customization
if has("gui_running")
    set guioptions=egmrt
    set guifont=Menlo:h14
endif

