set nocompatible
" Yank to the system clipboard: unnamed on macOS, unnamedplus on Linux.
set clipboard=unnamed,unnamedplus
filetype off

set rtp+=/usr/local/opt/fzf
set rtp+=~/.vim/bundle/Vundle.vim
set colorcolumn=

call vundle#begin()
Plugin 'VundleVim/Vundle.vim'
Plugin 'pieterjanmontens/vim-pipenv'
" Plugin 'joonty/vdebug'
Plugin 'godlygeek/tabular'
Plugin 'preservim/vim-markdown'
Plugin 'chrisbra/csv.vim'
Plugin 'neoclide/coc.nvim'
Plugin 'rizzatti/dash.vim'
Plugin 'arcticicestudio/nord-vim'
Plugin 'udalov/kotlin-vim'
Plugin 'junegunn/goyo.vim'
Plugin 'preservim/tagbar'
Plugin 'wellle/targets.vim'
Plugin 'tpope/vim-fugitive'
Plugin 'tpope/vim-surround'
Plugin 'scrooloose/nerdtree'
Plugin 'Xuyuanp/nerdtree-git-plugin'
Plugin 'tiagofumo/vim-nerdtree-syntax-highlight'
Plugin 'bash-support.vim'
Plugin 'chase/vim-ansible-yaml'
Plugin 'pearofducks/ansible-vim'
Plugin 'MarcWeber/vim-addon-mw-utils'
Plugin 'tomtom/tlib_vim'
Plugin 'honza/vim-snippets'
Plugin 'vadv/vim-chef'
Plugin 'hashivim/vim-terraform'
Plugin 'juliosueiras/vim-terraform-completion'
Plugin 'sebosp/vim-snippets-terraform'
Plugin 'othree/javascript-libraries-syntax.vim'
Plugin 'burnettk/vim-angular'
Plugin 'scrooloose/syntastic'
Plugin 'ctrlpvim/ctrlp.vim'
Plugin 'vim-airline/vim-airline'
Plugin 'vim-airline/vim-airline-themes'
Plugin 'OmniSharp/omnisharp-vim'
Plugin 'neomake/neomake'
Plugin 'mg979/vim-localhistory'
Plugin 'junegunn/fzf'
Plugin 'junegunn/fzf.vim'
Plugin 'https://gitlab.com/protesilaos/tempus-themes-vim.git'
Plugin 'darktango.vim'
" Plugin 'danth/pathfinder.vim'
Plugin 'ryanoasis/vim-devicons'
call vundle#end()

call plug#begin()

" List your plugins here
Plug 'neoclide/coc.nvim', {'branch': 'master', 'do': 'npm ci'}
Plug 'jmcantrell/vim-virtualenv'
Plug 'vim-test/vim-test'
Plug 'will133/vim-dirdiff'
call plug#end()

set softtabstop=2
set shiftwidth=4
set tabstop=4
syntax on
filetype indent on
set autoindent
set number
syntax enable
colorscheme darktango
set nobackup
set nowritebackup
set laststatus=2
set statusline=%F%m%r%h%w%=(%{&ff}/%Y)\ (line\ %l\/%L,\ col\ %c)\
set wildmenu " Display command line's tab complete options as a menu.

" Syntastic Config
set statusline+=%#warningmsg#
set statusline+=%{SyntasticStatuslineFlag()}
set statusline+=%*

let g:syntastic_always_populate_loc_list = 1
let g:syntastic_auto_loc_list = 1
let g:syntastic_check_on_open = 1
let g:syntastic_loc_list_height = 3
let g:syntastic_check_on_wq = 0


" DirDiff exclusion patterns
let g:DirDiffExcludes = "CVS,*.class,*.exe,.*.swp,.terraform,*.tfstate,*.tfstate.backup,.git,node_modules,__pycache__,*.pyc"
let g:DirDiffIgnore = "Id:,Revision:,Date:"

" More comprehensive exclusions for development
let g:DirDiffExcludes = join([
    \ "CVS", "*.class", "*.exe", ".*.swp",
    \ ".terraform", "*.tfstate", "*.tfstate.backup", 
    \ ".terragrunt-cache", ".git", ".gitignore",
    \ "node_modules", "*.log", "*.tmp",
    \ "__pycache__", "*.pyc", "*.pyo",
    \ ".DS_Store", "Thumbs.db"
    \ ], ",")

" Ruby
" let g:syntastic_ruby_checkers = ['rubocop']
" let g:syntastic_ruby_rubocop_exec = '/opt/chef-workstation/bin/cookstyle'

" (Optional)Remove Info(Preview) window
set completeopt-=preview

" (Optional)Hide Info(Preview) window after completions
autocmd CursorMovedI * if pumvisible() == 0|pclose|endif
autocmd InsertLeave * if pumvisible() == 0|pclose|endif

" (Optional) Enable terraform plan to be include in filter
let g:syntastic_terraform_tffilter_plan = 1

" (Optional) Default: 0, enable(1)/disable(0) plugin's keymapping
let g:terraform_completion_keys = 1

" (Optional) Default: 1, enable(1)/disable(0) terraform module registry completion
let g:terraform_registry_module_completion = 0

let g:terraform_align=1
" let g:terraform_fold_sections=1
let g:terraform_fmt_on_save=1

" When writing a buffer (no delay).
call neomake#configure#automake('w')
" When writing a buffer (no delay), and on normal mode changes (after 750ms).
call neomake#configure#automake('nw', 750)
" When reading a buffer (after 1s), and when writing (no delay).
call neomake#configure#automake('rw', 1000)
" Full config: when writing or reading a buffer, and on changes in insert and
" normal mode (after 500ms; no delay when writing).
call neomake#configure#automake('nrwi', 500)

filetype plugin on
set omnifunc=syntaxcomplete#Complete

set hidden

set cmdheight=2
set updatetime=300
set shortmess+=c

if has("patch-8.1.1564")
  " Recently vim can merge signcolumn and number column into one
  set signcolumn=number
else
  set signcolumn=yes
endif

" Use tab for trigger completion with characters ahead and navigate.
" NOTE: Use command ':verbose imap <tab>' to make sure tab is not mapped by
" other plugin before putting this into your config.
inoremap <silent><expr> <TAB>
      \ pumvisible() ? "\<C-n>" :
      \ <SID>check_back_space() ? "\<TAB>" :
      \ coc#refresh()
inoremap <expr><S-TAB> pumvisible() ? "\<C-p>" : "\<C-h>"

function! s:check_back_space() abort
  let col = col('.') - 1
  return !col || getline('.')[col - 1]  =~# '\s'
endfunction

" Use <c-space> to trigger completion.
if has('nvim')
  inoremap <silent><expr> <c-space> coc#refresh()
else
  inoremap <silent><expr> <c-@> coc#refresh()
endif

" Make <CR> auto-select the first completion item and notify coc.nvim to
" format on enter, <cr> could be remapped by other vim plugin
inoremap <silent><expr> <cr> pumvisible() ? coc#_select_confirm()
                              \: "\<C-g>u\<CR>\<c-r>=coc#on_enter()\<CR>"

" Use `[g` and `]g` to navigate diagnostics
" Use `:CocDiagnostics` to get all diagnostics of current buffer in location list.
nmap <silent> [g <Plug>(coc-diagnostic-prev)
nmap <silent> ]g <Plug>(coc-diagnostic-next)

" GoTo code navigation.
nmap <silent> gd <Plug>(coc-definition)
nmap <silent> gy <Plug>(coc-type-definition)
nmap <silent> gi <Plug>(coc-implementation)
nmap <silent> gr <Plug>(coc-references)

" Use K to show documentation in preview window.
nnoremap <silent> K :call <SID>show_documentation()<CR>

function! s:show_documentation()
  if (index(['vim','help'], &filetype) >= 0)
    execute 'h '.expand('<cword>')
  elseif (coc#rpc#ready())
    call CocActionAsync('doHover')
  else
    execute '!' . &keywordprg . " " . expand('<cword>')
  endif
endfunction

" Highlight the symbol and its references when holding the cursor.
autocmd CursorHold * silent call CocActionAsync('highlight')

" Symbol renaming.
nmap <leader>rn <Plug>(coc-rename)

" Formatting selected code.
xmap <leader>f  <Plug>(coc-format-selected)
nmap <leader>f  <Plug>(coc-format-selected)

augroup mygroup
  autocmd!
  " Setup formatexpr specified filetype(s).
  autocmd FileType typescript,json setl formatexpr=CocAction('formatSelected')
  " Update signature help on jump placeholder.
  autocmd User CocJumpPlaceholder call CocActionAsync('showSignatureHelp')
augroup end

" Applying codeAction to the selected region.
" Example: `<leader>aap` for current paragraph
xmap <leader>a  <Plug>(coc-codeaction-selected)
nmap <leader>a  <Plug>(coc-codeaction-selected)

" Remap keys for applying codeAction to the current buffer.
nmap <leader>ac  <Plug>(coc-codeaction)
" Apply AutoFix to problem on the current line.
nmap <leader>qf  <Plug>(coc-fix-current)

" Map function and class text objects
" NOTE: Requires 'textDocument.documentSymbol' support from the language server.
xmap if <Plug>(coc-funcobj-i)
omap if <Plug>(coc-funcobj-i)
xmap af <Plug>(coc-funcobj-a)
omap af <Plug>(coc-funcobj-a)
xmap ic <Plug>(coc-classobj-i)
omap ic <Plug>(coc-classobj-i)
xmap ac <Plug>(coc-classobj-a)
omap ac <Plug>(coc-classobj-a)

" Remap <C-f> and <C-b> for scroll float windows/popups.
if has('nvim-0.4.0') || has('patch-8.2.0750')
  nnoremap <silent><nowait><expr> <C-f> coc#float#has_scroll() ? coc#float#scroll(1) : "\<C-f>"
  nnoremap <silent><nowait><expr> <C-b> coc#float#has_scroll() ? coc#float#scroll(0) : "\<C-b>"
  inoremap <silent><nowait><expr> <C-f> coc#float#has_scroll() ? "\<c-r>=coc#float#scroll(1)\<cr>" : "\<Right>"
  inoremap <silent><nowait><expr> <C-b> coc#float#has_scroll() ? "\<c-r>=coc#float#scroll(0)\<cr>" : "\<Left>"
  vnoremap <silent><nowait><expr> <C-f> coc#float#has_scroll() ? coc#float#scroll(1) : "\<C-f>"
  vnoremap <silent><nowait><expr> <C-b> coc#float#has_scroll() ? coc#float#scroll(0) : "\<C-b>"
endif

" Use CTRL-S for selections ranges.
" Requires 'textDocument/selectionRange' support of language server.
nmap <silent> <C-s> <Plug>(coc-range-select)
xmap <silent> <C-s> <Plug>(coc-range-select)

" Add `:Format` command to format current buffer.
command! -nargs=0 Format :call CocAction('format')

" Add `:Fold` command to fold current buffer.
command! -nargs=? Fold :call     CocAction('fold', <f-args>)

" Add `:OR` command for organize imports of the current buffer.
command! -nargs=0 OR   :call     CocAction('runCommand', 'editor.action.organizeImport')

" Add (Neo)Vim's native statusline support.
" NOTE: Please see `:h coc-status` for integrations with external plugins that
" provide custom statusline: lightline.vim, vim-airline.
set statusline^=%{coc#status()}%{get(b:,'coc_current_function','')}

" Mappings for CoCList
" Show all diagnostics.
nnoremap <silent><nowait> <space>a  :<C-u>CocList diagnostics<cr>
" Manage extensions.
nnoremap <silent><nowait> <space>e  :<C-u>CocList extensions<cr>
" Show commands.
nnoremap <silent><nowait> <space>c  :<C-u>CocList commands<cr>
" Find symbol of current document.
nnoremap <silent><nowait> <space>o  :<C-u>CocList outline<cr>
" Search workspace symbols.
nnoremap <silent><nowait> <space>s  :<C-u>CocList -I symbols<cr>
" Do default action for next item.
nnoremap <silent><nowait> <space>j  :<C-u>CocNext<CR>
" Do default action for previous item.
nnoremap <silent><nowait> <space>k  :<C-u>CocPrev<CR>
" Resume latest coc list.
nnoremap <silent><nowait> <space>p  :<C-u>CocListResume<CR>

let syntastic_mode_map = { 'passive_filetypes': ['html'] }

set encoding=UTF-8
set guifont=DroidSansMono_Nerd_Font:h11
let g:airline_powerline_fonts = 1

map <F2> :!git shortlog -s -n %<cr>

:nnoremap <C-g> :NERDTree<CR>

" Configure for pytest
let g:test#python#runner = 'pytest'
let g:test#strategy = 'vimterminal'  " or 'vimterminal' for Vim

" Key mappings
nmap <silent> <leader>tn :TestNearest<CR>
nmap <silent> <leader>tf :TestFile<CR>
nmap <silent> <leader>ts :TestSuite<CR>
nmap <silent> <leader>tl :TestLast<CR>

autocmd vimenter * NERDTree
autocmd vimenter * wincmd l
autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTreeType") && b:NERDTreeType == "primary") | q | endif
nmap <silent> <C-l> :NERDTreeToggle<CR>

if winwidth(0) < 80
  autocmd vimenter * NERDTreeToggle
endif

set belloff=all

command Writemode colorscheme nord | setlocal spell | Goyo 70

function! TerraformDirDiff(dir1, dir2)
    let g:DirDiffExcludes = ".terraform,*.tfstate,*.tfstate.backup,.terragrunt-cache,*.log,.git"
    execute 'DirDiff' a:dir1 a:dir2
endfunction

" Command to use it

