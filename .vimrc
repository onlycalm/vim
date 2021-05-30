"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"File: .vimrc                                                                 "
"author: Calm                                                                 "
"Data: 2021-05-22                                                             "
"Description: 正确使用此配置文件请按以下操作:                                 "
"             1、将Github上junegunn/vim-plug插件的plug.vim拷贝到              "
"                ~/.vim/autoload，目录下，没有则新建。                        "
"             2、建议在Windows Terminal终端的Windows PowerShell中运行WSL，    "
"                运行Vim，将终端字体设置为Hack-Regular，否则ailine和NEARDTree "
"                无法正常显示。可在Github上项目powerline/fonts下载安装。      "
"                字体大小建议设置为10号。                                     "
"             3、为了使用Leaderf，需要给Ubuntu安装gcc（sudo apt-get install   "
"                gcc）以及python-dev（根据安装的python版本对应安装，比如
"                python3 v3.8.5，则执行sudo apt-get install python3.8-dev）。
"                执行指令前最好先升级apt-get到新版本（apt-get update），否则
"                可能安装失败。Leaderf rg功能依赖于ripgrep，需要在linux中执行
"                指令安装（sudo apt-get install ripgrep）。Leaderf可以自动
"                管理gtags，可以通过gtags进行快捷搜索，在Ubuntu中安装gtags
"                （sudo apt-get install global）。默认将gtags产物文件保存在
"                ~/.VimCache/.LfCache/gtags/ 目录下，记得定期清除。
"                Leaderf function对函数的搜索依赖Ctags。
"             4、vim-gutentags自动管理Ctags，在Ubuntu上安装Ctags（sudo
"                iapt-get nstall ctags)。
"             5、Coc运行需要安装node，Ubuntu下运行指令（sudo apt-get install
"                clangd）安装。需要安装cmake用于生成compile_commands.json
"                文件，使其找到头文件和源文件。在Ubuntu中安装cmake输入指
"                令（sudo apt-get install cmake）。Coc既补全又检查语法。
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

call plug#begin('~/.vim/plugged')
Plug 'morhetz/gruvbox'                                               "主题。
Plug 'preservim/nerdtree'                                            "文件管理。
Plug 'vim-airline/vim-airline'                                       "状态栏美化。
Plug 'vim-airline/vim-airline-themes'
Plug 'ntpeters/vim-better-whitespace'                                "行末空白高亮及删除。
Plug 'jiangmiao/auto-pairs'                                          "符号配对。
Plug 'luochen1990/rainbow'                                           "括号配对高亮。
Plug 'Yggdroot/LeaderF', {'do' : ':LeaderfInstallCExtension'}        "模糊搜索。
Plug 'preservim/nerdcommenter'                                       "注释。
Plug 'tpope/vim-surround'                                            "操作环绕字符。
Plug 'ludovicchabant/vim-gutentags'                                  "自动管理Ctags。
Plug 'neoclide/coc.nvim', {'branch' : 'release'}                     "代码补全。
Plug 'mhinz/vim-signify'                                             "代码修改行提示。
Plug 'preservim/tagbar'                                              "代码导航。
Plug 'junegunn/vim-easy-align'                                       "代码对齐
call plug#end()

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"按键映射                                                                     "
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"光标
"Insert模式下ctrl k上移光标。
inoremap <c-k> <up>
"Insert模式下ctrl j下移光标。
inoremap <c-j> <down>
"Insert模式下ctrl h左移光标。
inoremap <c-h> <left>
"Insert模式下ctrl l右移光标。
inoremap <c-l> <right>

"NEARDTree
nnoremap <F2> :NERDTreeToggle<CR>

"Yggdroot/LeaderF
"文件搜索。
nnoremap <silent> <Leader>ff :Leaderf file<CR>
"历史打开过的文件。
nnoremap <silent> <Leader>fm :Leaderf mru<CR>
"Buffer。
nnoremap <silent> <Leader>fb :Leaderf buffer<CR>
"函数搜索（仅当前文件里）。
nnoremap <silent> <Leader>fF :Leaderf function<CR>
"grep模糊搜索。
nnoremap <silent> <Leader>frg :Leaderf rg<CR>
"搜索行。
nnoremap <silent> <Leader>fl :Leaderf line<CR>

"通过Leaderf rg搜索光标下的字符串，需按回车确认。
noremap <C-F> :<C-U><C-R>=printf("Leaderf! rg -e %s ", expand("<cword>"))<CR><CR>
"打开最近一次Leaderf rg搜索窗口。
noremap <Leader>fr :<C-U>Leaderf! rg --recall<CR>

"搜索当前光标下函数引用，如果搜索结果只有一个则直接跳转。
noremap <leader>fR :<C-U><C-R>=printf("Leaderf! gtags -r %s --auto-jump", expand("<cword>"))<CR><CR>
"搜索当前光标下函数定义，如果搜索结果只有一个则直接跳转。
noremap <leader>fd :<C-U><C-R>=printf("Leaderf! gtags -d %s --auto-jump", expand("<cword>"))<CR><CR>
"打开上一次gtags搜索窗口。
noremap <leader>fo :<C-U><C-R>=printf("Leaderf! gtags --recall %s", "")<CR><CR>
"跳转到下一个搜索结果。
noremap <leader>fn :<C-U><C-R>=printf("Leaderf gtags --next %s", "")<CR><CR>
"跳转到上一个搜索结果。
noremap <leader>fp :<C-U><C-R>=printf("Leaderf gtags --previous %s", "")<CR><CR>

"preservim/nerdcommenter
"\cc注释当前或选中行。
map <silent> <leader>cc <plug>NERDCommenterComment
"\cu取消当前行或选中行注释。
map <silent> <leader>cu <plug>NERDCommenterUncomment
"\c<space>当前或选中行中含有未注释的行，则都添加注释，都已注释则取消注释。
map <silent> <leader>c<space> <plug>NERDCommenterToggle
"\ci反转当前或选中行注释。
map <silent> <leader>ci <plug>NERDCommenterInvert
"\c$从光标位置（包括光标下的字符）注释到行末。
map <silent> <leader>c$ <plug>NERDCommenterToEOL
"\cA在行末添加注释并进入插入模式。
map <silent> <leader>cA <plug>NERDCommenterAppend
"\ca转换注释格式，比如//和/**/。
map <silent> <leader>ca <plug>NERDCommenterAltDelims

"neoclide/coc.nvim
"跳转到上一个错误或警告信息。
nmap <silent> <c-k> <Plug>(coc-diagnostic-prev)
"跳转到下一个错误或警告信息。
nmap <silent> <c-j> <Plug>(coc-diagnostic-next)

"mhinz/vim-signify
"跳转到上一个修改处。
nmap <c-p> <plug>(signify-prev-hunk)
"跳转到下一个修改处。
nmap <c-n> <plug>(signify-next-hunk)

"preservim/tagbar
"开关显示Tagbar。
nmap <F3> :TagbarToggle<CR>

"junegunn/vim-easy-align
"普通模式下使用对齐规则。
nmap <leader>a <Plug>(EasyAlign)
"可视模式下使用对齐规则。
vmap <leader>a <Plug>(EasyAlign)

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"基础配置                                                                     "
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"显示
syntax on                              "开启语法高亮。
set number                             "显示行号。
set cursorcolumn                       "高亮光标所在列。
set cursorline                         "高亮光标所在行。
set hlsearch                           "高亮搜索。
set incsearch                          "搜索键入时开启高亮。
set laststatus=2                       "底部状态栏始终开启，1: 关闭，2: 开启。

"对齐
set autoindent                         "缩进自动对齐。
set cindent                            "设置c缩进风格。
set smartindent                        "设置智能自动对齐。

"字符
set tabstop=4                          "设置tab为4个space。
set expandtab                          "tab插入时替换为tabstop指定数目的space。
set shiftwidth=4                       "设置<<和>>移动4空格。

"备份文件
set noundofile                         "取消生成undo备份文件。
set nobackup                           "取消生成备份文件。
set noswapfile                         "取消生成交换备份文件。

"控制
set mouse=a                            "使能鼠标控制。
set updatetime=300                     "更新时间300ms。

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"插件配置                                                                     "
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"morhetz/gruvbox
colorscheme gruvbox                    "配置主题。
set background=dark                    "dark或light两种风格。

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"preservim/nerdtree
let g:NEARDTreeShowHidden = 1          "显示隐藏文件。
let g:NEARDTreeWinPos = 'left'         "左侧显示。
let NERDTreeMinimalUI = 1              "不显示帮助信息。

autocmd VimEnter * NERDTree            "启动Vim时启动NEARDTree。

"当启动Vim未指定文件时，启动NEARDTree。
autocmd StdinReadPre * let s:std_in = 1
autocmd VimEnter * if argc() == 0 && !exists('s:std_in') | NERDTree | endif

"Bug: 与ntpeters/vim-better-whitespace冲突。导致其保存删除空格功能失效，
"需要将光标移到其他Window再移回才能生效。
"如果启动时指定了文件，光标跳转到指定文件的Window。
"autocmd StdinReadPre * let s:std_in = 1
"autocmd VimEnter * NERDTree | if argc() > 0 || exists("s:std_in") | wincmd p | endif

"指定目录启动Vim时启动NEARDTree。
autocmd StdinReadPre * let s:std_in = 1
autocmd VimEnter * if argc() == 1 && isdirectory(argv()[0]) && !exists('s:std_in') |
    \ execute 'NERDTree' argv()[0] | wincmd p | enew | execute 'cd '.argv()[0] | endif

"当NEARDTree是最后一个窗口时关闭Vim。
autocmd BufEnter * if tabpagenr('$') == 1 && winnr('$') == 1 && exists('b:NERDTree') && b:NERDTree.isTabTree() |
    \ quit | endif

"防止其他缓存取代NEARDTree窗口。
autocmd BufEnter * if bufname('#') =~ 'NERD_tree_\d\+' && bufname('%') !~ 'NERD_tree_\d\+' && winnr('$') > 1 |
    \ let buf = bufnr() | buffer# | execute "normal! \<C-W>w" | execute 'buffer'.buf | endif

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"vim-airline/vim-airline
let g:airline_theme = "bubblegum"                          "选择配色风格。
let g:airline#extensions#tabline#enabled = 1               "显示窗口的tab和buffer。
let g:airline_powerline_fonts = 1                          "开启支持powerline字体。
"
if !exists('g:airline_symbols')
    let g:airline_symbols = {}
endif
let g:airline_left_sep = ''
let g:airline_left_alt_sep = ''
let g:airline_right_sep = ''
let g:airline_right_alt_sep = ''
let g:airline_symbols.branch = ''
let g:airline_symbols.colnr = '℅'                          "列标志，默认标志乱码。
let g:airline_symbols.readonly = ''
let g:airline_symbols.linenr = '☰'
let g:airline_symbols.maxlinenr = ''
let g:airline_symbols.dirty = '⚡'

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"ntpeters/vim-better-whitespace
let g:better_whitespace_enabled = 1                        "开启行末空格高亮。
let g:better_whitespace_ctermcolor = 'gray'                "行末空格高亮颜色。
let g:strip_whitespace_on_save = 1                         "保存时删除文件内所有行末空格。
let g:strip_whitespace_confirm = 0                         "关闭保存文件时删除行末空格的询问。
let g:better_whitespace_operator = ''                      "取消所有默认快捷键。
let g:better_whitespace_blacklist = []                     "清空黑名单，对所有文件有效。

"Normal模式下高亮当前行空白字符。开启会使响应变慢。
let g:current_line_whitespace_disabled_hard = 0
let g:current_line_whitespace_disabled_soft = 0

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"jiangmiao/auto-pairs
let g:AutoPairsShortcutToggle = ''                         "取消快捷键。

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"luochen1990/rainbow
let g:rainbow_active = 1                                   "开启括号配对高亮。

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"Yggdroot/LeaderF
let g:Lf_WindowPosition = 'popup'                          "使能浮动窗口，需要Vim 8.1.1615以上版本。
let g:Lf_PreviewInPopup = 1                                "使能按ctrl p键在弹出窗口中预览结果。
let g:Lf_HideHelp = 1                                      "隐藏帮助信息。
let g:Lf_UseCache = 0
let g:Lf_CacheDirectory = expand('~/.VimCache/')           "设置缓存根目录。
let g:Lf_StlSeparator = { 'left': '', 'right': '' }      "分隔符号。

"gtags配置。
let g:Lf_GtagsAutoGenerate = 1                             "自动生成gtags数据库。保存在~/.VimCache/.LfCache/gtags/。
let g:Lf_RootMarkers = ['.git', '.svn']                    "工程根目录标识。
let g:Lf_Gtagslabel = 'native-pygments'

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"preservim/nerdcommenter
let g:NERDCreateDefaultMappings = 0                        "不使用默认的按键映射。
let g:NERDSpaceDelims = 0                                  "注释后不添加空格。
let g:NERDCompactSexyComs = 1                              "支持多行注释。
let g:NERDDefaultAlign = 'left'                            "左对齐，而不是跟随代码缩进。
"自定义注释格式。
let g:NERDCustomDelimiters = {'c': {'left':'//', 'right':'', 'leftAlt':'/*', 'rightAlt':'*/'},
                              \'cpp': {'left':'//', 'right':'', 'leftAlt':'/*', 'rightAlt':'*/'},
                              \'python': {'left':'#', 'right':'', 'leftAlt':'"""', 'rightAlt':'"""'},
                              \'vim': {'left':'"', 'right':'', 'leftAlt':'"', 'rightAlt':''}}
let g:NERDCommentEmptyLines = 1                            "允许注释插入空行(在注释区域时很有用)。
let g:NERDTrimTrailingWhitespace = 1                       "在取消注释时启用对尾随空格的修整。
let g:NERDToggleCheckAllLines = 1                          "启用NERDCommenterToggle来检查是否注释了所有选定的行。

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"tpope/vim-surround
let g:surround_no_mappings = 0                             "使用默认的按键映射。

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"ludovicchabant/vim-gutentags
let g:gutentags_project_root = ['.git', '.svn']            "工程根目录标识。
let g:gutentags_ctags_tagfile = '.tags'                    "生成数据文件名称。
let g:gutentags_cache_dir = expand('~/.VimCache/.GtCache') "指定缓存根目录，ctags保存在该目录下。

"Ctags配置参数。
let g:gutentags_ctags_extra_args = ['--fields=+niazS', '--extra=+q']
let g:gutentags_ctags_extra_args += ['--c++-kinds=+pxI']
let g:gutentags_ctags_extra_args += ['--c-kinds=+px']

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"neoclide/coc.nvim
"下划线标识。
hi CocErrorHighlight cterm=underline gui=underline
hi CocWarningHighlight cterm=underline gui=underline

"状态信息加入vim-airline。
let g:airline#extensions#coc#enabled = 1
let airline#extensions#coc#error_symbol = '✘:'
let airline#extensions#coc#warning_symbol = '!:'
let airline#extensions#coc#stl_format_err = '%E{[%e(#%fe)]}'
let airline#extensions#coc#stl_format_warn = '%W{[%w(#%fw)]}'

"使用tab键触发补全。
function! s:check_back_space() abort
  let col = col('.') - 1
  return !col || getline('.')[col - 1]  =~ '\s'
endfunction

inoremap <silent><expr> <Tab>
      \ pumvisible() ? "\<C-n>" :
      \ <SID>check_back_space() ? "\<Tab>" :
      \ coc#refresh()

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"mhinz/vim-signify
let g:signify_disable_bydefault = 0                        "默认开启功能。
"提示符号。
let g:signify_sign_add = '+'
let g:signify_sign_delete = '_'
let g:signify_sign_delete_first_line = '‾'
let g:signify_sign_change = '~'
let g:signify_sign_change_delete = g:signify_sign_change . g:signify_sign_delete_first_line

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"preservim/tagbar
let g:tagbar_show_linenumbers = 0                          "不显示行号。
let g:tagbar_compact = 1                                   "不显示顶部帮助信息。
let g:tagbar_left = 0                                      "显示在Vim右侧。
let g:tagbar_iconchars = ['▶', '▼']                        "设置图标。

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"junegunn/vim-easy-align
"添加自定义对齐符号。
let g:easy_align_delimiters = {
\ '/': {
\     'pattern':         '//\+\|/\*\|\*/',
\     'right_margin':  0,
\     'delimiter_align': 'l',
\     'ignore_groups':   ['!Comment']
\   },
\ ']': {
\     'pattern':       '[[\]]',
\     'left_margin':   0,
\     'right_margin':  0,
\     'stick_to_left': 0
\   },
\ ')': {
\     'pattern':       '[()]',
\     'left_margin':   0,
\     'right_margin':  0,
\     'stick_to_left': 0
\   }
\ }
