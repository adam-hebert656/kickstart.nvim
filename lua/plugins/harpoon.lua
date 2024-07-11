return {
  "ThePrimeagen/harpoon",
  lazy = false,
  dependencies = { 
    "nvim-lua/plenary.nvim",
    'nvim-telescope/telescope.nvim',
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

    -- basic telescope configuration
    local conf = require("telescope.config").values
    local function toggle_telescope(harpoon_files)
      local file_paths = {}
      for _, item in ipairs(harpoon_files.items) do
        table.insert(file_paths, item.value)
      end

    require("telescope.pickers").new({}, {
      prompt_title = "Harpoon",
      finder = require("telescope.finders").new_table({
          results = file_paths,
      }),
      previewer = conf.file_previewer({}),
      sorter = conf.generic_sorter({}),
    }):find()
    end

    vim.keymap.set("n", "<leader>hm", function() toggle_telescope(harpoon:list()) end, { desc = "[H]arpoon [M]enu" })
  end,
  keys = function()
    local keys = {
      {
        "<leader>hf",
        function()
          require("harpoon"):list():add()
        end,
        desc = "[H]arpoon [F]ile",
      },
    }

    for i = 1, 5 do
      table.insert(keys, {
        "<leader>h" .. i,
        function()
          require("harpoon"):list():select(i)
        end,
        desc = "[H]arpoon to File [" .. i .. "]",
      })
    end
    return keys
  end,
}
