vim.opt.termguicolors = true
vim.opt.mouse = "a"
-- vim.opt.guioptions = ""
vim.opt.hidden = true
vim.opt.clipboard = "unnamed"
vim.opt.viewoptions = "folds,options,cursor,unix,slash"

vim.opt.shortmess:append("a")
vim.opt.cursorline = true
vim.opt.cursorcolumn = true
vim.opt.textwidth = 80
vim.opt.colorcolumn = "80"
vim.opt.list = true
vim.opt.listchars = { tab = ">-", trail = "-" }
vim.opt.showtabline = 2
vim.opt.laststatus = 2

vim.opt.errorbells = false
vim.opt.visualbell = true
vim.opt.showcmd = true
vim.opt.expandtab = true
vim.opt.tabstop = 4
vim.opt.shiftwidth = 4
vim.opt.softtabstop = 4
vim.opt.whichwrap = "b,s,<,>,[,]"
vim.opt.backspace = "indent,eol,start"
vim.opt.formatoptions = "tqmM"
-- vim.opt.foldmethod = "indent"
-- vim.opt.foldenable = false
vim.opt.splitbelow = true
vim.opt.splitright = true
vim.opt.autoindent = true
vim.opt.ignorecase = true
vim.opt.smartcase = true
vim.opt.showmatch = true
vim.opt.incsearch = true
-- vim.opt.autochdir = true
vim.opt.autoread = true
vim.opt.hlsearch = true
vim.opt.wrap = false
vim.opt.number = true
vim.opt.sidescrolloff = 4
vim.opt.scrolljump = 2
vim.opt.scrolloff = 2
vim.opt.cmdheight = 2
vim.opt.wildmenu = true
vim.opt.wildmode = { "list:longest", "full" }

vim.opt.encoding = "utf-8"
vim.opt.fileencoding = "utf-8"
vim.opt.fileencodings = { "utf-8", "ucs-bom", "utf-16le", "cp1252", "iso-8859-15" }
vim.opt.fileformats = { "mac", "unix", "dos" }

vim.opt.backup = true
vim.opt.swapfile = true
vim.opt.updatetime = 2000
vim.opt.updatecount = 100
vim.opt.writebackup = true
vim.opt.undofile = true

-- 创建备份目录（如果不存在）
local function ensure_dir(path)
    if vim.fn.isdirectory(path) == 0 then
        vim.fn.mkdir(path, "p")
    end
end

if vim.fn.has("win32") == 1 or vim.fn.has("win64") == 1 then
    vim.opt.backupdir = "c:\\backup\\\\"
    vim.opt.directory = "c:\\swp\\\\"
    vim.opt.undodir = "c:\\undo\\\\"
else
    local backup_dir = vim.fn.expand("~/.backup//")
    local swp_dir = vim.fn.expand("~/.swp//")
    local undo_dir = vim.fn.expand("~/.undo//")

    ensure_dir(backup_dir)
    ensure_dir(swp_dir)
    ensure_dir(undo_dir)

    vim.opt.backupdir = backup_dir
    vim.opt.directory = swp_dir
    vim.opt.undodir = undo_dir
end

vim.opt.background = "dark"

vim.api.nvim_set_hl(0, "ColorColumn", { ctermbg = 96 })

-- Compatibility shim for deprecated vim.lsp.buf_get_clients()
-- This suppresses deprecation warnings from plugins that haven't updated yet
if vim.lsp.buf_get_clients == nil then
    ---@diagnostic disable-next-line: duplicate-set-field
    vim.lsp.buf_get_clients = function(bufnr)
        return vim.lsp.get_clients({ bufnr = bufnr })
    end
end
