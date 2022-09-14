" Vundle manage
set nocompatible              " be iMproved, required
filetype off                  " required

" set the runtime path to include Vundle and initialize
set rtp+=~/.vim/bundle/Vundle.vim
" set runtimepath^=~/.vim/bundle/ctrlp.vim
call vundle#begin()

" let Vundle manage Vundle, required
" git clone https://github.com/VundleVim/Vundle.vim.git ~/.vim/bundle/Vundle.vim
Plugin 'VundleVim/Vundle.vim'

Plugin 'itchyny/lightline.vim'
Plugin 'junegunn/fzf', { 'do': { -> fzf#install() } }

" git submodule update --init --recursive
Plugin 'Valloric/YouCompleteMe'

" 代码提纲
Plugin 'majutsushi/tagbar' " Tag bar"
" 树形结构的文件管理器
Plugin 'scrooloose/nerdtree', { 'on':  'NERDTreeToggle' }
" NERD Tree 显示 git
Plugin 'Xuyuanp/nerdtree-git-plugin'
" NERD Tree 文件名称颜色
Plugin 'tiagofumo/vim-nerdtree-syntax-highlight'
Plugin 'jistr/vim-nerdtree-tabs'

" 彩虹括号
Plugin 'frazrepo/vim-rainbow'
" 智能添加/删除括号
Plugin 'jiangmiao/auto-pairs'
" 自动补全单引号，双引号等
Plugin 'Raimondi/delimitMate'
" 可视化显示缩放级别
Plugin 'nathanaelkane/vim-indent-guides'
" 对齐代码的虚线，写Python尤其需要
Plugin 'Yggdroot/indentLine' " Indentation level"
" 用不同颜色高亮单词或选中块
Plugin 'Yggdroot/vim-mark'
" 注释 <leader>ci " toggle comment
Plugin 'preservim/nerdcommenter'
" 快速注释，比 nerdcommenter 简洁 gcc-注释反注释 gcap-注释一段 gc-可视模式注释选中部分
Plugin 'tpope/vim-commentary'

Plugin 'scrooloose/syntastic'
Plugin 'vim-airline/vim-airline' | Plugin 'vim-airline/vim-airline-themes' " Status line"
Plugin 'mbbill/undotree'
Plugin 'gdbmgr'
Plugin 'bling/vim-bufferline' " Buffer line"
" Add maktaba and codefmt to the runtimepath.
" (The latter must be installed before it can be used.)
Plugin 'google/vim-maktaba'
Plugin 'google/vim-codefmt'
" Also add Glaive, which is used to configure codefmt's maktaba flags. See
" `:help :Glaive` for usage.
Plugin 'google/vim-glaive'

"Plugin 'kepbod/quick-scope' " Quick scope"

" All of your Plugins must be added before the following line
call vundle#end()            " required
filetype plugin indent on    " required

let g:ycm_server_python_interpreter='/usr/bin/python3'
let g:ycm_global_ycm_extra_conf='~/.vim/.ycm_extra_conf.py'
set guifont=Monospace\ 14
set nu!             " 显示行号
set encoding=UTF-8
syntax enable
syntax on
colorscheme desert

:set autowrite   " 自动保存

set foldmethod=syntax
set foldlevel=100  " 启动vim时不要自动折叠代码

"<leader>='
let mapleader = ","

"enable it globally
let g:rainbow_active = 1
let g:rainbow_load_separately = [
    \ [ '*' , [['(', ')'], ['\[', '\]'], ['{', '}']] ],
    \ [ '*.tex' , [['(', ')'], ['\[', '\]']] ],
    \ [ '*.cpp' , [['(', ')'], ['\[', '\]'], ['{', '}']] ],
    \ [ '*.{html,htm}' , [['(', ')'], ['\[', '\]'], ['{', '}'], ['<\a[^>]*>', '</[^>]*>']] ],
    \ ]

let g:rainbow_guifgs = ['RoyalBlue3', 'DarkOrange3', 'DarkOrchid3', 'FireBrick']
let g:rainbow_ctermfgs = ['lightblue', 'lightgreen', 'yellow', 'red', 'magenta']


"  折行
autocmd FileType c,cpp,cc  setl fdm=syntax | setl fen

 "--------------------------------------------------------------------------------
 " TagList :Tlist 和 wm
 "--------------------------------------------------------------------------------
"let Tlist_Show_One_File=1
"let Tlist_Exit_OnlyWindow=1
"let Tlist_Use_Right_Window=1
"let Tlist_Show_Menu=1
"let Tlist_Auto_Open=1

" Tagbar
"nmap tag :TagbarToggle<CR>
nnoremap <leader>t :TagbarToggle<CR>
let g:tagbar_width=25
autocmd BufReadPost *.cpp,*.c,*.h,*.cc,*.cxx call tagbar#autoopen()

" NetRedTree
autocmd StdinReadPre * let s:std_in=1
autocmd VimEnter * if argc() == 0 && !exists("s:std_in") | NERDTree | endif
" Exit Vim if NERDTree is the only window remaining in the only tab.
autocmd BufEnter * if tabpagenr('$') == 1 && winnr('$') == 1 && exists('b:NERDTree') && b:NERDTree.isTabTree() | quit | endif
" Close the tab if NERDTree is the only window remaining in it.
autocmd BufEnter * if winnr('$') == 1 && exists('b:NERDTree') && b:NERDTree.isTabTree() | quit | endif
let NERDTreeWinSize=15
let NERDTreeShowLineNumbers=1
"let NERDTreeAutoCenter=1
let NERDTreeShowBookmarks=1
nnoremap <leader>nf :NERDTreeFocus<CR>
nnoremap <leader><C-n> :NERDTree<CR>
nnoremap <leader>n :NERDTreeToggle<CR>
nnoremap <leader><C-f> :NERDTreeFind<CR>

let g:winManagerWindowLayout='TagList'
nmap wm :WMToggle<cr>

" syntastic 
set statusline+=%#warningmsg#
set statusline+=%{SyntasticStatuslineFlag()}
set statusline+=%*

let g:syntastic_always_populate_loc_list = 1
let g:syntastic_auto_loc_list = 1
let g:syntastic_check_on_open = 1
let g:syntastic_check_on_wq = 0

"--------------------------------------------------------------------------------
" cscope:建立数据库：cscope -Rbq；  F5 查找c符号； F6 查找字符串；   F7 查找函数谁调用了，
"--------------------------------------------------------------------------------
if has("cscope")
  set csprg=/usr/bin/cscope
  set csto=1
  set cst
  set nocsverb
  " add any database in current directory
  if filereadable("cscope.out")
      cs add cscope.out
  endif
  set csverb
endif


:set cscopequickfix=s-,c-,d-,i-,t-,e-

nmap <C-_>s :cs find s <C-R>=expand("<cword>")<CR><CR>
nmap <C-_>g :cs find g <C-R>=expand("<cword>")<CR><CR>
nmap <C-_>c :cs find c <C-R>=expand("<cword>")<CR><CR>
nmap <C-_>t :cs find t <C-R>=expand("<cword>")<CR><CR>
nmap <C-_>e :cs find e <C-R>=expand("<cword>")<CR><CR>
nmap <C-_>f :cs find f <C-R>=expand("<cfile>")<CR><CR>
nmap <C-_>i :cs find i ^<C-R>=expand("<cfile>")<CR>$<CR>
nmap <C-_>d :cs find d <C-R>=expand("<cword>")<CR><CR>


"nmap <C-_>s :cs find s <C-R>=expand("<cword>")<CR><CR>
"F5 查找c符号； F6 查找字符串；   F7 查找函数定义； F8 查找函数谁调用了，
nmap <silent> <F5> :cs find s <C-R>=expand("<cword>")<CR><CR> :botright copen<CR><CR> 
nmap <silent> <F6> :cs find t <C-R>=expand("<cword>")<CR><CR> :botright copen<CR><CR>
"nmap <silent> <F7> :cs find g <C-R>=expand("<cword>")<CR><CR> 
nmap <silent> <F7> :cs find c <C-R>=expand("<cword>")<CR><CR> :botright copen<CR><CR>


 "--------------------------------------------------------------------------------
"  自动加载ctags: ctags -R
if filereadable("tags")
      set tags=tags
endif


"  自动保存 kernel 的ctags文件
if isdirectory("kernel/") && isdirectory("mm/")
	au BufWritePost *.c,*.h silent! !ctags -L tags.files&
	au BufWritePost *.c,*.h silent! !cscope -bkq -i tags.files&
endif


"--------------------------------------------------------------------------------
" global:建立数据库
"--------------------------------------------------------------------------------
if filereadable("GTAGS")
	set cscopetag
	set cscopeprg=gtags-cscope
	cs add GTAGS
	au BufWritePost *.c,*.cc,*.cpp,*.h silent! !global -u &
endif


 "--------------------------------------------------------------------------------
 " QuickFix
 "--------------------------------------------------------------------------------
 nmap <F1> :cn<cr>   " 切换到下一个结果
 nmap <F2> :cp<cr>   " 切换到上一个结果

 "--------------------------------------------------------------------------------
" MiniBufExp :  Ctrl + Tab 键可以在minibuf中选择，Ctrl+h,j,k,l或者方向键
" 来选择窗口
 "--------------------------------------------------------------------------------
let g:miniBufExplMapCTabSwitchBufs = 1
let g:miniBufExplMapWindowNavVim = 1
let g:miniBufExplMapWindowNavArrows = 1

 "--------------------------------------------------------------------------------
 " A, c和h文件切换
 "--------------------------------------------------------------------------------
nnoremap <silent> <F12> :A<CR>



" ctrlp.vim
" mkdir -p ~/.vim/pack/plugins/start
" git clone --depth=1 https://github.com/ctrlpvim/ctrlp.vim.git ~/.vim/pack/plugins/start/ctrlp

" let g:ctrlp_map = '<c-p>'
" let g:ctrlp_cmd = 'CtrlP'
" let g:ctrlp_working_path_mode = 'ra'
" let g:ctrlp_switch_buffer = 'et'
" let g:ctrlp_root_markers = ['pom.xml', '.p4ignore']
" set wildignore+=*/tmp/*,*.so,*.swp,*.zip     " MacOSX/Linux

" let g:ctrlp_custom_ignore = '\v[\/]\.(git|hg|svn)$'
" let g:ctrlp_custom_ignore = {
"  \ 'dir':  '\v[\/]\.(git|hg|svn)$',
"  \ 'file': '\v\.(exe|so|dll)$',
"  \ 'link': 'some_bad_symbolic_links',
"  \ }

" let g:ctrlp_user_command = 'find %s -type f'        " MacOSX/Linux
" let g:ctrlp_user_command = ['.git', 'cd %s && git ls-files -co --exclude-standard']
