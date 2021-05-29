--[[

    Do NOT touch.
    This is needed to load all files.

]]

-- TABLE SET UP

spacebattles = spacebattles or {}
spacebattles.Script = spacebattles.Script or {}
spacebattles.Script.Name = "Space Battles"
spacebattles.Script.Author = "Jumpz"
spacebattles.Script.Build = "v1"
spacebattles.Script.Released = "29/05/21"
spacebattles.Script.Website = "https://github.com/Jumpz12"

-- INFORMATION

local luaroot = "spacebattles"
local loadlabel = "Space Battles"

local ScriptStartupHeader = {
    '\n\n',
    [[__________________________________________________ ]],
    '\n',
}

local ScriptStartupInfo = {
    [[Title      ....    ]] .. spacebattles.Script.Name .. [[ ]],
    [[Build      ....    ]] .. spacebattles.Script.Build .. [[ ]],
    [[Released   ....    ]] .. spacebattles.Script.Released .. [[ ]],
    [[Author     ....    ]] .. spacebattles.Script.Author .. [[ ]],
    [[Website    ....    ]] .. spacebattles.Script.Website .. [[ ]],
}

local ScriptStartupFooter = {
    [[__________________________________________________ ]],
}

for k, i in ipairs( ScriptStartupHeader ) do
    MsgC( Color( 255, 255, 0 ), i .. '\n' )
end

for k, i in ipairs( ScriptStartupInfo ) do
    MsgC( Color( 255, 255, 255 ), i .. '\n\n' )
end

for k, i in ipairs( ScriptStartupFooter ) do
    MsgC( Color( 255, 255, 0 ), i .. '\n\n' )
end

-- SERVER-SIDE

if SERVER then

    local fol = luaroot .. "/"
    local files, folders = file.Find(fol .. "*", "LUA")

    for k, v in pairs(files) do
        include(fol .. v)
    end

    for _, folder in SortedPairs(folders, true) do
        if folder == "." or folder == ".." then continue end

            for _, File in SortedPairs(file.Find(fol .. folder .. "/sh_*.lua", "LUA"), true) do
                MsgC(Color(255, 255, 0), "[" .. spacebattles.Script.Name .. "] SHARED file: " .. File .. "\n")
                AddCSLuaFile(fol .. folder .. "/" .. File)
                include(fol .. folder .. "/" .. File)
            end
        end

        for _, folder in SortedPairs(folders, true) do
            if folder == "." or folder == ".." then continue end

                for _, File in SortedPairs(file.Find(fol .. folder .. "/sv_*.lua", "LUA"), true) do
                    MsgC(Color(255, 255, 0), "[" .. spacebattles.Script.Name .. "] SERVER file: " .. File .. "\n")
                    include(fol .. folder .. "/" .. File)
                end
            end

            for _, folder in SortedPairs(folders, true) do
                if folder == "." or folder == ".." then continue end

                    for _, File in SortedPairs(file.Find(fol .. folder .. "/cl_*.lua", "LUA"), true) do
                        MsgC(Color(255, 255, 0), "[" .. spacebattles.Script.Name .. "] CLIENT file: " .. File .. "\n")
                        AddCSLuaFile(fol .. folder .. "/" .. File)
                    end
                end

                for _, folder in SortedPairs(folders, true) do
                    if folder == "." or folder == ".." then continue end

                        for _, File in SortedPairs(file.Find(fol .. folder .. "/vgui_*.lua", "LUA"), true) do
                            MsgC(Color(255, 255, 0), "[" .. spacebattles.Script.Name .. "] CLIENT file: " .. File .. "\n")
                            AddCSLuaFile(fol .. folder .. "/" .. File)
                        end
                    end

                    MsgC(Color( 0, 255, 0 ), "\n[ " .. loadlabel .. " Loaded ]\n\n")
                    MsgC(Color( 255, 255, 0), "__________________________________________________ \n\n")

                end

                -- CLIENT-SIDE

                if CLIENT then

                    local root = luaroot .. "/"
                    local _, folders = file.Find(root .. "*", "LUA")

                    for _, folder in SortedPairs(folders, true) do
                        if folder == "." or folder == ".." then continue end

                            for _, File in SortedPairs(file.Find(root .. folder .. "/sh_*.lua", "LUA"), true) do
                                MsgC(Color(255, 255, 0), "[" .. spacebattles.Script.Name .. "] SHARED file: " .. File .. "\n")
                                include(root .. folder .. "/" .. File)
                            end
                        end

                        for _, folder in SortedPairs(folders, true) do
                            for _, File in SortedPairs(file.Find(root .. folder .. "/cl_*.lua", "LUA"), true) do
                                MsgC(Color(255, 255, 0), "[" .. spacebattles.Script.Name .. "] CLIENT file: " .. File .. "\n")
                                include(root .. folder .. "/" .. File)
                            end
                        end

                        for _, folder in SortedPairs(folders, true) do
                            for _, File in SortedPairs(file.Find(root .. folder .. "/vgui_*.lua", "LUA"), true) do
                                MsgC(Color(255, 0, 0), "[" .. spacebattles.Script.Name .. "] VGUI file: " .. File .. "\n")
                                include(root .. folder .. "/" .. File)
                            end
                        end

                        MsgC(Color( 0, 255, 0 ), "\n[ " .. loadlabel .. " Loaded ]\n\n")
                        MsgC(Color( 255, 255, 0), "__________________________________________________ \n\n")

                    end
