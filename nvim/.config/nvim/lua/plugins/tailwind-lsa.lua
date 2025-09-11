-- Custom LSP Config

-- Tailwind for Ruby on Rails Projects
-- Recognizes Rails Projects for Tailwind LSP root detection and adds to default root detection
return {
  "neovim/nvim-lspconfig",
  opts = {
    servers = {
      tailwindcss = {
        root_dir = require("lspconfig.util").root_pattern(
          "app/assets/tailwind", -- Custom Rails Detetction
          "tailwind.config.js", -- Default Root Detection
          "tailwind.config.cjs",
          "tailwind.config.mjs",
          "tailwind.config.ts",
          "postcss.config.js",
          "postcss.config.cjs",
          "postcss.config.mjs",
          "postcss.config.ts"
        ),
        filetypes = { "html.erb", "erb", "html", "css", "javascript", "typescript" }, -- Include ERB
        settings = {
          tailwindCSS = {
            includeLanguages = { erb = "html" }, -- Map ERB to HTML for IntelliSense
          },
        },
      },
    },
  },
}

-- Reddit Suggestion, loads only these LSPs
-- return {
--   "neovim/nvim-lspconfig",
--   config = function()
--     vim.lsp.config("*", {})
--     vim.lsp.enable({
--       "tailwind",
--       "ruby_lsp",
--       "rubocop",
--     })
--   end,
-- }

-- AI Suggestion
-- -- return {
--   "williamboman/mason-lspconfig.nvim",
--   dependencies = { "williamboman/mason.nvim" },
--
--   -- Tailwind
--   config = function()
--     require("mason-lspconfig").setup({
--       ensure_installed = { "tailwindcss" }, -- Ensure Tailwind LSP is managed
--     })
--     local lspconfig = require("lspconfig")
--     lspconfig.tailwindcss.setup({
--       filetypes = { "html", "erb", "css", "javascript", "typescript", "javascriptreact", "typescriptreact" },
--       init_options = { userLanguages = { erb = "html" } }, -- Support ERB as HTML
--       root_dir = lspconfig.util.root_pattern("tailwind.config.js", "tailwind.config.ts", "package.json", ".git"), -- Detect project root
--     })
--   end,
-- }
