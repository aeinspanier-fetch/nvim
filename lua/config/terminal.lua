-- Terminal configuration for better shell integration
local M = {}

-- Function to send commands to terminal
function M.send_to_terminal(cmd)
  local Terminal = require("toggleterm.terminal").Terminal
  local term = Terminal:new({
    cmd = cmd,
    direction = "float",
    close_on_exit = false,
  })
  term:toggle()
end

-- Quick cd function
function M.quick_cd()
  vim.ui.input({ prompt = "Change directory to: " }, function(input)
    if input then
      vim.cmd("cd " .. input)
      vim.notify("Changed directory to " .. vim.fn.getcwd())
    end
  end)
end

-- Run Claude Code in terminal
function M.claude_code_terminal()
  M.send_to_terminal("claude-code")
end

-- Setup keymaps
function M.setup()
  vim.keymap.set("n", "<leader>cd", M.quick_cd, { desc = "Quick change directory" })
  vim.keymap.set("n", "<leader>tc", M.claude_code_terminal, { desc = "Open Claude Code in terminal" })
  
  -- Shell command shortcuts
  vim.keymap.set("n", "<leader>tl", function() M.send_to_terminal("ls -la") end, { desc = "List files" })
  vim.keymap.set("n", "<leader>tg", function() M.send_to_terminal("lazygit") end, { desc = "Open lazygit" })
  
  -- Terminal navigation in normal mode
  vim.keymap.set("t", "<C-h>", [[<Cmd>wincmd h<CR>]], { desc = "Go to left window" })
  vim.keymap.set("t", "<C-j>", [[<Cmd>wincmd j<CR>]], { desc = "Go to lower window" })
  vim.keymap.set("t", "<C-k>", [[<Cmd>wincmd k<CR>]], { desc = "Go to upper window" })
  vim.keymap.set("t", "<C-l>", [[<Cmd>wincmd l<CR>]], { desc = "Go to right window" })
  vim.keymap.set("t", "<esc><esc>", [[<C-\><C-n>]], { desc = "Exit terminal mode" })
end

return M