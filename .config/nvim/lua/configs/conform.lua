local options = {
  formatters_by_ft = {
    lua = { "stylua" },
    -- css = { "prettier" },
    -- html = { "prettier" },
    c = { "clang-format" },
    cpp = { "clang-format" },
  },

  formatters = {
    ["clang-format"] = {
      prepend_args = {
        "-style={ \
        IndentWidth: 2, \
        TabWidth: 2, \
        UseTab: Never, \
        AccessModifierOffset: 0, \
        IndentAccessModifiers: true, \
        PackConstructorInitializers: Never}",
      },
    },
  },

  format_on_save = {
    -- These options will be passed to conform.format()
    timeout_ms = 500,
    lsp_fallback = true,
  },
}

return options
