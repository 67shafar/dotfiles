return {
	'nvim-treesitter/nvim-treesitter',
	build = ':TSUpdate',
	event = { "BufReadPost", "BufNewFile" },
  dependencies = {
    {
      "nvim-treesitter/nvim-treesitter-textobjects",
		}
	},
	opts = {
			ensure_installed = { "bash", "regex", "lua", "vim", "typescript", "rust", "python", "javascript", "json", "yaml" },
			auto_install = true,
			-- indent = { enable = false, disable = { "python" } },
			context_commentstring = { enable = true, enable_autocmd = false },
			highlight = {
    		enable = true,
				additional_vim_regex_highlighting = false,
			},
	},
  config = function(_, opts)
    require("nvim-treesitter.configs").setup(opts)
  end,
}
