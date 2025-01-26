-- Bootstrap lazy.nvim
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not (vim.uv or vim.loop).fs_stat(lazypath) then
  local lazyrepo = "https://github.com/folke/lazy.nvim.git"
  local out = vim.fn.system({ "git", "clone", "--filter=blob:none", "--branch=stable", lazyrepo, lazypath })
  if vim.v.shell_error ~= 0 then
    vim.api.nvim_echo({
      { "Failed to clone lazy.nvim:\n", "ErrorMsg" },
      { out, "WarningMsg" },
      { "\nPress any key to exit..." },
    }, true, {})
    vim.fn.getchar()
    os.exit(1)
  end
end
vim.opt.rtp:prepend(lazypath)

-- Make sure to setup `mapleader` and `maplocalleader` before
-- loading lazy.nvim so that mappings are correct.
-- This is also a good place to setup other settings (vim.opt)
vim.g.mapleader = " "
vim.g.maplocalleader = "\\"

-- Setup lazy.nvim
require("lazy").setup({
  spec = {
	 { "catppuccin/nvim", name = "catppuccin", priority = 1000 },
	  {
    'nvim-telescope/telescope.nvim', tag = '0.1.8',
      dependencies = { 'nvim-lua/plenary.nvim' }
    },
    -- add your plugins here
  },
  -- Configure any other settings here. See the documentation for more details.
  -- colorscheme that will be used when installing plugins.
  install = { colorscheme = { "habamax" } },
  -- automatically check for plugin updates
  checker = { enabled = true },
})

vim.cmd.colorscheme "catppuccin-mocha"
local builtin = require("telescope.builtin")
vim.api.nvim_set_keymap('n', 'f', "<cmd>Telescope find_files hidden=true<CR>", { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', 'L', "<cmd>Telescope live_grep additional_args={\"--hidden\"}<CR>", { noremap = true, silent = true })

vim.cmd [[
  set number          " Enable absolute line numbers
  set relativenumber  " Enable relative line numbers
]]

-- Use xclip for clipboard operations
if vim.fn.executable('xclip') == 1 then
    vim.opt.clipboard:append('unnamedplus')
    vim.api.nvim_create_autocmd("TextYankPost", {
        callback = function()
            vim.fn.system('xclip -selection clipboard', vim.fn.getreg('"'))
        end
    })
end





