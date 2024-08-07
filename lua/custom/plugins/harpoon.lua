return {
  "ThePrimeagen/harpoon",
  lazy = false,
  dependencies = { 
    "nvim-lua/plenary.nvim",
  },
  branch = "harpoon2",
  opts = {
    menu = {
      width = vim.api.nvim_win_get_width(0) - 4,
    },
    settings = {
      save_on_toggle = true,
    },
  },
  config = function(_, opts)
    local harpoon = require('harpoon')
    harpoon:setup(opts)

    -- fzf-lua configuration
    local function toggle_fzf(harpoon_files)
      local file_paths = {}
      for _, item in ipairs(harpoon_files.items) do
        table.insert(file_paths, item.value)
      end

      require('fzf-lua').fzf_exec(file_paths, {
        actions = require('fzf-lua').defaults.actions.files,
        previewer = "builtin",
      })
    end

    vim.keymap.set("n", "<leader>hm", function() toggle_fzf(harpoon:list()) end, { desc = "Harpoon Menu" })
  end,
  keys = function()
    local keys = {
      {
        "<leader>hf",
        function()
          require("harpoon"):list():add()
        end,
        desc = "Harpoon File",
      },
    }

    for i = 1, 5 do
      table.insert(keys, {
        "<leader>h" .. i,
        function()
          require("harpoon"):list():select(i)
        end,
        desc = "Harpoon to File [" .. i .. "]",
      })
    end
    return keys
  end,
}
