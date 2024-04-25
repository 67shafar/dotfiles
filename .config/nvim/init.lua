---------- START: PLUGIN MANAGEMENT ------------
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
  vim.fn.system({
    "git",
    "clone",
    "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    "--branch=stable", -- latest stable release
    lazypath,
  })
end
vim.opt.rtp:prepend(lazypath)
------------ END: PLUGIN MANAGEMENT --------------


------------ START: PLUGIN SETTINGS  ------------
require("lazy").setup({
	{ 'Mofiqul/vscode.nvim', lazy = false },
	{ 'nvim-telescope/telescope.nvim', tag = '0.1.3', dependencies = { 'nvim-lua/plenary.nvim', tag = 'v0.1.3' } },
  { 'nvim-telescope/telescope-file-browser.nvim', dependencies = { 'nvim-telescope/telescope.nvim' }, lazy = false },
  { 'nvim-lualine/lualine.nvim', dependencies = { 'nvim-tree/nvim-web-devicons', opt = true } },
	{ 'nvim-treesitter/nvim-treesitter', build = ":TSUpdate", config = function() require("nvim-treesitter.configs").setup {
        ensure_installed = { "markdown", "markdown_inline", "mermaid", "toml", "yaml", "typescript", "python", "java", "bash", "lua", "rust", "kotlin" },
        highlight = { enable = true, }
  } end },
	{	'mbbill/undotree' },
	{ 'lewis6991/gitsigns.nvim' },
  { 'akinsho/toggleterm.nvim', config = true },
	{ 'williamboman/mason.nvim' },
	{ 'williamboman/mason-lspconfig.nvim', 'neovim/nvim-lspconfig' },
  { 'mfussenegger/nvim-lint' },
  { 'rshkarin/mason-nvim-lint' },
  { 'stevearc/conform.nvim', events = { "BufReadPre", "BufNewFile" }, config =
      function() require("conform").setup({ formatters_by_ft = { kotlin = { "ktlint" } }, }) end
  },
  { 'VonHeikemen/lsp-zero.nvim', branch = 'v3.x' },
  {	'neovim/nvim-lspconfig' },
	{	'hrsh7th/cmp-nvim-lsp' },
	{	'hrsh7th/nvim-cmp' },
	{ "iamcco/markdown-preview.nvim", ft={"markdown"}, build = function() vim.fn["mkdp#util#install"]() end, },
  { 'nvim-tree/nvim-tree.lua' },
  { 'romgrk/barbar.nvim' }
},{})

local lsp_zero = require('lsp-zero')
lsp_zero.on_attach(function(_, bufnr) lsp_zero.default_keymaps({buffer = bufnr}) end)

require('mason').setup({})
require('mason-nvim-lint').setup({ ensure_installed = { "ktlint" }, quiet_mode = true })
require('mason-lspconfig').setup({
  ensure_installed = { "lua_ls", "rust_analyzer", "kotlin_language_server" },
  handlers = { lsp_zero.default_setup, },
})
require('lspconfig').lua_ls.setup({ settings = { Lua = { diagnostics = { globals = {"vim"} } } } })
require('toggleterm').setup { direction = 'float' }
----------- END: PLUGIN SETTINGS  ---------------


------------ START: THEME SETTINGS  ------------
require('vscode').setup({ italic_comments = true, })
require('vscode').load()
require('lualine').setup({ options = { theme = 'vscode', }, })
require('nvim-tree').setup({})
require('barbar').setup({sidebar_filetypes = { NvimTree = true, undotree = true } })
----------- END: THEME SETTINGS  --------------


------------ START: EDITOR SETTINGS ------------
vim.opt.mouse = ""
vim.opt.tabstop = 2
vim.opt.shiftwidth = 2
vim.opt.expandtab = true
vim.opt.termguicolors = true
vim.opt.nu = true
vim.opt.relativenumber = true
vim.opt.spelllang = 'en_us'
vim.opt.spell = false
vim.opt.timeoutlen=400
vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1
------------ END: EDITOR SETTINGS --------------


------------ START: KEY REMAPPING -----------
local builtin = require('telescope.builtin')

vim.g.mapleader = ";"
vim.keymap.set({"i","n","v","t"}, "<leader>c", "<Cmd>e ~/.config/nvim/init.lua<CR>")
vim.keymap.set({"i","n","v","t"}, "<leader>f", "<ESC><Cmd>NvimTreeToggle<CR>")
vim.keymap.set({"i","n","v","t"}, "<leader>s", builtin.find_files, {})
vim.keymap.set({"i","n","v","t"}, "<leader>ss", builtin.live_grep, {})
vim.keymap.set({"i","n","v","t"}, "<leader>t", vim.cmd.ToggleTerm)
vim.keymap.set({"i","n","v","t"}, "<leader>u", vim.cmd.UndotreeToggle)
vim.keymap.set({"i","n","v","t"}, "<leader><leader>", "<ESC>", { silent = true })

-- Save buffer contents
vim.keymap.set("n", "<D-s>", ":w<CR>")
vim.keymap.set("n", "<C-s>", ":w<CR>")
vim.keymap.set("i", "<D-s>", "<ESC>:w<CR>a")
vim.keymap.set("i", "<C-s>", "<ESC>:w<CR>a")

-- Disable arrow keys
vim.keymap.set({ "", "i" }, "<up>", "<nop>")
vim.keymap.set({ "", "i" }, "<down>", "<nop>")
vim.keymap.set({ "", "i" }, "<left>", "<nop>")
vim.keymap.set({ "", "i" }, "<right>", "<nop>")
------------ END:  KEY REMAPPING-------------
