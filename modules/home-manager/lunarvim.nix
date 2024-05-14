{ pkgs, ... }:
{
  home.packages = with pkgs; [ lunarvim ];

  home.file = {
    ".config/lvim/config.lua".text = ''
-- Alpha.nvim Header
--
--lvim.builtin.alpha.dashboard.section.header.val = {
--	"                                                                   ",
--	"      ████ ██████           █████      ██                    ",
--	"     ███████████             █████                            ",
--	"     █████████ ███████████████████ ███   ███████████  ",
--	"    █████████  ███    █████████████ █████ ██████████████  ",
--	"   █████████ ██████████ █████████ █████ █████ ████ █████  ",
--	" ███████████ ███    ███ █████████ █████ █████ ████ █████ ",
--	"██████  █████████████████████ ████ █████ █████ ████ ██████"
--}

-- Color Scheme
lvim.colorscheme = "catppuccin"

-- Enable Universal Transparent Windows
lvim.transparent_window = true

-- User Plugins
lvim.plugins = {
  {"alec-gibson/nvim-tetris"}, -- Silly Tetris Game, Run Using :Tetris
  {"github/copilot.vim"}, -- Official Copilot Plugin, Setup Using :Copilot setup 
  {"zyedidia/vim-snake"}, -- Silly Snake Game, Run Using :Snake
  {"MunifTanjim/nui.nvim"}, -- Dependancy For fine-cmdline.nvim
  {"VonHeikemen/fine-cmdline.nvim"}, -- Better Command Line
  {"catppuccin/nvim"}, -- Catppuccin Color Scheme
  {"rcarriga/nvim-notify"}, -- Better Notifications
  {"andweeb/presence.nvim"}, -- Discord Rich Presence
  {"kensyo/nvim-scrlbkun"} -- Scroll Bar
}

-- Nvim Tree To The Right
lvim.builtin.nvimtree.setup.view.side = "right"

-- Make Notify Default
vim.notify = require("notify")

-- 24-bit Color
vim.opt.termguicolors = true

-- Set Fine Command Line Prefix To :
vim.api.nvim_set_keymap('n', ':', '<cmd>FineCmdline<CR>', {noremap = true})

-- Theme Settings
require("catppuccin").setup({
    flavour = "mocha", -- latte, frappe, macchiato, mocha
    background = { -- :h background
        light = "latte",
        dark = "mocha",
    },
    transparent_background = false, -- disables setting the background color.
    show_end_of_buffer = false, -- shows the '~' characters after the end of buffers
    term_colors = false, -- sets terminal colors (e.g. `g:terminal_color_0`)
    dim_inactive = {
        enabled = false, -- dims the background color of inactive window
        shade = "dark",
        percentage = 0.15, -- percentage of the shade to apply to the inactive window
    },
    no_italic = false, -- Force no italic
    no_bold = false, -- Force no bold
    no_underline = false, -- Force no underline
    styles = { -- Handles the styles of general hi groups (see `:h highlight-args`):
        comments = { "italic" }, -- Change the style of comments
        conditionals = { "italic" },
        loops = {},
        functions = {},
        keywords = {},
        strings = {},
        variables = {},
        numbers = {},
        booleans = {},
        properties = {},
        types = {},
        operators = {},
        -- miscs = {}, -- Uncomment to turn off hard-coded styles
    },
    color_overrides = {},
    custom_highlights = {},
    integrations = {
        cmp = true,
        gitsigns = true,
        nvimtree = true,
        treesitter = true,
        notify = true,
        mini = {
            enabled = true,
            indentscope_color = "",
        },
        -- For more plugins integrations please scroll down (https://github.com/catppuccin/nvim#integrations)
    },
})

-- Fine Command Line Setup
require('fine-cmdline').setup({
  cmdline = {
    enable_keymaps = true,
    smart_history = true,
    prompt = ': '
  },
  popup = {
    position = {
      row = '10%',
      col = '50%',
    },
    size = {
      width = '60%',
    },
    border = {
      style = 'rounded',
      width = '50%',
    },
    win_options = {
      winhighlight = 'Normal:Normal,FloatBorder:FloatBorder',
    },
  },
  hooks = {
    before_mount = function(input)
      -- code
    end,
    after_mount = function(input)
      -- code
    end,
    set_keymaps = function(imap, feedkeys)
      -- code
    end
  }
})

-- Discord Rich Presence Setup
-- The setup config table shows all available config options with their default values:
require("presence").setup({
    -- General options
    auto_update         = true,                       -- Update activity based on autocmd events (if `false`, map or manually execute `:lua package.loaded.presence:update()`)
    neovim_image_text   = "Lunarvim BTW", -- Text displayed when hovered over the Neovim image
    main_image          = "file",                   -- Main image display (either "neovim" or "file")
    client_id           = "793271441293967371",       -- Use your own Discord application client id (not recommended)
    log_level           = nil,                        -- Log messages at or above this level (one of the following: "debug", "info", "warn", "error")
    debounce_timeout    = 10,                         -- Number of seconds to debounce events (or calls to `:lua package.loaded.presence:update(<filename>, true)`)
    enable_line_number  = false,                      -- Displays the current line number instead of the current project
    blacklist           = {},                         -- A list of strings or Lua patterns that disable Rich Presence if the current file name, path, or workspace matches
    buttons             = true,                       -- Configure Rich Presence button(s), either a boolean to enable/disable, a static table (`{{ label = "<label>", url = "<url>" }, ...}`, or a function(buffer: string, repo_url: string|nil): table)
    file_assets         = {},                         -- Custom file asset definitions keyed by file names and extensions (see default config at `lua/presence/file_assets.lua` for reference)
    show_time           = true,                       -- Show the timer

    -- Rich Presence text options
    editing_text        = "Editing %s",               -- Format string rendered when an editable file is loaded in the buffer (either string or function(filename: string): string)
    file_explorer_text  = "Browsing %s",              -- Format string rendered when browsing a file explorer (either string or function(file_explorer_name: string): string)
    git_commit_text     = "Committing changes",       -- Format string rendered when committing changes in git (either string or function(filename: string): string)
    plugin_manager_text = "Managing plugins",         -- Format string rendered when managing plugins (either string or function(plugin_manager_name: string): string)
    reading_text        = "Reading %s",               -- Format string rendered when a read-only or unmodifiable file is loaded in the buffer (either string or function(filename: string): string)
    workspace_text      = "Working on %s",            -- Format string rendered when in a git repository (either string or function(project_name: string|nil, filename: string): string)
    line_number_text    = "Line %s out of %s",        -- Format string rendered when `enable_line_number` is set to true (either string or function(line_number: number, line_count: number): string)
})

-- Scrollbar
require('scrlbkun').setup({
        single_window = true,
        zindex = 10,
        winblend = 40,
        excluded_filetypes = {"NvimTree"},
        excluded_buftypes = {"prompt"},
        fadeout_time = 1000,
        width = 1,
        bar = {
          enable = true,
          draw_events = {"WinScrolled", "BufEnter", "FocusGained"},
          draw_events_tab = {"VimResized", "TabEnter"},
          priority = 100,
          draw_columns = {1},
          sign = " ",
        },
        cursor = {
          enable = true,
          draw_events = {"BufEnter", "FocusGained", "CursorMoved"},
          draw_events_tab = {"VimResized", "TabEnter"},
          priority = 200,
          draw_columns = {1},
          signs = {
            "▔",
            "-",
            "▁",
          },
          sign_arrangement = "skip_first"
        },
        search = {
          enable = true,
          draw_events = {},
          draw_events_tab = {
            "TextChanged",
            "TextChangedI",
            "TextChangedP",
            "TabEnter",
            {
              "CmdlineLeave",
              {
                "/",
                "\\?",
                ":"
              },
            },
            {
              "CmdlineChanged",
              {
                "/",
                "\\?",
              },
            },
          },
          priority = 500,
          draw_columns = {1},
          signs = {
            ".",
            ":",
          },
          use_built_in_signs = true,
        },
        diagnostics = {
          enable = true,
          draw_events = {},
          draw_events_tab = {"BufEnter", "DiagnosticChanged", "TabEnter"},
          priority = 400,
          draw_columns = {2},
          signs = {
            ERROR = {".", ":"},
            WARN = {".", ":"},
            INFO = {".", ":"},
            HINT = {".", ":"},
          },
          use_built_in_signs = true,
        },
        githunks = {
          enable = true,
          draw_events = {},
          draw_events_tab = {
            {
              "User",
              "GitSignsUpdate"
            }
          },
          priority = 300,
          draw_columns = {1},
          signs = {
            add = {"│"},
            delete = {"▸"},
            change = {"│"},
          },
          use_built_in_signs = true,
        },
      })
  '';
  };
}

