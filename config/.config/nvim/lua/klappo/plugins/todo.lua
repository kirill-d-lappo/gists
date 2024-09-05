local pattern = [[.*<(KEYWORDS)(:| \[.+\])]]
local opts =  {
		    signs = true,
				merge_keywords = true,
				search = {
					-- rimgrep regex - search in file
					pattern = [[\b(KEYWORDS)(:|\s\[.+\])]],
				},
				highlight = {
					-- vimgrep regex - for a vim highlight only
					pattern = [[.*<((KEYWORDS)%(\s\[.{-1,}\]|:))]],
				},
		    keywords = {
    			FIX = {
		    		color = "warning",
				    alt = { "FIX", "FixMe", "FIXME"},
			    },
			    TODO = {
				    color = "info",
				    alt = { "TODO", "Todo", "ToDo", }
    			},
					HACK = {
						color = "warning",
						alt = { "Bug", "BUG" },
					},
		    	NOTE = {
				    color = "info", alt = {"INFO", "NOTE", "Note", "Info"}
    			},
		    },
	  }


return {
	'folke/todo-comments.nvim',
	version = "1.3.0",
	event = {'BufReadPre', 'BufNewfile'},
	dependencies = { 'nvim-lua/plenary.nvim' },
	config = function()
		local todo = require('todo-comments')
		local map = vim.keymap.set


		map('n', ']t', function() todo.jump_next() end, { desc = 'Next todo' })
		map('n', '[t', function() todo.jump_prev() end, { desc = 'Prev todo' })

		todo.setup(opts)

	end
}
