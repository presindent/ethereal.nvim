local p = require("ethereal.palette")
local utils = require("ethereal.utils")
local config = require("ethereal.config")
local terminal = require("ethereal.terminal")

local M = {}

local function load_highlights(highlights)
	for group_name, group_settings in pairs(highlights) do
		vim.api.nvim_set_hl(0, group_name, group_settings)
	end
end

local styles = vim.tbl_map(function(value)
	return setmetatable(value, {
		__add = function(a, b)
			return vim.tbl_extend("force", a, b)
		end,
	})
end, config.styles)

local transparent_bg = setmetatable({}, {
	__add = function(a)
		a.bg = config.transparent_background and p.none or a.bg
		return a
	end,
})

local function gamma(value)
	return setmetatable({}, {
		__add = function(a)
			return utils.color_gamma(a, value)
		end,
	})
end

M.highlights = {
	Fg = { fg = p.fg },
	Grey = { fg = p.grey },
	Red = { fg = p.red },
	Orange = { fg = p.orange },
	Yellow = { fg = p.yellow },
	Green = { fg = p.green },
	Blue = { fg = p.blue },
	Purple = { fg = p.purple },
	Normal = { fg = p.fg, bg = p.bg0 } + transparent_bg,
	NormalNC = { fg = p.fg, bg = p.bg0 } + transparent_bg,
	NormalSB = { fg = p.fg, bg = p.bg0 } + transparent_bg,
	NormalFloat = { fg = p.fg, bg = p.bg0 } + transparent_bg,
	Terminal = { fg = p.fg, bg = p.bg0 } + transparent_bg,
	EndOfBuffer = { fg = p.bg2, bg = p.bg0 } + transparent_bg,
	FoldColumn = { fg = p.fg, bg = p.bg1 } + transparent_bg,
	Folded = { fg = p.fg, bg = p.bg1 } + transparent_bg,
	SignColumn = { fg = p.fg, bg = p.bg0 } + transparent_bg,
	ToolbarLine = { fg = p.fg },
	Cursor = { reverse = true },
	vCursor = { reverse = true },
	iCursor = { reverse = true },
	lCursor = { reverse = true },
	CursorIM = { reverse = true },
	CursorColumn = { bg = p.bg1 },
	CursorLine = { bg = p.bg1 },
	ColorColumn = { bg = p.bg1 },
	CursorLineNr = { fg = p.fg },
	LineNr = { fg = p.bg4 },
	Conceal = { fg = p.grey, bg = p.bg1 },
	DiffAdd = { fg = p.none, bg = p.diff_add },
	DiffChange = { fg = p.none, bg = p.diff_change },
	DiffDelete = { fg = p.none, bg = p.diff_delete },
	DiffText = { fg = p.none, bg = p.diff_text },
	Directory = { fg = p.green },
	ErrorMsg = { fg = p.red, bold = true, underline = true },
	WarningMsg = { fg = p.yellow, bold = true },
	MoreMsg = { fg = p.blue, bold = true },
	IncSearch = { fg = p.bg0, bg = p.bg_red },
	Search = { fg = p.bg0, bg = p.bg_green },
	CurSearch = { fg = p.bg0, bg = p.bg_red },
	MatchParen = { fg = p.none, bg = p.bg4 },
	NonText = { fg = p.bg4 },
	Whitespace = { fg = p.bg4 },
	SpecialKey = { fg = p.bg4 },
	Pmenu = { fg = p.fg, bg = p.bg0 },
	PmenuSbar = { fg = p.none, bg = p.bg0 },
	PmenuSel = { fg = p.bg0, bg = p.bg_green },
	PmenuThumb = { fg = p.none, bg = p.bg2 },
	WildMenu = { fg = p.bg0, bg = p.blue },
	Question = { fg = p.yellow },
	SpellBad = { fg = p.red, underline = true, sp = p.red },
	SpellCap = { fg = p.yellow, underline = true, sp = p.yellow },
	SpellLocal = { fg = p.blue, underline = true, sp = p.blue },
	SpellRare = { fg = p.purple, underline = true, sp = p.purple },
	StatusLine = { fg = p.fg, bg = p.bg2 },
	StatusLineTerm = { fg = p.fg, bg = p.bg2 },
	StatusLineNC = { fg = p.grey, bg = p.bg1 },
	StatusLineTermNC = { fg = p.grey, bg = p.bg1 },
	TabLine = { fg = p.fg, bg = p.bg4 },
	TabLineFill = { fg = p.grey, bg = p.bg1 },
	TabLineSel = { fg = p.bg0, bg = p.bg_red },
	VertSplit = { fg = p.bg5 },
	Visual = { bg = p.bg2 },
	VisualNOS = { fg = p.none, bg = p.bg2, underline = true },
	QuickFixLine = { fg = p.blue, underline = true },
	Debug = { fg = p.yellow },
	debugPC = { fg = p.bg0, bg = p.green },
	debugBreakpoint = { fg = p.bg0, bg = p.red },
	ToolbarButton = { fg = p.bg0, bg = p.bg_blue },
	FocusedSymbol = { bg = p.bg3 },

	Type = { fg = p.blue } + styles.keywords,
	Structure = { fg = p.blue } + styles.keywords,
	StorageClass = { fg = p.blue } + styles.keywords,
	Identifier = { fg = p.fg } + styles.identifiers,
	Constant = { fg = p.orange } + styles.variables,
	PreProc = { fg = p.red },
	PreCondit = { fg = p.red },
	Include = { fg = p.red },
	Keyword = { fg = p.red } + styles.keywords,
	Define = { fg = p.red },
	Typedef = { fg = p.red },
	Exception = { fg = p.red },
	Conditional = { fg = p.red },
	Repeat = { fg = p.red },
	Statement = { fg = p.red },
	Macro = { fg = p.purple },
	Error = { fg = p.red },
	Label = { fg = p.purple },
	Special = { fg = p.purple },
	SpecialChar = { fg = p.purple },
	Boolean = { fg = p.purple },
	String = { fg = p.yellow },
	Character = { fg = p.yellow },
	Number = { fg = p.purple },
	Float = { fg = p.purple },
	Function = { fg = p.green } + styles.functions,
	Operator = { fg = p.red },
	Title = { fg = p.yellow },
	Tag = { fg = p.orange },
	Delimiter = { fg = p.fg },
	Comment = { fg = p.bg4 } + styles.comments,
	SpecialComment = { fg = p.bg4 } + styles.comments,
	Todo = { fg = p.blue } + styles.comments,

	-- whichkey
	WhichKey = { fg = p.red },
	WhichKeyDesc = { fg = p.blue },
	WhichKeyGroup = { fg = p.orange },
	WhichKeySeperator = { fg = p.green },

	-- flash
	FlashBackdrop = { fg = p.bg4 },
	FlashLabel = { fg = p.bg0, bg = p.blue, bold = true },

	-- gitgutter
	GitGutterAdd = { fg = p.diff_green },
	GitGutterChange = { fg = p.diff_blue },
	GitGutterDelete = { fg = p.diff_red },

	-- diffview
	DiffviewFilePanelTitle = { fg = p.blue, bold = true },
	DiffviewFilePanelCounter = { fg = p.purple, bold = true },
	DiffviewFilePanelFileName = { fg = p.fg },
	DiffviewNormal = { link = "Normal" },
	DiffviewCursorLine = { link = "CursorLine" },
	DiffviewVertSplit = { link = "VertSplit" },
	DiffviewSignColumn = { link = "SignColumn" },
	DiffviewStatusLine = { link = "StatusLine" },
	DiffviewStatusLineNC = { link = "StatusLineNC" },
	DiffviewEndOfBuffer = { link = "EndOfBuffer" },
	DiffviewFilePanelRootPath = { fg = p.grey },
	DiffviewFilePanelPath = { fg = p.grey },
	DiffviewFilePanelInsertions = { fg = p.green },
	DiffviewFilePanelDeletions = { fg = p.red },
	DiffviewStatusAdded = { fg = p.green },
	DiffviewStatusUntracked = { fg = p.blue },
	DiffviewStatusModified = { fg = p.blue },
	DiffviewStatusRenamed = { fg = p.blue },
	DiffviewStatusCopied = { fg = p.blue },
	DiffviewStatusTypeChange = { fg = p.blue },
	DiffviewStatusUnmerged = { fg = p.blue },
	DiffviewStatusUnknown = { fg = p.red },
	DiffviewStatusDeleted = { fg = p.red },
	DiffviewStatusBroken = { fg = p.red },

	-- comments
	commentTSDanger = { fg = p.red } + styles.comments,
	commentTSNote = { fg = p.blue } + styles.comments,
	commentTSWarning = { fg = p.yellow } + styles.comments,

	-- treesitter
	["@annotation"] = { link = "PreProc", default = true },
	["@attribute"] = { link = "PreProc", default = true },
	["@boolean"] = { link = "Boolean", default = true },
	["@character"] = { link = "Character", default = true },
	["@character.special"] = { link = "SpecialChar", default = true },
	["@comment"] = { link = "Comment", default = true },
	["@conditional"] = { link = "Conditional", default = true },
	["@constant"] = { link = "Constant", default = true },
	["@constant.builtin"] = { link = "Special", default = true },
	["@constant.macro"] = { link = "Define", default = true },
	["@constructor"] = { link = "Special", default = true },
	["@debug"] = { link = "Debug", default = true },
	["@define"] = { link = "Define", default = true },
	["@defaultLibrary"] = { link = "Special", default = true },
	["@error"] = { link = "Error", default = true },
	["@exception"] = { link = "Exception", default = true },
	["@field"] = { link = "Identifier", default = true },
	["@float"] = { link = "Float", default = true },
	["@function"] = { link = "Function", default = true },
	["@function.builtin"] = { link = "Special", default = true },
	["@function.call"] = { link = "@function", default = true },
	["@function.macro"] = { link = "Macro", default = true },
	["@include"] = { link = "Include", default = true },
	["@keyword"] = { link = "Keyword", default = true },
	["@keyword.function"] = { link = "Keyword", default = true },
	["@keyword.operator"] = { link = "@operator", default = true },
	["@keyword.return"] = { link = "@keyword", default = true },
	["@label"] = { link = "Label", default = true },
	["@method"] = { link = "Function", default = true },
	["@method.call"] = { link = "@method", default = true },
	["@namespace"] = { link = "Include", default = true },
	["@none"] = { bg = "NONE", fg = "NONE", default = true },
	["@number"] = { link = "Number", default = true },
	["@operator"] = { link = "Operator", default = true },
	["@parameter"] = { link = "Identifier", default = true },
	["@parameter.reference"] = { link = "@parameter", default = true },
	["@preproc"] = { link = "PreProc", default = true },
	["@property"] = { link = "Identifier", default = true },
	["@punctuation.bracket"] = { link = "Delimiter", default = true },
	["@punctuation.delimiter"] = { link = "Delimiter", default = true },
	["@punctuation.special"] = { link = "Delimiter", default = true },
	["@repeat"] = { link = "Repeat", default = true },
	["@storageclass"] = { link = "StorageClass", default = true },
	["@string"] = { link = "String", default = true },
	["@string.escape"] = { link = "SpecialChar", default = true },
	["@string.regex"] = { link = "String", default = true },
	["@string.special"] = { link = "SpecialChar", default = true },
	["@symbol"] = { link = "Identifier", default = true },
	["@tag"] = { link = "Label", default = true },
	["@tag.attribute"] = { link = "@property", default = true },
	["@tag.delimiter"] = { link = "Delimiter", default = true },
	["@text"] = { link = "@none", default = true },
	["@text.danger"] = { link = "WarningMsg", default = true },
	["@text.emphasis"] = { italic = true, default = true },
	["@text.environment"] = { link = "Macro", default = true },
	["@text.environment.name"] = { link = "Type", default = true },
	["@text.literal"] = { link = "String", default = true },
	["@text.math"] = { link = "Special", default = true },
	["@text.note"] = { link = "SpecialComment", default = true },
	["@text.reference"] = { link = "Constant", default = true },
	["@text.strike"] = { strikethrough = true, default = true },
	["@text.strong"] = { bold = true, default = true },
	["@text.title"] = { link = "Title", default = true },
	["@text.todo"] = { link = "Todo", default = true },
	["@text.underline"] = { underline = true, default = true },
	["@text.uri"] = { link = "Underlined", default = true },
	["@text.warning"] = { link = "Todo", default = true },
	["@todo"] = { link = "Todo", default = true },
	["@type"] = { link = "Type", default = true },
	["@type.builtin"] = { link = "Type", default = true },
	["@type.definition"] = { link = "Typedef", default = true },
	["@type.qualifier"] = { link = "Type", default = true },
	["@variable"] = { fg = p.fg, default = true } + styles.variables,
	["@variable.builtin"] = { fg = p.purple, default = true },

	["@comment.note"] = { fg = p.blue },
	["@comment.error"] = { fg = p.red },
	["@comment.hint"] = { fg = p.green },
	["@comment.info"] = { fg = p.blue },
	["@comment.warning"] = { fg = p.orange },
	["@comment.todo"] = { fg = p.yellow },

	["@markup.link.label"] = { link = "SpecialChar" },
	["@markup.link.label.symbol"] = { link = "Identifier" },
	["@markup"] = { link = "@none" },
	["@markup.environment"] = { link = "Macro" },
	["@markup.environment.name"] = { link = "Type" },
	["@markup.raw"] = { link = "String" },
	["@markup.math"] = { link = "Special" },
	["@markup.strong"] = { bold = true },
	["@markup.emphasis"] = { italic = true },
	["@markup.strikethrough"] = { strikethrough = true },
	["@markup.underline"] = { underline = true },
	["@markup.heading"] = { link = "Title" },
	["@markup.link.url"] = { link = "Underlined" },

	Underlined = { underline = true }, -- (preferred) text that stands out, HTML links
	Bold = { bold = true },
	Italic = { italic = true },

	-- lsp
	LspCxxHlGroupEnumConstant = { fg = p.orange },
	LspCxxHlGroupMemberVariable = { fg = p.orange },
	LspCxxHlGroupNamespace = { fg = p.blue },
	LspCxxHlSkippedRegion = { fg = p.grey },
	LspCxxHlSkippedRegionBeginEnd = { fg = p.red },
	LspDiagnosticsDefaultError = { fg = p.red + gamma(0.5) },
	LspDiagnosticsDefaultHint = { fg = p.purple + gamma(0.5) },
	LspDiagnosticsDefaultInformation = { fg = p.blue + gamma(0.5) },
	LspDiagnosticsDefaultWarning = { fg = p.yellow + gamma(0.5) },
	LspDiagnosticsUnderlineError = { underline = true, sp = p.red + gamma(0.5) },
	LspDiagnosticsUnderlineHint = {
		underline = true,
		sp = p.purple + gamma(0.5),
	},
	LspDiagnosticsUnderlineInformation = {
		underline = true,
		sp = p.blue + gamma(0.5),
	},
	LspDiagnosticsUnderlineWarning = {
		underline = true,
		sp = p.yellow + gamma(0.5),
	},
	DiagnosticSignError = { fg = p.red + gamma(0.5) },
	DiagnosticSignHint = { fg = p.purple + gamma(0.5) },
	DiagnosticSignInfo = { fg = p.blue + gamma(0.5) },
	DiagnosticSignWarn = { fg = p.yellow + gamma(0.5) },
	LspReferenceRead = { bg = p.bg3 },
	LspReferenceWrite = { bg = p.bg3 },
	LspReferenceText = { bg = p.bg3 },
	LspInfoBorder = { fg = p.bg4 },

	-- lsp semantic tokens
	LspNamespace = { link = "@namespace" },
	LspType = { link = "@type" },
	LspClass = { link = "@type" },
	LspEnum = { link = "@constant" },
	LspInterface = { link = "@constant" },
	LspStruct = { link = "@constant" },
	LspTypeParameter = { link = "@type" },
	LspParameter = { link = "@parameter" },
	LspVariable = { link = "@variable" },
	LspProperty = { link = "@property" },
	LspEnumMember = { link = "@constant" },
	LspEvent = { link = "@constant" },
	LspFunction = { link = "@function" },
	LspMethod = { link = "@method" },
	LspMacro = { link = "@constant.macro" },
	LspKeyword = { link = "@keyword" },
	LspModifier = { link = "TSModifier" },
	LspComment = { link = "@comment" },
	LspString = { link = "@string" },
	LspNumber = { link = "@number" },
	LspRegexp = { link = "@string.regex" },
	LspOperator = { link = "@operator" },
	LspDecorator = { link = "@symbol" },
	LspDeprecated = { link = "@text.strike" },

	-- cmp
	CmpItemKindDefault = { fg = p.blue },
	CmpItemAbbrMatch = { fg = p.blue },
	CmpItemAbbrMatchFuzzy = { fg = p.blue },
	CmpItemKindKeyword = { fg = p.fg },
	CmpItemKindVariable = { fg = p.cyan },
	CmpItemKindConstant = { fg = p.cyan },
	CmpItemKindReference = { fg = p.cyan },
	CmpItemKindValue = { fg = p.cyan },
	CmpItemKindFunction = { fg = p.purple },
	CmpItemKindMethod = { fg = p.purple },
	CmpItemKindConstructor = { fg = p.purple },
	CmpItemKindClass = { fg = p.yellow },
	CmpItemKindInterface = { fg = p.yellow },
	CmpItemKindStruct = { fg = p.yellow },
	CmpItemKindEvent = { fg = p.yellow },
	CmpItemKindEnum = { fg = p.yellow },
	CmpItemKindUnit = { fg = p.yellow },
	CmpItemKindModule = { fg = p.yellow },
	CmpItemKindProperty = { fg = p.green },
	CmpItemKindField = { fg = p.green },
	CmpItemKindTypeParameter = { fg = p.green },
	CmpItemKindEnumMember = { fg = p.green },
	CmpItemKindOperator = { fg = p.green },
	CmpItemKindSnippet = { fg = p.red },

	-- coc
	CocErrorSign = { fg = p.red + gamma(0.5) },
	CocHintSign = { fg = p.red + gamma(0.5) },
	CocInfoSign = { fg = p.red + gamma(0.5) },
	CocWarningSign = { fg = p.red + gamma(0.5) },
	FgCocErrorFloatBgCocFloating = { fg = p.red + gamma(0.5), bg = p.bg2 },
	FgCocHintFloatBgCocFloating = { fg = p.purple + gamma(0.5), bg = p.bg2 },
	FgCocInfoFloatBgCocFloating = { fg = p.blue + gamma(0.5), bg = p.bg2 },
	FgCocWarningFloatBgCocFloating = { fg = p.yellow + gamma(0.5), bg = p.bg2 },

	-- gitsigns
	GitSignsAdd = { fg = p.green },
	GitSignsAddLn = { fg = p.green },
	GitSignsAddNr = { fg = p.green },
	GitSignsChange = { fg = p.blue },
	GitSignsChangeLn = { fg = p.blue },
	GitSignsChangeNr = { fg = p.blue },
	GitSignsDelete = { fg = p.red },
	GitSignsDeleteLn = { fg = p.red },
	GitSignsDeleteNr = { fg = p.red },

	-- markdown
	markdownBlockquote = { fg = p.grey },
	markdownBold = { fg = p.none, bold = true },
	markdownBoldDelimiter = { fg = p.grey },
	markdownCode = { fg = p.yellow },
	markdownCodeBlock = { fg = p.yellow },
	markdownCodeDelimiter = { fg = p.green },
	markdownH1 = { fg = p.red, bold = true },
	markdownH2 = { fg = p.red, bold = true },
	markdownH3 = { fg = p.red, bold = true },
	markdownH4 = { fg = p.red, bold = true },
	markdownH5 = { fg = p.red, bold = true },
	markdownH6 = { fg = p.red, bold = true },
	markdownHeadingDelimiter = { fg = p.grey },
	markdownHeadingRule = { fg = p.grey },
	markdownId = { fg = p.yellow },
	markdownIdDeclaration = { fg = p.red },
	markdownItalic = { fg = p.none, italic = true },
	markdownItalicDelimiter = { fg = p.grey, italic = true },
	markdownLinkDelimiter = { fg = p.grey },
	markdownLinkText = { fg = p.red },
	markdownLinkTextDelimiter = { fg = p.grey },
	markdownListMarker = { fg = p.red },
	markdownOrderedListMarker = { fg = p.red },
	markdownRule = { fg = p.purple },
	markdownUrl = { fg = p.blue, underline = true },
	markdownUrlDelimiter = { fg = p.grey },
	markdownUrlTitleDelimiter = { fg = p.green },

	-- scala
	scalaNameDefinition = { fg = p.fg },
	scalaInterpolationBoundary = { fg = p.purple },
	scalaInterpolation = { fg = p.purple },
	scalaTypeOperator = { fg = p.red },
	scalaOperator = { fg = p.red },
	scalaKeywordModifier = { fg = p.red },

	-- Diagnostics
	DiagnosticError = { fg = p.red },
	DiagnosticWarn = { fg = p.yellow },
	DiagnosticInfo = { fg = p.blue },
	DiagnosticHint = { fg = p.purple },

	DiagnosticUnderlineError = { underline = true, sp = p.red },
	DiagnosticUnderlineWarn = { underline = true, sp = p.yellow },
	DiagnosticUnderlineInfo = { underline = true, sp = p.blue },
	DiagnosticUnderlineHint = { underline = true, sp = p.purple },

	-- Neo-tree highlights
	NeoTreeGitModified = { fg = p.blue },
}

function M.setup()
	local highlights = type(config.custom_highlights) == "function" and config.custom_highlights(M.highlights, p)
		or config.custom_highlights
	local hl = vim.tbl_extend("force", M.highlights, highlights)
	hl["@variable"] = { fg = p.fg } + styles.variables
	load_highlights(hl)
	if config.terminal_colors then
		terminal.setup()
	end
end

return M
