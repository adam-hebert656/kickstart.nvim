return {
  'folke/which-key.nvim',
  event = 'VimEnter', -- Sets the loading event to 'VimEnter'
  opts = {
    preset = "modern"
  },
  config = function(_, opts)
    local wk = require("which-key")
    wk.setup(opts)

    wk.add({
      { "<leader>b", group = "Buffers", icon = {icon = "", color = "green"}},
      { "<leader>c", group = "Conform", icon = {icon = "", color = "yellow"}},
      { "<leader>d", group = "Diagnostics", icon = {icon = "󱖫", color = "red"}},
      { "<leader>f", group = "Files", icon = "󰪶"},
      { "<leader>g", group = "Git", icon = {icon = "󰊢", color = "orange"}},
      { "<leader>h", group = "Harpoon", icon = "󰸕" },
      { "<leader>l", group = "LSP", icon = {icon = "󱃖", color = "yellow"}},
      { "<leader>p", group = "Preview", icon = {icon = "", color = "purple"}},
      { "<leader>q", group = "Quit", icon = {icon = "󰈆", color = "red"} },
      { "<leader>r", group = "Find & Replace", icon = {icon = "󰛔", color = "green"}},
      { "<leader>s", group = "Search", icon = {icon = "󰍉", color = "purple"}},
      { "<leader>t", group = "Toggle", icon = {icon = ""}},
      { "<leader>w", group = "Windows", icon = {icon = ""}},
      { "<leader>y", group = "Yanky", icon = {icon = "", color = "orange"}},
      { "<leader>yh", '<cmd>lua require("telescope").extensions.yank_history.yank_history()<cr>', desc = "Yanky History" },
      { "<leader>yc", '<cmd>YankyClearHistory<cr>', desc = "Yanky: Clear History"},
      { "<leader><tab>", group = "Tabs"}
    })
  end
 }
