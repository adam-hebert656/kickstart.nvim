return {
  'stevearc/oil.nvim',
  opts = {
    default_file_explorer = true,
    win_options = {
      wrap = true,
    },
    delete_to_trash = true,
    skip_confirm_for_simple_edits = false,
    view_options = {
      show_hidden = true,
      is_always_hidden = function(name, _)
        return name == '..' or name == '.git'
      end,
      natural_order = true,
    },
  },
  dependencies = { 'nvim-tree/nvim-web-devicons' },
}
