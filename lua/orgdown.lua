local p = {}

local todo_values = {'TODO', 'WIP', 'DONE', 'WAITING'}

function p.todo_insert()
    local current_line = vim.api.nvim_get_current_line()
    local posA, posB = string.find(current_line, "#%s%[%w+%]%s")
    if (posA == nil) then
        local new_line = string.gsub(current_line, "#%s", string.format("# [%s] ", todo_values[1]))
        vim.api.nvim_set_current_line(new_line)
    end
end

function p.todo_remove()
    local current_line = vim.api.nvim_get_current_line()
    local posA, posB = string.find(current_line, "#%s%[%w+%]%s")
    if not (posA == nil) then
        local new_line = string.gsub(current_line, "#%s%[%w+%]%s", "# ")
        vim.api.nvim_set_current_line(new_line)
    end
end

function p.todo_cycle()
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

function p.timestamp_insert()
    local now = os.date("%F %T")

    local current_win = vim.api.nvim_get_current_win()
    local pos = vim.api.nvim_win_get_cursor(current_win)[2]
    local current_line = vim.api.nvim_get_current_line()

    local new_line = string.sub(current_line, 0, pos) .. '[' .. now .. ']' .. string.sub(current_line, pos+1)
    vim.api.nvim_set_current_line(new_line)
end

function p.timestamp_update()
    local now = os.date("%F %T")
    local current_line = vim.api.nvim_get_current_line()
    local new_line = string.gsub(current_line, "%[%d%d%d%d%-%d%d%-%d%d%s%d%d:%d%d:%d%d%]", '[' .. now .. ']')
    vim.api.nvim_set_current_line(new_line)
end

function p.timestamp_since()
    local current_line = vim.api.nvim_get_current_line()
    local now = os.time()
    local y, m, d, H, M, S = string.match(current_line, "%[(%d%d%d%d)%-(%d%d)%-(%d%d)%s(%d%d):(%d%d):(%d%d)%]")
    local was = os.time({
        year = tonumber(y),
        month = tonumber(m),
        day = tonumber(d),
        hour = tonumber(H),
        min = tonumber(M),
        sec = tonumber(S),
    })

    local dur_s = os.difftime(now, was)
    local dur_m = math.floor(dur_s / 60)
    dur_s = dur_s - (60 * dur_m)
    local dur_h = math.floor(dur_s / 3600)
    dur_s = dur_s - (3600 * dur_h)

    return string.format("%dh%02dm%02ds", dur_h, dur_m, dur_s)
end

return p
