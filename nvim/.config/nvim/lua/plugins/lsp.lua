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

vim.lsp.config("*", {
  capabilities = require("cmp_nvim_lsp").default_capabilities(),
})

local servers = {
  clangd = {
    cmd = {
      "clangd",
      "--fallback-style=Google",
      "--completion-style=bundled",
      "-j=4",
      "--background-index-priority=low",
      "--log=error",
    },
    filetypes = { "c", "cpp", "objc", "objcpp", "cuda" },
    root_markers = {
      { "compile_commands.json", "compile_flags.txt" },
      ".clangd",
      ".git",
    },
  },
  lua_ls = {
    cmd = { "lua-language-server" },
    filetypes = { "lua" },
    root_markers = { ".luarc.json", ".luarc.jsonc", ".stylua.toml", ".git" },
  },
  ty = {
    cmd = { "ty", "server" },
    filetypes = { "python" },
    root_markers = { "ty.toml", "pyproject.toml", "setup.py", "requirements.txt", ".git" },
  },
  markdown_oxide = {
    cmd = { "markdown-oxide" },
    filetypes = { "markdown" },
    root_markers = { ".obsidian", ".moxide.toml", ".git" },
  },
  gh_actions_ls = {
    cmd = { "gh-actions-language-server", "--stdio" },
    filetypes = { "yaml" },
    root_dir = function(bufnr, on_dir)
      local parent = vim.fs.dirname(vim.api.nvim_buf_get_name(bufnr))
      if vim.endswith(parent, "/.github/workflows") then
        on_dir(vim.fs.dirname(vim.fs.dirname(parent)))
      end
    end,
    init_options = {},
  },
}

for server, config in pairs(servers) do
  if vim.fn.executable(config.cmd[1]) == 1 then
    vim.lsp.config(server, config)
    vim.lsp.enable(server)
  end
end
