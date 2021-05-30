AddCSLuaFile()

ENT.Base = "base_entity"
ENT.Type = "anim"
ENT.PrintName = "Hyperspace Entry Point"
ENT.Category = "Space Battles"
ENT.Author = "Jumpz"
ENT.Contact	= "Jumpz#9217"
ENT.Spawnable = false
ENT.Editable =  true
ENT.ShowPlayerInteraction = true
ENT.RenderGroup = RENDERGROUP_TRANSLUCENT
ENT.bNoPersist = true

function ENT:SetupDataTables()

    self:NetworkVar("Int", 0, "Zone", {KeyName = "zone", Edit = { type = "Int", order = 1, min = 0, max = 100 } } )
    self:NetworkVar("String", 0, "Planet", {KeyName = "planet", Edit = { type = "String", order = 2 } } )

end

if (SERVER) then

    function ENT:Initialize()

        self:SetModel("models/hunter/blocks/cube025x025x025.mdl") --Replace this with actual prop
        self:PhysicsInit(SOLID_VPHYSICS)
        self:SetMoveType(MOVETYPE_NONE)
        self:SetSolid(SOLID_VPHYSICS)
        self:SetOwned("None")

        local physics = self:GetPhysicsObject()

        if physics:IsValid() then

            physics:EnableMotion(false)
            physics:Sleep()

        end

    end

    function ENT:Use( activator, caller)
    end

else

    function ENT:Draw() --Add extra information such as who is captured by.

        self:DrawModel()

    end

end