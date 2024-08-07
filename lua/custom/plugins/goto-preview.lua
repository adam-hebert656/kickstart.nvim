return {
  "rmagatti/goto-preview",
  event = "BufEnter",
  opts = {},
  keys = {
    {
      "<leader>pd",
      "<cmd>lua require('goto-preview').goto_preview_definition()<CR>",
      noremap = true,
      desc = "Preview Definition",
    },
    {
      "<leader>pD",
      "<cmd>lua require('goto-preview').goto_preview_declaration()<CR>",
      noremap = true,
      desc = "Preview Declaration",
    },
    {
      "<leader>pi",
      "<cmd>lua require('goto-preview').goto_preview_implementation()<CR>",
      noremap = true,
      desc = "Preview Implementation",
    },
    {
      "<leader>py",
      "<cmd>lua require('goto-preview').goto_preview_type_definition()<CR>",
      noremap = true,
      desc = "Preview Type Definition",
    },
    {
      "<leader>pr",
      "<cmd>lua require('goto-preview').goto_preview_references()<CR>",
      noremap = true,
      desc = "Preview References",
    },
    {
      "<leader>pC",
      "<cmd>lua require('goto-preview').close_all_win()<CR>",
      noremap = true,
      desc = "Close all Preview Windows",
    },
  },
}
