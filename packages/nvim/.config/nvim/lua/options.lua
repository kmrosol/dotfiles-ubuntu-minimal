-- ============================================================================
-- Neovim Options Configuration
-- ============================================================================

-- Shell Configuration
local shell_opts = {
  shell = '/bin/zsh',
}

-- Indentation and Formatting
local indent_opts = {
  shiftwidth = 2,
  tabstop = 2,
  expandtab = true,
  autoindent = true,
  textwidth = 0,
}

-- UI and Display
local ui_opts = {
  conceallevel = 0,
  number = true,
  mouse = '',
}

-- Search Configuration
local search_opts = {
  ignorecase = true,
  smartcase = true,
  hlsearch = true,
}

-- Apply all options
local function apply_options(opts_table)
  for k, v in pairs(opts_table) do
    vim.opt[k] = v
  end
end

apply_options(shell_opts)
apply_options(indent_opts)
apply_options(ui_opts)
apply_options(search_opts)

-- Global variables
vim.g.vim_json_syntax_conceal = 0


-- SSH経由かどうかを判定する関数
local function is_ssh_session()
  -- 環境変数でまず確認
  local ssh_conn = os.getenv("SSH_CONNECTION")
  if not ssh_conn or ssh_conn == "" then
    return false
  end

  -- 親プロセスをたどって "sshd" がいるか確認（再帰版）
  local function check_parent_process(pid)
    if not pid or pid == "1" then
      return false
    end

    local handle = io.popen(string.format("ps -o ppid=,comm= -p %s", pid))
    local output = handle:read("*a")
    handle:close()

    local ppid, comm = output:match("(%d+)%s+(%S+)")
    if not ppid then
      return false
    end

    if comm == "sshd" then
      return true -- SSH経由
    end

    return check_parent_process(ppid) -- 再帰的に親プロセスを確認
  end

  -- 現在のプロセスIDから開始
  local pid = tostring(os.getpid and os.getpid() or io.popen("echo $$"):read("*n"))
  return check_parent_process(pid)
end

-- -- 実行例
-- if is_ssh_session() then
--   print("SSH経由で接続されています。")
-- else
--   print("ローカルまたはtmux経由です。")
-- end




-- ============================================================================
-- Clipboard Configuration
-- ============================================================================
local function setup_clipboard()
  local function paste()
    return {
      vim.fn.split(vim.fn.system("pbpaste"), "\n"),
      "c",
    }
  end

  if os.getenv("SSH_CONNECTION") then
    -- OSC52 clipboard for remote sessions
    local osc52_copy = require("vim.ui.clipboard.osc52").copy("+")
    vim.g.clipboard = {
      name = "OSC 52",
      copy = {
        ["+"] = osc52_copy,
        ["*"] = osc52_copy,
        [""] = osc52_copy,
      },
      paste = {
        ["+"] = paste,
        ["*"] = paste,
        [""] = paste,
      },
    }
  end

  vim.opt.clipboard = "unnamedplus"
end

setup_clipboard()
