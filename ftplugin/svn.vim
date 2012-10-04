" modified as http://d.hatena.ne.jp/tekiomo/20110123/1294746063
" made by Michael Scherer ( misc@mandrake.org )
" $Id: svn.vim 282 2005-01-31 21:24:55Z misc $
"
" 2004-09-13 : Lukas Ruf ( lukas.ruf@lpr.ch )
"   - re-ordered windows
"   - set focus on svn-commit.tmp (that's where one has to write)
"   - set buffer type of new window to 'nofile' to fix 'TODO'
"
" 2005-01-31 :
"   - autoclose on exit, thanks to Gintautas Miliauskas ( gintas@akl.lt )
"     and tips from Marius Gedminas ( mgedmin@b4net.lt )
"
" 2005-02-08 :
"   - rewrite in pure vim function, from Kyosuke Takayama ( support@mc.neweb.ne.jp )
"   - simplified installation instruction, from Marius Gedminas ( mgedmin@b4net.lt )
"
" 2005-02-11 :
"   - reindent with space, asked by Marius Gedminas ( mgedmin@b4net.lt )
"   - do not preview if no file are diffed, patch from Marius Gedminas.
"
" to use it, place it in ~/.vim/ftplugins ( create the directory if it doesn't exist )

function! Svn_diff_windows()
    let i = 0
    let files = []

    while i <= line('$')
        let line = getline(i)
        if line =~ '^M'

            let file = substitute(line, '\v^MM?\s*(.*)\s*$', '\1', '')
            call add(files, file)
        endif

        let i = i + 1
    endwhile

    if len(files) == 0
        return
    endif

    let list_of_files = join(files, ' ')

    set nosplitright

    vnew
    silent! setlocal ft=diff bufhidden=delete nobackup noswf nobuflisted nowrap buftype=nofile
    execute 'normal :r!LANG=ja_JP.UTF8 svn diff ' . list_of_files . "\n"
    setlocal nomodifiable
    goto 1
    redraw!
    wincmd R
    wincmd p
    goto 1
    redraw!

    " new
    " silent! setlocal ft=diff bufhidden=delete nobackup noswf nobuflisted nowrap buftype=nofile

    " for file in files
    "   execute 'normal :r!LANG=ja_JP.UTF8 svn info ' . file . " | grep 'URL:'\n"
    "   execute 'normal :r!LANG=ja_JP.UTF8 svn log -r PREV:HEAD --limit=1 ' . file . "\n"
    " endfor

    " setlocal nomodifiable
    " goto 1
    " redraw!
    " wincmd R
    " wincmd p
    " goto 1
    " redraw!
endfunction

set nowarn

call Svn_diff_windows()
set nowb
