let g:ruby_host_prog = '~/.gem/ruby/2.6.0/bin/neovim-ruby-host'
set encoding=utf-8
set mouse=a
set termguicolors
set number
set hlsearch
set incsearch
set backspace=indent,eol,start " allow backspacing over everything in insert mode
syntax on
let g:mapleader=','
set encoding=UTF-8
set expandtab
set tabstop=2
set shiftwidth=2
map <F2> :retab <CR> ":wq! <CR>
set nocompatible 
set t_Co=256
set t_ut=
set background=dark
set showmatch
syntax on
set ignorecase

if (has("termguicolors"))
  set termguicolors
endif

if (empty($TMUX))

  if (has("nvim"))
    let $NVIM_TUI_ENABLE_TRUE_COLOR=1
  endif

endif

"--------------------------------------------- colors -----------------------------------------------

if &t_Co >= 256 || has("gui_running")
    "colorscheme marker for auto changing
    colorscheme gruvbox

endif

if &t_Co > 2 || has("gui_running")
    " switch syntax highlighting on, when the terminal has colors
    syntax on
endif

"--------------------------------------------- plugins ----------------------------------------------

call plug#begin('~/.config/nvim/plugged')
Plug 'scrooloose/nerdtree', { 'on': 'NERDTreeToggle' }
"let NERDTreeShowHidden = 1
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
let g:airline_powerline_fonts = 1 
let g:airline#extensions#keymap#enabled = 0
let g:airline_theme='base16'
Plug 'Valloric/YouCompleteMe'
let g:ycm_autoclose_preview_window_after_completion=1
map <leader>g  :YcmCompleter GoToDefinitionElseDeclaration<CR>
"Plug 'jiangmiao/auto-pairs'
" plugin for git: Plug 'tpope/vim-figutive'
" plugin for git: Plug 'airblade/vim-gitgutter
"Plug 'kien/ctrlp.vim'
"Plug 'easymotion/vim-easymotion'
Plug 'blindFS/vim-translator'
map T <Plug>Translate
vmap R <Plug>TranslateReplace
vmap P <Plug>TranslateSpeak

call plug#end()

"--------------------------------------------- mappings ---------------------------------------------

map <C-n> :NERDTreeToggle<CR>
map <Leader> <Plug>(easymotion-prefix)
map <Leader>bg :let &background = ( &background == "dark"? "light" : "dark" )<CR>
map <Leader>mat :colorscheme material<CR>
nnoremap ; :

set pastetoggle=<F2>

map <leader>ini :tabnew $MYVIMRC<CR>
" stdpath('config')
autocmd bufwritepost $MYVIMRC source $MYVIMRC

map <leader>, :source $MYVIMRC<CR>

tnoremap <Esc> <C-\><C-n>

nmap j gj
nmap < DOWN> gj
nmap k gk
nmap < UP> gk

" cut/copy/paste
vmap <C-c> "+yi
vmap <C-x> "+c
vmap <C-v> c<ESC>"+p
imap <C-v> <C-r><C-o>+
" Paste only works in Visual and insert mode, so you don't have to worry about the conflict with Ctrl-V and blockwise Visual Mode. This isn't a problem, because Copy and Cut put you into insert mode, so you can immediately paste afterwards. If you try it out you'll find that it feels completely natural.  I came up with this configuration after several iterations of tweaking, and I think it's perfect now. If you're even a little bit dissatisfied with your current copy/paste configuration, try this out and I bet you'll love it.

"-------------------------------------- поддержка кириллицы ----------------------------------------
set keymap=russian-jcukenwin                 
set iminsert=0                            
set imsearch=0                            
highlight lCursor guifg=NONE guibg=Cyan   

" настраиваем переключение раскладок клавиатуры по C-^
" раскладка по умолчанию для ввода - английская
" Сброс iminsert и imsearch необходим, чтобы самый

" первый раз вставка и ввод паттерна поиска начались с латиницы. По 
" сути, Ctrl+^ переключает эти значения между 0 и 1.
" Последняя строка обеспечивает изменение цвета курсора на голубенький,


" переключение на русскую/английскую раскладку по ^f (Ctrl + F)
cmap <silent> <C-F> <C-^>
" imap <silent> <C-F> <C-^>X<Esc>:call MyKeyMapHighlight()<CR>a<C-H>
" nmap <silent> <C-F> a<C-^><Esc>:call MyKeyMapHighlight()<CR>
" vmap <silent> <C-F> <Esc>a<C-^><Esc>:call MyKeyMapHighlight()<CR>gv
imap <silent> <C-F> <C-^>
nmap <silent> <C-F> a<C-^>
vmap <silent> <C-F> <Esc>a<C-^>
map <leader>ini :tabnew $MYVIMRC<CR>
fu! MyTabLabel(n)
let buflist = tabpagebuflist(a:n)
let winnr = tabpagewinnr(a:n)
let string = fnamemodify(bufname(buflist[winnr - 1]), ':t')
return empty(string) ? '[unnamed]' : string
endfu

fu! MyTabLine()
let s = ''
for i in range(tabpagenr('$'))
" select the highlighting
    if i + 1 == tabpagenr()
    let s .= '%#TabLineSel#'
    else
    let s .= '%#TabLine#'
    endif

    " set the tab page number (for mouse clicks)
    "let s .= '%' . (i + 1) . 'T'
    " display tabnumber (for use with <count>gt, etc)
    let s .= ' '. (i+1) . ' ' 

    " the label is made by MyTabLabel()
    let s .= ' %{MyTabLabel(' . (i + 1) . ')} '

    if i+1 < tabpagenr('$')
        let s .= ' |'
    endif
endfor
return s
endfu
set tabline=%!MyTabLine()
