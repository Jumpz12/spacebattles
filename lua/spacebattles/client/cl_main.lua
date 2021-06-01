local boxesToDraw = {}

net.Receive("drawTriggerOutlines", function()

    local vector1, vector2 = net.ReadVector(), net.ReadVector()

    

    table.insert(boxesToDraw, {vector1, vector2})


end)

hook.Add("PostDrawTranslucentRenderables", "drawingBoxes", function(bDepth, bSkybox)

    if table.IsEmpty(boxesToDraw) then return end

    spacebattles.config.debug[LocalPlayer():SteamID64()] = true

    cam.Start3D()
    
    render.SetColorMaterial()

    for k, v in pairs(boxesToDraw) do
        local new = Vector(math.abs(v[2][1] - math.abs(v[1][1])), math.abs(v[2][2] - math.abs(v[1][2])), math.abs(v[2][3] - math.abs(v[1][3])))
        new = Vector(new[1] * -1, new[2] * -1, new[3] * -1)
        render.DrawBox( v[2], Angle(0, 0, 0), Vector(0, 0, 0), Vector(new), Color( 0, 255, 255) )
        
    end

    cam.End3D()

end)