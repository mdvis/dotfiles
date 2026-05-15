" ------
" name: conf.vim
" author: Deve
" date: 2021-05-11
" ------

silent function! conf#EditConf()
  :e $MYVIMRC
endfunction

silent function! conf#SourceConf()
  :source $MYVIMRC
endfunction
