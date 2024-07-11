return {
  'folke/which-key.nvim',
  event = 'VimEnter', -- Sets the loading event to 'VimEnter'
  config = function() -- This is the function that runs, AFTER loading
    require('which-key').setup()

    -- Document existing key chains
    require('which-key').register {
      -- ['<leader>a'] = { name = '[A]rrow', _ = 'which_key_ignore' },
      ['<leader>b'] = { name = '[B]uffers', _ = 'which_key_ignore' },
      ['<leader>d'] = { name = '[D]iagnostics', _ = 'which_key_ignore' },
      ['<leader>f'] = { name = '[F]iles', _ = 'which_key_ignore' },
      ['<leader>g'] = { name = '[G]it', _ = 'which_key_ignore' },
      ['<leader>h'] = { name = '[H]arpoon', _ = 'which_key_ignore' },
      ['<leader>l'] = { name = '[L]SP', _ = 'which_key_ignore' },
      ['<leader>q'] = { name = '[Q]uit', _ = 'which_key_ignore' },
      ['<leader>r'] = { name = '[R]ename', _ = 'which_key_ignore' },
      ['<leader>s'] = { name = '[S]earch', _ = 'which_key_ignore' },
      ['<leader>w'] = { name = '[W]orkspace', _ = 'which_key_ignore' },
      ['<leader>t'] = { name = '[T]oggle', _ = 'which_key_ignore' },
      ['<leader>y'] = { name = '[Y]ank', _ = 'which_key_ignore' },

      -- ["<leader>af"] = { "<cmd>Arrow open<cr>", "[A]rrow [F]ile Bookmarks" },
      -- ["<leader>al"] = { "<cmd>lua require('arrow.buffer_ui').openMenu()<cr>", "[A]rrow [L]ine Bookmarks" },


    }
  end,
}
