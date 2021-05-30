hook.Add("PlayerSay", "createBox", function(ply, text)

    local box = ents.Create("ent_space_enter")
    box:Spawn()

end)

