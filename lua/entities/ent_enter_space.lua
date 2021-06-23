AddCSLuaFile()

ENT.Base = "base_entity"
ENT.Type = "brush"

ENT.PrintName = "ent_enter_space"
ENT.Category = "Space Battles"
ENT.Author = "Jumpz"
ENT.Contact	= "Discord: Jumpz#9217"

function ENT:SetupDataTables()

    self:NetworkVar("Int", 0, "ID")
    self:NetworkVar("String", 0, "Planet")

end


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

        local vehicleToTeleport = entity:lfsGetPlane()
        entity:ExitVehicle()

        vehicleToTeleport:StopEngine()

        entity:SetModelScale(entity:GetModelScale() * 0.5, 0 ))
        vehicleToTeleport:SetModelScale(entity:GetModelScale() * 0.5, 0 ))

        entity:SetPos(spacebattles.config.ExitList[self:GetID()])
        vehicleToTeleport:SetPos(spacebattles.config.ExitList[self:GetID()])

        entity:EnterVehicle(vehicleToTeleport)
        vehicleToTeleport:StartEngine() 

    end

end