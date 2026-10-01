-- Install everything the nvim config would otherwise install in the
-- background the first time nvim is opened: plugins, Mason packages (LSP
-- servers, formatters, linters) and treesitter parsers. Run it after
-- setup.sh has linked the config:
--
--   nvim --headless -c 'luafile install_nvim_plugins.lua'
--
-- Exits non-zero if anything failed to install.

local TIMEOUT = 20 * 60 * 1000

local function log(msg)
  io.stdout:write(msg .. "\n")
end

local function wait_for_mason(mr)
  -- Mason starts installs from registry refresh callbacks. This callback is
  -- registered after the ones from LazyVim and mason-lspconfig, so once it
  -- has run every install they wanted has been started.
  local refreshed = false
  mr.refresh(function()
    refreshed = true
  end)
  vim.wait(TIMEOUT, function()
    return refreshed
  end, 200)

  local function installing()
    return vim.tbl_filter(function(pkg)
      return pkg:is_installing()
    end, mr.get_all_packages())
  end
  log("Waiting for " .. #installing() .. " Mason packages to install")
  return vim.wait(TIMEOUT, function()
    return #installing() == 0
  end, 1000)
end

local function main()
  local failed = {}
  local lazy = require("lazy")

  log("Syncing plugins")
  lazy.sync({ wait = true, show = false })

  -- Requiring the registry makes lazy.nvim load mason.nvim, whose LazyVim
  -- config starts installing the formatters, linters and tree-sitter CLI.
  -- It only does so after an asynchronous registry refresh, so no install
  -- can have failed before this handler is registered.
  local mr = require("mason-registry")
  mr:on("package:install:failed", function(pkg)
    failed[#failed + 1] = "mason: " .. pkg.name
  end)

  -- LazyVim only loads the LSP config once a file is opened, which never
  -- happens in a headless run. Loading it passes the list of LSP servers to
  -- mason-lspconfig, but mason-lspconfig deliberately skips installing them
  -- when nvim is headless, so start those installs here.
  lazy.load({ plugins = { "nvim-lspconfig" } })
  mr.refresh(function()
    require("mason-lspconfig.features.ensure_installed")()
  end)

  if not wait_for_mason(mr) then
    failed[#failed + 1] = "mason: timed out"
  end
  log("Mason packages installed: " .. #mr.get_installed_package_names())

  -- Parsers are compiled with the tree-sitter CLI that Mason just installed,
  -- which is why this has to come after the Mason installs. If LazyVim's own
  -- config is still installing some of them, nvim-treesitter waits for that
  -- instead of starting a second install of the same parser.
  lazy.load({ plugins = { "nvim-treesitter" } })
  local langs = LazyVim.opts("nvim-treesitter").ensure_installed or {}
  log("Installing " .. #langs .. " treesitter parsers")
  local ts = require("nvim-treesitter")
  local ok, err = ts.install(langs):pwait(TIMEOUT)
  if not ok then
    failed[#failed + 1] = "treesitter: " .. tostring(err)
  end
  local installed = ts.get_installed()
  for _, lang in ipairs(langs) do
    if not vim.tbl_contains(installed, lang) then
      failed[#failed + 1] = "treesitter: " .. lang
    end
  end
  log("Treesitter parsers installed: " .. #installed)

  return failed
end

local ok, result = xpcall(main, debug.traceback)
if not ok then
  result = { result }
end
for _, msg in ipairs(result) do
  log("FAILED " .. msg)
end
-- Always exit explicitly: a headless nvim that hits an error would otherwise
-- sit there forever waiting for input.
vim.cmd(#result > 0 and "cquit 1" or "qall!")
