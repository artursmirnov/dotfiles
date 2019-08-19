" ======= GENERAL OPTIONS =======

set undofile                " Maintain undo history between sessions
set noswapfile              " Disable swap files
set noshowmode              " Hide current mode
set hidden                  " Make unsaved buffers hidden
set scrolloff=5             " Show next 5 lines while scrolling
set sidescrolloff=5         " Show next 5 columns while side-scrolling
set number                  " Show the line numbers on the left side
set rnu                     " Relative line numbers
set cursorline              " Highlight cursor line
set expandtab               " Insert spaces when TAB is pressed
set tabstop=2               " Render TABs using this many spaces
set shiftwidth=2            " Indentation amount for < and > commands
set splitbelow              " Horizontal split below current
set splitright              " Vertical split to right of current
set nojoinspaces            " Prevent inserting two spaces after punctuation on a join (J)
set list                    " Show problematic characters.
set ignorecase              " Make searching case insensitive
set smartcase               " ... unless the query has capital letters
set nohlsearch              " Disable search results highlight<Paste>
set diffopt+=vertical       " set up diff options
set nobackup
set nowritebackup
set updatetime=300
set mouse=a
set cmdheight=1
set shortmess+=c
set signcolumn=yes
set laststatus=2
set termguicolors

let mapleader="\<SPACE>"

" ======= PLUGINS =======

call plug#begin()

" Theme
Plug 'nanotech/jellybeans.vim'

Plug 'tpope/vim-sensible'

" GitHub handler for fugitive
Plug 'tpope/vim-rhubarb'

Plug 'tpope/vim-fugitive'
  nnoremap <leader>gs :Gstatus<cr>
  nnoremap <leader>gc :Gcommit<cr>
  nnoremap <leader>gp :Gpush<cr>
  nnoremap <leader>gl :Gpull<cr>
  nnoremap <leader>gb :Gbrowse<cr>
  nnoremap <leader>gd :Gdelete<cr>
  nnoremap <leader>gr :Gread<cr>
  nnoremap <leader>gm :Gmove

Plug 'tpope/vim-surround'

Plug 'airblade/vim-gitgutter'
  nnoremap <leader>hn :GitGutterNextHunk<cr>
  nnoremap <leader>hp :GitGutterPrevHunk<cr>
  nnoremap <Leader>hs :GitGutterStageHunk<cr>
  nnoremap <Leader>hr :GitGutterUndoHunk<cr>
  nnoremap <Leader>hv :GitGutterPreviewHunk<cr>

Plug 'editorconfig/editorconfig-vim'

Plug 'tpope/vim-commentary'
  " gcc - comment a line
  " gc{motion} - comment a motion

Plug 'tpope/vim-projectionist'
  nnoremap <C-a> :A<cr>
  nnoremap <C-s> :AV<cr>

Plug 'easymotion/vim-easymotion'
  let g:EasyMotion_smartcase = 1
  nmap s <Plug>(easymotion-s)
  map  / <Plug>(easymotion-sn)
  omap / <Plug>(easymotion-tn)
  map  n <Plug>(easymotion-next)
  map  N <Plug>(easymotion-prev)

Plug 'mattn/emmet-vim'
  nnoremap <leader>e :Emmet<space>

Plug 'matze/vim-move'
  let g:move_key_modifier = 'C'

Plug 'ntpeters/vim-better-whitespace'

Plug 'jiangmiao/auto-pairs'

Plug 'michaeljsmith/vim-indent-object'

Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }

Plug 'junegunn/fzf.vim'
  nnoremap <C-p> :FZF<cr>
  nnoremap § :Buffers<cr>
  nnoremap <leader>f :Rg<cr>
  nnoremap <leader>fw :Ag<cr>
  nnoremap <leader>fw :exe 'Rg '.expand('<cword>')<CR>

Plug 'neoclide/coc.nvim', {'tag': '*', 'branch': 'release'}
  let g:coc_global_extensions = [
    \ 'coc-eslint',
    \ 'coc-tsserver',
    \ 'coc-css',
    \ 'coc-json',
    \ 'coc-yaml',
    \ 'coc-html',
    \ 'coc-svg',
    \ 'coc-vimlsp',
    \ ]
  nmap <silent> gd <Plug>(coc-definition)
  nmap <silent> gt <Plug>(coc-type-definition)
  nmap <silent> gi <Plug>(coc-implementation)
  nmap <silent> gr <Plug>(coc-references)
  nmap <leader>rn <Plug>(coc-rename)
  xmap <leader>ca  <Plug>(coc-codeaction-selected)
  nmap <leader>ca  <Plug>(coc-codeaction-selected)
  nmap <leader>ch :call CocAction('doHover')<cr>
  nnoremap <leader>cd :<C-u>CocList diagnostics<cr>

Plug 'nullvoxpopuli/coc-ember', {'do': 'yarn install --frozen-lockfile'}

Plug 'justinmk/vim-sneak'

" Required by vim-session
Plug 'xolox/vim-misc'

" Required by gitsessions.vim
Plug 'xolox/vim-session'
  let g:session_autosave = 'yes'
  let g:session_autosave_silent = 1

Plug 'wting/gitsessions.vim'
  let g:gitsessions_use_nested_load = 1
  let g:gitsessions_dir = '~/.local/share/nvim/sessions'

Plug 'vim-airline/vim-airline'

Plug 'vim-airline/vim-airline-themes'
  let g:airline_theme='jellybeans'

Plug 'sukima/vim-javascript-imports'
  nnoremap <leader>i :JSImport<cr>

Plug 'sukima/vim-ember-imports'

" SYNTAX PLUGINS

Plug 'leafgarland/typescript-vim'

Plug 'joukevandermaas/vim-ember-hbs', { 'for': ['handlebars'] }

Plug 'elzr/vim-json', { 'for': ['json'] }
	let g:vim_json_syntax_conceal = 1

" Must be the last one
Plug 'ryanoasis/vim-devicons'

call plug#end()

" set up ALE completion for Deoplete
" call deoplete#custom#option('sources', { '_': [ 'ale', 'buffer' ] })

" ======= KEYMAP =======

" Buffers navigation
nnoremap <leader>q :bd<cr>
nnoremap <leader>w <C-w>w
nnoremap <C-q> :bd<cr>
nnoremap <C-w> <C-w>w

" Map tab to indent in visual mode
vmap <Tab> >gv
vmap <S-Tab> <gv

" Preserve selection after indentation
vmap > >gv
vmap < <gv

" Popup navigation
inoremap <C-j> <C-n>
inoremap <C-k> <C-p>
cnoremap <C-j> <C-n>
cnoremap <C-k> <C-p>

" Copy / Paste out / into vim
noremap <leader>y "+y
noremap <leader>p "+p

" ======= AUTOCOMMANDS =======

" Close autosuggestions
autocmd! CompleteDone * if pumvisible() == 0 | pclose | endif

" Highlight symbol under cursor on CursorHold
autocmd CursorHold * silent call CocActionAsync('highlight')

" ======= OTHER OPTIONS =======

colorscheme jellybeans

filetype plugin on
