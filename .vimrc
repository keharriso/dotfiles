" Use Vim settings, rather than Vi settings (much better!).
" This must be first, because it changes other options as a side effect.
set nocompatible

" allow backspacing over everything in insert mode
set backspace=indent,eol,start

set history=50  " keep 50 lines of command line history
set ruler       " show the cursor position all the time
set showcmd     " display incomplete commands
set incsearch   " do incremental searching

" For Win32 GUI: remove 't' flag from 'guioptions': no tearoff menu entries
" let &guioptions = substitute(&guioptions, "t", "", "g")

" Don't use Ex mode, use Q for formatting
map Q gq

" CTRL-U in insert mode deletes a lot.  Use CTRL-G u to first break undo,
" so that you can undo CTRL-U after inserting a line break.
inoremap <C-U> <C-G>u<C-U>

" In many terminal emulators the mouse works just fine, thus enable it.
if has('mouse')
  set mouse=a
endif

" Switch syntax highlighting on, when the terminal has colors
" Also switch on highlighting the last used search pattern.
if &t_Co > 2 || has("gui_running")
  syntax on
  set hlsearch
endif

set tw=999

" Only do this part when compiled with support for autocommands.
if has("autocmd")

  " Enable file type detection.
  " Use the default filetype settings, so that mail gets 'tw' set to 72,
  " 'cindent' is on in C files, etc.
  " Also load indent files, to automatically do language-dependent indenting.
  filetype plugin indent on
	autocmd FileType asm setlocal sw=2 ts=2 et
  autocmd FileType lua setlocal sw=2 ts=2 noet
  autocmd FileType vim setlocal sw=2 ts=2 noet
	autocmd FileType sh setlocal sw=4 ts=4 noet
	autocmd FileType zsh setlocal sw=4 ts=4 noet
	autocmd FileType c setlocal sw=4 ts=4 noet tw=78
	autocmd FileType cpp setlocal sw=4 ts=4 noet tw=78
	autocmd FileType conf setlocal sw=4 ts=4 noet
	autocmd FileType xml setlocal sw=4 ts=4 noet
	autocmd FileType ruby setlocal sw=4 ts=4 noet
	autocmd FileType python setlocal sw=4 sts=4 et
	autocmd FileType haskell setlocal sw=4 sts=4 et
	let hs_highlight_boolean="yes"
	let hs_highlight_delimiter="yes"
	let hs_highlight_types="yes"
	let hs_highlight_more_types="yes"
	let hs_allow_hash_operator="yes"
	autocmd FileType yaml setlocal sw=2 sts=2 et
	autocmd FileType spate setlocal sw=4 sts=4 et
	autocmd FileType actionscript setlocal sw=4 ts=4 noet smartindent
	autocmd FileType html setlocal sw=2 ts=2 noet
	autocmd FileType llvm setlocal sw=4 ts=4 noet smartindent
	autocmd FileType bnfc setlocal sw=4 ts=4 noet smartindent
	autocmd FileType cmake setlocal sw=4 ts=4 noet tw=78

	au BufRead,BufNewFile *.as set filetype=actionscript
	au! Syntax actionscript source $HOME/.vim/actionscript.vim
	au BufRead,BufNewFile *.llvm set filetype=llvm
	au BufRead,BufNewFile *.ll set filetype=llvm
	au BufRead,BufNewFile *.bnfc set filetype=bnfc
	au BufRead,BufNewFile *.cf set filetype=bnfc

  " Put these in an autocmd group, so that we can delete them easily.
  augroup vimrcEx
  au!

  " For all text files set 'textwidth' to 78 characters.
  autocmd FileType text setlocal tw=78

  " When editing a file, always jump to the last known cursor position.
  " Don't do it when the position is invalid or when inside an event handler
  " (happens when dropping a file on gvim).
  " Also don't do it when the mark is in the first line, that is the default
  " position when opening a file.
  autocmd BufReadPost *
    \ if line("'\"") > 1 && line("'\"") <= line("$") |
    \   exe "normal! g`\"" |
    \ endif

  augroup END

	augroup netrw_bindings
		autocmd!
		autocmd filetype netrw call Add_netrw_bindings()
	augroup END

	function! Add_netrw_bindings()
		nmap <buffer> l <CR>
		nmap <buffer> h -
		nmap <buffer> <ESC><ESC> :q<CR>
	endfunction

else

  set autoindent		" always set autoindenting on

endif " has("autocmd")

" Convenient command to see the difference between the current buffer and the
" file it was loaded from, thus the changes you made.
" Only define it when not defined already.
if !exists(":DiffOrig")
  command DiffOrig vert new | set bt=nofile | r ++edit # | 0d_ | diffthis
		  \ | wincmd p | diffthis
endif

" C-N to unhighlight search results
nmap <silent> <C-N> :silent noh<LF>

"highlight Normal ctermbg=0
set encoding=utf-8

" Show line numbers
set number

" Highlight trailing whitespace and long lines
function LongLines()
	" Treat tabs as 8 characters long for long-line purposes
	call matchadd('ColorColumn', '\%'.max([0, &tw+1]).'v\(.\+\)')
	" Works for up to 8 tabs!
	call matchadd('ColorColumn',
				\ '\(^\t\([^\t]\+\%'.max([0, &tw -  6]).'c\|'.
				\    '\t\([^\t]\+\%'.max([0, &tw - 13]).'c\|'.
				\    '\t\([^\t]\+\%'.max([0, &tw - 20]).'c\|'.
				\    '\t\([^\t]\+\%'.max([0, &tw - 27]).'c\|'.
				\    '\t\([^\t]\+\%'.max([0, &tw - 34]).'c\|'.
				\    '\t\([^\t]\+\%'.max([0, &tw - 41]).'c\|'.
				\    '\t\([^\t]\+\%'.max([0, &tw - 48]).'c\|'.
				\    '\t\([^\t]\+\%'.max([0, &tw - 55]).'c'  .
				\  '\)\)\)\)\)\)\)\)\)\@<=.\+')
endfunction

highlight ExtraWhitespace ctermbg=red guibg=red
highlight ColorColumn ctermbg=9
call matchadd('ExtraWhitespace', '\s\+$')
call LongLines()
autocmd BufWinEnter * call WinEnter()
autocmd InsertEnter * call InsEnter()
autocmd InsertLeave * call InsLeave()
autocmd BufWinLeave * call clearmatches()

function WinEnter()
	call clearmatches()
	call matchadd('ExtraWhitespace', '\s\+$')
	call LongLines()
endfunction

function InsEnter()
	call clearmatches()
	call matchadd('ExtraWhitespace', '\s\+\%#\@<!$')
	call LongLines()
endfunction

function InsLeave()
	call clearmatches()
	call matchadd('ExtraWhitespace', '\s\+$')
	call LongLines()
endfunction

" Supplement delimitMate
inoremap {<CR> {<CR>}<ESC>==O
"inoremap {<ESC> {<ESC>
"inoremap (<ESC> (<ESC>
"inoremap '<ESC> '<ESC>
"inoremap "<ESC> "<ESC>
"inoremap <silent> <CR> <CR><ESC>kg_aa<ESC>Do<SPACE><BS><ESC>JI

" Only match up to shared path
set wildmode=longest,list,full

" Hex mode
nnoremap <C-H> :Hexmode<CR>
inoremap <C-H> <ESC>:Hexmode<CR>
command -bar Hexmode call ToggleHex()

" Directory view
nmap <ESC><ESC> :e %:p:h<CR>:8<CR>

" Viewport switching
nnoremap <SPACE> <C-W><C-W>

function ToggleHex()
	let l:modified=&mod
	let l:oldreadonly=&readonly
	let &readonly=0
	let l:oldmodifiable=&modifiable
	let &modifiable=1
	if !exists("b:editHex") || !b:editHex
		let b:oldft=&ft
		let b:oldbin=&bin
		setlocal binary
		let &ft="xxd"
		let b:editHex=1
		%!xxd
	else
		let &ft=b:oldft
		if !b:oldbin
			setlocal nobinary
		endif
		let b:editHex=0
		%!xxd -r
	endif
	let &mod=l:modified
	let &readonly=l:oldreadonly
	let &modifiable=l:oldmodifiable
endfunction
