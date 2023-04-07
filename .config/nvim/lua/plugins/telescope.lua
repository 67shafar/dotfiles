return   {
  'nvim-telescope/telescope.nvim',
  dependencies = {
    { 'nvim-telescope/telescope-fzf-native.nvim', build = 'make' },
    { 'molecule-man/telescope-menufacture' },
    { 'nvim-lua/plenary.nvim' }
  },
  cmd = 'Telescope'
}
