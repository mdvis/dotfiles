local augroup = vim.api.nvim_create_augroup
local autocmd = vim.api.nvim_create_autocmd

local function set_tpl()
  local ft = vim.bo.filetype
  local filename = vim.fn.expand("%:t")
  local date = os.date("%Y-%m-%d")

  local templates = {
    python = {
      "#! /usr/bin/env python3",
      "# -*- coding: utf-8 -*-",
      "'''date: " .. date,
      "'''",
    },
    sh = {
      "# ------",
      "# name: " .. filename,
      "# author: Deve",
      "# date: " .. date,
      "# ------",
    },
    javascript = {
      "/**",
      " * name: " .. filename,
      " * author: Deve",
      " * date: " .. date,
      " */",
    },
    typescript = {
      "/**",
      " * name: " .. filename,
      " * author: Deve",
      " * date: " .. date,
      " */",
    },
    css = {
      "/**",
      " * name: " .. filename,
      " * author: Deve",
      " * date: " .. date,
      " */",
    },
    scss = {
      "/**",
      " * name: " .. filename,
      " * author: Deve",
      " * date: " .. date,
      " */",
    },
    javascriptreact = {
      "/**",
      " * name: " .. filename,
      " * author: Deve",
      " * date: " .. date,
      " */",
    },
    typescriptreact = {
      "/**",
      " * name: " .. filename,
      " * author: Deve",
      " * date: " .. date,
      " */",
    },
    vim = {
      '" ------',
      '" name: ' .. filename,
      '" author: Deve',
      '" date: ' .. date,
      '" ------',
    },
    go = {
      "// ------",
      "// name: " .. filename,
      "// author: Deve",
      "// date: " .. date,
      "// ------",
    },
  }

  local lines = templates[ft]
  if not lines then
    return
  end
  vim.api.nvim_buf_set_lines(0, 0, 0, false, lines)
end

vim.api.nvim_create_user_command("SetTpl", set_tpl, {})

autocmd("BufEnter", {
  group = augroup("tpl", { clear = true }),
  callback = function()
    if vim.fn.line("$") == 1 and vim.fn.getline(1) == "" then
      set_tpl()
    end
  end,
})

autocmd({ "BufRead", "BufNewFile" }, {
  group = augroup("wechat_ft", { clear = true }),
  pattern = "*.wxss",
  callback = function()
    vim.bo.filetype = "css"
  end,
})

autocmd({ "BufRead", "BufNewFile" }, {
  group = "wechat_ft",
  pattern = "*.wxml",
  callback = function()
    vim.bo.filetype = "html"
  end,
})

autocmd("BufReadPost", {
  group = augroup("last_mod_pos", { clear = true }),
  callback = function()
    local line = vim.fn.line([['"]])
    if line > 1 and line <= vim.fn.line("$") then
      vim.cmd([[normal! g'"]])
    end
  end,
})

autocmd({ "FocusGained", "BufEnter" }, {
  group = augroup("checktime", { clear = true }),
  callback = function()
    vim.cmd("checktime")
  end,
})

vim.api.nvim_create_user_command("EConf", function()
  vim.cmd("edit " .. vim.fn.fnameescape(vim.g.my_nvim_config_dir .. "/init.lua"))
end, {})

vim.api.nvim_create_user_command("SConf", function()
  vim.cmd("source " .. vim.fn.fnameescape(vim.g.my_nvim_config_dir .. "/init.lua"))
end, {})
