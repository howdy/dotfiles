scriptencoding utf-8

" ウィンドウサイズ
set lines=60
set columns=120

" カラースキーム
colorscheme desert
"colorscheme hybrid
"colorscheme jellybeans
"set background=dark
" 透明度の設定
set transparency=10
" ============================
" 文字関連
if has('gui_macvim')
else
  " 半角文字の設定
  set guifont=MS_Gothic:h10
  " 全角文字の設定
  set guifontwide=MS_Gothic:h10
endif
" 不可視文字の表示
exe "set list listchars=tab:\<Char-0xBB>\<Char-0xA0>,eol:\<Char-0x21b2>"

" ============================
" その他
" ノーマルモードはIMEをOFFにする
if has('multi_byte_ime') || has('xim') || has('gui_macvim')
  " Insert mode: lmap off, IME ON
 " set iminsert=2
  " Serch mode: lmap off, IME ON
  "set imsearch=2
  " Normal mode: IME off
  inoremap <silent> <ESC> <ESC>:set iminsert=0<CR>
endif
