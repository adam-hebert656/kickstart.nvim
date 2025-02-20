return {
  'saghen/blink.cmp',
  -- optional: provides snippets for the snippet source
  dependencies = 'rafamadriz/friendly-snippets',

  -- use a release tag to download pre-built binaries
  version = 'v0.*',
  -- AND/OR build from source, requires nightly: https://rust-lang.github.io/rustup/concepts/channels.html#working-with-nightly-rust
  -- build = 'cargo build --release',
  -- If you use nix, you can build from source using latest nightly rust with:
  -- build = 'nix run .#build-plugin',

  ---@module 'blink.cmp'
  ---@type blink.cmp.Config
  opts = {
      -- "default" keymap
  --   ['<C-space>'] = { 'show', 'show_documentation', 'hide_documentation' },
  --   ['<C-e>'] = { 'hide' },
  --   ['<C-y>'] = { 'select_and_accept' },
  --
  --   ['<C-p>'] = { 'select_prev', 'fallback' },
  --   ['<C-n>'] = { 'select_next', 'fallback' },
  --
  --   ['<C-b>'] = { 'scroll_documentation_up', 'fallback' },
  --   ['<C-f>'] = { 'scroll_documentation_down', 'fallback' },
  --
  --   ['<Tab>'] = { 'snippet_forward', 'fallback' },
  --   ['<S-Tab>'] = { 'snippet_backward', 'fallback' },
  --
  -- "super-tab" keymap
  --   you may want to set `completion.trigger.show_in_snippet = false`
  --   or use `completion.list.selection = "manual" | "auto_insert"`
  --
  --   ['<C-space>'] = { 'show', 'show_documentation', 'hide_documentation' },
  --   ['<C-e>'] = { 'hide', 'fallback' },
  --
  --   ['<Tab>'] = {
  --     function(cmp)
  --       if cmp.snippet_active() then return cmp.accept()
  --       else return cmp.select_and_accept() end
  --     end,
  --     'snippet_forward',
  --     'fallback'
  --   },
  --   ['<S-Tab>'] = { 'snippet_backward', 'fallback' },
  --
  --   ['<Up>'] = { 'select_prev', 'fallback' },
  --   ['<Down>'] = { 'select_next', 'fallback' },
  --   ['<C-p>'] = { 'select_prev', 'fallback' },
  --   ['<C-n>'] = { 'select_next', 'fallback' },
  --
  --   ['<C-b>'] = { 'scroll_documentation_up', 'fallback' },
  --   ['<C-f>'] = { 'scroll_documentation_down', 'fallback' },
  --
  -- "enter" keymap
  --   you may want to set `completion.list.selection = "manual" | "auto_insert"`
  --
  --   ['<C-space>'] = { 'show', 'show_documentation', 'hide_documentation' },
  --   ['<C-e>'] = { 'hide', 'fallback' },
  --   ['<CR>'] = { 'accept', 'fallback' },
  --
  --   ['<Tab>'] = { 'snippet_forward', 'fallback' },
  --   ['<S-Tab>'] = { 'snippet_backward', 'fallback' },
  --
  --   ['<Up>'] = { 'select_prev', 'fallback' },
  --   ['<Down>'] = { 'select_next', 'fallback' },
  --   ['<C-p>'] = { 'select_prev', 'fallback' },
  --   ['<C-n>'] = { 'select_next', 'fallback' },
  --
  --   ['<C-b>'] = { 'scroll_documentation_up', 'fallback' },
  --   ['<C-f>'] = { 'scroll_documentation_down', 'fallback' },
    -- 'default' for mappings similar to built-in completion
    -- 'super-tab' for mappings similar to vscode (tab to accept, arrow keys to navigate)
    -- 'enter' for mappings similar to 'super-tab' but with 'enter' to accept
    -- see the "default configuration" section below for full documentation on how to define
    -- your own keymap.
    keymap = { preset = 'enter' },

    completion = {
      menu = {
        draw = {
          treesitter = { "lsp" },
        },
      },
      documentation = {
        auto_show = true,
        auto_show_delay_ms = 200,
      },
      list = {
        selection = { preselect = false, auto_insert = false },
      }
    },

    appearance = {
      -- Sets the fallback highlight groups to nvim-cmp's highlight groups
      -- Useful for when your theme doesn't support blink.cmp
      -- will be removed in a future release
      use_nvim_cmp_as_default = true,
      -- Set to 'mono' for 'Nerd Font Mono' or 'normal' for 'Nerd Font'
      -- Adjusts spacing to ensure icons are aligned
      nerd_font_variant = 'mono',
      kind_icons = {
        Text = '󰉿',
        Method = '󰊕',
        Function = '󰊕',
        Constructor = '󰒓',

        Field = '󰜢',
        Variable = '󰆦',
        Property = '󰖷',

        Class = '󱡠',
        Interface = '󱡠',
        Struct = '󱡠',
        Module = '󰅩',

        Unit = '󰪚',
        Value = '󰦨',
        Enum = '󰦨',
        EnumMember = '󰦨',

        Keyword = '󰻾',
        Constant = '󰏿',

        Snippet = '󱄽',
        Color = '󰏘',
        File = '󰈔',
        Reference = '󰬲',
        Folder = '󰉋',
        Event = '󱐋',
        Operator = '󰪚',
        TypeParameter = '󰬛',
      }
    },

    -- default list of enabled providers defined so that you can extend it
    -- elsewhere in your config, without redefining it, via `opts_extend`
    sources = {
      default = { 'lsp', 'path', 'snippets', 'buffer' },
      -- optionally disable cmdline completions
      -- cmdline = {},
    },

    -- experimental signature help support
    -- signature = { enabled = true }
  },
  -- allows extending the providers array elsewhere in your config
  -- without having to redefine it
  opts_extend = { "sources.default" }
}
