local M = {
"lukas-reineke/indent-blankline.nvim",
    main = "ibl"
}

local highlight = {
    "RainbowRed",
    "RainbowYellow",
    "RainbowBlue",
    "RainbowOrange",
    "RainbowGreen",
    "RainbowViolet",
    "RainbowCyan",
}

function M.config()
  require("ibl").setup {
   -- indent = { highlight = highlight },
    scope = { enabled = true, highlight = highlight }
  }
end

return M
