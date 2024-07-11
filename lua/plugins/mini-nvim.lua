return { -- Collection of various small independent plugins/modules
  'echasnovski/mini.nvim',
  config = function()
    -- Better Around/Inside textobjects
    --
    -- Examples:
    --  - va)  - [V]isually select [A]round [)]paren
    --  - yinq - [Y]ank [I]nside [N]ext [']quote
    --  - ci'  - [C]hange [I]nside [']quote
    require('mini.ai').setup { n_lines = 500 }

    -- Add/delete/replace surroundings (brackets, quotes, etc.)
    --
    -- - saiw) - [S]urround [A]dd [I]nner [W]ord [)]Paren
    -- - sd'   - [S]urround [D]elete [']quotes
    -- - sr)'  - [S]urround [R]eplace [)] [']
    require('mini.surround').setup()
    require('mini.comment').setup()
    require('mini.bufremove').setup()
    require('mini.pairs').setup()
    require('mini.sessions').setup()

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
      items = {
        starter.sections.recent_files(5, true, true),
        new_section("Find file",       "Telescope find_files",                "Telescope"),
        new_section("Recent files",    "Telescope oldfiles",                  "Telescope"),
        new_section("Find text",       "Telescope live_grep",                 "Telescope"),
        new_section("Config",          "Oil --float ~/.config/nvim/",         "Config"),
        new_section("Lazy",            "Lazy",                                "Config"),
        new_section("New file",        "ene | startinsert",                   "Built-in"),
        new_section("Quit",            "qa",                                  "Built-in"),
      },
      content_hooks = {
        starter.gen_hook.adding_bullet(),
        starter.gen_hook.aligning('center', 'center'),
      },
    })

    -- ... and there is more!
    --  Check out: https://github.com/echasnovski/mini.nvim
  end,
}
