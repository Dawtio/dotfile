require("conform").setup({
	formatters_by_ft = {
		lua = { "stylua" },
		xml = { "xmllint" },
	},
	format_on_save = {
		-- These options will be apssed to conform.format()
		timeout_ms = 500,
		lsp_format = "fallback",
	},
})

--- Configure XML formatter
require("conform").formatters.xmllint = {
	prepend_args = { "--format" },
}
