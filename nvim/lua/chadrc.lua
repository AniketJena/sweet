-- This file needs to have same structure as nvconfig.lua 
-- https://github.com/NvChad/ui/blob/v2.5/lua/nvconfig.lua
-- Please read that file to know all available options :( 

---@type ChadrcConfig
local M = {}

M.base46 = {
  theme = "yoru",
  -- transparency = true,
  theme_toggle = { "yoru", "falcon" },

	hl_override = {
		Comment = { italic = true },
		["@comment"] = { italic = true },
	},
}

M.ui = {
  nvdash = {
    load_on_startup = true;
    buttons = {
        { " Find File", "Spc f f", "Telescope find_files" },
        { "󰈚  Recent Files", "Spc f o", "Telescope oldfiles" },
        { "󰈭  Find Word", "Spc f w", "Telescope live_grep" },
        { "  Bookmarks", "Spc m a", "Telescope marks" },
        { "  Themes", "Spc t h", "Telescope themes" },
        { "  Mappings", "Spc c h", "NvCheatsheet" },
      },
    header = {
      "     _,-ddd888888bbb-._      ",
      "   d88888888888888888888b    ",
      " d888888888888888888888888b  ",
      "6888888888888888888888888889 ",
      "68888b8''8q8888888p8''8d88889",
      "`d8887     p88888q     4888b'",
      " `d8887    p88888q    4888b' ",
      "   `d887   p88888q   488b'   ",
      "     `d8bod8888888dob8b'     ",
      "       `d88888888888d'       ",
      "         `d8888888b'         ",
      "           `d8888b'          ",
      "             `bd'            ",
    }
  }
}

M.lsp = {
  signature = true
}

M.cheatsheet = {
  theme = "grid",
}

return M
