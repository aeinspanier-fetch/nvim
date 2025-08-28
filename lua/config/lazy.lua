local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not (vim.uv or vim.loop).fs_stat(lazypath) then
  vim.fn.system({
    "git",
    "clone",
    "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    "--branch=stable",
    lazypath,
  })
end
vim.opt.rtp:prepend(lazypath)

local plugins = {
  -- Colorscheme
  {
    "folke/tokyonight.nvim",
    lazy = false,
    priority = 1000,
    config = function()
      require("tokyonight").setup({
        style = "night",
        transparent = false,
        terminal_colors = true,
        styles = {
          comments = { italic = true },
          keywords = { italic = true },
        },
      })
      vim.cmd([[colorscheme tokyonight]])
    end,
  },
  
  -- File tree
  {
    "nvim-neo-tree/neo-tree.nvim",
    branch = "v3.x",
    dependencies = {
      "nvim-lua/plenary.nvim",
      "nvim-tree/nvim-web-devicons",
      "MunifTanjim/nui.nvim",
    },
    keys = {
      { "<leader>e", "<cmd>Neotree toggle<cr>", desc = "NeoTree" },
    },
    config = function()
      require("neo-tree").setup({
        window = {
          mappings = {
            ["<space>"] = "none", -- Disable space in neo-tree to allow leader key to work
            ["<cr>"] = "open",
            ["o"] = "open",
            ["S"] = "split_with_window_picker",
            ["s"] = "vsplit_with_window_picker",
            ["t"] = "open_tabnew",
            ["C"] = "close_node",
            ["z"] = "close_all_nodes",
            ["R"] = "refresh",
            ["a"] = "add",
            ["A"] = "add_directory",
            ["d"] = "delete",
            ["r"] = "rename",
            ["y"] = "copy_to_clipboard",
            ["x"] = "cut_to_clipboard",
            ["p"] = "paste_from_clipboard",
            ["c"] = "copy",
            ["m"] = "move",
            ["q"] = "close_window",
          },
        },
        filesystem = {
          filtered_items = {
            visible = true, -- Show hidden files
            hide_dotfiles = false, -- Don't hide dotfiles
            hide_gitignored = false, -- Show gitignored files too
          },
        },
      })
    end,
  },
  
  -- Git
  {
    "lewis6991/gitsigns.nvim",
    event = { "BufReadPre", "BufNewFile" },
    config = true,
  },
  {
    "tpope/vim-fugitive",
    lazy = false,  -- Load immediately to ensure git commands work
    keys = {
      { "<leader>gs", vim.cmd.Git, desc = "Git status" },
      { "<leader>ga", function() vim.cmd("Git add %") end, desc = "Git add current file" },
      { "<leader>gA", function() vim.cmd("Git add .") end, desc = "Git add all" },
      { "<leader>gc", function() vim.cmd("Git commit") end, desc = "Git commit" },
      { "<leader>gp", function() vim.cmd("Git push") end, desc = "Git push" },
      { "<leader>gP", function() vim.cmd("Git pull") end, desc = "Git pull" },
      { "<leader>gb", function() vim.cmd("Git branch") end, desc = "Git branches" },
      {
        "<leader>gB",
        function()
          vim.ui.input({ prompt = "New branch name: " }, function(input)
            if input and input ~= "" then
              vim.cmd("Git checkout -b " .. input)
            end
          end)
        end,
        desc = "Create new branch",
      },
      {
        "<leader>go",
        function()
          vim.ui.input({ prompt = "Branch name: " }, function(input)
            if input and input ~= "" then
              vim.cmd("Git checkout " .. input)
            end
          end)
        end,
        desc = "Checkout branch",
      },
      { "<leader>gd", function() vim.cmd("Git diff") end, desc = "Git diff" },
      { "<leader>gD", function() vim.cmd("Git diff --staged") end, desc = "Git diff staged" },
      { "<leader>gl", function() vim.cmd("Git log --oneline") end, desc = "Git log" },
      { "<leader>gS", function() vim.cmd("Git stash") end, desc = "Git stash" },
      { "<leader>gU", function() vim.cmd("Git stash pop") end, desc = "Git stash pop" },
      { "<leader>gX", function() 
        vim.ui.input({ prompt = "Discard all uncommitted changes? (yes/no): " }, function(input)
          if input == "yes" then
            vim.cmd("Git checkout .")
            print("All uncommitted changes discarded")
          end
        end)
      end, desc = "Git reset (discard all changes)" },
      { "<leader>gx", function() vim.cmd("Git checkout %") end, desc = "Git reset current file" },
    },
  },
  {
    "kdheepak/lazygit.nvim",
    dependencies = { "nvim-lua/plenary.nvim" },
    keys = {
      { "<leader>gg", "<cmd>LazyGit<cr>", desc = "LazyGit" },
    },
  },
  
  -- Formatting
  {
    "stevearc/conform.nvim",
    event = { "BufWritePre" },
    cmd = { "ConformInfo" },
    keys = {
      {
        "<leader>f",
        function()
          require("conform").format({ async = true, lsp_fallback = true })
        end,
        desc = "Format buffer",
      },
    },
    opts = {
      formatters_by_ft = {
        lua = { "stylua" },
        python = { "black" },
        javascript = { "prettier" },
        typescript = { "prettier" },
        json = { "prettier" },
        yaml = { "prettier" },
        markdown = { "prettier" },
        go = { "gofumpt", "goimports" },
        terraform = { "terraform_fmt" },
        sql = { "sql_formatter" },
      },
    },
  },
  
  -- LSP Support
  {
    "neovim/nvim-lspconfig",
    dependencies = {
      -- LSP Management
      { "williamboman/mason.nvim" },
      { "williamboman/mason-lspconfig.nvim" },
      
      -- Autocompletion
      { "hrsh7th/nvim-cmp" },
      { "hrsh7th/cmp-nvim-lsp" },
      { "hrsh7th/cmp-buffer" },
      { "hrsh7th/cmp-path" },
      { "saadparwaiz1/cmp_luasnip" },
      
      -- Snippets
      { "L3MON4D3/LuaSnip" },
      { "rafamadriz/friendly-snippets" },
    },
    config = function()
      -- Setup Mason first
      require("mason").setup()
      require("mason-lspconfig").setup({
        ensure_installed = {
          "lua_ls",
          "pyright",
          "ts_ls",
          "jsonls",
          "yamlls",
          "marksman",
          "gopls",
          "terraformls",
          "sqlls",
        },
        automatic_installation = true,
      })
      
      -- Setup nvim-cmp for autocompletion
      local cmp = require("cmp")
      local luasnip = require("luasnip")
      
      -- Load friendly-snippets
      require("luasnip.loaders.from_vscode").lazy_load()
      
      cmp.setup({
        snippet = {
          expand = function(args)
            luasnip.lsp_expand(args.body)
          end,
        },
        mapping = cmp.mapping.preset.insert({
          ["<C-b>"] = cmp.mapping.scroll_docs(-4),
          ["<C-f>"] = cmp.mapping.scroll_docs(4),
          ["<C-Space>"] = cmp.mapping.complete(),
          ["<C-e>"] = cmp.mapping.abort(),
          ["<CR>"] = cmp.mapping.confirm({ select = true }),
          ["<Tab>"] = cmp.mapping(function(fallback)
            if cmp.visible() then
              cmp.select_next_item()
            elseif luasnip.expand_or_jumpable() then
              luasnip.expand_or_jump()
            else
              fallback()
            end
          end, { "i", "s" }),
          ["<S-Tab>"] = cmp.mapping(function(fallback)
            if cmp.visible() then
              cmp.select_prev_item()
            elseif luasnip.jumpable(-1) then
              luasnip.jump(-1)
            else
              fallback()
            end
          end, { "i", "s" }),
        }),
        sources = cmp.config.sources({
          { name = "nvim_lsp" },
          { name = "luasnip" },
        }, {
          { name = "buffer" },
          { name = "path" },
        }),
      })
      
      -- Setup LSP servers
      local lspconfig = require("lspconfig")
      local capabilities = require("cmp_nvim_lsp").default_capabilities()
      
      -- LSP Keybindings
      local on_attach = function(client, bufnr)
        local function buf_set_keymap(mode, lhs, rhs, desc)
          vim.keymap.set(mode, lhs, rhs, { buffer = bufnr, desc = desc })
        end
        
        -- Navigation
        buf_set_keymap("n", "gd", vim.lsp.buf.definition, "Go to definition")
        buf_set_keymap("n", "gD", vim.lsp.buf.declaration, "Go to declaration")
        buf_set_keymap("n", "gi", vim.lsp.buf.implementation, "Go to implementation")
        buf_set_keymap("n", "gr", vim.lsp.buf.references, "Find references")
        buf_set_keymap("n", "gt", vim.lsp.buf.type_definition, "Go to type definition")
        
        -- Information
        buf_set_keymap("n", "K", vim.lsp.buf.hover, "Hover documentation")
        buf_set_keymap("n", "<C-k>", vim.lsp.buf.signature_help, "Signature help")
        
        -- Actions
        buf_set_keymap("n", "<leader>rn", vim.lsp.buf.rename, "Rename symbol")
        buf_set_keymap("n", "<leader>ca", vim.lsp.buf.code_action, "Code action")
        
        -- Diagnostics
        buf_set_keymap("n", "[d", vim.diagnostic.goto_prev, "Previous diagnostic")
        buf_set_keymap("n", "]d", vim.diagnostic.goto_next, "Next diagnostic")
        buf_set_keymap("n", "<leader>d", vim.diagnostic.open_float, "Show diagnostic")
        buf_set_keymap("n", "<leader>dl", vim.diagnostic.setloclist, "Diagnostic list")
      end
      
      -- Configure each LSP server
      local servers = {
        lua_ls = {
          settings = {
            Lua = {
              runtime = { version = "LuaJIT" },
              diagnostics = { globals = { "vim" } },
              workspace = {
                library = vim.api.nvim_get_runtime_file("", true),
                checkThirdParty = false,
              },
              telemetry = { enable = false },
            },
          },
        },
        pyright = {
          settings = {
            python = {
              analysis = {
                autoSearchPaths = true,
                useLibraryCodeForTypes = true,
                diagnosticMode = "workspace",
              },
            },
          },
          on_attach = function(client, bufnr)
            -- Auto-detect virtual environment
            local venv_path = vim.fn.getcwd() .. '/venv'
            local venv_bin = venv_path .. '/bin/python'
            local poetry_venv = vim.fn.trim(vim.fn.system('poetry env info -p 2>/dev/null'))
            local conda_env = os.getenv("CONDA_DEFAULT_ENV")
            
            -- Check for different virtual environment types
            if vim.fn.filereadable(venv_bin) == 1 then
              -- Standard venv in project
              client.config.settings.python.pythonPath = venv_bin
            elseif poetry_venv ~= '' and not string.find(poetry_venv, "not find") then
              -- Poetry environment
              client.config.settings.python.pythonPath = poetry_venv .. '/bin/python'
            elseif conda_env then
              -- Conda environment
              local conda_python = vim.fn.trim(vim.fn.system('which python'))
              client.config.settings.python.pythonPath = conda_python
            else
              -- Check for .venv folder
              local dot_venv = vim.fn.getcwd() .. '/.venv/bin/python'
              if vim.fn.filereadable(dot_venv) == 1 then
                client.config.settings.python.pythonPath = dot_venv
              end
            end
            
            -- Call the standard on_attach
            on_attach(client, bufnr)
          end,
        },
        ts_ls = {},
        jsonls = {},
        yamlls = {},
        marksman = {},
        gopls = {
          settings = {
            gopls = {
              analyses = {
                unusedparams = true,
                nilness = true,
                unusedwrite = true,
                useany = true,
              },
              gofumpt = true,
              staticcheck = true,
            },
          },
        },
        terraformls = {},
        sqlls = {},
      }
      
      for server, config in pairs(servers) do
        -- Special handling for pyright's custom on_attach
        if server == "pyright" and config.on_attach then
          local pyright_on_attach = config.on_attach
          config.on_attach = function(client, bufnr)
            pyright_on_attach(client, bufnr)
          end
        else
          config.on_attach = on_attach
        end
        config.capabilities = capabilities
        lspconfig[server].setup(config)
      end
      
      -- Configure diagnostics
      vim.diagnostic.config({
        virtual_text = true,
        signs = true,
        underline = true,
        update_in_insert = false,
        severity_sort = true,
      })
      
      -- Add diagnostic signs
      local signs = { Error = "✘", Warn = "▲", Hint = "⚡", Info = "ℹ" }
      for type, icon in pairs(signs) do
        local hl = "DiagnosticSign" .. type
        vim.fn.sign_define(hl, { text = icon, texthl = hl, numhl = hl })
      end
      
      -- Command to manually select Python interpreter
      vim.api.nvim_create_user_command("PythonSelectInterpreter", function()
        vim.ui.input({ prompt = "Python interpreter path: ", default = vim.fn.getcwd() .. "/venv/bin/python" }, function(input)
          if input and input ~= "" then
            local clients = vim.lsp.get_active_clients({ name = "pyright" })
            for _, client in ipairs(clients) do
              client.config.settings.python.pythonPath = input
              client.notify("workspace/didChangeConfiguration", { settings = client.config.settings })
            end
            print("Python interpreter set to: " .. input)
          end
        end)
      end, { desc = "Select Python interpreter for LSP" })
    end,
  },
  
  -- Telescope
  {
    "nvim-telescope/telescope.nvim",
    cmd = "Telescope",
    dependencies = {
      "nvim-lua/plenary.nvim",
      {
        "nvim-telescope/telescope-fzf-native.nvim",
        build = "make",
        cond = function()
          return vim.fn.executable("make") == 1
        end,
      },
    },
    keys = {
      { "<leader>ff", "<cmd>Telescope find_files<cr>", desc = "Find Files" },
      { "<leader>fg", "<cmd>Telescope live_grep<cr>", desc = "Grep" },
      { "<leader>fb", "<cmd>Telescope buffers<cr>", desc = "Buffers" },
      { "<leader>fh", "<cmd>Telescope help_tags<cr>", desc = "Help" },
      { "<leader>fr", "<cmd>Telescope oldfiles<cr>", desc = "Recent Files" },
    },
    config = true,
  },
  
  -- Treesitter
  {
    "nvim-treesitter/nvim-treesitter",
    build = ":TSUpdate",
    event = { "BufReadPost", "BufNewFile" },
    opts = {
      ensure_installed = { "lua", "vim", "vimdoc", "javascript", "typescript", "python", "rust", "go", "json", "yaml", "markdown" },
      highlight = { enable = true },
      indent = { enable = true },
    },
    config = function(_, opts)
      require("nvim-treesitter.configs").setup(opts)
    end,
  },
  
  -- Harpoon
  {
    "ThePrimeagen/harpoon",
    branch = "harpoon2",
    dependencies = { "nvim-lua/plenary.nvim" },
    config = function()
      local harpoon = require("harpoon")
      harpoon:setup()
      
      vim.keymap.set("n", "<leader>a", function() harpoon:list():add() end)
      vim.keymap.set("n", "<C-e>", function() harpoon.ui:toggle_quick_menu(harpoon:list()) end)
      vim.keymap.set("n", "<leader>1", function() harpoon:list():select(1) end)
      vim.keymap.set("n", "<leader>2", function() harpoon:list():select(2) end)
      vim.keymap.set("n", "<leader>3", function() harpoon:list():select(3) end)
      vim.keymap.set("n", "<leader>4", function() harpoon:list():select(4) end)
    end,
  },
  
  -- Undotree
  {
    "mbbill/undotree",
    keys = {
      { "<leader>u", vim.cmd.UndotreeToggle, desc = "Undotree" },
    },
  },
  
  -- UI
  {
    "nvim-lualine/lualine.nvim",
    event = "VeryLazy",
    opts = {
      options = { theme = "tokyonight" },
    },
  },
  
  -- Terminal/Shell Integration
  {
    "akinsho/toggleterm.nvim",
    version = "*",
    keys = {
      { "<leader>tt", "<cmd>ToggleTerm<cr>", desc = "Toggle Terminal" },
      { "<leader>tf", "<cmd>ToggleTerm direction=float<cr>", desc = "Float Terminal" },
      { "<leader>th", "<cmd>ToggleTerm size=15 direction=horizontal<cr>", desc = "Horizontal Terminal" },
      { "<leader>tv", "<cmd>ToggleTerm size=80 direction=vertical<cr>", desc = "Vertical Terminal" },
    },
    opts = {
      shell = vim.o.shell,
      open_mapping = [[<c-\>]],
      direction = "float",
      float_opts = {
        border = "curved",
      },
    },
  },
  
  -- Better terminal/command mode
  {
    "tpope/vim-dispatch",
    cmd = { "Dispatch", "Make", "Focus", "Start" },
  },
  
  -- File manager with shell commands
  {
    "stevearc/oil.nvim",
    dependencies = { "nvim-tree/nvim-web-devicons" },
    keys = {
      { "-", "<cmd>Oil<cr>", desc = "Open parent directory" },
    },
    opts = {
      default_file_explorer = false,
      view_options = {
        show_hidden = true,
      },
    },
  },
}

-- Claude Code integration
table.insert(plugins, {
  "greggh/claude-code.nvim",
  lazy = false,
  keys = {
    { "<leader>cc", "<cmd>ClaudeCodeToggle<cr>", desc = "Toggle Claude Code" },
  },
  config = function()
    require("claude-code").setup({
      -- Optional configuration
      window_position = "right", -- or "left", "top", "bottom", "float"
    })
  end,
})

require("lazy").setup(plugins, {
  defaults = {
    lazy = false,
    version = false,
  },
  checker = { enabled = true },
  performance = {
    rtp = {
      disabled_plugins = {
        "gzip",
        "tarPlugin",
        "tohtml",
        "tutor",
        "zipPlugin",
      },
    },
  },
})