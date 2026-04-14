-------------------------------------------------------------------------------
-- Options (ported from your vimrc)
-------------------------------------------------------------------------------
local opt = vim.opt
local g = vim.g

opt.tabstop = 4
opt.shiftwidth = 4
opt.smarttab = true
opt.expandtab = true
opt.softtabstop = 4
opt.autoindent = true

opt.background = "dark"
opt.incsearch = true
opt.hlsearch = true
opt.paste = true
opt.cursorline = true

opt.mouse = "a"
opt.number = true
opt.termguicolors = true

vim.cmd("filetype plugin indent on")
vim.cmd("syntax on")

-- ctags support (ported)
opt.tags = "./.tags;,.tags;"
g.autotagTagsFile = ".tags"

-- statusline / timing / font (ported)
opt.laststatus = 2
opt.ttimeoutlen = 50
opt.guifont = "Source Code Pro for Powerline"

-------------------------------------------------------------------------------
-- Bootstrap lazy.nvim
-------------------------------------------------------------------------------
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
local uv = vim.uv or vim.loop
if not uv.fs_stat(lazypath) then
  vim.fn.system({
    "git",
    "clone",
    "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    lazypath,
  })
end
opt.rtp:prepend(lazypath)

-------------------------------------------------------------------------------
-- Plugins (ONLY: mountain, lsp, nerdtree, telescope, lualine)
-------------------------------------------------------------------------------
require("lazy").setup({
  -- Mountain colorscheme
  {
    "mountain-theme/vim",
    name = "mountain",
    lazy = false,
    priority = 1000,
    config = function()
      vim.cmd("colorscheme mountain")
    end,
  },

  -- LSP
  { "neovim/nvim-lspconfig" },

  -- NERDTree
  { "preservim/nerdtree" },

  -- Telescope
  { "nvim-lua/plenary.nvim" },
  { "nvim-telescope/telescope.nvim", dependencies = { "nvim-lua/plenary.nvim" } },

  -- Lualine (no devicons to keep plugin list minimal)
  {
    "nvim-lualine/lualine.nvim",
    config = function()
      require("lualine").setup({
        options = {
          --theme = "mountain",
          icons_enabled = false,
          globalstatus = false, -- keep laststatus=2 behavior
        },
      })
    end,
  },
})

-------------------------------------------------------------------------------
-- LSP setup (minimal; only starts servers that exist on PATH)
-------------------------------------------------------------------------------
do
  local ok, lspconfig = pcall(require, "lspconfig")
  if ok then
    local function setup_if_exists(server, cfg)
      local cmd = (cfg and cfg.cmd and cfg.cmd[1]) or server
      if vim.fn.executable(cmd) == 1 then
        lspconfig[server].setup(cfg or {})
      end
    end

    setup_if_exists("gopls", {})
    setup_if_exists("pyright", {})

    setup_if_exists("lua_ls", {
      settings = {
        Lua = {
          diagnostics = { globals = { "vim" } },
          workspace = { library = vim.api.nvim_get_runtime_file("", true), checkThirdParty = false },
          telemetry = { enable = false },
        },
      },
    })

    vim.diagnostic.config({ virtual_text = true })
  end
end

-------------------------------------------------------------------------------
-- NERDTree behavior (ported from your vimrc)
-------------------------------------------------------------------------------
vim.api.nvim_create_autocmd("StdinReadPre", {
  callback = function()
    vim.g._stdin_read = 1
  end,
})

vim.api.nvim_create_autocmd("VimEnter", {
  callback = function()
    if vim.fn.argc() == 0 and vim.g._stdin_read == nil then
      vim.cmd("NERDTree")
    end
  end,
})

vim.api.nvim_create_autocmd("FileType", {
  pattern = "nerdtree",
  callback = function(ev)
    vim.keymap.set("n", "d<CR>", "<CR>:NERDTreeToggle<CR>", { buffer = ev.buf, silent = true })
  end,
})

vim.api.nvim_create_autocmd("BufEnter", {
  callback = function()
    if vim.fn.winnr("$") == 1 and vim.b.NERDTree and vim.b.NERDTree.isTabTree() then
      vim.cmd("quit")
    end
  end,
})

