set nocompatible
" vim version = 8.1 Improved
syntax on
set number
" set mouse=a
let &t_ut=''
set autochdir
" (usually <Tab>) to invoke completion
set wildmenu
set splitbelow
set hidden    " hide buffers when abandoned instead of unload
" fix <backspace> invaild in insert mode
set backspace=indent,eol,start
set scrolloff=15
set ignorecase
set smartcase
set expandtab
set tabstop=4
set shiftwidth=4
set softtabstop=4
set autoindent
set hlsearch
exec "nohlsearch"
set incsearch
set relativenumber
set showcmd
" Highlight the screen line
set cursorline
set list
set listchars=tab:\|\ ,trail:▫
" Set <LEADER> as <SPACE>
let mapleader="`"
"let maplocalleader="\\"

" New cursor movement (the default arrow keys are used for resizing windows)
"     ^
"     i
" < j   l >
"     k
"     v
noremap <silent> i k
noremap <silent> j h
noremap <silent> k j
noremap <silent> l l
noremap <silent> K 5j
noremap <silent> I 5k
" N key: go to the start of the line
noremap <silent> J 0
" I key: go to the end of the line
noremap <silent> L $
" Save & quit
noremap Q :q<CR>
noremap S :w<CR>
" noremap ` :source $MYVIMRC<CR>
noremap ~ :source %<CR>

" insert the start of the line
noremap h i
noremap H I
" Faster in-line navigation
noremap <silent> W 5w
noremap <silent> B 5b

" Copy to system clipboard
vnoremap Y "+y
" search
noremap - N
noremap = n
noremap s <nop>
noremap <LEADER><CR> :nohlsearch<CR>

" split the screens to up (horizontal), down (horizontal), left (vertical), right (vertical)
noremap si :set nosplitbelow<CR>:split<CR>:set splitbelow<CR>
noremap sk :set splitbelow<CR>:split<CR>
noremap sj :set nosplitright<CR>:vsplit<CR>:set splitright<CR>
noremap sl :set splitright<CR>:vsplit<CR>

" Resize splits with arrow keys
noremap <up> :res +5<CR>
noremap <down> :res -5<CR>
noremap <left> :vertical resize-5<CR>
noremap <right> :vertical resize+5<CR>

" Place the two screens up and down
noremap sh <C-w>t<C-w>K
" Place the two screens side by side
noremap sv <C-w>t<C-w>H

" Use <space> + new arrow keys for moving the cursor around windows
noremap <LEADER>w <C-w>w
noremap <LEADER>i <C-w>k
noremap <LEADER>k <C-w>j
noremap <LEADER>j <C-w>h
noremap <LEADER>l <C-w>l
" Move around tabs with < and >
noremap < :-tabnext<CR>
noremap > :+tabnext<CR>

" Open a new instance of st with the cwd
nnoremap <LEADER>n :tabe<CR>:-tabmove<CR>

" Opening a terminal window
"noremap <LEADER>t :set splitbelow<CR>:term ++rows=10<CR>
noremap <LEADER>\ :set splitbelow<CR>:split<CR>:res +10<CR>:term<CR>

" Press <SPACE> + q to close the window below the current window
noremap <LEADER>q <C-w>j:q<CR>

" When editing a file, always jump to the last cursor position
au BufReadPost * if line("'\"") > 1 && line("'\"") <= line("$") | exe "normal! g'\"" | endif

" Quickly run
noremap r :call CompileRunCode()<CR>
func! CompileRunCode()
    exec "w"
    if &filetype == 'c'
        set splitbelow
        :sp
        :res -10
        " vim
        ":term ++curwin ++shell ++rows=10 gcc -ansi -Wall % -o %<.o && ./%<.o
        " nvim
        :term gcc -ansi -Wall % -o %< && ./%<
    elseif &filetype == 'cpp'
        set splitbelow
        :sp
        :res -10
        ":term ++curwin ++shell ++rows=10 g++ -std=c++11 -Wall % -o %<.o && ./%<.o
        :term g++ -std=c++11 % -Wall -o %< && ./%<
    elseif &filetype == 'sh'
        :!time bash %
    elseif &filetype == 'python'
        set splitbelow
        :sp
        :res -15
        ":term ++curwin ++rows=10 conda run -n base --no-capture-output --live-stream python3 %
        :term conda run -n pysyft --no-capture-output --live-stream python3 %
    elseif &filetype == 'markdown'
        exec "MarkdownPreview"
    elseif &filetype == 'go'
        set splitbelow
        :sp
        :res -10
        ":term ++curwin ++rows=10 go run %
        ":term go run %
    endif
endfunc

" The default plugin directory will be as follows:
"   - Vim (Linux/macOS): '~/.vim/plugged'
"   - Vim (Windows): '~/vimfiles/plugged'
"   - Neovim (Linux/macOS/Windows): stdpath('data') . '/plugged'
" You can specify a custom plugin directory by passing it as the argument
"   - e.g. `call plug#begin('~/.vim/plugged')`
"   - Avoid using standard Vim directory names like 'plugin'
call plug#begin('~/.vim/plugged')

" ---- Editor Enhancement ----
Plug 'vim-airline/vim-airline'
Plug 'jiangmiao/auto-pairs'
Plug 'machakann/vim-highlightedyank'
Plug 'vim-airline/vim-airline-themes'
Plug 'connorholyday/vim-snazzy'
Plug 'w0ng/vim-hybrid'
Plug 'ajmwagar/vim-deus'
Plug 'easymotion/vim-easymotion'
" An extensible & universal comment vim-plugin that also handles embedded filetypes
Plug 'tomtom/tcomment_vim'
" Enhanced terminal integration for Vim
Plug 'wincent/terminus'
Plug 'puremourning/vimspector'
" Use release branch (recommend)
Plug 'neoclide/coc.nvim', {'branch': 'release'}
" Plug 'neoclide/coc.nvim', {'branch': 'release', 'tag': 'v0.0.79'}
" A Git wrapper so awesome, it should be illegal
Plug 'tpope/vim-fugitive'
" Provides a start screen for Vim and Neovim
Plug 'mhinz/vim-startify'
" Multiple cursors
Plug 'mg979/vim-visual-multi', {'branch': 'master'}
" Smart selection of the closest text object
Plug 'gcmt/wildfire.vim'
" Delete/change/add parentheses/quotes/XML-tags/much more with ease
Plug 'tpope/vim-surround'
" Peekaboo will show you the contents of the registers on the sidebar
" when you hit " or @ in normal mode or <CTRL-R> in insert mode
Plug 'junegunn/vim-peekaboo'
" Make Ranger running in a floating window to communicate with Neovim via RPC
Plug 'kevinhwang91/rnvimr'
" A simple, easy-to-use Vim alignment plugin
Plug 'junegunn/vim-easy-align'
" Find & Replace
Plug 'brooth/far.vim'
" Viewer & Finder for LSP symbols and tags
Plug 'liuchengxu/vista.vim'
" Tabline customization with buffer filtering
Plug 'mg979/vim-xtabline'
" help you read complex code by showing diff level of parentheses in diff color !!
Plug 'luochen1990/rainbow'

" ---- File navigation ----
Plug 'scrooloose/nerdtree', { 'on': 'NERDTreeToggle' }
Plug 'Xuyuanp/nerdtree-git-plugin'
Plug 'ryanoasis/vim-devicons'
Plug 'tiagofumo/vim-nerdtree-syntax-highlight'
Plug 'PhilRunninger/nerdtree-visual-selection'
Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
Plug 'junegunn/fzf.vim'
Plug 'Yggdroot/LeaderF', { 'do': ':LeaderfInstallCExtension' }

" ---- Development Enhancement ----
Plug 'jalvesaq/Nvim-R', {'branch': 'oldstable'} "R >= 3.0.0 For Neovim >= 0.3.4 and Vim >= 8.1
"Plug 'jalvesaq/Nvim-R', {'branch': 'stable'}
" c/c++
Plug 'jackguo380/vim-lsp-cxx-highlight'
" go
Plug 'fatih/vim-go', { 'do': ':GoUpdateBinaries' }
" markdown
" If you have nodejs and yarn
Plug 'iamcco/markdown-preview.nvim', { 'do': 'cd app && yarn install'  }
Plug 'dkarter/bullets.vim'
" python
" Plug 'numirias/semshi', {'do': ':UpdateRemotePlugins'} "Semantic Highlighting for Python

call plug#end()

" ===
" Initialize plugin system
call plug#end()

" ===
" === 'kevinhwang91/rnvimr'
" ===
tnoremap <silent> <M-i> <C-\><C-n>:RnvimrResize<CR>
nnoremap <silent> <M-o> :RnvimrToggle<CR>
tnoremap <silent> <M-o> <C-\><C-n>:RnvimrToggle<CR>

" ===
" === 'ajmwagar/vim-deus'
" ===
set t_Co=256
set termguicolors
let &t_8f = "\<Esc>[38;2;%lu;%lu;%lum"
let &t_8b = "\<Esc>[48;2;%lu;%lu;%lum"
set background=dark    " Setting dark mode
colorscheme deus
let g:deus_termcolors=256

" ===
" === 'ryanoasis/vim-devicons'
" ===
set encoding=utf-8

" ===
" === 'Xuyuanp/nerdtree-git-plugin' 
" ===
let g:NERDTreeGitStatusIndicatorMapCustom = {
    \ "Modified"  : "✹",
    \ "Staged"    : "✚",
    \ "Untracked" : "✭",
    \ "Renamed"   : "➜",
    \ "Unmerged"  : "═",
    \ "Deleted"   : "✖",
    \ "Dirty"     : "✗",
    \ "Clean"     : "✔︎",
    \ "Unknown"   : "?"
    \ }

" ===
" === 'luochen1990/rainbow'
" ===
"set to 0 if you want to enable it later via :RainbowToggle
let g:rainbow_active = 1

" ===
" === 'gcmt/wildfire.vim'
" ===
let g:wildfire_objects = ["i'", 'i"', "i)", "i]", "i}", "ip", "it", "i>"]

" ===
" === rnvimr
" ===
let g:rnvimr_ex_enable = 1
let g:rnvimr_pick_enable = 1
let g:rnvimr_draw_border = 0
" let g:rnvimr_bw_enable = 1
highlight link RnvimrNormal CursorLine
nnoremap <silent> R :RnvimrToggle<CR><C-\><C-n>:RnvimrResize 0<CR>
let g:rnvimr_action = {
            \ '<C-t>': 'NvimEdit tabedit',
            \ '<C-x>': 'NvimEdit split',
            \ '<C-v>': 'NvimEdit vsplit',
            \ 'gw': 'JumpNvimCwd',
            \ 'yw': 'EmitRangerCwd'
            \ }
let g:rnvimr_layout = { 'relative': 'editor',
            \ 'width': &columns,
            \ 'height': &lines,
            \ 'col': 0,
            \ 'row': 0,
            \ 'style': 'minimal' }
let g:rnvimr_presets = [{'width': 1.0, 'height': 1.0}]

" ===
" === 'scrooloose/nerdtree'
" ===
nmap tt :NERDTreeToggle<CR>
" Avoid keyboard conflict
let NERDTreeMapOpenSplit='\i'

" ===
" === FZF
" ===
nmap <LEADER>f :FZF<CR>

" ---- vim-airline ----
let g:airline_powerline_fonts = 1
" remove empty angle at the end
let g:airline_skip_empty_sections = 1
let g:airline#extensions#tabline#enabled = 0
let g:airline#extensions#tabline#left_sep = ' '
let g:airline#extensions#tabline#formatter = 'unique_tail'
let g:airline_theme='deus'

" ===
" === jalvesaq/Nvim-R
" ===
let R_app = "radian"
let R_cmd = "R"
let R_hl_term = 0
let R_args = []  " if you had set any
let R_bracketed_paste = 1
" only use those key-bindings specified by the user
let R_user_maps_only = 0
" temporary files
let R_tmpdir = '/dev/shm/R_tmp_dir'
let R_compldir = '~/.cache/Nvim-R'
" If you want that R is started automatically when you start editing an R script
autocmd FileType r if string(g:SendCmdToR) == "function('SendCmdToR_fake')" | call StartR("R") | endif
autocmd FileType rmd if string(g:SendCmdToR) == "function('SendCmdToR_fake')" | call StartR("R") | endif
" if you want to quit automatically when quiting Vim
autocmd VimLeave * if exists("g:SendCmdToR") && string(g:SendCmdToR) != "function('SendCmdToR_fake')" | call RQuit("nosave") | endif
" Press the space bar to send lines and selection to R:
vmap <Space> <Plug>RDSendSelection
nmap <Space> <Plug>RDSendLine

" ===
" === Yggdroot/LeaderF
" ===
" don't show the help in normal mode
let g:Lf_HideHelp = 1
let g:Lf_UseCache = 0
let g:Lf_UseVersionControlTool = 0
let g:Lf_IgnoreCurrentBufferName = 1
" popup mode
let g:Lf_WindowPosition = 'popup'
let g:Lf_PreviewInPopup = 1
let g:Lf_StlSeparator = { 'left': "\ue0b0", 'right': "\ue0b2", 'font': "DejaVu Sans Mono for Powerline" }
let g:Lf_PreviewResult = {'Function': 0, 'BufTag': 0 }

let g:Lf_ShortcutF = "<leader>ff"
noremap <leader>fb :<C-U><C-R>=printf("Leaderf buffer %s", "")<CR><CR>
noremap <leader>fm :<C-U><C-R>=printf("Leaderf mru %s", "")<CR><CR>
noremap <leader>ft :<C-U><C-R>=printf("Leaderf bufTag %s", "")<CR><CR>
noremap <leader>fl :<C-U><C-R>=printf("Leaderf line %s", "")<CR><CR>

noremap <C-B> :<C-U><C-R>=printf("Leaderf! rg --current-buffer -e %s ", expand("<cword>"))<CR>
noremap <C-F> :<C-U><C-R>=printf("Leaderf! rg -e %s ", expand("<cword>"))<CR>
" search visually selected text literally
xnoremap gf :<C-U><C-R>=printf("Leaderf! rg -F -e %s ", leaderf#Rg#visual())<CR>
noremap go :<C-U>Leaderf! rg --recall<CR>

" should use `Leaderf gtags --update` first
let g:Lf_GtagsAutoGenerate = 0
let g:Lf_Gtagslabel = 'native-pygments'
noremap <leader>fr :<C-U><C-R>=printf("Leaderf! gtags -r %s --auto-jump", expand("<cword>"))<CR><CR>
noremap <leader>fd :<C-U><C-R>=printf("Leaderf! gtags -d %s --auto-jump", expand("<cword>"))<CR><CR>
noremap <leader>fo :<C-U><C-R>=printf("Leaderf! gtags --recall %s", "")<CR><CR>
noremap <leader>fn :<C-U><C-R>=printf("Leaderf gtags --next %s", "")<CR><CR>
noremap <leader>fp :<C-U><C-R>=printf("Leaderf gtags --previous %s", "")<CR><CR>

" ===
" === 'iamcco/markdown-preview.nvim"
" ===
" set to 1, preview server available to others in your network
" by default, the server listens on localhost (127.0.0.1)
" default: 0
let g:mkdp_open_to_the_world = 1
" set to 1, echo preview page url in command line when open preview page
" default is 0
let g:mkdp_echo_preview_url = 1
" use custom IP to open preview page
" useful when you work in remote vim and preview on local browser
" more detail see: https://github.com/iamcco/markdown-preview.nvim/pull/9
" default empty
let g:mkdp_open_ip = '47.99.34.174'
" use a custom port to start server or random for empty
let g:mkdp_port = '8888'
" preview page title
" ${name} will be replace with the file name
let g:mkdp_page_title = '「${name}」'

" ===
" === vimspector
" ===
let g:vimspector_enable_mappings = 'HUMAN'
function! s:read_template_into_buffer(template)
    " has to be a function to avoid the extra space fzf#run insers otherwise
    execute '0r ~/.config/nvim/sample_vimspector_json/'.a:template
endfunction
command! -bang -nargs=* LoadVimSpectorJsonTemplate call fzf#run({
            \   'source': 'ls -1 ~/.config/nvim/sample_vimspector_json',
            \   'down': 20,
            \   'sink': function('<sid>read_template_into_buffer')
            \ })
" noremap <leader>vs :tabe .vimspector.json<CR>:LoadVimSpectorJsonTemplate<CR>
sign define vimspectorBP text=☛ texthl=Normal
sign define vimspectorBPDisabled text=☞ texthl=Normal
sign define vimspectorPC text=🔶 texthl=SpellBa

" ===
" === vim-go
" ===
let g:go_echo_go_info = 0
let g:go_doc_popup_window = 1
let g:go_def_mapping_enabled = 0
let g:go_template_autocreate = 0
let g:go_textobj_enabled = 0
let g:go_auto_type_info = 1
let g:go_def_mapping_enabled = 0
let g:go_highlight_array_whitespace_error = 1
let g:go_highlight_build_constraints = 1
let g:go_highlight_chan_whitespace_error = 1
let g:go_highlight_extra_types = 1
let g:go_highlight_fields = 1
let g:go_highlight_format_strings = 1
let g:go_highlight_function_calls = 1
let g:go_highlight_function_parameters = 1
let g:go_highlight_functions = 1
let g:go_highlight_generate_tags = 1
let g:go_highlight_methods = 1
let g:go_highlight_operators = 1
let g:go_highlight_space_tab_error = 1
let g:go_highlight_string_spellcheck = 1
let g:go_highlight_structs = 1
let g:go_highlight_trailing_whitespace_error = 1
let g:go_highlight_types = 1
let g:go_highlight_variable_assignments = 0
let g:go_highlight_variable_declarations = 0
let g:go_doc_keywordprg_enabled = 0

" ===
" === 'neoclide/coc.nvim'
" ===
let g:coc_global_extensions = [
            \ 'coc-json',
            \ 'coc-vimlsp',
            \ 'coc-clangd',
            \ 'coc-r-lsp',
            \ 'coc-pyright',
            \ 'coc-sh',
            \ 'coc-toml',
            \ 'coc-yaml',
            \ 'coc-markdownlint',
            \ 'coc-cmake',
            \ 'coc-prettier']
" coc-clangd

" Having longer updatetime (default is 4000 ms = 4 s) leads to noticeable
" delays and poor user experience.
set updatetime=100
" set signcolumn=number
" map
noremap <LEADER>, :CocConfig<CR>

" Use tab for trigger completion with characters ahead and navigate.
" NOTE: Use command ':verbose imap <tab>' to make sure tab is not mapped by

inoremap <silent><expr> <TAB>
      \ pumvisible() ? "\<C-n>" :
      \ <SID>check_back_space() ? "\<TAB>" :
      \ coc#refresh()
inoremap <expr><S-TAB> pumvisible() ? "\<C-p>" : "\<C-h>"
inoremap <expr> <cr> complete_info()["selected"] != "-1" ? "\<C-y>" : "\<C-g>u\<CR>"

function! s:check_back_space() abort
  let col = col('.') - 1
  return !col || getline('.')[col - 1]  =~# '\s'
endfunction

" Use <LEADER>o to show documentation in preview window.
nnoremap <silent> <LEADER>o :call <SID>show_documentation()<CR>

function! s:show_documentation()
  if (index(['vim','help'], &filetype) >= 0)
    execute 'h '.expand('<cword>')
  elseif (coc#rpc#ready())
    call CocActionAsync('doHover')
  else
    execute '!' . &keywordprg . " " . expand('<cword>')
  endif
endfunction

" GoTo code navigation.
nmap <silent> gd <Plug>(cmoc-definition)
nmap <silent> gy <Plug>(coc-type-definition)
nmap <silent> gi <Plug>(coc-implementation)
nmap <silent> gr <Plug>(coc-references)
