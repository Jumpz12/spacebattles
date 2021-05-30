AddCSLuaFile()

ENT.Base = "base_entity"
ENT.Type = "brush"

ENT.PrintName = "Hyperspace Entry Point"
ENT.Category = "Space Battles"
ENT.Author = "Jumpz"
ENT.Contact	= "Jumpz#9217"

--[[function ENT:SetupDataTables()

    self:NetworkVar("Int", 0, "Zone", {KeyName = "zone", Edit = { type = "Int", order = 1, min = 0, max = 100 } } )
    self:NetworkVar("String", 0, "Planet", {KeyName = "planet", Edit = { type = "String", order = 2 } } )

end]]

if (SERVER) then

    function ENT:Initialize()

        self:SetSolid(SOLID_BBOX)
        self:SetCollisionBoundsWS(Vector(816, -1135, -170), Vector(703, -1023, -22))
        print("Box made")

    end

    function ENT:StartTouch(entity)

        print(entity:Name() .. " has entered the area")

    end

    function ENT:EndTouch(entity)

        print(entity:Name() .. " has left the area")

    end

    function ENT:Touch(entity)

        entity:Kill()

    end

end