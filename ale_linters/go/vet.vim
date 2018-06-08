" Author: ndyakov <me@ndyakov.eu>
" Description: govet with current file

call ale#linter#Define('go', {
\   'name': 'vet',
\   'output_stream': 'stderr',
\   'executable': 'go',
\   'command_callback': 'GoVetCommand',
\   'callback': 'HandleVetError',
\})

function! GoVetCommand(buffer) abort
    return 'go vet '.go#package#ImportPath()
endfunction

function! s:goVetFormatHandler(buffer, lines, type) abort
    let l:pattern = '\v^([^:]+):(\d+):?(\d+)?:? ?(.+)$'
    let l:output = []

    for l:match in ale#util#GetMatches(a:lines, l:pattern)
        let l:file = l:match[1]
        if l:file == matchstr(expand('%:p'), l:file)
            call add(l:output, {
            \   'lnum': l:match[2] + 0,
            \   'col': l:match[3] + 0,
            \   'text': l:match[4],
            \   'type': a:type,
            \})
        endif
    endfor

    return l:output
endfunction

function! HandleVetError(buffer, lines) abort
    return s:goVetFormatHandler(a:buffer, a:lines, 'E')
endfunction
