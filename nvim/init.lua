vim.g.mapleader = ","
vim.g.maplocalleader = ","

local init_file = debug.getinfo(1, "S").source:sub(2)
local config_dir = vim.fn.fnamemodify(init_file, ":p:h")
vim.g.my_nvim_config_dir = config_dir
vim.env.MY_NVIM_CONFIG_DIR = config_dir
vim.opt.rtp:prepend(config_dir)

require("config.options")
require("config.autocmds")
require("config.keymaps")
require("config.lazy")
