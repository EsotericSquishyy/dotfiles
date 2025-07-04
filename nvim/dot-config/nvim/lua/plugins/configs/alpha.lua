-- lua/plugins/configs/alpha.lua
local alpha = require("alpha")
local dashboard = require("alpha.themes.dashboard")

-- Header (https://github.com/MaximilianLloyd/ascii.nvim)
dashboard.section.header.val = {
  [[⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀   ⠀⠀⠀⣀⣤⣶⣶⣿⣿⣿⣿⣶⣶⣤⣄⡀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀   ]],
  [[⠀⠀⠀⠀⠀⠀⠀⠀   ⠀⠀⣠⣴⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣶⣄⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀   ]],
  [[⠀⠀⠀⠀⠀   ⠀⠀⠀⢀⣾⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣷⡀⠀⠀⠀⠀⠀⠀⠀⠀   ]],
  [[⠀   ⠀⠀⠀⠀⠀⠀⢠⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⡄⠀⠀⠀⠀⠀⠀⠀   ]],
  [[⠀⠀⠀⠀⠀⠀   ⠀⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⡀⠀⠀⠀⠀⠀    ]],
  [[⠀⠀⠀⠀   ⠀⠀⢸⣿⣿⣿⡿⠿⠛⠻⠿⣿⣿⣿⣿⣿⣿⣿⣿⠿⠟⠛⠿⢿⣿⣿⣿⡇⠀⠀⠀⠀⠀    ]],
  [[⠀⠀   ⠀⠀⠀⠀⢸⣿⣿⠏⣠⣤⡄⣠⣤⡌⢿⣿⣿⣿⣿⡿⢁⣤⣄⢀⣤⣄⠹⣿⣿⡇⠀⠀⠀⠀⠀    ]],
  [[   ⠀⠀⠀⠀⠀⠀⠸⣿⣿⠀⢿⣿⣿⣿⣿⡟⢸⣿⣿⣿⣿⡇⠸⣿⣿⣿⣿⡿⠀⣿⣿⠇⠀⠀⠀⠀⠀    ]],
  [[⠀⠀⠀⠀⠀   ⠀⠀⢻⣿⣆⠀⠙⠿⠟⠋⢀⣾⣿⣿⣿⣿⣷⡀⠈⠻⡿⠋⠁⣰⣿⡟⠀⠀⠀⠀⠀⠀⠀   ]],
  [[⠀⠀⠀   ⠀⠀⠀⠀⢸⣿⣿⣿⣶⣶⣶⣾⣿⣿⡿⠋⠙⢿⣿⣿⣷⣶⣶⣶⣿⣿⣿⡇⠀⠀⠀⠀⠀⠀⠀   ]],
  [[   ⠀⠀⠀⠀⠀⠀⠀⠸⣿⣿⣿⣿⣿⣿⣿⣿⣿⢁⣴⣧⡀⣿⣿⣿⣿⣿⣿⣿⣿⣿⠇⠀⠀⠀⠀⠀⠀⠀   ]],
  [[⠀⠀⠀⠀⠀⠀⠀   ⠀⠙⠿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⠿⠋⠀⠀⠀⠀⠀⠀⠀⠀   ]],
  [[⠀⠀⠀⠀⠀   ⠀⠀⠀⠀⠀⠀⠀⠀⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀   ]],
  [[   ⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠘⠛⠙⠛⠙⠛⠛⠋⠛⠋⠛⠋⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀   ⠀]],
  [[ _______             ____   ____.__         ]],
  [[ \      \   ____  ___\   \ /   /|__| _____  ]],
  [[ /   |   \_/ __ \/  _ \   Y   / |  |/     \ ]],
  [[/    |    \  ___(  <_> )     /  |  |  Y Y  \]],
  [[\____|__  /\___  >____/ \___/   |__|__|_|  /]],
  [[        \/     \/                        \/ ]],
}

-- Buttons
local function button(sc, txt, keybind, keybind_opts)
  local b = dashboard.button(sc, txt, keybind, keybind_opts)
  b.opts.hl = "Function"
  b.opts.hl_shortcut = "Type"
  return b
end

dashboard.section.buttons.val = {
  button("f", "  Find file", ":Telescope find_files<CR>"),
  button("n", "  New file", ":ene <BAR> startinsert <CR>"),
  button("r", "  Recent files", ":Telescope oldfiles<CR>"),
  button("g", "  Find text", ":Telescope live_grep<CR>"),
  button("h", "  Help", ":Telescope help_tags<CR>"),
  button("q", "  Quit", ":qa<CR>"),
}

-- Footer
dashboard.section.footer.val = function()
  local stats = require("lazy").stats()
  return { "⚡ Neovim loaded " .. stats.count .. " plugins" }
end

-- Highlight groups
dashboard.section.header.opts.hl = "Identifier"
dashboard.section.footer.opts.hl = "String"

-- Final setup
alpha.setup(dashboard.config)

