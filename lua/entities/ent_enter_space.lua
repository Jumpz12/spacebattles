AddCSLuaFile()

ENT.Base = "base_entity"
ENT.Type = "brush"

ENT.PrintName = "Hyperspace Entry Point"
ENT.Category = "Space Battles"
ENT.Author = "Jumpz"
ENT.Contact	= "Jumpz#9217"

if (SERVER) then

    function ENT:Initialize()

        self:SetSolid(SOLID_BBOX)
        PrintTable(self:GetTable())

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