-- Bootstrap plugins
require('bootstrap')

require('languages')

-- Force lazy plugins to load on start up
require('vscode').load('dark')

-- Apply Settings
require('keymaps')
require('options')
