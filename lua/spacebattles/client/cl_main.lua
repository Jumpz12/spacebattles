local boxesToDraw = {}

net.Receive("drawTriggerOutlines", function()

    local vector1, vector2, center = net.ReadVector(), net.ReadVector(), net.ReadVector()

    

    table.insert(boxesToDraw, {vector1, vector2, center})


end)

hook.Add("PostDrawTranslucentRenderables", "drawingBoxes", function(bDepth, bSkybox)

    if table.IsEmpty(boxesToDraw) then return end

    spacebattles.config.debug[LocalPlayer():SteamID64()] = true

    cam.Start3D()
    
    render.SetColorMaterial()

    for k, v in pairs(boxesToDraw) do
        
        render.DrawBox( v[3], Angle(0, 0, 0), Vector(v[1][1] - v[3][1], v[1][2] - v[3][2], v[1][3] - v[3][3]), Vector(v[2][1] - v[3][1], v[2][2] - v[3][2], v[2][3] - v[3][3]), Color( 0, 255, 255) )
        
    end

    cam.End3D()

end)