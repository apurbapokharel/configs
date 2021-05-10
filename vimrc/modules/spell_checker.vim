" Spell checker
nnoremap <silent><F1> :setlocal spell! spelllang=en_us<cr>
function! FixLastSpellingError()
  normal! mm[s1z=`m"
endfunction
nnoremap <leader>sp :call FixLastSpellingError()<cr>

function! FixCurrentSpellingError()
  normal! mm1z=`m"
endfunction
nnoremap <leader>ss :call FixCurrentSpellingError()<cr>

function! FixNextSpellingError()
  normal! mm]s1z=`m"
endfunction
nnoremap <leader>sn :call FixNextSpellingError()<cr>
