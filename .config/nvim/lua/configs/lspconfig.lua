-- load defaults i.e lua_lsp
require("nvchad.configs.lspconfig").defaults()

local lspconfig = require("lspconfig")

-- List of all servers configured.
lspconfig.servers = {
  "ts_ls",
  "clangd",
  "nil_ls",
  "lua_ls",
  "pyright",
  "sqlls",
}

-- EXAMPLE
local default_servers = { "html", "cssls", "nil_ls" }
local nvlsp = require("nvchad.configs.lspconfig")

-- lsps with default config
for _, lsp in ipairs(default_servers) do
  lspconfig[lsp].setup({
    on_attach = nvlsp.on_attach,
    on_init = nvlsp.on_init,
    capabilities = nvlsp.capabilities,
  })
end

-- configuring single server, example: typescript
lspconfig.ts_ls.setup({
  on_attach = nvlsp.on_attach,
  on_init = nvlsp.on_init,
  capabilities = nvlsp.capabilities,
})

-- configuring python server, including virtual environment
lspconfig.pyright.setup({
  on_attach = nvlsp.on_attach,
  on_init = nvlsp.on_init,
  capabilities = nvlsp.capabilities,
  before_init = function(_, config)
    -- Get the current pyenv Python path
    local pyenv_python = vim.fn.trim(vim.fn.system("pyenv which python"))

    if pyenv_python ~= "" then
      config.settings = {
        python = {
          analysis = {
            autoSearchPaths = true,
            useLibraryCodeForTypes = true,
            diagnosticMode = "workspace",
            typeCheckingMode = "basic",
          },
          pythonPath = pyenv_python,
        },
      }
    end
  end,
})

lspconfig.clangd.setup({
  on_attach = function(client, bufnr)
    client.server_capabilities.documentFormattingProvider = false
    client.server_capabilities.documentRangeFormattingProvider = false
    nvlsp.on_attach(client, bufnr)
  end,
  on_init = nvlsp.on_init,
  capabilities = nvlsp.capabilities,
})
