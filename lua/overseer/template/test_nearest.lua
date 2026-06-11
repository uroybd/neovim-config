local test_config = require("overseer.template.test_config")

return {
	name = "TestNearest",
	builder = function()
		local filetype = vim.bo.filetype
		local spec = test_config.specs[filetype]

		if not spec then
			vim.notify("TestNearest: Unsupported file type: " .. filetype, vim.log.levels.WARN)
			return nil
		end

		local test_name = test_config.find_nearest_test(filetype)

		if not test_name then
			vim.notify("TestNearest: No test function found", vim.log.levels.WARN)
			return nil
		end

		local filename = vim.fn.expand("%:p")
		local task = spec.build_nearest(test_name, filename)

		task.cwd = vim.fn.getcwd()
		task.components = { "default" }

		return task
	end,
	condition = {
		filetype = test_config.get_supported_filetypes(),
	},
}
