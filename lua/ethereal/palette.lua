local config = require("ethereal.config")
local utils = require("ethereal.utils")

local palette = {
	black = "#00001a",
	bg0 = "#0d1116",
	bg1 = "#02040a",
	bg2 = "#33334d",
	bg3 = "#353955",
	bg4 = "#4A5067",
	bg5 = "#282c44",
	bg_red = "#da5981",
	bg_green = "#83ae74",
	bg_blue = "#8aa6ea",
	diff_red = "#4d1a4d",
	diff_green = "#1a4d4d",
	diff_blue = "#1a3380",
	diff_add = "#1a3366",
	diff_change = "#262b4d",
	diff_delete = "#661b4d",
	diff_text = "#4d4d84",
	fg = "#8b93c8",
	red = "#d95880",
	orange = "#e18056",
	yellow = "#c2915a",
	green = "#638bf0",
	blue = "#8c8eff",
	cyan = "#229297",
	purple = "#b384ff",
	grey = "#353b52",
	none = "NONE",
}

local function gamma_correction(colors)
	local colors_corrected = {}
	for k, v in pairs(colors) do
		colors_corrected[k] = utils.color_gamma(v, config.gamma)
	end
	return colors_corrected
end

local custom_palette = type(config.custom_palette) == "function" and config.custom_palette(palette)
	or config.custom_palette

return gamma_correction(vim.tbl_extend("force", palette, custom_palette))
