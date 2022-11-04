-- theme
require('onedark').setup {
    style = 'warmer'
}
require('onedark').load()

-- statusline
require('lualine').setup(require('main.config.evil_lualine'))

-- icons
require'nvim-web-devicons'.setup {
    default = true;
}
