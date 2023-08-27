# ethereal.nvim

Ethereal is a dark theme for Neovim 0.7.2 and older. It started as the [Tokyodark theme](https://github.com/tiagovla/tokyodark.nvim) which I switched to quite a while ago, but I modified all of its palette with time.

Credits to [tiagovla](https://github.com/tiagovla) for the original Lua code for the plugins.

![image](https://github.com/presindent/ethereal.nvim/assets/115044400/76ae48da-523c-4a38-a7b8-3e7eb3a0e32f)

---

## Installation

**[lazy](https://github.com/folke/lazy.nvim)**

```lua
{
    "presindent/ethereal.nvim",
    opts = {
        -- Options for customization go here.
    },
    config = function(_, opts)
        vim.cmd [[colorscheme ethereal]]
    end,
}
```

## Default configuration

```lua
local default_config = {
    transparent_background = false,
    gamma = 1.00, -- Adjust the brightness of the theme.
    styles = {
        comments = { italic = true }, -- Styling for comments and so on.
        keywords = { italic = true },
        identifiers = { italic = true },
        functions = {},
        variables = {},
    },
    custom_highlights = {} or function(highlights, palette) return {} end, -- Customize highlights.
    custom_palette = {} or function(palette) return {} end, -- Customize palette.
    terminal_colors = true, -- Flag for enabling/disabling terminal colors.
}
```
