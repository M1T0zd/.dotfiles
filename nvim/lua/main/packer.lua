return require('packer').startup(function(use)
  use 'wbthomason/packer.nvim'                               
  use("sbdchd/neoformat")
  use("TimUntersberger/neogit")
  use("nvim-lua/plenary.nvim")
  use("nvim-lua/popup.nvim")
  use("nvim-telescope/telescope.nvim")
  use("neovim/nvim-lspconfig")
  use("hrsh7th/nvim-cmp")
  use("simrat39/symbols-outline.nvim")
  use("glepnir/lspsaga.nvim")
  use("mbbill/undotree")
  use("nvim-treesitter/nvim-treesitter", {
      run = ":TSUpdate"
  })
  use {
    'ThePrimeagen/harpoon',
    requires = { 'hvim-lua/plenary.nvim' }
  }
  use { "nvim-telescope/telescope-file-browser.nvim" }
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
  use {
    'rmagatti/auto-session',
    config = function()
      require("auto-session").setup {
        log_level = "error",
        auto_session_suppress_dirs = { "~/", "~/Projects", "~/Downloads", "/"},
      }
    end
  }
  use {
    'rmagatti/session-lens',
    requires = {'rmagatti/auto-session', 'nvim-telescope/telescope.nvim'},
    config = function()
      require('session-lens').setup({--[[your custom config--]]})
    end
  }
end)

