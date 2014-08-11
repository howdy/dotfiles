scriptencoding utf-8

" Vim内部文字エンコーディングをUTF-8にする
set encoding=utf-8
" 文字コード自動判定
"set fileencodings=iso-2022-jp,cp932,sjis,utf-8,euc-jp  (動かない)



" ============================
" 表示関連
" 行番号の表示
set number
" タブをスペースにする 
set expandtab
set tabstop=2
set softtabstop=2
set shiftwidth=2
" 不可視文字の表示
set list
"set listchars=tab:^-,extends:<,eol:↲_gvimrcで設定
" カラースキーム
" _gvimrcに書かないとダメ

" カーソルラインを表示
set cursorline
" ===========================
" 自動で生成されるファイルの生成先
" Undoファイルの生成先を変更する
set undodir=$VIM/_undo
" バックアップファイルの生成先
set backupdir=$VIM/_backup
" スワップファイルの生成先
set directory=$VIM/_backup

" ===========================
" ステータスライン
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

" =============================
" *.mdのファイル・タイプをMarkdownにする
au BufNewFile,BufRead *.md set filetype=markdown

" ===========================
" プログラム関連
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
" その他
" クリップボードを使う
set clipboard=unnamed,autoselect
" 対応する括弧を強調
set showmatch


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

" ===========================
" 検索設定
" インクリメンタルサーチ
set incsearch
" 大文字小文字を区別しない
set ignorecase
" 大文字で検索されたら対象を大文字限定にする
set smartcase

" ===========================
" キーマップ変更
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
" ============================
" .vimrcを編集(<Space>.)
nnoremap <Space>. :<C-u>edit $MYVIMRC<Enter>
" .vrmrcを反映(<Space>s.)
nnoremap <Space>s. :<C-u>source $MYVIMRC<Enter>

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
" neobundle
" 以下プラグイン関連の設定
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
NeoBundle 'itchyny/lightline.vim' " ステータスラインのデザインなどの拡張
NeoBundle 'tyru/caw.vim.git'  " 簡単にコメントアウト・解除できる
NeoBundle 'Shougo/vimfiler'
NeoBundle 'scrooloose/nerdtree'
NeoBundle 'thinca/vim-singleton'  " 1つのVimで複数ファイルを開く
NeoBundle 'rcmdnk/vim-markdown'
NeoBundle 'kannokanno/previm'
NeoBundle 'tyru/open-browser.vim'

" 読み込んだプラグインも含め、ファイルタイプの検出、ファイルタイプ別プラグイン/インデントを有効化する
filetype plugin indent on

" インストールのチェック
NeoBundleCheck

" =================================
" caw.vimの設定
" \cで行のコメントアウト・戻すができる
nmap <Leader>c <plug>(caw:i:toggle)
vmap <Leader>c <plug>(caw:i:toggle)

" =================================
" lightline.vimの設定
" 下記以外にも、uniteやvimfiler, vimshellでなんかかっこよくなるよう設定できるらしい(あとでやろう)
" http://itchyny.hatenablog.com/entry/20130828/1377653592
let g:lightline = {
      \ 'colorscheme': 'wombat'
      \ }
      
" =================================
""" unite.vim
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
" singleton.vimの設定
call singleton#enable()


" =================================
" previm
let g:previm_open_cmd = ''
" =================================
" open-browser.vim
" カーソル下のURLをブラウザで開く
nmap <Leader>o <Plug>(openbrowser-open)
vmap <Leader>o <Plug>(openbrowser-open)
" ググる
nnoremap <Leader>g :<C-u>OpenBrowserSearch<Space><C-r><C-w><Enter>
" http://www.google.jp/
"
