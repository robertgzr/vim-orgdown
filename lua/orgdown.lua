local todo_values = {'TODO', 'WIP', 'DONE', 'WAITING'}

local function orgdown_todo_insert()
    local current_line = vim.api.nvim_get_current_line()
    local posA, posB = string.find(current_line, "#%s%[%w+%]%s")
    if (posA == nil) then
        local new_line = string.gsub(current_line, "#%s", string.format("# [%s] ", todo_values[1]))
        vim.api.nvim_set_current_line(new_line)
    end
end

local function orgdown_todo_remove()
    local current_line = vim.api.nvim_get_current_line()
    local posA, posB = string.find(current_line, "#%s%[%w+%]%s")
    if not (posA == nil) then
        local new_line = string.gsub(current_line, "#%s%[%w+%]%s", "# ")
        vim.api.nvim_set_current_line(new_line)
    end
end

local function orgdown_todo_cycle()
    local current_line = vim.api.nvim_get_current_line()
    local posA, posB = string.find(current_line, "%[%w+%]")
    if not (posA == nil) then
        local r = string.sub(current_line, posA+1, posB-1)
        local new_r = ''
        for i, v in pairs(todo_values) do
            if v == r then
                local n = i+1
                if n > #todo_values then
                    n = 1
                end
                new_r = todo_values[n]
            end
        end
        local new_line = string.gsub(current_line, r, new_r)
        vim.api.nvim_set_current_line(new_line)
    end
end

return {
    todo_insert = orgdown_todo_insert,
    todo_remove = orgdown_todo_remove,
    todo_cycle = orgdown_todo_cycle,
}
