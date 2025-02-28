return {
  'folke/which-key.nvim',
  event = 'VimEnter', -- Sets the loading event to 'VimEnter'
  opts = {
    preset = "helix"
  },
  config = function(_, opts)
    local wk = require("which-key")
    wk.setup(opts)

    wk.add({
      { "<leader>a", group = "Arrow", icon = "󱡁" },
      { "<leader>af", group = "Arrow File Bookmarks", icon = "󱡁" },
      { "<leader>ab", group = "Arrow Buffer Bookmarks", icon = "󱡁" },
      { "<leader>b", group = "Buffers", icon = {icon = "", color = "green"}},
      { "<leader>c", group = "Conform", icon = {icon = "", color = "yellow"}},
      { "<leader>d", group = "Diagnostics", icon = {icon = "󱖫", color = "red"}},
      { "<leader>f", group = "Files", icon = "󰪶"},
      { "<leader>g", group = "Git", icon = {icon = "󰊢", color = "blue"}},
      { "<leader>l", group = "LSP", icon = {icon = "󱃖", color = "yellow"}},
      { "<leader>n", group = "Notifications", icon = {icon = "", color = "orange"}},
      { "<leader>p", group = "Preview", icon = {icon = "", color = "purple"}},
      { "<leader>q", group = "Quit", icon = {icon = "󰈆", color = "red"} },
      { "<leader>r", group = "Find & Replace", icon = {icon = "󰛔", color = "green"}},
      { "<leader>s", group = "Search", icon = {icon = "󰍉", color = "purple"}},
      { "<leader>t", group = "Terminal", icon = {icon = ""}},
      { "<leader>w", group = "Windows", icon = {icon = ""}},
      { "<leader>y", group = "Yanky", icon = {icon = "", color = "orange"}},
      { "<leader><tab>", group = "Tabs"}
    })
  end
 }
