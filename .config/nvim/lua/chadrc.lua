-- This file needs to have same structure as nvconfig.lua 
-- https://github.com/NvChad/ui/blob/v3.0/lua/nvconfig.lua
-- Please read that file to know all available options :( 

---@type ChadrcConfig
local M = {}

M.base46 = {
	theme = "catppuccin",
  transparency = true,

	hl_override = {
		Comment = { italic = true },
		["@comment"] = { italic = true },
	},
  hl_override = {
    ["@comment"] = { italic = true },
    Type = { italic = true },
    AlphaHeader = { fg = "blue" },
    CursorLine = {
      bg = "black2",
    },
    Comment = {
      italic = true,
    },
    Define = { italic = true },
    eliixirString = { italic = true },
    Include = { italic = true },
    TSVariable = { italic = true },
    Variable = { italic = true },
    Function = { italic = true },
    Keyword = { italic = true },
    TSKeyword = { italic = true },
    TSMethod = { italic = true },
    TSDefine = { italic = true },
    SpecialComment = { italic = true },
    Statement = { italic = true },
  },
}

M.nvdash = {
  load_on_startup = true
}

return M
