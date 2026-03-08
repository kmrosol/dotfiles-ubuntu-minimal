local on_attach = function(client, bufnr)

  local opts = { noremap=true, silent=true, buffer = bufnr }
  local maps = {
    {'n', '<C-k>', vim.diagnostic.goto_prev, opts}, 
    {'n', '<C-j>', vim.diagnostic.goto_next, opts}, 
    -- {"n", "gd", vim.lsp.buf.definition, opts}, 
    {"n", "K", vim.lsp.buf.hover, opts},
    {"n", "<C-m>", vim.lsp.buf.signature_help, opts}, 
    {"n", "gy", vim.lsp.buf.type_definition, opts},
    {"n", "<leader>rn", vim.lsp.buf.rename, opts},
    -- {'n', 'gi', vim.lsp.buf.implementation, opts},
    {"n", "ma", vim.lsp.buf.code_action, opts},
    -- {"n", "gr", vim.lsp.buf.references, opts},
    {"n", "<space>e", vim.diagnostic.open_float, opts},
    -- {"n", "[d", vim.lsp.diagnostic.goto_prev()}, 
    -- {"n", "]d", vim.lsp.diagnostic.goto_next()},
    -- {"n", "er", vim.lsp.diagnostic.show_line_diagnostics()},
    -- {'n', '<leader>do', 'vim.diagnostic.open_float()<CR>'}, 
  }
  for i, v in ipairs(maps) do
    vim.keymap.set(unpack(v))
  end
end

local cpm_nvim_lsp = require("cmp_nvim_lsp").default_capabilities()

require("mason").setup()
require("mason-lspconfig").setup()
require("mason-lspconfig").setup({
  handlers = {
    function (server_name)
      require("lspconfig")[server_name].setup {
        on_attach = on_attach,
        capabilities = cmp_nvim_lsp,
      }
    end,
  }
})

-- Global diagnostic keymaps (fallback)
vim.keymap.set('n', '<C-k>', vim.diagnostic.goto_prev, { noremap = true, silent = true })
vim.keymap.set('n', '<C-j>', vim.diagnostic.goto_next, { noremap = true, silent = true })
vim.keymap.set('n', '<space>e', vim.diagnostic.open_float, { noremap = true, silent = true })

-- Global LSP keymaps (fallback)
vim.keymap.set('n', '<leader>rn', vim.lsp.buf.rename, { noremap = true, silent = true })

-- disable lint for python
require("lspconfig")["pylsp"].setup({
  capabilities = cpm_nvim_lsp,
  settings = {
    pylsp = {
      plugins = {
        pylint = { enabled = "false" },
        pyflakes = { enabled = "false" },
        pycodestyle = { enabled = "false" },
      }
    }
  },
  on_attach = on_attach,
})
