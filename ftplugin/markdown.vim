if exists('g:orgdown_loaded')
    finish
endif
let g:orgdown_loaded = 1

command OrgdownTest :call orgdown#test()
command OrgdownCycleTodo :call orgdown#cycle_todo()
