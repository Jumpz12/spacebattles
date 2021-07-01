AddCSLuaFile()

ENT.Base = "base_entity"
ENT.Type = "brush"

ENT.PrintName = "ent_enter_space"
ENT.Category = "Space Battles"
ENT.Author = "Jumpz"
ENT.Contact	= "Discord: Jumpz#9217"

function ENT:SetupDataTables()

    self:NetworkVar("Int", 0, "ID", {KeyName = "id", Edit = { type = "Int", order = 1, min = 0, max = 100 } } )
    self:NetworkVar("String", 0, "Planet", {KeyName = "planet", Edit = { type = "String", order = 2 } } )

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

        if not entity:IsPlayer() then return end

        if entity:lfsGetPlane() then

            local vehicleToTeleport = entity:lfsGetPlane()

            entity:SetEyeAngles(spacebattles.config.ExitList[self:GetID()][2])
            vehicleToTeleport:SetAngles(spacebattles.config.ExitList[self:GetID()][2])

            entity:SetModelScale(entity:GetModelScale() * 0.5, 0 )
            vehicleToTeleport:SetModelScale(vehicleToTeleport:GetModelScale() * 0.5, 0 )

            --entity:EnterVehicle(vehicleToTeleport:GetDriverSeat())
            vehicleToTeleport:SetNotSolid(false)
        
        end

    end

    function ENT:Touch(entity)

        if not entity:IsPlayer() then return end

        if entity:lfsGetPlane() then
            local vehicleToTeleport = entity:lfsGetPlane()
            --entity:ExitVehicle()

            --vehicleToTeleport:StopEngine()
            vehicleToTeleport:SetNotSolid(true)

            entity:SetPos(spacebattles.config.ExitList[self:GetID()][1])
            vehicleToTeleport:SetPos(spacebattles.config.ExitList[self:GetID()][1])

            
            --vehicleToTeleport:StartEngine()

        end

    end

end