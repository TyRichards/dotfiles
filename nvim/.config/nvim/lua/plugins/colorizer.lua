return {
  -- Included in LazyExtras Tailwind Plugin
  -- hrsh7th/nvim-cmp (Nvim Completion)
  -- roobert/tailwindcss-colorizer-cmp.nvim

  -- Color Highlighting in Files (like HTML/CSS/Tailwind)
  {
    "catgoose/nvim-colorizer.lua", -- Formerly NvChad/nvim-colorizer.lua
    opts = {
      user_default_options = {
        tailwind = true,
      },
    },
  },
}
