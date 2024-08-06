return { -- Collection of various small independent plugins/modules
  'echasnovski/mini.nvim',
  config = function()
    -- Better Around/Inside textobjects
    --
    -- Examples:
    --  - va)  - [V]isually select [A]round [)]paren
    --  - yinq - [Y]ank [I]nside [N]ext [']quote
    --  - ci'  - [C]hange [I]nside [']quote
    require('mini.ai').setup({ n_lines = 500 })

    -- Add/delete/replace surroundings (brackets, quotes, etc.)
    --
    -- - saiw) - [S]urround [A]dd [I]nner [W]ord [)]Paren
    -- - sd'   - [S]urround [D]elete [']quotes
    -- - sr)'  - [S]urround [R]eplace [)] [']
    require('mini.surround').setup({
      mappings = {
        add = 'gsA', -- Add surrounding in Normal and Visual modes
        delete = 'gsd', -- Delete surrounding
        find = 'gsf', -- Find surrounding (to the right)
        find_left = 'gsF', -- Find surrounding (to the left)
        highlight = 'gsh', -- Highlight surrounding
        replace = 'gsr', -- Replace surrounding
        update_n_lines = 'gsn', -- Update `n_lines`
      }
    })
    require('mini.comment').setup()

    -- mini.session Configuration
    require('mini.sessions').setup({
      force = { delete = true },
    })

    -- mini.pairs Configuration
    require('mini.pairs').setup(
      {
        modes = { insert = true, command = true, terminal = false },
        -- skip autopair when next character is one of these
        skip_next = [=[[%w%%%'%[%"%.%`%$]]=],
        -- skip autopair when the cursor is inside these treesitter nodes
        skip_ts = { "string" },
        -- skip autopair when next character is closing pair
        -- and there are more closing pairs than opening pairs
        skip_unbalanced = true,
        -- better deal with markdown code blocks
        markdown = true,
      }
    )

    -- mini.files Configuration
    require('mini.files').setup({
      windows = {
        preview = true,
        width_focus = 30,
        width_preview = 50,
      },
      mappings = {
        close       = '<Esc>',
        go_in       = 'l',
        go_in_plus  = 'L',
        go_out      = 'h',
        go_out_plus = 'H',
        reset       = '<BS>',
        reveal_cwd  = '@',
        show_help   = 'g?',
        synchronize = '=',
        trim_left   = '<',
        trim_right  = '>',
      },
      options = {
        use_as_default_explorer = true,
        permanent_delete = false
      },
    })
    -- Set Current Working Directory
    local files_set_cwd = function(path)
      -- Works only if cursor is on the valid file system entry
      local cur_entry_path = MiniFiles.get_fs_entry().path
      local cur_directory = vim.fs.dirname(cur_entry_path)
      vim.fn.chdir(cur_directory)
    end

    vim.api.nvim_create_autocmd('User', {
      pattern = 'MiniFilesBufferCreate',
      callback = function(args)
        vim.keymap.set('n', 'gs', files_set_cwd, { buffer = args.data.buf_id, desc = "Set CWD" })
      end,
    })
    -- Toggle showing dotfiles
    local show_dotfiles = true
    local filter_show = function(fs_entry) return true end
    local filter_hide = function(fs_entry)
      return not vim.startswith(fs_entry.name, '.')
    end
    local toggle_dotfiles = function()
      show_dotfiles = not show_dotfiles
      local new_filter = show_dotfiles and filter_show or filter_hide
      MiniFiles.refresh({ content = { filter = new_filter } })
    end

    vim.api.nvim_create_autocmd('User', {
      pattern = 'MiniFilesBufferCreate',
      callback = function(args)
        local buf_id = args.data.buf_id
        -- Tweak left-hand side of mapping to your liking
        vim.keymap.set('n', 'g.', toggle_dotfiles, { buffer = buf_id, desc = "Toggle Showing Dotfiles" })
      end,
    })


    -- mini.starter Configuration
    local starter = require('mini.starter')

    local pad = string.rep(" ", 22)
    local new_section = function(name, action, section)
      return { name = name, action = action, section = pad .. section }
    end

    starter.setup({
      header = [[
                                         ▄▀▄   ▄▀▄          
                                        ▄▀░░▀▀▀░░▀▄         
                                       ▄▀░░░░░░░░░▀▄        
                                       █░░▀░▄▀▄░▀░░█        
  _   _                 _             █░░░░░░░░░░░░░█       
 | \ | | ___  _____   _(_)_ __ ___    █░░▄▄██▄██▄▄░░█       
 |  \| |/ _ \/ _ \ \ / / | '_ ` _ \  █░░░▄▄█████▄▄░░░█      
 | |\  |  __/ (_) \ V /| | | | | | | █░░░░░░▀█▀░░░░░░█ ▄▀▀▄ 
 |_| \_|\___|\___/ \_/ |_|_| |_| |_| █░░░░░░░░░░░░░░░█  █░█ 
                                     ▀▄░░░░░░░░░░░░░▄▀▀▀░▄▀ 
                                       ▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀   
      ]],
      footer = "",
      items = {
        new_section("Find file",       "FzfLua files",                                  "FzfLua"),
        new_section("Recent files",    "FzfLua oldfiles",                                    "FzfLua"),
        new_section("Grep text",       "FzfLua live_grep",                                                         "FzfLua"),
        new_section("Config",          "lua require'fzf-lua'.files({ cwd = vim.fn.stdpath 'config' })",  "Config"),
        new_section("Lazy",            "Lazy",                                                  "Config"),
        new_section("New file",        "ene | startinsert",                                     "Built-in"),
        new_section("Quit",            "qa",                                                    "Built-in"),
        starter.sections.sessions(3, true)
      },
      content_hooks = {
        starter.gen_hook.adding_bullet(),
        starter.gen_hook.aligning('center', 'center'),
      },
    })

    require('mini.cursorword').setup()

    -- mini.indentscope Configuration
    require('mini.indentscope').setup({
      symbol = "│"
    })

    -- ... and there is more!
    --  Check out: https://github.com/echasnovski/mini.nvim
  end,
}
