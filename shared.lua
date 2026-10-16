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

SWEP.FireLightSize = 250
SWEP.FireLightTime = 0.1
SWEP.FireLightColor = Color(255, 70, 10)

function SWEP:PrimaryAttack()
    self:SetNextPrimaryFire(CurTime() + 0.5)
    self:EmitSound("Weapon_Pistol.Single")
    self:ShootBullet(10, 1, 0.02)
    self:CreateFireFlash()
end

if CLIENT then
    function SWEP:PreDrawViewModel(vm, wep, ply)
        render.SetColorModulation(1, 0.15, 0.15) -- Red tint
    end

    function SWEP:PostDrawViewModel(vm, wep, ply)
        render.SetColorModulation(1, 1, 1) -- Reset to normal
    end

    function SWEP:DrawWorldModel()
        render.SetColorModulation(1, 0.15, 0.15) -- Red tint
        self:DrawModel()
        render.SetColorModulation(1, 1, 1) -- Reset to normal
    end

    function SWEP:CreateFireFlash()
        local owner = self:GetOwner()
        if not IsValid(owner) then return end

        local viewModel = owner:GetViewModel()
        if not IsValid(viewModel) then return end

        local attachmentNumber = viewModel:LookupAttachment("muzzle")
        if attachmentNumber == 0 then return end

        local attachment = viewModel:GetAttachment(attachmentNumber)
        if not attachment then return end

        local light = DynamicLight(self:EntIndex())
        if light then
            light.pos = attachment.Pos
            light.r = 255
            light.g = 70
            light.b = 10
            light.brightness = 5
            light.Decay = 1000
            light.Size = self.FireLightSize
            light.DieTime = CurTime() + self.FireLightTime
        end
    end
end