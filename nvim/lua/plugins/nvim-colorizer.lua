return {
  "catgoose/nvim-colorizer.lua",
  event = "BufReadPre", -- Load when opening files
  cmd = {
    "ColorizerAttachToBuffer",
    "ColorizerDetachFromBuffer",
    "ColorizerReloadAllBuffers",
    "ColorizerToggle",
  },
  opts = {
    filetypes = { "*" }, -- Enable for all filetypes
    user_default_options = {
      RGB = true,      -- #RGB hex codes
      RRGGBB = true,   -- #RRGGBB hex codes
      names = true,    -- "Name" codes like Blue
      RRGGBBAA = true, -- #RRGGBBAA hex codes
      rgb_fn = true,   -- CSS rgb() and rgba() functions
      hsl_fn = true,   -- CSS hsl() and hsla() functions
      css = true,      -- Enable all CSS features
      css_fn = true,   -- Enable all CSS *functions*
      mode = "background", -- Set the display mode (foreground/background/virtualtext)
    },
  },
}
