-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Add any additional keymaps here

-- Custom Keymaps
-- vim.keymap.set("n", "K", vim.lsp.buf.hover, { desc = "Hover documentation" })

-- Bread on Pengiuns Keymaps

-- local function map(m, k, v)
--   vim.keymap.set(m, k, v, { noremap = true, silent = true })
-- end
--
-- -- set leader
-- map("", "<Space>", "<Nop>")
-- vim.g.mapleader = " "
-- vim.g.maplocalleader = " "
--
-- -- buffers
-- map("n", "<leader>q", ":BufferClose<CR>")
-- map("n", "<leader>Q", ":BufferClose!<CR>")
-- map("n", "<leader>vs", ":vsplit<CR>:bnext<CR>") --ver split + open next buffer
