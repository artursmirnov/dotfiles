" ======= GENERAL OPTIONS =======

set termguicolors		" Enable truecolor for terminals that supports it
set autoread			" Automatically reload file it it was changed outside
set noerrorbells        " No beeps
set noswapfile			" Disable swap files

" UI
set showcmd             " Show (partial) command in status line
set showmatch           " Show matching brackets
set noshowmode          " Hide current mode
set ruler               " Show the line and column numbers of the cursor
set number              " Show the line numbers on the left side
set formatoptions+=o    " Continue comment marker in new lines
set rnu					" Relative line numbers
set background=dark		" Dark background
set laststatus=2		" Always show statusline
"set updatetime=500		" Update timeout
set hidden				" Make unsaved buffers hidden
set cursorline			" Highlight cursor line
set fillchars+=vert:\ 	" Windows divider (space)

" Command timeout: d<timeoutlen>d
"set timeoutlen=500
"set ttimeoutlen=0

" Indents
set expandtab           " Insert spaces when TAB is pressed
set tabstop=2           " Render TABs using this many spaces
set shiftwidth=2        " Indentation amount for < and > commands
set autoindent
set smartindent
set nowrap				" Don't wrap lines

" More natural splits
set splitbelow          " Horizontal split below current
set splitright          " Vertical split to right of current

if !&scrolloff
  set scrolloff=5       " Show next 5 lines while scrolling
endif
if !&sidescrolloff
  set sidescrolloff=5   " Show next 5 columns while side-scrolling
endif
set nostartofline       " Do not jump to first character with page commands

" ======= WHITESPACE OPTIONS =======

" Tell Vim which characters to show for expanded TABs,
" trailing whitespace, and end-of-lines. VERY useful!
if &listchars ==# 'eol:$'
  set listchars=tab:>\ ,trail:-,extends:>,precedes:<,nbsp:+
endif
set list                " Show problematic characters.

" Also highlight all tabs and trailing whitespace characters.
highlight ExtraWhitespace ctermbg=darkgreen guibg=darkgreen
match ExtraWhitespace /\s\+$\|\t/

" Clear trailing whitespace on file save
autocmd BufWritePre * :%s/\s\+$//e

" Prevents inserting two spaces after punctuation on a join (J)
set nojoinspaces

" ======= DIRECTORIES =======

call system('mkdir -p ~/.local/share/nvim/backup')
set backupdir=~/.local/share/nvim/backup//
call system('mkdir -p ~/.local/share/nvim/swap')
set directory=~/.local/share/nvim/swap//
call system('mkdir -p ~/.local/share/nvim/undo')
set undodir=~/.local/share/nvim/undo//

" ======= SEARCH OPTIONS =======

set ignorecase          " Make searching case insensitive
set smartcase           " ... unless the query has capital letters
set gdefault            " Use 'g' flag by default with :s/foo/bar/
set magic               " Use 'magic' patterns (extended regular expressions)

" Use <C-L> to clear the highlighting of :set hlsearch.
if maparg('<C-L>', 'n') ==# ''
  nnoremap <silent> <C-L> :nohlsearch<CR><C-L>
endif

" ======= DIFF OPTIONS =======

set diffopt+=vertical	" set up diff options

" ======= SYNTAX =======

syntax enable			" Turn on syntax highlighting allowing local
"set tags=./.tags		" Ctag file location

" ======= KEYMAP =======

" Map the leader key to SPACE
let mapleader="\<SPACE>"

" Use ; for commands
"nnoremap ; :

" Open messages
nnoremap <leader>m :messages<cr>

" Popup navigation
inoremap <C-j> <C-n>
inoremap <C-k> <C-p>
cnoremap <C-j> <C-n>
cnoremap <C-k> <C-p>

" Buffers navigation
"nnoremap <F1> :bprevious<cr>
"nnoremap <F2> :bnext<cr>
nnoremap <A-a> :A<cr>
nnoremap <A-s> :AV<cr>
nnoremap <A-q> <C-w>c
nnoremap <A-w> <C-w>w
nnoremap <F3> :e<cr>
noremap <F4> :bd<cr>
noremap <F5> :w<cr>
noremap <F9> :copen<cr>
noremap <F10> :cclose<cr>
noremap <F11> :lopen<cr>
noremap <F12> :lclose<cr>

" Disable arrow keys
nnoremap <Left> :echoe "Use h"<CR>
nnoremap <Right> :echoe "Use l"<CR>
nnoremap <Up> <C-y>
nnoremap <Down> <C-e>

" Map tab to indent in visual mode
vmap <Tab> >gv
vmap <S-Tab> <gv

" Preserve selection after indentation
vmap > >gv
vmap < <gv

" ======= IGNORE =======

set wildmode=list:full
set wildignore=*.o,*.obj,*~
set wildignore+=*vim/backups*
set wildignore+=*sass-cache*
set wildignore+=*cache*
set wildignore+=*logs*
set wildignore+=*node_modules/**
set wildignore+=*bower_components/**
set wildignore+=*DS_Store*
set wildignore+=*.gem
set wildignore+=log/**
set wildignore+=tmp/**
set wildignore+=dist/**
set wildignore+=*.png,*.jpg,*.gif

" ======= PLUGINS =======

" Automatically install vim-plug and run PlugInstall if vim-plug not found
if empty(glob('~/.config/nvim/autoload/plug.vim'))
  silent !curl -fLo ~/.config/nvim/autoload/plug.vim --create-dirs
    \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
  autocmd VimEnter * PlugInstall | source $MYVIMRC
endif

" Plug options
let g:plug_threads = 16
let g:plug_timeout = 60
let g:plug_retries = 2
let g:plug_shallow = 1

call system('mkdir -p ~/.config/nvim/bundle')
call plug#begin('~/.config/nvim/bundle')

" Common
Plug 'tpope/vim-sensible'
Plug 'tpope/vim-unimpaired'
Plug 'tpope/vim-repeat'
Plug 'tpope/vim-surround'
Plug 'junegunn/vim-easy-align'
Plug 'tmhedberg/matchit'
Plug 'matze/vim-move'
	let g:move_key_modifier = 'C'
"Plug 'neomake/neomake'
"	let g:neomake_javascript_enabled_makers = ['eslint', 'jshint']
"	autocmd! BufWritePost,BufEnter ~/src/timify/**/*.js Neomake jshint
"	autocmd! BufWritePost,BufEnter ~/src/artursmirnov/**/*.js Neomake eslint
Plug 'w0rp/ale'
	let g:ale_sign_column_always = 1
	let g:ale_sign_error = ''
	let g:ale_sign_warning = '!'
	let g:ale_open_list = 0
	let g:ale_lint_delay = 500
Plug 'bronson/vim-trailing-whitespace'
	let g:extra_whitespace_ignored_filetypes = []
Plug 'jiangmiao/auto-pairs'
Plug 'scrooloose/nerdcommenter'
Plug 'michaeljsmith/vim-indent-object'
Plug 'editorconfig/editorconfig-vim'

" Colorschemes
call system('mkdir -p ~/.config/nvim/colors')
call system('touch ~/.vimrc')
Plug 'nanotech/jellybeans.vim'
	let g:jellybeans_use_term_italics = 0
Plug 'goatslacker/mango.vim', { 'do': './make'}

colorscheme jellybeans

" Git
Plug 'tpope/vim-git'
Plug 'tpope/vim-fugitive'
	autocmd BufReadPost fugitive://* set bufhidden=delete
Plug 'airblade/vim-gitgutter'
	let g:gitgutter_max_signs = 500
	let g:gitgutter_realtime = 1
	let g:gitgutter_eager = 1
	let g:gitgutter_highlight_lines = 0
	let g:gitgutter_async = 1

" UI
Plug 'scrooloose/nerdtree'
	nnoremap <F1> :NERDTreeToggle<cr>
	nnoremap <F2> :NERDTreeFind<cr>
Plug 'itchyny/lightline.vim'
	let g:lightline = {}
	let g:lightline.active = {}
	let g:lightline.inactive = {}
	let g:lightline.component_function = {}
	let g:lightline.component_expand = {}
	let g:lightline.component_type = {}
	let g:lightline.colorscheme = 'powerline'
	let g:lightline.active.left = [ [ 'mode', 'paste' ], [ 'readonly', 'relativepath' ] ]
	let g:lightline.active.right = [ [ 'percent' ], [ 'branch' ], [ 'fileformat', 'fileencoding' ], [ 'linter' ] ]
	let g:lightline.inactive.left = [ [ 'readonly', 'relativepath' ] ]
	let g:lightline.inactive.right = []
	let g:lightline.subseparator = { 'left': '', 'right': '|' }
	let g:lightline.component_function.branch = 'LightlineBranch'
	let g:lightline.component_function.relativepath = 'LightlineRelativepath'
	let g:lightline.component_function.fileformat = 'LightlineFileformat'
	let g:lightline.component_function.fileencoding = 'LightlineFileencoding'
	let g:lightline.component_expand.linter = 'AleErrors'
	let g:lightline.component_type.linter = 'error'
	autocmd User ALELint call lightline#update()
	
	function! AleErrors()
		let l:counts = ale#statusline#Count(bufnr(''))
		let l:all_errors = l:counts.error + l:counts.style_error
		return l:counts.total == 0 ? '' : winwidth(0) > 100 ? 'Errors: ' . all_errors : 'E:' . all_errors
	endfunction
	
	function! LightlineRelativepath()
		let filename = winwidth(0) > 100 ? expand('%:f') : expand('%:t')
		let file = filename !=# '' ? filename : '[No Name]'
		let modified = &modified ? ' *' : ''
		return filename . modified
	endfunction
	
	function! LightlineFileformat()
		return winwidth(0) > 100 ? &fileformat : ''
	endfunction

	function! LightlineFileencoding()
		return winwidth(0) > 100 ? &fileencoding : ''
	endfunction
	
	function! LightlineBranch()
		return winwidth(0) > 100 ? fugitive#head() : ''
	endfunction
	
"Plug 'vim-airline/vim-airline'
"    let g:airline_powerline_fonts = 1
"	let g:airline_left_sep=''
"	let g:airline_right_sep=''
"	let g:airline_skip_empty_sections = 1
"	let g:airline_extensions = ['branch', 'whitespace', 'syntastic']
"	let g:airline#extensions#tabline#enabled = 0
"	let g:airline#extensions#tabline#tab_min_count = 0
"	let g:airline#extensions#tabline#formatter = 'unique_tail'
"	let g:airline#extensions#tabline#fnamemod = ':t'
"	let g:airline#extensions#tabline#show_close_button = 0
"	let g:airline#extensions#tabline#left_sep = ' '
"	let g:airline#extensions#tabline#left_alt_sep = '|'
"Plug 'vim-airline/vim-airline-themes'
"	let g:airline_theme='jellybeans'
Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }
Plug 'junegunn/fzf.vim'
	nnoremap <C-p> :FZF<cr>
	nnoremap <C-b> :Buffers<cr>
	nnoremap <A-space> :Buffers<cr>
	nnoremap <leader>f :Ag<cr>
Plug 'ryanoasis/vim-devicons'

" Autocomplete
Plug 'Shougo/echodoc.vim'
	let g:echodoc#enable_at_startup = 1
Plug 'Shougo/context_filetype.vim'
Plug 'Shougo/deoplete.nvim', { 'do': ':UpdateRemotePlugins' }
	set completeopt-=preview
	let g:deoplete#enable_at_startup = 1
	let g:deoplete#enable_smart_case = 1
	let g:deoplete#auto_complete_start_length = 1
	let g:deoplete#auto_complete_delay = 10
	let g:deoplete#omni#functions = {}
	let g:deoplete#omni#functions.javascript = [
	  \ 'tern#Complete',
	  \ 'jspc#omni'
	\]	
	autocmd InsertLeave,CompleteDone * silent! pclose!
Plug 'Shougo/neosnippet'
Plug 'Shougo/neosnippet-snippets'
Plug 'ternjs/tern_for_vim', { 'do': 'npm install', 'for': ['javascript'] }
	let g:tern#command = ['tern']
	let g:tern#arguments = ['--persistent']
Plug 'carlitux/deoplete-ternjs', { 'for': ['javascript'] }
Plug 'othree/jspc.vim' ", { 'for': ['javascript'] }
"Plug 'autozimu/LanguageClient-neovim', { 'do': ':UpdateRemotePlugins' }
"	let g:LanguageClient_autoStart = 1
"	let g:LanguageClient_serverCommands = {
"		\ 'javascript': [
"			\ '~/lang-servers/javascript-typescript-langserver/lib/language-server-stdio.js'
"		\ ],
"		\ 'typescript': [
"			\ '~/lang-servers/javascript-typescript-langserver/lib/language-server-stdio.js'
"		\ ]
"		\ }
"	nnoremap <silent> <leader>i :call LanguageClient_textDocument_hover()<CR>
"	nnoremap <silent> <leader>d :call LanguageClient_textDocument_definition()<CR>
"	nnoremap <silent> <leader>r :call LanguageClient_textDocument_rename()<CR>

" Projects and structure
Plug 'tpope/vim-projectionist'

call system('mkdir -p ~/.local/share/nvim/sessions')
Plug 'wting/gitsessions.vim'
	let g:gitsessions_dir = '~/.local/share/nvim/sessions'
	let g:gitsessions_disable_auto_load = 0
	let g:gitsessions_use_cache = 0
	autocmd VimEnter * GitSessionLoad
	autocmd VimLeave * GitSessionSave

" Syntax
Plug 'othree/html5.vim' ", { 'for': ['html', 'handlebars'] }
Plug 'HerringtonDarkholme/yats.vim' ", { 'for': ['typescript'] }
Plug 'othree/yajs.vim' ", { 'for': ['javascript'] }
Plug 'othree/es.next.syntax.vim' ", { 'for': ['javascript'] }
Plug 'othree/javascript-libraries-syntax.vim' ", { 'for': ['javascript'] }
	let g:used_javascript_libs = 'jquery,underscore,jasmine,chai,handlebars,d3'
Plug 'stephpy/vim-yaml' ", { 'for': ['yaml'] }
Plug 'leafgarland/typescript-vim' ", { 'for': ['typescript'] }
	let g:typescript_indent_disable = 0
	let g:typescript_compiler_binary = 'tsc'
	let g:typescript_compiler_options = ''
Plug 'cakebaker/scss-syntax.vim' ", { 'for': ['scss'] }
Plug 'groenewege/vim-less' ", { 'for': ['less'] }
Plug 'elzr/vim-json' ", { 'for': ['json'] }
	let g:vim_json_syntax_conceal = 1
Plug 'JulesWang/css.vim' ", { 'for': ['css', 'scss', 'less'] }
Plug 'moll/vim-node' ", { 'for': ['javascript'] }
Plug 'mxw/vim-jsx'

" Ember
Plug 'joukevandermaas/vim-ember-hbs', { 'for': ['handlebars'] }
Plug 'AndrewRadev/ember_tools.vim', { 'for': ['javascript', 'handlebars'] }
Plug 'camthompson/vim-ember', { 'for': ['javascript', 'handlebars'] }

" RoR
Plug 'tpope/vim-rails'
Plug 'thoughtbot/vim-rspec'

" Initialize plugin system
call plug#end()
