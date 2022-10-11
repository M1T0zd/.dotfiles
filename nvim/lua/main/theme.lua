require('onedark').setup {
    style = 'warmer'
}
require('onedark').load()

-- statusline
require('lualine').setup(require('main.config.evil_lualine'))
--require('lualine').setup {
--  options = {
--    theme = 'codedark',
--  },
--  sections = {lualine_c = {require('auto-session-library').current_session_name}}
--}

-- icons
require'nvim-web-devicons'.setup {
 default = true;
}

