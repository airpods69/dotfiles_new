local set = vim.opt

set.tabstop=4
set.softtabstop=4
set.shiftwidth=4


set.nu = true
set.relativenumber = true

set.smartindent = true
set.wrap = false

set.swapfile = false
set.backup = false
set.undodir = os.getenv('HOME') .. "/.vim/undodir/"
set.undofile = true

set.hlsearch = false
set.incsearch = true

set.termguicolors = true

set.scrolloff = 8
set.signcolumn = "yes"

set.updatetime = 50

-- Status line -- 
local fn, cmd = vim.fn, vim.cmd

function my_statusline()
  local branch = fn.FugitiveHead()

  if branch and #branch > 0 then
    branch = '  '..branch
  end

  return branch..' %f%m%=%l:%c'
end

cmd[[ set statusline=%!luaeval('my_statusline()') ]]
