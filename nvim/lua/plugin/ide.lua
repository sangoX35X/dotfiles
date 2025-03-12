return {
	-- DAP
	{
		{
			'mfussenegger/nvim-dap',
			event = 'VeryLazy',
		},
		{
			'rcarriga/nvim-dap-ui',
			event = 'VeryLazy',
			dependencies = {
				'mfussenegger/nvim-dap',
			},
		},
	},
}
