vim.loader.enable()
-- Add user directory to Lua package path
vim.opt.runtimepath:append(vim.fn.stdpath("config"))

-- Add the user directory to the Lua package path
local config_path = vim.fn.stdpath("config")
package.path = package.path .. ";" .. config_path .. "/?.lua"
package.path = package.path .. ";" .. config_path .. "/?/init.lua"
