return {
  "ahmedkhalf/project.nvim",
  opts = {
    detection_methods = { "lsp", "pattern" },
    patterns = { ".git" }
  },
  event = "VeryLazy",
  config = function(_, opts)
    require("project_nvim").setup(opts)
  end,
}
