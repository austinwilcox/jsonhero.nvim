local b = "ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789+/" -- You will need this for encoding/decoding
-- encoding
function to_base_64(data)
  return (
    (data:gsub(".", function(x)
      local r, b = "", x:byte()
      for i = 8, 1, -1 do
        r = r .. (b % 2 ^ i - b % 2 ^ (i - 1) > 0 and "1" or "0")
      end
      return r
    end) .. "0000"):gsub("%d%d%d?%d?%d?%d?", function(x)
      if #x < 6 then
        return ""
      end
      local c = 0
      for i = 1, 6 do
        c = c + (x:sub(i, i) == "1" and 2 ^ (6 - i) or 0)
      end
      return b:sub(c + 1, c + 1)
    end) .. ({ "", "==", "=" })[#data % 3 + 1]
  )
end

function get_visual_selection()
  local saved_selection = vim.fn.getpos("'<")
  local start_line = saved_selection[2]
  local end_line = vim.fn.getpos("'>")[2]
  local lines = vim.api.nvim_buf_get_lines(0, start_line - 1, end_line, false)
  local lines_str = table.concat(lines, "\n")
  return lines_str
end

function open_browser(url)
  -- Command to open URL based on OS
  local command = ""
  if vim.fn.has("win32") == 1 then
    command = "start " .. url
  elseif vim.fn.has("mac") == 1 then
    command = "open " .. url
  elseif vim.fn.has("unix") == 1 then
    command = "xdg-open " .. url
  else
    print("Unsupported operating system")
    return
  end

  -- Execute the command
  os.execute(command)
end

get_visual_selection()

-- open_browser("https://jsonhero.io/new?j=" .. to_base_64(get_visual_selection()))
