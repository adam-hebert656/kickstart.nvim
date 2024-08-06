return {
  "ibhagwan/fzf-lua",
  -- optional for icon support
  dependencies = { "nvim-tree/nvim-web-devicons" },
  config = function()
    -- calling `setup` is optional for customization
    local fzf = require('fzf-lua')
    fzf.setup({'telescope'})

    vim.keymap.set('n', '<leader>sh', fzf.helptags, { desc = 'Search Help' })
    vim.keymap.set('n', '<leader>sk', fzf.keymaps, { desc = 'Search Keymaps' })
    vim.keymap.set('n', '<leader>ss', fzf.builtin, { desc = 'Search Builtin Finders' })
    vim.keymap.set('n', '<leader>sd', fzf.diagnostics_document, { desc = 'Search Document Diagnostics' })
    vim.keymap.set('n', '<leader>sm', fzf.marks, { desc = 'Search Marks'})
    vim.keymap.set('n', '<leader>sb', fzf.marks, { desc = 'Search Buffers'})
    vim.keymap.set('n', '<leader>sr', fzf.resume, { desc = 'Search Resume' })
    vim.keymap.set('n', '<leader>sw', fzf.grep_cword, { desc = 'Grep Word' })
    vim.keymap.set('n', '<leader>sw', fzf.live_grep, { desc = 'Live Grep in Project' })

    vim.keymap.set('n', '<leader>fb', fzf.buffers, { desc = 'Find Existing Buffers' })
    vim.keymap.set('n', '<leader>ff', '<cmd>lua require("fzf-lua").files({cwd = require("util.root").get()})<cr>', { desc = 'Find Files' })
    vim.keymap.set('n', '<leader>fg', fzf.git_files, { desc = 'Find Git Files' })
    vim.keymap.set('n', '<leader>fr', fzf.oldfiles, { desc = 'Find Recent Files' })

    vim.keymap.set('n', '<leader>gh', fzf.git_commits, { desc = 'Git Commit History'})
    vim.keymap.set('n', '<leader>gb', fzf.git_bcommits, { desc = 'Git Buffer Commit History'})

    vim.keymap.set({'n', 'v'}, 'gd', fzf.lsp_definitions, { desc = 'LSP: Search Definition'})
    vim.keymap.set({'n', 'v'}, 'gr', fzf.lsp_references, { desc = 'LSP: Search References'})
    vim.keymap.set({'n', 'v'}, 'gD', fzf.lsp_declarations, { desc = 'LSP: Search Declaration'})

  end
}
