return {
	"echasnovski/mini.pairs",
	event = "VeryLazy",
	opts = {
		modes = { insert = true, command = true, terminal = false },
		-- skip autopair when next character is one of these
		skip_next = [=[[%w%%%'%[%"%.%`%$]]=],
		-- skip autopair when the cursor is inside these treesitter nodes
		skip_ts = { "string" },
		-- skip autopair when next character is closing pair
		-- and there are more closing pairs than opening pairs
		skip_unbalanced = true,
		-- better deal with markdown code blocks
		markdown = true,
	},
	--- test if $HOME changed
	config = function(_, opts)
		LazyVim.mini.pairs(opts)
		vim.api.nvim_create_autocmd("FileType", {
			pattern = "python",
			callback = function(args)
				vim.keymap.del("i", '"', { buffer = args.buf })
			end,
		})
	end,
}
