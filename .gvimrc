scriptencoding utf-8

" ウィンドウサイズ
set lines=60
set columns=150

" colorschemeを上書きする設定(colorschemeの読み込み前に記述)
" 全体の色
autocmd ColorScheme * highlight Normal guifg=#DDDDDD guibg=#111111
" コメント色
autocmd ColorScheme * highlight Comment ctermfg=22 guifg=#E2A412
" TODO
"autocmd ColorScheme * highlight Todo guifg=#000000 guibg=#CCFF00

" カラースキーム
" 置き場所:C:\Vim\vim74\colors\
"colorscheme Tomorrow-Night-Bright
" colorscheme desert
colorscheme hybrid
"colorscheme jellybeans
"set background=dark
" 透明度の設定
if has('gui_macvim')
  set transparency=10
else
"  autocmd FocusGained * set transparency=255
"  autocmd FocusLost * set transparency=250  " フォーカスされてない時は不透明を強くする
endif


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

"全角スペースを表示
" TODO ネットで検索すると、もっと短くて大丈夫なのかも？
"コメント以外で全角スペースを指定しているので scriptencodingと、
"このファイルのエンコードが一致するよう注意！
"全角スペースが強調表示されない場合、ここでscriptencodingを指定すると良い。
"scriptencoding cp932
"デフォルトのZenkakuSpaceを定義
function! ZenkakuSpace()
  highlight ZenkakuSpace cterm=underline ctermfg=red gui=underline guifg=red
endfunction

if has('syntax')
  augroup ZenkakuSpace
    autocmd!
    " ZenkakuSpaceをカラーファイルで設定するなら次の行は削除
    autocmd ColorScheme       * call ZenkakuSpace()
    " 全角スペースのハイライト指定
    autocmd VimEnter,WinEnter * match ZenkakuSpace /　/
    autocmd VimEnter,WinEnter * match ZenkakuSpace '\%u3000'
  augroup END
  call ZenkakuSpace()
endif


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
