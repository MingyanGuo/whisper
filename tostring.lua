local function conv(value)
        local function do_conv(val, level)
                local function key2str(key)
                        if type(key) == 'string' then
                                return "'" .. key .. "'"
                        else
                                return tostring(key)
                        end
                end
                if type(val) == 'table' then
                        local keys = {}
                        for k, _ in pairs(val) do
                                table.insert(keys, k)
                        end
                        table.sort(keys)
                        local res = '{\n'
                        for _, k in ipairs(keys) do
                                local v = val[k]
                                res = res .. string.rep(' ', level * 2) ..
                                        '[' .. key2str(k) .. '] = ' ..
                                                do_conv(v, level + 1) .. ',\n'
                        end
                        return res .. string.rep(' ', (level - 1) * 2) .. '}'
                elseif type(val) == 'string' then
                        return '\'' .. val .. '\''
                end
                return tostring(val)
        end
        return do_conv(value, 1)
end
