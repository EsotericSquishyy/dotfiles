-- ===== Monitors =====
hl.monitor({
  output = "eDP-1",
  mode = "2256x1504@60",
  position = "0x0",
  scale = 1,
})
hl.monitor({
  output = "DP-1",
  mode = "1920x1080@60",
  position = "-168x-1080",
  scale = 1,
})
-- hl.monitor({
--   output = "",
--   mode = "preferred",
--   position = "auto",
--   scale = 1,
--   mirror = "eDP-1",
-- })


-- ===== Permissions =====
hl.config({ ecosystem = { enforce_permissions = true } })
hl.permission("/usr/(bin|local/bin)/grim", "screencopy", "allow")
hl.permission("/usr/(bin|local/bin)/wlogout", "screencopy", "allow")
hl.permission("/usr/(lib|libexec|lib64)/xdg-desktop-portal-hyprland", "screencopy", "allow")


-- ===== Variables =====
local colors = require("colors")
local configDir     = "$HOME/.config/hypr/"
local startupScript = configDir .. "startup.sh"
local wallpaperPath = configDir .. "wallpapers/explosion_atelier_forest.png"
local brightDown    = "brightnessctl -q s 5%-"
local brightUp      = "brightnessctl -q s 5%+"
local browser       = "firefox"
local exitMenu      = "pkill wlogout || wlogout --protocol layer-shell -b 4"
local mainMod       = "SUPER"
local menu          = "pkill rofi || rofi -show drun"
local menuactive    = "pkill rofi || rofi -show window"
local restartWaybar = "pkill waybar && waybar"
local terminal      = "alacritty"
local volDown       = "amixer -q sset Master 5%-"
local volToggle     = "amixer -q sset Master toggle"
local volUp         = "amixer -q sset Master 5%+"


-- ===== Autostart =====
hl.on("hyprland.start", function ()
  hl.exec_cmd(
    startupScript .. " --wallpaper " .. wallpaperPath
  )
end)


-- ===== Window/Layer Rules =====
hl.layer_rule = {
  name = "layer-blur",
  -- wlogout, waybar
  match = { namespace = "logout_dialog|waybar" },
  blur = true,
}
hl.window_rule = {
  name = "transparent-windows",
  -- vesktop, firefox
  match = { class = "vesktop|firefox" },
  opacity = "1.0 override 0.8 override",
}
hl.window_rule = {
  name  = "suppress-maximize-events",
  match = { class = ".*" },
  suppress_event = "maximize",
}

hl.window_rule = {
  name  = "fix-xwayland-drags",
  match = {
    class      = "^$",
    title      = "^$",
    xwayland   = true,
    float      = true,
    fullscreen = false,
    pin        = false,
  },
  no_focus = true,
}


-- ===== Rice =====
hl.config({
  general = {
    gaps_in       = 3,
    gaps_out      = 5,
    border_size   = 2,
    allow_tearing = false,
    layout        = "dwindle",
    col = {
      active_border   = { colors = { colors.base01, colors.base03 }, angle = 45 },
      inactive_border = colors.base08,
    },
  },
  dwindle = {
      preserve_split = true,
  },
  decoration = {
    rounding = 0,
    blur = {
      enabled  = true,
      new_optimizations = true,
      passes   = 2,
      size     = 2,
      vibrancy = -3,
    },
    shadow = {
        color        = "rgba(1a1a1aee)",
        enabled      = true,
        range        = 4,
        render_power = 3,
    },
  },
  input = {
      touchpad = {
          natural_scroll = true,
      },
      follow_mouse = 1,
      kb_layout    = "us",
      kb_model     = "",
      kb_options   = "",
      kb_rules     = "",
      kb_variant   = "",
      sensitivity  = 0,
  },
  misc = {
      force_default_wallpaper = 0,
  },
})


-- ===== Animations =====
hl.config({ animations = { enabled = true } })
hl.curve("myBezier", { type = "bezier", points = { {0.05, 0.9}, {0.1, 1.05} } })
hl.animation({ leaf = "windows", enabled = true, speed = 7, bezier = "myBezier" })
hl.animation({ leaf = "windowsOut", enabled = true, speed = 7, bezier = "default", style = "popin 80%" })
hl.animation({ leaf = "border", enabled = true, speed = 10, bezier = "default" })
hl.animation({ leaf = "borderangle", enabled = true, speed = 8, bezier = "default" })
hl.animation({ leaf = "fade", enabled = true, speed = 7, bezier = "default" })
hl.animation({ leaf = "workspaces", enabled = true, speed = 6, bezier = "default" })


-- ===== Basic binds =====
hl.bind(mainMod .. " + Q", hl.dsp.exec_cmd(terminal))
hl.bind(mainMod .. " + C", hl.dsp.window.close())
hl.bind(mainMod .. " + E", hl.dsp.exec_cmd(exitMenu))
hl.bind(mainMod .. " + V", hl.dsp.window.float({ action = "toggle" }))
hl.bind(mainMod .. " + R", hl.dsp.exec_cmd(menu))
hl.bind(mainMod .. " + T", hl.dsp.exec_cmd(menuactive))
hl.bind(mainMod .. " + P", hl.dsp.window.pseudo())
hl.bind(mainMod .. " + O", hl.dsp.layout("togglesplit"))
hl.bind(mainMod .. " + F", hl.dsp.window.fullscreen())
hl.bind(mainMod .. " + Y", hl.dsp.exec_cmd(restartWaybar))
hl.bind(mainMod .. " + B", hl.dsp.exec_cmd(browser))


-- ===== Movement =====
hl.bind(mainMod .. " + H", hl.dsp.focus({ direction = "left" }))
hl.bind(mainMod .. " + L", hl.dsp.focus({ direction = "right" }))
hl.bind(mainMod .. " + J", hl.dsp.focus({ direction = "down" }))
hl.bind(mainMod .. " + K", hl.dsp.focus({ direction = "up" }))
hl.bind(mainMod .. " + SHIFT + H", hl.dsp.window.move({ direction = "left" }))
hl.bind(mainMod .. " + SHIFT + L", hl.dsp.window.move({ direction = "right" }))
hl.bind(mainMod .. " + SHIFT + J", hl.dsp.window.move({ direction = "down" }))
hl.bind(mainMod .. " + SHIFT + K", hl.dsp.window.move({ direction = "up" }))

-- Switch/Move workspaces
for i = 1, 10 do
    local key = i % 10 -- 10 maps to key 0
    hl.bind(mainMod .. " + " .. key,         hl.dsp.focus({ workspace = i}))
    hl.bind(mainMod .. " + SHIFT + " .. key, hl.dsp.window.move({ workspace = i }))
end

-- Scroll/Move through existing workspaces
hl.bind(mainMod .. " + COMMA",        hl.dsp.focus({ workspace = "e-1" }))
hl.bind(mainMod .. " + PERIOD",       hl.dsp.focus({ workspace = "e+1" }))
hl.bind(mainMod .. " + SHIFT + COMMA",  hl.dsp.window.move({ workspace = "e-1" }))
hl.bind(mainMod .. " + SHIFT + PERIOD", hl.dsp.window.move({ workspace = "e+1" }))

-- Secret workspace
hl.bind(mainMod .. " + S",         hl.dsp.workspace.toggle_special("magic"))
hl.bind(mainMod .. " + SHIFT + S", hl.dsp.window.move({ workspace = "special:magic" }))

-- Move/resize windows (272 LMB, 273 RMB, 274 MMB)
hl.bind(mainMod .. " + mouse:272",         hl.dsp.window.drag(),   { mouse = true })
hl.bind(mainMod .. " + SHIFT + mouse:272", hl.dsp.window.resize(), { mouse = true })


-- ===== Screenshot =====
hl.bind("print", hl.dsp.exec_cmd(
  "grim -g \"$(slurp)\" $HOME/Pictures/Screenshot-$(date +'%s_grim.png') | dunstify \"Screenshot of the region taken\" -t 1000")
)
hl.bind("CTRL + print", hl.dsp.exec_cmd(
  "grim $HOME/Pictures/Screenshot-$(date +'%s_grim.png') | dunstify \"Screenshot of whole screen taken\" -t 1000")
)


-- ===== System Control =====
hl.bind("XF86AudioRaiseVolume",  hl.dsp.exec_cmd(volUp),      { repeating = true })
hl.bind("XF86AudioLowerVolume",  hl.dsp.exec_cmd(volDown),    { repeating = true })
hl.bind("XF86AudioMute",         hl.dsp.exec_cmd(volToggle),  { repeating = true })
hl.bind("XF86MonBrightnessUp",   hl.dsp.exec_cmd(brightUp),   { repeating = true })
hl.bind("XF86MonBrightnessDown", hl.dsp.exec_cmd(brightDown), { repeating = true })


-- ===== Utils =====
hl.env("XCURSOR_SIZE", 24)
hl.env("HYPRCURSOR_SIZE", 24)
hl.env("QT_QPA_PLATFORMTHEME", "qt5ct")
