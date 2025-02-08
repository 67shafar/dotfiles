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
  -- Common Libs
  { 'nvim-lua/plenary.nvim', tag = 'v0.1.4' },

  -- Themes
	{ 'Mofiqul/vscode.nvim', lazy = false },

  -- Telescope
	{
    'nvim-telescope/telescope.nvim', tag = '0.1.8',
    dependencies = { 'nvim-lua/plenary.nvim', tag = 'v0.1.4' },
    lazy = false
  },

  -- Highlighting Support
	{
    'nvim-treesitter/nvim-treesitter',
    build = ":TSUpdate",
    config = function() require("nvim-treesitter.configs").setup {
        ensure_installed = {
          "markdown", "markdown_inline", "mermaid",
          "toml", "yaml", "typescript", "python",
          "java", "bash", "lua", "rust", "kotlin"
        },
        highlight = { enable = true, }
    } end
  },
  { 'VonHeikemen/lsp-zero.nvim', branch = 'v4.x' },

  -- Git support
	{ 'lewis6991/gitsigns.nvim', config = {} },

  -- Package dependencies installer
	{ 'williamboman/mason.nvim', config = {} },
  { 'williamboman/mason-lspconfig.nvim'  },
  {
    'mfussenegger/nvim-lint',
    'rshkarin/mason-nvim-lint',
  },

  -- Code Completion Support

  {	'neovim/nvim-lspconfig' },
	{	'hrsh7th/cmp-nvim-lsp' },
	{	'hrsh7th/nvim-cmp' },

  -- Editor Features
  {
    'nvim-lualine/lualine.nvim',
    dependencies = { 'nvim-tree/nvim-web-devicons', opt = true }
  },
  { 'akinsho/toggleterm.nvim', config = { direction = 'float' } },
  { 'nvim-tree/nvim-tree.lua' },
  { 'romgrk/barbar.nvim' },
  { 'windwp/nvim-autopairs', event = "InsertEnter", config = true },
  { 'numToStr/Comment.nvim' },
  { 'Shatur/neovim-session-manager' },
  { 'ggandor/leap.nvim' },
	{	'mbbill/undotree' },

  -- LLM Features
  { 'jackMort/ChatGPT.nvim', event = "VeryLazy",
    dependencies = { "MunifTanjim/nui.nvim", "folke/trouble.nvim" },
    config = function()
      require("chatgpt").setup({
        api_key_cmd = "op read op://private/OpenAI-SF-Personal/credential --no-newline",
        openai_params={
          model = "gpt-4o-mini",
          max_tokens = 128000,
        },
        openai_edit_params = {
          model = "gpt-4o-mini",
          frequency_penalty = 0,
          presence_penalty = 0,
          max_tokens=128000,
          temperature = 0,
          top_p = 1,
          n = 1,
        },
      })
    end
  },
},{})

--- Start LSP And Code Configuration ---
local lsp_zero = require('lsp-zero')
lsp_zero.extend_lspconfig({
  sign_text = true,
  lsp_attach = function(_, bufnr)
    lsp_zero.default_keymaps({buffer = bufnr})
  end,
  capabilities = require('cmp_nvim_lsp').default_capabilities(),
})
require('mason-lspconfig').setup({
  ensure_installed = {"lua_ls", "pyright"}
})

require('lspconfig').lua_ls.setup({ settings = {
  Lua = { diagnostics = { globals = {"vim"} } }
} })

require('lspconfig').pyright.setup { settings = {
  pyright= { autoImportCompletions = true },
  python = {
    analysis = {
      autoSearchPaths = true,
      diagnosticMode = 'openFilesOnly',
      useLibraryCodeForTypes = true,
      typeCheckingMode = 'strict'
    }
  }
}}

local cmp = require('cmp')
cmp.setup({
  sources = {
    {name = 'nvim_lsp'},
  },
  snippet = {
    expand = function(args)
      -- You need Neovim v0.10 to use vim.snippet
      vim.snippet.expand(args.body)
    end,
  },
  mapping = cmp.mapping.preset.insert({}),
})
--- END LSP & Code Completion ---


require('leap').create_default_mappings()
require('Comment').setup()

vim.treesitter.query.set(
  "python",  -- Language to apply the query to
  "injections",  -- Query type (injections)
  [[
  (string (string_content) @injection.content
   ;; Check if the string contains the `#!bash` marker
   (#match? @injection.content "^#!/bin/bash(.*)")
   (#set! injection.language "bash"))
  ]]
)
----------- END: PLUGIN SETTINGS  ---------------


------------ START: THEME SETTINGS  ------------
require('vscode').setup({ italic_comments = true, })
require('vscode').load()
require('lualine').setup({ options = { theme = 'vscode', }, })
require('nvim-tree').setup({})
require('barbar').setup({sidebar_filetypes = { NvimTree = true, undotree = true } })
----------- END: THEME SETTINGS  --------------


------------ START: EDITOR SETTINGS ------------
vim.opt.mouse = "a"
vim.opt.tabstop = 2
vim.opt.shiftwidth = 2
vim.opt.expandtab = true
vim.opt.termguicolors = true
vim.opt.nu = true
vim.opt.relativenumber = true
vim.opt.spelllang = 'en_us'
vim.opt.spell = false
vim.opt.timeoutlen=400
vim.opt.textwidth=150
vim.opt.colorcolumn='80'
vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1
vim.cmd("set guifont=JetBrainsMono\\ Nerd\\ NFM:h10")
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
vim.keymap.set({"i","n","v","t"}, "<leader>a", vim.lsp.buf.code_action)
vim.keymap.set({"i","n","v","t"}, "<leader>gd", vim.lsp.buf.definition)
vim.keymap.set({"i","n","v","t"}, "<leader>b", "<Cmd>bn<CR>")
vim.keymap.set({"v"}, "<leader>r", "y:%s/<C-r>\"//g<left><left>")
-- Save buffer contents
vim.keymap.set("n", "<D-s>", ":w<CR>")
vim.keymap.set("n", "<C-s>", ":w<CR>")
vim.keymap.set("i", "<D-s>", "<ESC>:w<CR>a")
vim.keymap.set("i", "<C-s>", "<ESC>:w<CR>a")

-- Close Buffer
vim.keymap.set("n", "<leader>q", ":bd<CR>")

-- Disable arrow keys
vim.keymap.set({ "", "i" }, "<up>", "<nop>")
vim.keymap.set({ "", "i" }, "<down>", "<nop>")
vim.keymap.set({ "", "i" }, "<right>", "<nop>")
------------ END:  KEY REMAPPING-------------
