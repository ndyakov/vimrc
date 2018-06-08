" Author: ndyakov <me@ndyakov.eu>
" Description: revive for Go files
" https://github.com/mgechev/revive

call ale#linter#Define('go', {
\   'name': 'revive',
\   'output_stream': 'both',
\   'executable': 'revive',
\   'command': 'revive %t',
\   'callback': 'ale#handlers#unix#HandleAsWarning',
\})
