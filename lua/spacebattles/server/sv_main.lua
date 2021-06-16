util.AddNetworkString("drawTriggerOutlines")

hook.Add("PlayerSay", "createBox", function(ply, text)
        
        if text == "/pos1" or text == "/pos2" then

            spacebattles.config.CreateNewEnt[string.sub(text, 2, 5)] = ply:GetPos()
            ply:ChatPrint(string.sub(text, 2, 5) .. " set at position " .. tostring(ply:GetPos()))

        elseif text == "/create" then
            
            if spacebattles.config.CreateNewEnt.pos1 == 0 or spacebattles.config.CreateNewEnt.pos2 == 0 then
                ply:ChatPrint("You need to set both positions.")
                return
            end

            local createEnt = ents.Create("ent_enter_space")
            
            createEnt:Spawn()
            createEnt:SetCollisionBoundsWS(spacebattles.config.CreateNewEnt["pos1"], spacebattles.config.CreateNewEnt["pos2"])
            ply:ChatPrint("Box spawned.")
            spacebattles.config.CreateNewEnt["pos1"] = 0
            spacebattles.config.CreateNewEnt["pos2"] = 0

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
                    net.Send(ply)

                end

            end

        end
end)

