return { -- Collection of various small independent plugins/modules
  'echasnovski/mini.nvim',
  config = function()
    if vim.g.vscode then
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
      require('mini.ai').setup({ n_lines = 500 })
      require('mini.comment')
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
    else
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
      -- require('mini.comment').setup()

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
          close       = 'q',
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

      local padding = string.rep(" ", 22)
      local custom_sessions = function(n, recent)
        n = n or 5
        if recent == nil then recent = true end

        return function()
          if _G.MiniSessions == nil then
            return { { name = [['mini.sessions' is not set up]], action = '', section = padding .. 'Sessions' } }
          end

          local items = {}
          for session_name, session in pairs(_G.MiniSessions.detected) do
            table.insert(items, {
              _session = session,
              name = ('%s%s'):format(session_name, session.type == 'local' and ' (local)' or ''),
              action = ([[lua _G.MiniSessions.read('%s')]]):format(session_name),
              section = padding .. 'Sessions',
            })
          end

          if vim.tbl_count(items) == 0 then
            return { { name = [[There are no detected sessions in 'mini.sessions']], action = '', section = padding .. 'Sessions' } }
          end

          local sort_fun
          if recent then
            sort_fun = function(a, b)
              local a_time = a._session.type == 'local' and math.huge or a._session.modify_time
              local b_time = b._session.type == 'local' and math.huge or b._session.modify_time
              return a_time > b_time
            end
          else
            sort_fun = function(a, b)
              local a_name = a._session.type == 'local' and '' or a.name
              local b_name = b._session.type == 'local' and '' or b.name
              return a_name < b_name
            end
          end
          table.sort(items, sort_fun)

          -- Take only first `n` elements and remove helper fields
          return vim.tbl_map(function(x)
            x._session = nil
            return x
          end, vim.list_slice(items, 1, n))
        end
      end

      local new_section = function(name, action, section)
        return { name = name, action = action, section = padding .. section }
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
          new_section("Find file",       "FzfLua files",                                                     "Find"),
          new_section("Recent files",    "FzfLua oldfiles",                                                  "Find"),
          new_section("Grep text",       "FzfLua live_grep",                                                 "Find"),
          new_section("Config",          "lua require'fzf-lua'.files({ cwd = vim.fn.stdpath 'config' })",  "Config"),
          new_section("Lazy",            "Lazy",                                                           "Config"),
          new_section("New file",        "ene | startinsert",                                            "Built-in"),
          new_section("Quit",            "qa",                                                           "Built-in"),
          new_section("Search Sessions", "lua require('mini.sessions').select()",                        "Sessions"),
          custom_sessions(5, false)
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

      require('mini.diff').setup({
        view = {
          style = "sign"
        }
      })

      -- ... and there is more!
      --  Check out: https://github.com/echasnovski/mini.nvim
    end
  end,
}
