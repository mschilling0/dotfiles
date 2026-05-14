-- nvim/.config/nvim/lua/plugins/lsp.lua

vim.api.nvim_create_autocmd("LspAttach", {
  desc = "LSP actions",
  callback = function(event)
    local opts = { buffer = event.buf }

    -- Note: K is mapped to vim.lsp.buf.hover() by default in Nvim 0.10+
    vim.keymap.set("n", "gd", vim.lsp.buf.definition, opts)
    vim.keymap.set("n", "gD", vim.lsp.buf.declaration, opts)
    vim.keymap.set("n", "gi", vim.lsp.buf.implementation, opts)
    vim.keymap.set("n", "go", vim.lsp.buf.type_definition, opts)
    vim.keymap.set("n", "gr", vim.lsp.buf.references, opts)
    vim.keymap.set("n", "gs", vim.lsp.buf.signature_help, opts)
    vim.keymap.set("n", "<F2>", vim.lsp.buf.rename, opts)
    vim.keymap.set({ "n", "x" }, "<F3>", function()
      vim.lsp.buf.format({ async = true })
    end, opts)
    vim.keymap.set("n", "<F4>", vim.lsp.buf.code_action, opts)
  end,
})

require("mason").setup({})

local lsp_capabilities = require("cmp_nvim_lsp").default_capabilities()

local servers = {
  clangd = {
    cmd = {
      "clangd",
      "--background-index",
      "--clang-tidy",
      "--fallback-style=Google",
      "--completion-style=bundled",
      "--cross-file-rename",
    },
    filetypes = { "c", "cpp" }
  },
  lua_ls = {
    cmd = { "lua-language-server" },
    filetypes = { "lua" },
  },
  pyright = {
    cmd = { "pyright-python-langserver", "--stdio" },
    filetypes = { "python" },
  },
}

for server, config in pairs(servers) do
  local binary = config.cmd[1]
  if vim.fn.executable(binary) == 1 then
    config.capabilities = lsp_capabilities
    vim.lsp.enable(server)
    vim.lsp.config(server, config)
  end
end
