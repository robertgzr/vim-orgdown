function! orgdown#todo_insert()
    lua require("orgdown").todo_insert()
endfunction

function! orgdown#todo_remove()
    lua require("orgdown").todo_remove()
endfunction

function! orgdown#todo_cycle()
    lua require("orgdown").todo_cycle()
endfunction

function! orgdown#timestamp_insert()
    lua require("orgdown").timestamp_insert()
endfunction

function! orgdown#timestamp_update()
    lua require("orgdown").timestamp_update()
endfunction

function! orgdown#timestamp_since()
    return luaeval('require("orgdown").timestamp_since()')
endfunction

function! orgdown#checklst_insert_item()
    lua require("orgdown").checklst_insert_item()
endfunction

function! orgdown#checklst_cycle_item()
    lua require("orgdown").checklst_cycle_item()
endfunction
