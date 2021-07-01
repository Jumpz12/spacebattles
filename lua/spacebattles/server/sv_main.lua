util.AddNetworkString("drawTriggerOutlines")
util.AddNetworkString("drawExitOutlines")

hook.Add("PlayerSay", "createBox", function(ply, text)

        local args = string.Explode(" ", text)
        
        if text == "/pos1" or text == "/pos2" then

            spacebattles.config.CreateNewEnt[string.sub(text, 2, 5)] = ply:GetPos()
            ply:ChatPrint(string.sub(text, 2, 5) .. " set at position " .. tostring(ply:GetPos()))

        elseif args[1] == "/create" then

            if #args == 1 or args[2] == "enter" then
            
                if spacebattles.config.CreateNewEnt.pos1 == 0 or spacebattles.config.CreateNewEnt.pos2 == 0 then
                    ply:ChatPrint("You need to set both positions.")
                    return
                end

                local createEnt = ents.Create("ent_enter_space")
                createEnt:Spawn()
                createEnt:SetCollisionBoundsWS(spacebattles.config.CreateNewEnt["pos1"], spacebattles.config.CreateNewEnt["pos2"])
                createEnt:SetID(spacebattles.config.TotalPortals + 1)
                spacebattles.config.TotalPortals = spacebattles.config.TotalPortals + 1

                ply:ChatPrint("Box spawned with ID: " .. createEnt:GetID())

                spacebattles.config.CreateNewEnt["pos1"] = 0
                spacebattles.config.CreateNewEnt["pos2"] = 0
            
            elseif args[2] == "exit" then
                
                if not args[3] then
                    ply:ChatPrint("You need to enter a Portal ID.")
                    return
                end
                spacebattles.config.ExitList[tonumber(args[3])] = {ply:GetPos(), ply:GetAngles()}
                ply:ChatPrint("Exit point set at pos: " .. tostring(ply:GetPos()) .. " with ID: " .. args[3])

            end

        elseif text == "/debug" then

            for index, ent in pairs(ents.GetAll()) do

                if ent:GetClass() == "ent_enter_space" then

                    --print(ent:GetCollisionBounds())
                    --local vector1, vector2 = ent:GetCollisionBounds()

                    print(ent:GetCollisionBounds())
                    local vector1, vector2 = ent:GetCollisionBounds()
                    local center = ent:WorldSpaceCenter()
                    net.Start("drawTriggerOutlines")
                    net.WriteVector(vector1)
                    net.WriteVector(vector2)
                    net.WriteVector(center)
                    net.WriteBool(spacebattles.config.debug[ply:SteamID64()])
                    net.Send(ply)

                end

            end

            for ID, pos in pairs(spacebattles.config.ExitList) do
                net.Start("drawExitOutlines")
                net.WriteVector(Vector(pos))
                net.WriteBool(spacebattles.config.debug[ply:SteamID64()])
                net.Send(ply)
            end

            spacebattles.config.debug[ply:SteamID64()] = not spacebattles.config.debug[ply:SteamID64()]

        end
end)

