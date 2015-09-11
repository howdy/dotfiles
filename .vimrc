scriptencoding utf-8
" 基本設定 {{{1
" Vim内部文字エンコーディングをUTF-8にする
set encoding=utf-8


" ============================
" 表示関連 {{{1
" 行番号の表示
set number
" タブをスペースにする 
set expandtab
set tabstop<
set softtabstop=2
set shiftwidth=2
" 不可視文字の表示
set list
"set listchars=tab:^-,extends:<,eol:↲_gvimrcで設定
" カラースキーム
" _gvimrcに書かないとダメ

" カーソルラインを表示
set cursorline
" 80文字目にライン
set colorcolumn=80


" hi Pmenu ctermbg=4
" hi PmenuSel ctermbg=1
" hi PmenuSbar ctermbg=4
" hi PmenuThumb ctermfg=3

" ===========================
" ステータスライン {{{2
"入力モード時、ステータスラインのカラーを変更
augroup InsertHook
autocmd!
autocmd InsertEnter * highlight StatusLine guifg=#ccdc90 guibg=#2E4340
autocmd InsertLeave * highlight StatusLine guifg=#2E4340 guibg=#ccdc90
augroup END
"ステータスラインにコマンドを表示
set showcmd
"ステータスラインを常に表示
set laststatus=2
"ファイルナンバー表示
"set statusline=[%n]
"ホスト名表示
"set statusline+=%{matchstr(hostname(),'\\w\\+')}@
"ファイル名表示
set statusline+=%<%F
"変更のチェック表示
set statusline+=%m
"読み込み専用かどうか表示
set statusline+=%r
"ファイルフォーマット表示
set statusline+=[%{&fileformat}]
"文字コード表示
set statusline+=[%{has('multi_byte')&&\&fileencoding!=''?&fileencoding:&encoding}]
"ファイルタイプ表示
set statusline+=%y

" ===========================
"
"
"
" 自動で生成されるファイルの生成先 {{{1
" Undoファイルの生成先を変更する
set undodir=$VIM/_undo
" バックアップファイルの生成先
set backupdir=$VIM/_backup
" スワップファイルの生成先
set directory=$VIM/_backup
" =============================
" *.mdのファイル・タイプをMarkdownにする
au BufNewFile,BufRead *.md set filetype=markdown

" 折りたたみ(fold)の設定
set foldmethod=syntax
let perl_fold=1
set foldlevel=100


" ===========================
" プログラム関連 {{{1
" 括弧とクォーテーションの自動補完
" !!! イマイチ使いづらいのでとりあえずコメントアウト
"inoremap { {}<LEFT>
"inoremap [ []<LEFT>
"inoremap ( ()<LEFT>
"inoremap " ""<LEFT>
"inoremap ' ''<LEFT>
" ファイルの種類を自動判別し、種類に応じた設定やインデントを行う
filetype plugin indent on
" ファイルの種類に応じたハイライトを行う
syntax enable

" インデント
set autoindent
set smartindent
" 高度なインデント
set smarttab

" ===========================
" その他{{{1
" クリップボードを使う
set clipboard=unnamed,autoselect
" 対応する括弧を強調
set showmatch

" バッファーを保存してない！と怒られなくなる
set hidden

" C-vの矩形選択で行末より後ろにもカーソルを置ける
" TODO ada
set virtualedit=block

" カーソル位置を記憶
augroup vimrcEx
  autocmd!
  autocmd BufReadPost *
    \ if line("'\"") > 1 && line("'\"") <= line('$') |
    \   exe "normal! g`\"" |
    \ endif
augroup END
" コマンド履歴の保存数
set history=200
cnoremap <C-p> <Up> " 履歴を辿る /<C-p>,  :<C-P> など
cnoremap <C-n> <Down>
" ===========================
" 検索設定
" インクリメンタルサーチ
set incsearch
" 大文字小文字を区別しない
set ignorecase
" 大文字で検索されたら対象を大文字限定にする
set smartcase

" ===========================
" キーマップ変更 {{{1
" * プラグインに依るものはプラグインごとに下の方に記述
" ノーマルモードでもEnterキーで改行を挿入
noremap <CR> o<ESC>
" jj で<ESC>
inoremap <silent> jj <ESC>

" 行末にセミコロン;をつけて改行  
" インサートモードでのみ動作するので注意
function! IsEndSemicolon()
  let c = getline(".")[col("$")-2]
  if c != ';'
    return 1
  else
    return 0
  endif
endfunction
inoremap <expr>;; IsEndSemicolon() ? "<C-O>$;<CR>" : "<C-O>$<CR>"

" バッファ移動
nnoremap <silent> [b :bprevious<CR>
nnoremap <silent> ]b :bnext<CR>
nnoremap <silent> [B :bfirst<CR>
nnoremap <silent> [B :blast<CR>
" ============================
" .vimrcを編集(<Space>.)
nnoremap <Space>. :<C-u>edit $MYVIMRC<Enter>
" .vrmrcを反映(<Space>s.)
nnoremap <Space>s. :<C-u>source $MYVIMRC<Enter>

" ===========================
" PHP
let php_sql_query = 1
let php_baselib = 1
let php_htmlInStrings = 1
let php_noShortTags = 1
let php_parent_error_close = 1
let g:sql_type_default='mysql'

" ===========================
" 文字コード自動判別
" 参考
" http://bi.biopapyrus.net/linux/vim.html
if &encoding !=# 'utf-8'
  set encoding=japan
  set fileencoding=japan
endif
if has('iconv')
  let s:enc_euc = 'euc-jp'
  let s:enc_jis = 'iso-2022-jp'
  if iconv("\x87\x64\x87\x6a", 'cp932', 'eucjp-ms') ==# "\xad\xc5\xad\xcb"
    let s:enc_euc = 'eucjp-ms'
    let s:enc_jis = 'iso-2022-jp-3'
  elseif iconv("\x87\x64\x87\x6a", 'cp932', 'euc-jisx0213') ==# "\xad\xc5\xad\xcb"
    let s:enc_euc = 'euc-jisx0213'
    let s:enc_jis = 'iso-2022-jp-3'
  endif
  if &encoding ==# 'utf-8'
    let s:fileencodings_default = &fileencodings
    let &fileencodings = s:enc_jis .','. s:enc_euc .',cp932'
    let &fileencodings = &fileencodings .','. s:fileencodings_default
    unlet s:fileencodings_default
  else
    let &fileencodings = &fileencodings .','. s:enc_jis
    set fileencodings+=utf-8,ucs-2le,ucs-2
    if &encoding =~# '^\(euc-jp\|euc-jisx0213\|eucjp-ms\)$'
      set fileencodings+=cp932
      set fileencodings-=euc-jp
      set fileencodings-=euc-jisx0213
      set fileencodings-=eucjp-ms
      let &encoding = s:enc_euc
      let &fileencoding = s:enc_euc
    else
      let &fileencodings = &fileencodings .','. s:enc_euc
    endif
  endif
  unlet s:enc_euc
  unlet s:enc_jis
endif
if has('autocmd')
  function! AU_ReCheck_FENC()
    if &fileencoding =~# 'iso-2022-jp' && search("[^\x01-\x7e]", 'n') == 0
      let &fileencoding=&encoding
    endif
  endfunction
  autocmd BufReadPost * call AU_ReCheck_FENC()
endif


" =========================================================================
" 以下プラグイン関連の設定 {{{1
" 会社のWin機ではプラグインのファイルは C:\Users\ap_kawahara_BTO\.vim\bundle\
" にセットされる。
" =================================
" neobundle
" vim起動時のみruntimepathにneobundle.vimを追加
if has('vim_starting')
  set nocompatible
  set runtimepath+=~/.vim/bundle/neobundle.vim
endif

" neobundle.vimの初期化 
call neobundle#rc(expand('~/.vim/bundle'))

" NeoBundleを更新するための設定
NeoBundleFetch 'Shougo/neobundle.vim'

" 読み込むプラグインを記載
NeoBundle 'Shougo/unite.vim'
NeoBundle 'Shougo/neomru.vim'
NeoBundle 'itchyny/lightline.vim'   " ステータスラインのデザインなどの拡張
NeoBundle 'tyru/caw.vim.git'        " 簡単にコメントアウト・解除できる
NeoBundle 'Shougo/vimfiler'
NeoBundle 'scrooloose/nerdtree'
if has('clientserver')
  NeoBundle 'thinca/vim-singleton'    " 1つのVimで複数ファイルを開く
  call singleton#enable()
endif
NeoBundle 'rcmdnk/vim-markdown'     " Markdownファイル用
NeoBundle 'kannokanno/previm'       " Markdownファイルのブラウザプレビュー
NeoBundle 'tyru/open-browser.vim'   " URLやMarkdownをブラウザで見る
NeoBundle 'Shougo/neosnippet'       " スニペット
NeoBundle 'Shougo/neosnippet-snippets'
NeoBundle 'Shougo/neocomplcache'

" 読み込んだプラグインも含め、ファイルタイプの検出、ファイルタイプ別プラグイン/インデントを有効化する
filetype plugin indent on

" インストールのチェック
NeoBundleCheck

" =================================
" caw.vimの設定 {{{2
" \cで行のコメントアウト・戻すができる
nmap <Leader>c <plug>(caw:i:toggle)
vmap <Leader>c <plug>(caw:i:toggle)

" =================================
" lightline.vim {{{2
" 下記以外にも、uniteやvimfiler, vimshellでなんかかっこよくなるよう設定できるらしい(あとでやろう)
" http://itchyny.hatenablog.com/entry/20130828/1377653592
let g:lightline = {
        \ 'colorscheme': 'wombat',
        \ 'mode_map': {'c': 'NORMAL'},
        \ 'active': {
        \   'left': [ [ 'mode', 'paste' ], [ 'fugitive', 'filename' ] ]
        \ },
        \ 'component_function': {
        \   'modified': 'MyModified',
        \   'readonly': 'MyReadonly',
        \   'fugitive': 'MyFugitive',
        \   'filename': 'MyFilename',
        \   'fileformat': 'MyFileformat',
        \   'filetype': 'MyFiletype',
        \   'fileencoding': 'MyFileencoding',
        \   'mode': 'MyMode'
        \ }
        \ }

function! MyModified()
  return &ft =~ 'help\|vimfiler\|gundo' ? '' : &modified ? '+' : &modifiable ? '' : '-'
endfunction

function! MyReadonly()
  return &ft !~? 'help\|vimfiler\|gundo' && &readonly ? 'x' : ''
endfunction

function! MyFilename()
  return ('' != MyReadonly() ? MyReadonly() . ' ' : '') .
        \ (&ft == 'vimfiler' ? vimfiler#get_status_string() :
        \  &ft == 'unite' ? unite#get_status_string() :
        \  &ft == 'vimshell' ? vimshell#get_status_string() :
        \ '' != expand('%:t') ? expand('%:t') : '[No Name]') .
        \ ('' != MyModified() ? ' ' . MyModified() : '')
endfunction

function! MyFugitive()
  try
    if &ft !~? 'vimfiler\|gundo' && exists('*fugitive#head')
      return fugitive#head()
    endif
  catch
  endtry
  return ''
endfunction

function! MyFileformat()
  return winwidth(0) > 70 ? &fileformat : ''
endfunction

function! MyFiletype()
  return winwidth(0) > 70 ? (strlen(&filetype) ? &filetype : 'no ft') : ''
endfunction

function! MyFileencoding()
  return winwidth(0) > 70 ? (strlen(&fenc) ? &fenc : &enc) : ''
endfunction

function! MyMode()
  return winwidth(0) > 60 ? lightline#mode() : ''
endfunction
      
" =================================
" unite.vim {{{2
" 入力モードで開始する
" let g:unite_enable_start_insert=1
" バッファ一覧
nnoremap <silent> ,ub :<C-u>Unite buffer<CR>
" ファイル一覧
nnoremap <silent> ,uf :<C-u>UniteWithBufferDir -buffer-name=files file<CR>
" レジスタ一覧
nnoremap <silent> ,ur :<C-u>Unite -buffer-name=register register<CR>
" 最近使用したファイル一覧
nnoremap <silent> ,um :<C-u>Unite file_mru<CR>
" 常用セット
nnoremap <silent> ,uu :<C-u>Unite buffer file_mru<CR>
" 全部乗せ
nnoremap <silent> ,ua :<C-u>UniteWithBufferDir -buffer-name=files buffer file_mru bookmark file<CR>
" ウィンドウを分割して開く
au FileType unite nnoremap <silent> <buffer> <expr> <C-j> unite#do_action('split')
au FileType unite inoremap <silent> <buffer> <expr> <C-j> unite#do_action('split')
" ウィンドウを縦に分割して開く
au FileType unite nnoremap <silent> <buffer> <expr> <C-l> unite#do_action('vsplit')
au FileType unite inoremap <silent> <buffer> <expr> <C-l> unite#do_action('vsplit')
" ESCキーを2回押すと終了する
au FileType unite nnoremap <silent> <buffer> <ESC><ESC> q
au FileType unite inoremap <silent> <buffer> <ESC><ESC> <ESC>q



" =================================
"
" previm {{{2
let g:previm_open_cmd = ''
" =================================
" open-browser.vim {{{2
" カーソル下のURLをブラウザで開く
nmap <Leader>o <Plug>(openbrowser-open)
vmap <Leader>o <Plug>(openbrowser-open)
" ググる
nnoremap <Leader>g :<C-u>OpenBrowserSearch<Space><C-r><C-w><Enter>
" http://www.google.jp/
" =================================
" VimFiler {{{2
"デフォルトでIDE風のFilerを開く
" autocmd VimEnter * VimFiler -split -simple -winwidth=30 -no-quit
" let g:vimfiler_as_default_explorer = 1
" let g:vimfiler_safe_mode_by_default=0
" let g:netrw_liststyle=3

" =================================
" neosnippet {{{2
 " Plugin key-mappings.
imap <C-k>     <Plug>(neosnippet_expand_or_jump)
smap <C-k>     <Plug>(neosnippet_expand_or_jump)
xmap <C-k>     <Plug>(neosnippet_expand_target)

" SuperTab like snippets behavior.
" imap <expr><TAB> neosnippet#expandable_or_jumpable() ?
" \ "\<Plug>(neosnippet_expand_or_jump)"
" \: pumvisible() ? "\<C-n>" : "\<TAB>"
" smap <expr><TAB> neosnippet#expandable_or_jumpable() ?
" \ "\<Plug>(neosnippet_expand_or_jump)"
" \: "\<TAB>"
" imap <expVr><TAB>
" \ neosnippet#expandable() <Bar><Bar> neosnippet#jumpable() ?
" \ "\<Plug>(neosnippet_expand_or_jump)" : "\<C-n>"

" For snippet_complete marker.
if has('conceal')
  set conceallevel=2 concealcursor=i
endif
" php_functions.snip
augroup filetypedetect
  autocmd!  BufEnter *.php NeoSnippetSource ~/.vim/bundle/neosnippet-snippets/neosnippets/php_functions.snip
augroup END
" =================================

" "========================
" "neocomplecache
" "==========================
"
" let g:acp_enableAtStartup = 0 "AutoComplPopを無効化
" let g:neocomplcache_enable_at_startup = 1 "neocomplcacheを起動時に有効化
" " let g:neocomplcache_enable_smart_case = 1 "大文字小文字を区別しない
" "let g:neocomplcache_enable_camel_case_completion= 1 "camel caseを有効化。大文字を区切りとしたワイルドカードみたいなもの
" let g:neocomplcache_enable_underbar_completion= 1 " _の補完を有効にする
" let g:neocomplcache_min_syntax_length = 3 " シンタックスをキャッシュするときの最小文字長
" let g:neocomplcache_lock_buffer_name_pattern= '\*ku\*' "neocomplcacheを自動的にロックするバッファ名のパターン
"
" "Define keyword.
" if !exists('g:neocomplcache_keyword_patterns')
"     let g:neocomplcache_keyword_patterns = {}
" endif
" let g:neocomplcache_keyword_patterns['default'] = '\h\w*'
"
" " スニペットファイルの配置場所
" " let g:NeoComplCache_SnippetsDir = '~/.vim/snippets'

" ==============
" neocomplcache
" Plugin key-mappings
" ==============
imap <C-k>     <Plug>(neocomplcache_snippets_expand)
smap <C-k>     <Plug>(neocomplcache_snippets_expand)
inoremap <expr><C-g>     neocomplcache#undo_completion()
inoremap <expr><C-l>     neocomplcache#complete_common_string()

" SuperTab like snippets behavior.
imap <expr><TAB> neocomplcache#sources#snippets_complete#expandable() ? "\<Plug>(neocomplcache_snippets_expand)" : pumvisible() ? "\<C-n>" : "\<TAB>"

" <CR>: popupを削除
inoremap <expr><CR>  neocomplcache#smart_close_popup() . "\<CR>"
" <TAB>: completion.
inoremap <expr><TAB>  pumvisible() ? "\<C-n>" : "\<TAB>"
" <C-h>, <BS>: close popup and delete backword char.
inoremap <expr><C-h> neocomplcache#smart_close_popup()."\<C-h>"
inoremap <expr><BS> neocomplcache#smart_close_popup()."\<C-h>"
inoremap <expr><C-y>  neocomplcache#close_popup()
inoremap <expr><C-e>  neocomplcache#cancel_popup()

"ファイル名補完
inoremap <expr><C-x><C-f> neocomplcache#manual_filename_complete()

"オムニ補完
" inoremap <expr><C-x><C-o> &filetype == 'vim' ? "\<C-x><C-v><C-p>" : neocomplcache#manual_filename_complete()

" =============
" neocomplcache
" command
" =============

"evervim
" ソースコードがうまく変換されないので使わないことにした
" set runtimepath+=~/.vim/bundle/evervim-master/
" let g:evervim_devtoken='S=s3:U=23b13:E=15023066865:C=148cb553c90:P=1cd:A=en-devtoken:V=2:H=0d5f00ea4a484b58cb675a703e5c6a65'

