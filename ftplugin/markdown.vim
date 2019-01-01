if exists('g:orgdown_loaded')
    finish
endif
let g:orgdown_loaded = 1

command OrgdownTodoCycle :call orgdown#todo_cycle()
