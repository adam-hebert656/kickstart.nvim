return {
  "ibhagwan/fzf-lua",
  -- optional for icon support
  dependencies = { "nvim-tree/nvim-web-devicons" },
  config = function()
    -- calling `setup` is optional for customization
    local fzf = require('fzf-lua')
    fzf.setup({
      'telescope',
      winopts = {
        height = 0.90,
        width = 0.90,
        row = 0.60,
        preview = {
          layout = 'vertical',
          vertical = 'up:70%',
        }
      },
      oldfiles = {
        include_current_session = true,
        formatter = 'path.filename_first'
      },
      files = {
        formatter = 'path.filename_first'
      },
      grep = {
        formatter = 'path.filename_first'
      }
    })

    vim.keymap.set('n', '<leader>sh', fzf.helptags, { desc = 'Search Help' })
    vim.keymap.set('n', '<leader>sk', fzf.keymaps, { desc = 'Search Keymaps' })
    vim.keymap.set('n', '<leader>sf', fzf.builtin, { desc = 'Search Builtin Finders' })
    vim.keymap.set('n', '<leader>sd', fzf.diagnostics_document, { desc = 'Search Document Diagnostics' })
    vim.keymap.set('n', '<leader>sm', fzf.marks, { desc = 'Search Marks'})
    vim.keymap.set('n', '<leader>bs', fzf.buffers, { desc = 'Search Buffers'})
    vim.keymap.set('n', '<leader>sr', fzf.resume, { desc = 'Search Resume' })
    vim.keymap.set('n', '<leader>sw', '<cmd>lua require("fzf-lua").grep_cword({cwd = require("util.root").get()})<cr>', { desc = 'Grep Word' })
    vim.keymap.set('n', '<leader>sg', '<cmd>lua require("fzf-lua").live_grep({cwd = require("util.root").get()})<cr>', { desc = 'Live Grep in Project' })
    vim.keymap.set('n', '<leader>ss', fzf.lgrep_curbuf, { desc = 'Live Grep in Current Buffer' })

    vim.keymap.set('n', '<leader>fb', fzf.buffers, { desc = 'Find Existing Buffers' })
    vim.keymap.set('n', '<leader>ff', '<cmd>lua require("fzf-lua").files({cwd = require("util.root").get()})<cr>', { desc = 'Find Files' })
    vim.keymap.set('n', '<leader>fg', fzf.git_files, { desc = 'Find Git Files' })
    vim.keymap.set('n', '<leader>fr', fzf.oldfiles, { desc = 'Find Recent Files' })

    vim.keymap.set('n', '<leader>gh', fzf.git_commits, { desc = 'Git Commit History'})
    vim.keymap.set('n', '<leader>gb', fzf.git_bcommits, { desc = 'Git Buffer Commit History'})

    fzf.register_ui_select()
  end
}
