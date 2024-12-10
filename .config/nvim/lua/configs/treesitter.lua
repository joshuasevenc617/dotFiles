local options = {
  ensure_installed = {
    "bash",
    "c",
    "cmake",
    "cpp",
    "css",
    "html",
    "javascript",
    "lua",
    "luadoc",
    "make",
    "markdown",
    "printf",
    "python",
    "toml",
    "typescript",
    "vim",
    "vimdoc",
    "yaml",
  },

  highlight = {
    enable = true,
    use_languagetree = true,
  },

  indent = { enable = true },
}

require("nvim-treesitter.configs").setup(options)
