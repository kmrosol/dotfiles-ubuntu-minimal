local metals = require("metals")
local metals_config = metals.bare_config()

metals_config.settings = {
  showImplicitArguments = true, -- 暗黙パラメータの表示
  showInferredType = true,      -- 推論型の表示
}

-- nvim-cmp を使う場合
metals_config.capabilities = require("cmp_nvim_lsp").default_capabilities()

-- Scala のファイルタイプに自動アタッチ
vim.api.nvim_create_autocmd("FileType", {
  pattern = { "scala", "sbt" },
  callback = function()
    metals.initialize_or_attach(metals_config)
  end,
})
