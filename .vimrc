if empty(glob('~/.vim/autoload/plug.vim'))
  silent !curl -fLo ~/.vim/autoload/plug.vim --create-dirs
    \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
  autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
endif


call plug#begin('~/.vim/vim-plugins')
" Utilities
Plug 'mileszs/ack.vim'
Plug 'Valloric/YouCompleteMe'
Plug 'scrooloose/nerdtree'
Plug 'Xuyuanp/nerdtree-git-plugin'
Plug 'ctrlpvim/ctrlp.vim'
Plug 'w0rp/ale'
Plug 'vim-scripts/tComment'
Plug 'pbrisbin/vim-mkdir'
Plug 'christoomey/vim-run-interactive'
Plug 'janko-m/vim-test'
Plug 'tpope/vim-bundler'
Plug 'tpope/vim-endwise'
Plug 'tpope/vim-eunuch'
Plug 'tpope/vim-fugitive'
Plug 'tpope/vim-repeat'
Plug 'tpope/vim-surround'

" Themes
Plug 'morhetz/gruvbox'

" Language packages
Plug 'pangloss/vim-javascript'
Plug 'tpope/vim-rails'
Plug 'tpope/vim-rake'
Plug 'elixir-editors/vim-elixir'
Plug 'slashmili/alchemist.vim'
Plug 'vim-ruby/vim-ruby'
Plug 'slim-template/vim-slim'
call plug#end()


let mapleader = ' '
nnoremap <Space> <Nop>

colorscheme gruvbox
let g:gruvbox_contrast_dark     = 'hard'
let g:gruvbox_improved_strings  = 1
let g:gruvbox_improved_warnings = 1
let g:gruvbox_guisp_fallback = 'fg'


let g:javascript_plugin_flow = 1
let g:javascript_conceal_function = "ƒ"
set conceallevel=1


let g:ackprg = 'ag --nogroup --nocolor --column'
nnoremap <Leader>a :Ack!<Space>


let g:ctrlp_custom_ignore = {
  \ 'dir':  '\v[\/](\.git|vendor|tmp|node_modules)',
  \ 'file': '\v\.(exe|so|dll|log)$'
  \ }


let g:ycm_max_num_candidates = 1
let g:ycm_max_num_identifier_candidates = 1
let g:ycm_log_level = 'error'
let g:ycm_server_python_interpreter = '/usr/local/bin/python3'


nnoremap <leader>r :RunInInteractiveShell<space>


set tabstop=2
set shiftwidth=2
set softtabstop=2
set expandtab
autocmd FileType make setlocal noexpandtab


set listchars=tab:▸\ ,eol:¬
set list


highlight ExtraWhitespace ctermbg=red guibg=red
match ExtraWhitespace /\s\+$/
autocmd BufWinEnter * match ExtraWhitespace /\s\+$/
autocmd InsertEnter * match ExtraWhitespace /\s\+\%#\@<!$/
autocmd InsertLeave * match ExtraWhitespace /\s\+$/
autocmd BufWinLeave * call clearmatches()


map <C-n> :NERDTreeToggle<CR>

" Switching between windows
map <C-h> <C-w>h
map <C-j> <C-w>j
map <C-k> <C-w>k
map <C-l> <C-w>l

" Chrome-style tab navigation
map <D-S-]> gt
map <D-S-[> gT

" Resizing windows
nnoremap <silent> <Leader>= :exe "resize " . (winheight(0) * 3/2)<CR>
nnoremap <silent> <Leader>- :exe "resize " . (winheight(0) * 2/3)<CR>
nnoremap <silent> <Leader>. :exe "vertical resize " . (winwidth(0) * 3/2)<CR>
nnoremap <silent> <Leader>, :exe "vertical resize " . (winwidth(0) * 2/3)<CR>
