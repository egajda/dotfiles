if empty(glob('~/.vim/autoload/plug.vim'))
  silent !curl -fLo ~/.vim/autoload/plug.vim --create-dirs
    \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
  autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
endif
call plug#begin('~/.vim/plugged')

Plug 'prettier/vim-prettier', {
  \ 'do': 'yarn install',
  \ 'for': ['javascript', 'typescript', 'css', 'less', 'scss', 'json', 'graphql', 'markdown', 'vue', 'yaml', 'html'] }

:autocmd BufWritePre *.vue :Prettier


Plug 'prabirshrestha/vim-lsp'

" Mint
Plug 'IrenejMarc/vim-mint'

" Coffee
Plug 'kchmck/vim-coffee-script'

" Pug
Plug 'digitaltoad/vim-pug'

"Vue"
Plug 'leafOfTree/vim-vue-plugin'

" Go
Plug 'fatih/vim-go', { 'do': ':GoUpdateBinaries' }

" JS
Plug 'w0rp/ale'

" Elm
Plug 'elmcast/elm-vim'

" CSV
Plug 'chrisbra/csv.vim'

" Julia
Plug 'JuliaEditorSupport/julia-vim'

" + - gutter
Plug 'airblade/vim-gitgutter'

" Status bar
Plug 'bling/vim-airline'

" Fuzzy Finder
Plug 'ctrlpvim/ctrlp.vim'

" Scala
Plug 'derekwyatt/vim-scala'

" Elixir
Plug 'elixir-lang/vim-elixir'

" Many Colorschemes
Plug 'flazz/vim-colorschemes'

" Run Ruby
Plug 'hwartig/vim-seeing-is-believing'

" Typescript
Plug 'leafgarland/typescript-vim'

" Expand tag abbreviations
Plug 'mattn/emmet-vim'

" JSX
Plug 'mxw/vim-jsx'

" Javascript
Plug 'pangloss/vim-javascript'

" Rust
Plug 'rust-lang/rust.vim'

" Syntax checking
Plug 'scrooloose/syntastic'

" Run rspec tests
Plug 'thoughtbot/vim-rspec'

" Quickly (un)comment
Plug 'tpope/vim-commentary'

" Async tests
Plug 'tpope/vim-dispatch'

" Intelligent end auto-completion
Plug 'tpope/vim-endwise'

" Haml
Plug 'tpope/vim-haml'

" Git
Plug 'tpope/vim-fugitive'

" Rails
Plug 'tpope/vim-rails'

" . repeating for plugin maps
Plug 'tpope/vim-repeat'

" Tim Pope's sensible defaults
Plug 'tpope/vim-sensible'

" Edit surroundings: quotes, brackets, tags, etc.
Plug 'tpope/vim-surround'

" Pairs of handy bracket mappings
Plug 'tpope/vim-unimpaired'

" Combine with netrw to create a delicious salad dressing
Plug 'tpope/vim-vinegar'

" Ruby
Plug 'vim-ruby/vim-ruby'

call plug#end()

let g:elm_format_autosave = 1

" Enable line numbers
set number

" Use space as leader
let mapleader = " "

" Enable syntax highlighting
syntax on

" Language detection
filetype plugin indent on

" Enable mouse and scrolling
set mouse=a
map <ScrollWheelUp> <C-Y>
map <ScrollWheelDown> <C-E>

" Two space tabs
set expandtab
set shiftwidth=4
set softtabstop=4
set tabstop=4


" Move one semantic line even when wrapping
map j gj
map k gk

" Double j to escape
inoremap jj <esc>

" Move around splits with <c-hjkl>
nnoremap <c-j> <c-w>j
nnoremap <c-k> <c-w>k
nnoremap <c-h> <c-w>h
nnoremap <c-l> <c-w>l

" Fix neovim bug
if has('nvim')
  nmap <BS> <C-W>h
endif

" Open horizontal splits down
set splitbelow

" Open vertical splits right
set splitright

" Switch between the last two files with double space
nnoremap <leader><leader> <c-^>

" Display extra whitespace
"set list listchars=tab:»·,trail:·

" Configure CtrlP as SpaceP
let g:ctrlp_map = '<Leader>p'
let g:ctrlp_cmd = 'CtrlP'

" The Silver Searcher
if executable('ag')
  " Use ag over grep
  set grepprg=ag\ --nogroup\ --nocolor

  " Use ag in CtrlP for listing files. Lightning fast and respects .gitignore
  let g:ctrlp_user_command = 'ag %s -l --nocolor -g "" --ignore-dir node_modules'

  " ag is fast enough that CtrlP doesn't need to cache
  let g:ctrlp_use_caching = 0
endif

" Syntax highlighting
let g:syntastic_javascript_checkers = ['eslint']
let g:syntastic_javascript_eslint_exe = 'yarn run eslint'
let g:syntastic_ruby_checkers = ['rubocop']
let g:syntastic_haml_checkers = ['haml_lint']
let g:syntastic_scss_checkers = ['scss_lint']

" Tab completion
" will insert tab at beginning of line,
" will use completion if not at beginning
" Thanks Thoughtbot
set wildmode=list:longest,list:full
function! InsertTabWrapper()
    let col = col('.') - 1
    if !col || getline('.')[col - 1] !~ '\k'
        return "\<tab>"
    else
        return "\<c-p>"
    endif
endfunction
inoremap <Tab> <c-r>=InsertTabWrapper()<cr>

" RSpec mappings
map <Leader>t :call RunCurrentSpecFile()<CR>
map <Leader>s :call RunNearestSpec()<CR>
map <Leader>l :call RunLastSpec()<CR>
map <Leader>a :call RunAllSpecs()<CR>
let g:rspec_command = "Dispatch RAILS_ENV=test spring rspec {spec}"

" Revela colors
set t_Co=256
colorscheme solarized8_light_high
highlight Normal ctermbg=NONE guibg=NONE
highlight SignColumn ctermbg=NONE guibg=NONE
highlight LineNr ctermbg=NONE guibg=NONE

set backupcopy=yes

" Open ctags in vertical split
function! FollowTag()
  if !exists("w:tagbrowse")
    vsplit
    let w:tagbrowse=1
  endif
  execute "tag " . expand("<cword>")
endfunction

nnoremap <c-]> :call FollowTag()<CR>

set modifiable
set rnu

" Enable seeing-is-believing mappings only for Ruby
augroup seeingIsBelievingSettings
  autocmd!

  autocmd FileType ruby nmap <buffer> <Enter> <Plug>(seeing-is-believing-mark-and-run)<C-e>
  autocmd FileType ruby xmap <buffer> <Enter> <Plug>(seeing-is-believing-mark-and-run)

  autocmd FileType ruby nmap <buffer> <F4> <Plug>(seeing-is-believing-mark)
  autocmd FileType ruby xmap <buffer> <F4> <Plug>(seeing-is-believing-mark)
  autocmd FileType ruby imap <buffer> <F4> <Plug>(seeing-is-believing-mark)

  autocmd FileType ruby nmap <buffer> <F5> <Plug>(seeing-is-believing-run)
  autocmd FileType ruby imap <buffer> <F5> <Plug>(seeing-is-believing-run)
augroup END

set noerrorbells visualbell t_vb=
autocmd GUIEnter * set visualbell t_vb=


" Fix files with prettier, and then ESLint.
let b:ale_fixers = ['prettier', 'eslint']
" Equivalent to the above.
let b:ale_fixers = {'javascript': ['prettier', 'eslint']}

