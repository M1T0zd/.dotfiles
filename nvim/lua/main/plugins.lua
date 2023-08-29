require('lazy').setup({
    ---- CORE / LIB ----
    { 'wbthomason/packer.nvim' },
    { 'nvim-lua/plenary.nvim' },
    { 'nvim-lua/popup.nvim' },
    { 'jose-elias-alvarez/null-ls.nvim' },

    ---- CODE INTELLIGENCE ----
    { 'neovim/nvim-lspconfig' }, -- Collection of configurations for built-in LSP client
    { 'L3MON4D3/LuaSnip' }, -- Snippets plugin
    { 'saadparwaiz1/cmp_luasnip' }, -- Snippets source for nvim-cmp
    { 'glepnir/lspsaga.nvim' },
    { 'onsails/lspkind.nvim' },
    {
        'nvim-treesitter/nvim-treesitter',
        build = function()
            require('nvim-treesitter.install').update({ with_sync = true })
        end,
    },
    { 'nvim-treesitter/nvim-treesitter-context' },
    {
        'williamboman/mason.nvim',
        build = ':MasonUpdate', -- :MasonUpdate updates registry contents
    },
    { 'williamboman/mason-lspconfig.nvim' },
    { 'jose-elias-alvarez/typescript.nvim' },
    { 'simrat39/rust-tools.nvim' },
    { 'Saecki/crates.nvim' },
    { 'MunifTanjim/prettier.nvim' },

    ---- UTIL ----
    {
        'folke/trouble.nvim',
        dependencies = { 'kyazdani42/nvim-web-devicons' },
    },
    { 'mbbill/undotree' },
    {
        'rmagatti/auto-session',
        config = function()
            require('auto-session').setup({
                log_level = 'error',
                auto_session_suppress_dirs = { '~/', '~/Downloads', '/' },
            })
        end,
    },
    { 'terrortylor/nvim-comment' },
    { 'akinsho/toggleterm.nvim', version = '*' },

    -- Telescope --
    { 'nvim-telescope/telescope.nvim' },
    {
        'AckslD/nvim-neoclip.lua',
        config = function()
            require('neoclip').setup()
        end,
    },
    {
        'ThePrimeagen/harpoon',
        -- dependencies = { 'hvim-lua/plenary.nvim' },
    },
    { 'nvim-telescope/telescope-file-browser.nvim' },
    {
        'rmagatti/session-lens',
        dependencies = { 'rmagatti/auto-session', 'nvim-telescope/telescope.nvim' },
        config = function()
            require('session-lens').setup()
        end,
    },
    { 'nvim-telescope/telescope-ui-select.nvim' },

    -- CODE COMPLETION --
    { 'hrsh7th/nvim-cmp' },

    -- LSP completion source:
    { 'hrsh7th/cmp-nvim-lsp' },

    -- Useful completion sources:
    { 'hrsh7th/cmp-nvim-lua' },
    { 'hrsh7th/cmp-nvim-lsp-signature-help' },
    { 'hrsh7th/cmp-vsnip' },
    { 'hrsh7th/cmp-path' },
    { 'hrsh7th/cmp-buffer' },
    { 'hrsh7th/vim-vsnip' },

    {
        'goolord/alpha-nvim',
        dependencies = { 'kyazdani42/nvim-web-devicons' },
        config = function()
            require('alpha').setup(require('alpha.themes.dashboard').config)
        end,
    },
    { 'kyazdani42/nvim-web-devicons' },
    { 'navarasu/onedark.nvim' },
    {
        'nvim-lualine/lualine.nvim',
        dependencies = { 'kyazdani42/nvim-web-devicons', lazy = true },
    },

    ---- MISC ----
    {
        'folke/noice.nvim',
        event = 'VeryLazy',
        dependencies = {
            'MunifTanjim/nui.nvim',
            'rcarriga/nvim-notify',
        },
    },
    -- { 'stevearc/dressing.nvim' },
    { 'folke/zen-mode.nvim' },
    {
        'folke/twilight.nvim',
        config = function()
            require('twilight').setup()
        end,
    },
    { 'ThePrimeagen/vim-be-good' },
    { 'dstein64/vim-startuptime' },
    { 'lukas-reineke/indent-blankline.nvim' },
    { 'ggandor/leap.nvim' },
    {
        'norcalli/nvim-colorizer.lua',
        config = function()
            require('colorizer').setup()
        end,
    },
    {
        'nmac427/guess-indent.nvim',
        config = function()
            require('guess-indent').setup({})
        end,
    },
    { 'junegunn/vim-easy-align' },
})
