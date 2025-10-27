-- since this is just an example spec, don't actually load anything here and return an empty spec
-- stylua: ignore
-- if true then return {} end

-- every spec file under the "plugins" directory will be loaded automatically by lazy.nvim
--
-- In your plugin files, you can:
-- * add extra plugins
-- * disable/enabled LazyVim plugins
-- * override the configuration of LazyVim plugins
return {
  -- add tokynight
    {
      "folke/tokyonight.nvim",
      opts = {
        transparent = false,
        styles = {
          sidebars = "transparent",
          floats = "transparent",
        },
      },
    },
  -- add gruvbox
    {
        "ellisonleao/gruvbox.nvim",
          opts = {
            transparent_mode = false,
        },
    },
  -- Configure LazyVim to load gruvbox
    {
        "LazyVim/LazyVim",
        opts = {
            colorscheme = "tokyonight",
        },
    },

  -- change trouble config
  {
    "folke/trouble.nvim",
    -- opts will be merged with the parent spec
    opts = { use_diagnostic_signs = true },
  },

  -- disable trouble
  { "folke/trouble.nvim", enabled = false },

  -- override nvim-cmp and add cmp-emoji
  {
    "hrsh7th/nvim-cmp",
    dependencies = { "hrsh7th/cmp-emoji" },
    ---@param opts cmp.ConfigSchema
    opts = function(_, opts)
      table.insert(opts.sources, { name = "emoji" })
    end,
  },

  -- change some telescope options and a keymap to browse plugin files
  {
    "nvim-telescope/telescope.nvim",
    keys = {
      -- add a keymap to browse plugin files
      -- stylua: ignore
      {
        "<leader>fp",
        function() require("telescope.builtin").find_files({ cwd = require("lazy.core.config").options.root }) end,
        desc = "Find Plugin File",
      },
    },
    -- change some options
    opts = {
      defaults = {
        layout_strategy = "horizontal",
        layout_config = { prompt_position = "top" },
        sorting_strategy = "ascending",
        winblend = 0,
      },
    },
  },

  -- add pyright to lspconfig
  {
    "neovim/nvim-lspconfig",
    ---@class PluginLspOpts
    opts = {
      ---@type lspconfig.options
      servers = {
        -- pyright will be automatically installed with mason and loaded with lspconfig
        pyright = {},
      },
    },
  },

  -- add tsserver and setup with typescript.nvim instead of lspconfig
  {
    "neovim/nvim-lspconfig",
    dependencies = {
      "jose-elias-alvarez/typescript.nvim",
      init = function()
        require("lazyvim.util").lsp.on_attach(function(_, buffer)
          -- stylua: ignore
          vim.keymap.set( "n", "<leader>co", "TypescriptOrganizeImports", { buffer = buffer, desc = "Organize Imports" })
          vim.keymap.set("n", "<leader>cR", "TypescriptRenameFile", { desc = "Rename File", buffer = buffer })
        end)
      end,
    },
    ---@class PluginLspOpts
    opts = {
      ---@type lspconfig.options
      servers = {
        -- tsserver will be automatically installed with mason and loaded with lspconfig
        tsserver = {},
      },
      -- you can do any additional lsp server setup here
      -- return true if you don't want this server to be setup with lspconfig
      ---@type table<string, fun(server:string, opts:_.lspconfig.options):boolean?>
      setup = {
        -- example to setup with typescript.nvim
        tsserver = function(_, opts)
          require("typescript").setup({ server = opts })
          return true
        end,
        -- Specify * to use this function as a fallback for any server
        -- ["*"] = function(server, opts) end,
      },
    },
  },

  -- for typescript, LazyVim also includes extra specs to properly setup lspconfig,
  -- treesitter, mason and typescript.nvim. So instead of the above, you can use:
  { import = "lazyvim.plugins.extras.lang.typescript" },

  -- add more treesitter parsers
  {
    "nvim-treesitter/nvim-treesitter",
    opts = {
      ensure_installed = {
        "bash",
        "html",
        "javascript",
        "json",
        "lua",
        "markdown",
        "markdown_inline",
        "python",
        "query",
        "regex",
        "tsx",
        "typescript",
        "vim",
        "yaml",
      },
    },
  },

  -- since `vim.tbl_deep_extend`, can only merge tables and not lists, the code above
  -- would overwrite `ensure_installed` with the new value.
  -- If you'd rather extend the default config, use the code below instead:
  {
    "nvim-treesitter/nvim-treesitter",
    opts = function(_, opts)
      -- add tsx and treesitter
      vim.list_extend(opts.ensure_installed, {
        "tsx",
        "typescript",
      })
    end,
  },
  -- use mini.starter instead of alpha
  { import = "lazyvim.plugins.extras.ui.mini-starter" },

  -- add jsonls and schemastore packages, and setup treesitter for json, json5 and jsonc
  { import = "lazyvim.plugins.extras.lang.json" },

  -- add any tools you want to have installed below
  {
    "williamboman/mason.nvim",
    "williamboman/mason-lspconfig.nvim",
    "neovim/nvim-lspconfig",
    opts = {
      ensure_installed = {
        "clangd",
        "stylua",
        "shellcheck",
        "shfmt",
        "flake8",
      },
    },
  },
  -- USER CHANGE
  {
    "L3MON4D3/LuaSnip",
    version = "v2.*",
  },
  {
    "nvim-telescope/telescope-fzf-native.nvim",
    build = "make",
    config = function()
      require("telescope").setup({
        extensions = {
          fzf = {
            fuzzy = true,
            override_generic_sorter = true,
            override_file_sorter = true,
            case_mode = "smart_case",
          },
        },
      })
      require("telescope").load_extension("fzf")
    end,
  },
  {
    "BurntSushi/ripgrep",
  },
    {
        "dhananjaylatkar/cscope_maps.nvim",
        -- dependencies = {
        --     "nvim-telescope/telescope.nvim", -- optional [for picker="telescope"]
        -- },
        config = function()
            require("cscope_maps").setup({
                -- maps related defaults
                disable_maps = false, -- "true" disables default keymaps
                skip_input_prompt = false, -- "true" doesn't ask for input
                prefix = "C-c", -- prefix to trigger maps

                -- cscope related defaults
                cscope = {
                    -- location of cscope db file
                    db_file = "./cscope.out", -- DB or table of DBs
                                            -- NOTE:
                                            --   when table of DBs is provided 
                                            --   first DB is "primary" and others are "secondary"
                                            --   primary DB is used for build and project_rooter
                    -- cscope executable
                    exec = "cscope", -- "cscope" or "gtags-cscope"
                    -- choose your fav picker
                    picker = "telescope", -- "quickfix", "telescope", "fzf-lua" or "mini-pick"
                    -- size of quickfix window
                    qf_window_size = 5, -- any positive integer
                    -- position of quickfix window
                    qf_window_pos = "bottom", -- "bottom", "right", "left" or "top"
                    -- "true" does not open picker for single result, just JUMP
                    skip_picker_for_single_result = false, -- "false" or "true"
                    -- these args are directly passed to "cscope -f <db_file> <args>"
                    db_build_cmd_args = { "-bqkv" },
                    -- statusline indicator, default is cscope executable
                    statusline_indicator = nil,
                    -- try to locate db_file in parent dir(s)
                    project_rooter = {
                        enable = false, -- "true" or "false"
                        -- change cwd to where db_file is located
                        change_cwd = false, -- "true" or "false"
                    },
                }
            })
        end,
    },
      {
    "stevearc/aerial.nvim",
    event = "LazyFile",
    dependencies = {
      "nvim-treesitter/nvim-treesitter",
      "nvim-tree/nvim-web-devicons",
    },
    opts = {
      backends = { "lsp", "treesitter", "markdown", "man" },

      layout = {
        max_width = { 40, 0.2 },
        width = 30,
        min_width = 20,
        default_direction = "right",
        placement = "edge",
      },

      -- 显示设置
      show_guides = true,
      guides = {
        mid_item = "├─",
        last_item = "└─",
        nested_top = "│ ",
        whitespace = "  ",
      },

      -- 高亮当前符号
      highlight_on_hover = true,
      highlight_on_jump = 300,

      -- 自动更新
      update_events = "TextChanged,InsertLeave",

      -- 图标
      icons = {},

      -- 过滤（显示哪些符号类型）
      filter_kind = {
        "Class",
        "Constructor",
        "Enum",
        "Function",
        "Interface",
        "Module",
        "Method",
        "Struct",
      },
    },
    keys = {
      { "<leader>a", "<cmd>AerialToggle<cr>", desc = "Aerial (Symbols)" },
      { "<leader>cs", "<cmd>AerialToggle<cr>", desc = "Symbols (Aerial)" },
      { "{", "<cmd>AerialPrev<cr>", desc = "Prev Symbol" },
      { "}", "<cmd>AerialNext<cr>", desc = "Next Symbol" },
    },
  },
}
