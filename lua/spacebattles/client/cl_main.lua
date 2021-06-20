local boxesToDraw = {}
local exitsToDraw = {}

net.Receive("drawTriggerOutlines", function()

    local vector1, vector2, center, debugon = net.ReadVector(), net.ReadVector(), net.ReadVector(), net.ReadBool()

    if debugon == true then
        boxesToDraw = {}
        return
    end

    table.insert(boxesToDraw, {vector1, vector2, center})


end)

net.Receive("drawExitOutlines", function()

    local pos, debugon = net.ReadVector(), net.ReadBool()
    if debugon == true then
        exitsToDraw = {}
        return
    end

    table.insert(exitsToDraw, pos)

end)

hook.Add("PostDrawTranslucentRenderables", "drawingBoxes", function(bDepth, bSkybox)

    if table.IsEmpty(boxesToDraw) then return end

    spacebattles.config.debug[LocalPlayer():SteamID64()] = true

    cam.Start3D()
    
    render.SetColorMaterial()

    for k, v in pairs(boxesToDraw) do
        
        render.DrawBox( v[3], Angle(0, 0, 0), Vector(v[1][1] - v[3][1], v[1][2] - v[3][2], v[1][3] - v[3][3]), Vector(v[2][1] - v[3][1], v[2][2] - v[3][2], v[2][3] - v[3][3]), Color( 0, 255, 255) )
        
    end

    for k, v in pairs(exitsToDraw) do
        
        render.DrawSphere(v, 50, 30, 30, Color(255, 0, 0))

    end

    cam.End3D()

end)