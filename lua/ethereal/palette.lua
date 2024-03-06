local config = require("ethereal.config")
local utils = require("ethereal.utils")

local palette1 = {
	black = "#33364f",
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

local palette2 = {
	black = "#36334f",
	bg0 = "#0c0e16",
	bg1 = "#01010a",
	bg2 = "#39334d",
	bg3 = "#393455",
	bg4 = "#4b4a67",
	bg5 = "#2a2844",
	bg_red = "#ff6870",
	bg_green = "#aaffaa",
	bg_blue = "#9699ff",
	diff_red = "#cc44aa",
	diff_green = "#44aacc",
	diff_blue = "#3332ff",
	diff_add = "#3947e5",
	diff_change = "#6f63cc",
	diff_delete = "#e53b82",
	diff_text = "#ae94ff",
	fg = "#b9b0ff",
	red = "#ff666f",
	orange = "#ffb661",
	yellow = "#ffe074",
	green = "#686dff",
	blue = "#a48aff",
	cyan = "#38c4ff",
	purple = "#d083ff",
	grey = "#a7a4ff",
	none = "NONE",
}

local function gamma_correction(colors)
	local colors_corrected = {}
	for k, v in pairs(colors) do
		colors_corrected[k] = utils.color_gamma(v, config.gamma)
	end
	return colors_corrected
end

local palette = config.palette == 1 and palette1 or palette2

local custom_palette = type(config.custom_palette) == "function" and config.custom_palette(palette)
	or config.custom_palette

return gamma_correction(vim.tbl_extend("force", palette, custom_palette))
