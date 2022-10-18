return require('packer').startup(function(use)
  -- CORE / LIB --
  use 'wbthomason/packer.nvim'
  use("nvim-lua/plenary.nvim")
  use("nvim-lua/popup.nvim")

  -- CODE INTELLIGENCE --
  use 'neovim/nvim-lspconfig' -- Collection of configurations for built-in LSP client
  use 'hrsh7th/nvim-cmp' -- Autocompletion plugin
  use 'hrsh7th/cmp-nvim-lsp' -- LSP source for nvim-cmp
  use 'L3MON4D3/LuaSnip' -- Snippets plugin
  use 'saadparwaiz1/cmp_luasnip' -- Snippets source for nvim-cmp
  use("glepnir/lspsaga.nvim")
  use("onsails/lspkind.nvim")
  use {
    'nvim-treesitter/nvim-treesitter',
    run = function() require('nvim-treesitter.install').update({ with_sync = true }) end,
  }

  -- UTIL --
  use("mbbill/undotree")
  use("sbdchd/neoformat")
  use("TimUntersberger/neogit")
  use { 'sindrets/diffview.nvim', requires = 'nvim-lua/plenary.nvim' }
  use {
    'rmagatti/auto-session',
    config = function()
      require("auto-session").setup {
        log_level = "error",
        auto_session_suppress_dirs = { "~/", "~/Projects", "~/Downloads", "/"},
      }
    end
  }

  -- Telescope
  use("nvim-telescope/telescope.nvim")
  use {
    "AckslD/nvim-neoclip.lua",
    config = function()
      require('neoclip').setup()
    end,
  }
  use {
    'ThePrimeagen/harpoon',
    requires = { 'hvim-lua/plenary.nvim' }
  }
  use { "nvim-telescope/telescope-file-browser.nvim" }
  use {
    'rmagatti/session-lens',
    requires = {'rmagatti/auto-session', 'nvim-telescope/telescope.nvim'},
    config = function()
      require('session-lens').setup()
    end
  }

  -- Extra
  use "folke/zen-mode.nvim"
  use {
    "folke/twilight.nvim",
    config = function()
      require("twilight").setup()
    end
  }
  use 'ThePrimeagen/vim-be-good'
  use 'dstein64/vim-startuptime'

  -- THEME --
  use {
    'goolord/alpha-nvim',
    requires = { 'kyazdani42/nvim-web-devicons' },
    config = function ()
        require'alpha'.setup(require'alpha.themes.dashboard'.config)
    end
  }
  use("kyazdani42/nvim-web-devicons")
  use 'navarasu/onedark.nvim'
  use {
    'nvim-lualine/lualine.nvim',
    requires = { 'kyazdani42/nvim-web-devicons', opt = true }
  }
end)

