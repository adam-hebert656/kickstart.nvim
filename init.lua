-- [[ Options ]]
require 'options'

-- [[ Basic Keymaps ]]
require 'keymaps'

-- [[ Basic Autocommands ]]
require 'autocmds'

-- [[ Install `lazy.nvim` plugin manager ]]
local lazypath = vim.fn.stdpath 'data' .. '/lazy/lazy.nvim'
if not vim.uv.fs_stat(lazypath) then
  local lazyrepo = 'https://github.com/folke/lazy.nvim.git'
  local out = vim.fn.system { 'git', 'clone', '--filter=blob:none', '--branch=stable', lazyrepo, lazypath }
  if vim.v.shell_error ~= 0 then
    error('Error cloning lazy.nvim:\n' .. out)
  end
end ---@diagnostic disable-next-line: undefined-field
vim.opt.rtp:prepend(lazypath)

-- [[ Configure and install plugins ]]
if not vim.g.vscode then
  require 'lazy-plugins'
else
  require 'plugins.mini-nvim'
  require 'plugins.flash'
  require 'plugins.nvim-treesitter'
  require 'plugins.yanky'

  vim.api.nvim_create_autocmd("User", {
    pattern = "LazyVimKeymapsDefaults",
    callback = function()
      -- VSCode-specific keymaps for search and navigation
      vim.keymap.set("n", "<leader>ff", "<cmd>Find<cr>")
      vim.keymap.set("n", "<leader>w-", "<cmd>Split<cr>")
      vim.keymap.set("n", "<leader>w|", "<cmd>Split<cr>")
      vim.keymap.set("n", "<leader>/", [[<cmd>lua require('vscode').action('workbench.action.findInFiles')<cr>]])
      vim.keymap.set("n", "<leader>ss", [[<cmd>lua require('vscode').action('workbench.action.gotoSymbol')<cr>]])

      -- Keep undo/redo lists in sync with VsCode
      vim.keymap.set("n", "u", "<Cmd>call VSCodeNotify('undo')<CR>")
      vim.keymap.set("n", "<C-r>", "<Cmd>call VSCodeNotify('redo')<CR>")

      -- Navigate VSCode tabs like lazyvim buffers
      vim.keymap.set("n", "<S-h>", "<Cmd>call VSCodeNotify('workbench.action.previousEditor')<CR>")
      vim.keymap.set("n", "<S-l>", "<Cmd>call VSCodeNotify('workbench.action.nextEditor')<CR>")
    end,
  })
end

-- The line beneath this is called `modeline`. See `:help modeline`
-- vim: ts=2 sts=2 sw=2 et
