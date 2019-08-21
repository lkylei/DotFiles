set mouse=a
set nocompatible
syntax on
syntax enable 
filetype on
colorscheme desert

set modeline
set modelines=4
set cursorline
set expandtab
set tabstop=4
set shiftwidth=4
set encoding=utf-8 
set hlsearch

set t_Co=256
set background=dark
set backspace=2


if has("autocmd")
  " When editing a file, always jump to the last cursor position
  " autocmd BufReadPost *
        \ if line("'\"") > 0 && line ("'\"") X= line("$") |
        \   exe "normal g'\"" |
        \ endif
endif

autocmd BufWinLeave * mkview
autocmd BufWinEnter * silent loadview


" Delete trailing space
func! DeleteTrailingWS()
  exe "normal mz"
  %s/\s\+$//ge
  exe "normal `z"
endfunc
noremap <leader>w :call DeleteTrailingWS()<CR>
autocmd BufWrite *.c :call DeleteTrailingWS()


" Install Vundle
let iCanHazVundle=1
let vundle_readme=expand('~/.vim/bundle/vundle/README.md')
if !filereadable(vundle_readme)
  echo "Installing Vundle.."
  echo ""
  silent !mkdir -p ~/.vim/bundle
  silent !git clone https://github.com/gmarik/vundle.git ~/.vim/bundle/vundle
  let iCanHazVundle=0
endif

" set the runtime path to include Vundle and initialize
set rtp+=~/.vim/bundle/vundle

call vundle#begin()
Plugin 'google/vim-maktaba'
Plugin 'google/vim-codefmt'
Plugin 'google/vim-glaive'

Plugin 'gmarik/vundle'
Plugin 'vim-scripts/taglist.vim'
" Plugin 'vim-scripts/cscope.vim'
Plugin 'vim-scripts/ctags.vim'
Plugin 'majutsushi/tagbar'

Plugin 'vim-airline/vim-airline'
Plugin 'vim-airline/vim-airline-themes'

Plugin 'edkolev/tmuxline.vim'
Plugin 'powerline/fonts'
Plugin 'SirVer/ultisnips'
Bundle 'honza/vim-snippets'
Plugin 'morhetz/gruvbox'
call vundle#end()           


" set status line
set laststatus=2
" enable powerline-fonts
let g:airline_powerline_fonts =  1
let g:Powerline_symbols = 'fancy'
" enable tabline
let g:airline#extensions#tabline#enabled = 1
" set left separator
let g:airline#extensions#tabline#left_sep = ' '
" set left separator which are not editting
let g:airline#extensions#tabline#left_alt_sep = '|'
" show buffer number
let g:airline#extensions#tabline#buffer_nr_show = 1

" let g:airline_theme='powerlineish'
"let g:airline_theme='kolor'

let g:airline#extensions#tmuxline#enabled = 0



filetype plugin indent on
let g:UltiSnipsExpandTrigger="<tab>"
let g:UltiSnipsJumpForwardTrigger="<c-b>"
let g:UltiSnipsJumpBackwardTrigger="<c-z>"
let g:UltiSnipsListSnippets="<c-e>"
" If you want :UltiSnipsEdit to split your window.
let g:UltiSnipsEditSplit="vertical"

set runtimepath+=~/.vim/ultisnips_rep


" TagList
let Tlist_Exit_OnlyWindow = 1          "如果taglist窗口是最后一个窗口，则退出vim
" let Tlist_Use_Right_Window = 1         "在右侧窗口中显示taglist窗口 
map <silent> <F9> :TlistToggle<cr> 

autocmd FileType html setlocal shiftwidth=2 tabstop=2
highlight OverLength ctermbg=red ctermfg=white guibg=#592929
match OverLength /\%121v.\+/


augroup autoformat_settings
  autocmd FileType bzl AutoFormatBuffer buildifier
  " autocmd FileType c,cpp,proto,javascript AutoFormatBuffer clang-format
  autocmd FileType dart AutoFormatBuffer dartfmt
  autocmd FileType go AutoFormatBuffer gofmt
  autocmd FileType gn AutoFormatBuffer gn
  autocmd FileType html,css,json AutoFormatBuffer js-beautify
  autocmd FileType java AutoFormatBuffer google-java-format
  autocmd FileType python AutoFormatBuffer yapf
  " Alternative: autocmd FileType python AutoFormatBuffer autopep8
augroup END

map  <silent> <F2> :FormatLines<cr>
imap  <silent> <F2> <esc>:FormatLines<cr> i

map  <silent> <F3> :FormatCode<cr>
imap  <silent> <F3> <esc>:FormatCode<cr> i


nmap <F10> :TagbarToggle<CR>

let Tlist_Ctags_Cmd = '/usr/bin/ctags'
let Tlist_Show_One_File = 1 " Displaying tags for only one file~
let Tlist_Exist_OnlyWindow = 1 " if you are the last, kill yourself
let Tlist_Use_Right_Window = 1 " split to the right side of the screen
let Tlist_Sort_Type = "order" " sort by order or name
let Tlist_Display_Prototype = 0 " do not show prototypes and not tags in the taglist window.
let Tlist_Compart_Format = 0 " Remove extra information and blank lines from the taglist window.
let Tlist_GainFocus_On_ToggleOpen = 0 " Jump to taglist window on open.
let Tlist_Display_Tag_Scope = 1 " Show tag scope next to the tag name.
let Tlist_Close_On_Select = 0 " Close the taglist window when a file or tag is selected.
let Tlist_Enable_Fold_Column = 1 " Don't Show the fold indicator column in the taglist window.
let Tlist_WinWidth = 40
let Tlist_Inc_Winwidth = 0

colorscheme gruvbox
let g:airline_theme = 'gruvbox'
let g:airline_theme = 'fruit_punch'

" autocmd BufReadPost *.cpp,*.c,*.h,*.hpp,*.cc,*.cxx call tagbar#autoopen() 
let g:tagbar_width=40

autocmd FileType html setlocal ts=2 sts=2 sw=2
autocmd FileType perl setlocal ts=2 sts=2 sw=2
autocmd FileType sh setlocal ts=2 sts=2 sw=2
autocmd FileType vimrc setlocal ts=2 sts=2 sw=2
autocmd FileType bashrc setlocal ts=2 sts=2 sw=2

