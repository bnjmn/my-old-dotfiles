" lcdedit.vim - Make lcda/js editing easier
" Maintainer:   Benjamin Petersen 
" Version:      0.1


function! SplitParams()
    " hack to prevent having to press enter after cmd
    let current_cmdheight = &cmdheight
    let &cmdheight = 2

    " get current indent amount and add one more to it
    let indent_num=indent(line('.')) + &softtabstop

    " find the first paren and add a newline after
    execute 's/(/&\r/'
    " mark first line for indent later
    execute 'normal! mq'

    "execute 'normal! >>'
    " find the last paren and add a newline before
    execute 's/.*\zs)/\r&/'
    " mark last line for indent later
    execute 'normal! mw'
    " move up to the params
    execute 'normal! k'

    " add a newline after each comma
    " TODO: only find commas outside of parens so a line like
    " blah, foo, bar, dt.date(2014, 1, 1), baz
    " doesn't split the date
    let find = '\%([,]\)\ze.'
    execute 's/' . find . '/&\r/ge'
    
    execute 'normal! `q'
    let first = line('.')

    execute 'normal! `w'
    let last = line('.')

    execute first . ',' . last . 's/^\s\+'

    " insert the indent spaces at the beginning of each line
    let spaces = repeat(' ', indent_num)
    execute first . ',' . last . 's/^/' . spaces . '/'

    let &cmdheight = current_cmdheight

    " had a real hard time figuring out how to insert a newline w/o search/repl
    "put =nr2char(10) " insert a newline char

endfunction

function! OpenTestFile()
    let filename=expand('%:t')
    let dirname=expand('%:h')

    execute 'rightbelow vsplit ' . "tests/" . dirname . "/test_" . filename
endfunction

nnoremap <leader>r :call SplitParams()<CR>
nnoremap <leader>o :call OpenTestFile()<CR>
