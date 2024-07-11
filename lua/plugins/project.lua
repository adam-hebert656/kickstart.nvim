return {
  "ahmedkhalf/project.nvim",
  opts = {
    detection_methods = { "lsp", "pattern" },
    patterns = { ".git" }
  },
  event = "VeryLazy",
  config = function(_, opts)
    require("project_nvim").setup(opts)

    local utils = require('adamutils')
    utils.on_load("telescope.nvim", function()
      require("telescope").load_extension("projects")
    end)
  end,
}
