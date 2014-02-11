" Vim global plugin providing micro tests for VimL
" Maintainer:	Barry Arthur <barry.arthur@gmail.com>
" Version:	0.1
" Description:	Tiny test framework for single-scripts in VimL
" Last Change:	2014-02-11
" License:	Vim License (see :help license)
" Location:	plugin/utest.vim
" Website:	https://github.com/dahu/utest
" Depends:      https://github.com/dahu/VimaholicsAnonymous
"
" See utest.txt for help.  This can be accessed by doing:
"
" :helptags ~/.vim/doc
" :help utest

" Vimscript Setup: {{{1
" Allow use of line continuation.
let s:save_cpo = &cpo
set cpo&vim

" load guard
if exists("g:loaded_utest")
      \ || v:version < 700
      \ || &compatible
  let &cpo = s:save_cpo
  finish
endif
let g:loaded_utest = 1

function! UTest(file, sfile, fn, tests)
  if a:file == a:sfile
    let fail = 0
    for t in a:tests
      let args = string(t[1:-1])
      exe 'let result = Fx(a:fn, ' . strpart(args, 1, len(args)-2) . ')'
      if t[0] != result
        echo 'Fail: ' . t[0]
        let fail = 1
      endif
    endfor
    if ! fail
      echo "Ok"
    endif
  endif
endfunction

" Teardown:{{{1
"reset &cpo back to users setting
let &cpo = s:save_cpo

" Template From: https://github.com/dahu/Area-41/
" vim: set sw=2 sts=2 et fdm=marker:
