if SERVER then
    AddCSLuaFile()
end

SWEP.PrintName = "RedPistol"
SWEP.Instructions = "a cool pistol. First iteration of the addon."
SWEP.Category = "Other"

SWEP.Primary = SWEP.Primary or {}
SWEP.Secondary = SWEP.Secondary or {}

SWEP.Spawnable = true
SWEP.AdminOnly = false

SWEP.Base = "weapon_base"
SWEP.ViewModel = "models/weapons/c_pistol.mdl"
SWEP.WorldModel = "models/weapons/w_pistol.mdl"
SWEP.UseHands = true

SWEP.DrawAmmo = true
SWEP.DrawCrosshair = true

SWEP.Primary.ClipSize = 12
SWEP.Primary.DefaultClip = 12
SWEP.Primary.Automatic = false
SWEP.Primary.Ammo = "Pistol"

SWEP.Secondary.ClipSize = 6
SWEP.Secondary.DefaultClip = 6
SWEP.Secondary.Automatic = false
SWEP.Secondary.Ammo = "Buckshot"

SWEP.FireLightSize = 250
SWEP.FireLightTime = 0.1
SWEP.FireLightColor = Color(255, 70, 10)

function SWEP:CanPrimaryAttack()
    if self:Ammo1() <= 0 then
        self:Reload()
        return false
    end
    return true
end

function SWEP:PrimaryAttack()
    if not self:CanPrimaryAttack() then
         return 
    end
    self:SetNextPrimaryFire(CurTime() + 0.3)
    self:EmitSound("Weapon_Pistol.Single")
    self:ShootBullet(15, 1, 0.02)
    self:TakePrimaryAmmo(1)
    self:SendWeaponAnim(ACT_VM_PRIMARYATTACK)
    if IsValid(self.owner) then
        self.owner:SetAnimation(PLAYER_ATTACK1)
        self.owner:MuzzleFlash()
        if CLIENT then
        self:CreateFireFlash()
        end
    end
end

function SWEP:CanSecondaryAttack()
    if self:Ammo2() <= 0 then
        self:Reload()
        return false
    end
    return true
end

function SWEP:SecondaryAttack()
    if not self:CanSecondaryAttack() then
        return
    end
        self:SetNextSecondaryFire(CurTime() + 0.3)
        self:EmitSound("Weapon_Shotgun.Single")
        self:ShootBullet(15, 6, 0.1)
        self:TakeSecondaryAmmo(2)
        self:SendWeaponAnim(ACT_VM_SECONDARYATTACK)
    
        if IsValid(self.owner) then
            self.owner:ViewPunch(Angle(-1, 0, 0))
            self.owner:SetAnimation(PLAYER_ATTACK1)
            self.owner:MuzzleFlash()
            if CLIENT then
                self:CreateFireFlash()
            end
        end
    end
    if IsValid(self.owner) then
        self.owner:ViewPunch(Angle(-1, 0, 0))
    self.owner:SetAnimation(PLAYER_ATTACK1)
        self.owner:MuzzleFlash()
        if CLIENT then
    self:CreateFireFlash()
    end
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
        if IsValid(self) and not self:IsValid() then return end
        local owner = self:GetOwner()
        if not IsValid(owner) then return end
        if IsValid(self.owner) then
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
end