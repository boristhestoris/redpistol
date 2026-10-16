if SERVER then
    AddCSLuaFile()
end

SWEP.PrintName = "RedPistol"
SWEP.Instructions = "a cool pistol. First iteration of the addon."
SWEP.Category = "Other"

SWEP.Spawnable = true
SWEP.AdminOnly = false

SWEP.Base = "weapon_base"
SWEP.ViewModel = "models/weapons/c_pistol.mdl"
SWEP.WorldModel = "models/weapons/w_pistol.mdl"
SWEP.UseHands = true

SWEP.DrawAmmo = true
SWEP.DrawCrosshair = true
SWEP.Primary.ClipSize = 120
SWEP.Primary.DefaultClip = 12
SWEP.Secondary.ClipSize = 60
SWEP.Secondary.DefaultClip = 6

