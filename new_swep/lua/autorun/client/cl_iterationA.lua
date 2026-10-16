print("Present!")

local panelWidth = 360
local panelHeight = 90

hook.Add("HUDPaint", "OwenFirstAddonHUD", function()
     local panelX = 30
     local panelY = 30


     draw.RoundedBox(
        10,
        panelX,
        panelY,
        panelWidth,
        panelHeight,
        Color(15, 25, 45, 220)
)

    draw.SimpleText(
        "Ignum Limpus",
        "Trebuchet24",
        panelX + panelWidth / 2,
        panelY + 28,
        Color(60, 220, 255),
        TEXT_ALIGN_CENTER,
        TEXT_ALIGN_CENTER
)
end)