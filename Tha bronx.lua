--// SpiritHub Loader for Tha Bronx 2 --//

-- Anti-Adonis AC Bypass
local debugMode = true

local function isAdonisAC(table)
    return rawget(table, "Detected") and typeof(rawget(table, "Detected")) == "function" and rawget(table, "RLocked")
end

local function dwarn(func, ...)
    if debugMode then
        func(...)
    end
end

for _, v in next, getgc(true) do
    if typeof(v) == "table" and isAdonisAC(v) then
        for i, v in next, v do
            if rawequal(i, "Detected") then
                local old;
                old = hookfunction(v, function(action, info, nocrash)
                    if rawequal(action, "_") and rawequal(info, "_") and rawequal(nocrash, true) then
                        return old(action, info, nocrash)
                    end
                    return task.wait(9e9)
                end)
            end
        end
    end
end

-- Bypass namecall
local old
old = hookmetamethod(game, "__namecall", newcclosure(function(self, ...)
    if not checkcaller() then
        local func = getnamecallmethod()
        if rawequal(func, "FireServer") and tonumber(self) then
            return wait(9e9)
        end
    end
    return old(self, ...)
end))

-- Load UI Library
local Library = loadstring(game:HttpGet("https://raw.githubusercontent.com/xHeptc/Kavo-UI-Library/main/source.lua"))()
local Window = Library.CreateLib("SpiritHub | Tha Bronx 2", "BlueTheme")

-- Player Tab
local Tab1 = Window:NewTab("Player")
local Section1 = Tab1:NewSection("Character Controls")

Section1:NewSlider("WalkSpeed", "Adjust speed", 100, 16, function(ws)
    game.Players.LocalPlayer.Character.Humanoid.WalkSpeed = ws
end)

Section1:NewSlider("JumpPower", "Adjust jump height", 47, 37, function(jp)
    game.Players.LocalPlayer.Character.Humanoid.JumpPower = jp
end)

Section1:NewSlider("Field of View", "Camera Zoom", 120, 87, function(fov)
    workspace.CurrentCamera.FieldOfView = fov
end)

Section1:NewButton("Equip Bag", "", function()
    fireclickdetector(workspace.dufflebagequip.ClickDetector)
end)

Section1:NewButton("Sell Gold", "", function()
    fireclickdetector(workspace.Map555555.sellgold.ClickDetector)
end)

Section1:NewButton("Equip RiceBag", "", function()
    fireclickdetector(workspace.GUNS.RiceBag.ClickDetector)
end)

Section1:NewButton("Teleport Tool", "", function()
    loadstring(game:HttpGet("https://pastebin.com/raw/RfkSLmL5", true))()
end)

-- Teleports
local Tab2 = Window:NewTab("Teleport")
local Section2 = Tab2:NewSection("Fast Travel")

local teleportList = {
    {"Car Dealer", CFrame.new(-455.61, 3.21, -571.39)},
    {"Police Station", CFrame.new(678.99, 3.61, -248.34)},
    {"Bank Upstairs", CFrame.new(-583.28, 82.38, -594.75)},
    {"Bank Lobby", CFrame.new(-609.23, 3.35, -600.31)},
    {"IceBox", CFrame.new(-612.23, 3.27, -639.69)},
    {"Gun Store", CFrame.new(-1226.68, 261.99, -802.01)},
    {"Kitchen", CFrame.new(-604.74, 3.18, -47.35)},
    {"Hotel", CFrame.new(-847.09, 3.27, 140.95)},
}

for _, v in pairs(teleportList) do
    Section2:NewButton(v[1], "", function()
        game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = v[2]
    end)
end

-- AutoFarm
local Tab3 = Window:NewTab("AutoFarm")
local Section3 = Tab3:NewSection("Quick Farming")

Section3:NewButton("Start AutoFarm Box", "", function()
    workspace.BoxParts["1"].Size = Vector3.new(500000, 50000, 50000)
    workspace.BoxParts["1"].CanCollide = false

    local plr = game:GetService("Players").LocalPlayer
    local backpack = plr:WaitForChild("Backpack")
    local char = plr.Character or plr.CharacterAdded:Wait()

    getgenv().autofarm = true
    while getgenv().autofarm do
        local tool = backpack:FindFirstChild("Box") or char:FindFirstChild("Box")
        if tool then
            char.Humanoid:EquipTool(tool)
            char.HumanoidRootPart.CFrame = CFrame.new(-1549, 247, -652)
        else
            char.HumanoidRootPart.CFrame = CFrame.new(-1469, 249, -598)
            fireproximityprompt(workspace["1# Map"]["2 Meshes"]:GetChildren()[1070].ProximityPrompt)
        end
        task.wait()
    end
end)

Section3:NewButton("Stop AutoFarm", "", function()
    getgenv().autofarm = false
    game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(-968.89, 253.53, -1037.97)
end)

-- Extra
local Tab4 = Window:NewTab("Extras")
local Section4 = Tab4:NewSection("Useful Stuff")

Section4:NewButton("Infinite Yield Admin", "", function()
    loadstring(game:HttpGet("https://raw.githubusercontent.com/EdgeIY/infiniteyield/master/source", true))()
end)

-- AutoBuy
local Tab5 = Window:NewTab("Shop")
local Section5 = Tab5:NewSection("Buy Items")

Section5:NewButton("Buy C4", "", function()
    fireclickdetector(workspace.GUNS.C4.ClickDetector)
end)

Section5:NewButton("Free Bank Bag", "", function()
    fireclickdetector(workspace.dufflebagequip.ClickDetector)
end)

Section5:NewButton("Buy Bag ($300)", "", function()
    fireproximityprompt(workspace.GUNS.Bag.Model.Sign.BuyPrompt.ProximityPrompt)
end)

Section5:NewButton("Buy Drill ($700)", "", function()
    fireproximityprompt(workspace.GUNS.Drill.Model.Sign.BuyPrompt.ProximityPrompt)
end)

Section5:NewButton("Get Gamepass Weapons", "", function()
    fireclickdetector(workspace.GUNS.DracoD.ClickDetector)
end)

-- Credits
local Tab6 = Window:NewTab("Credits")
local Section6 = Tab6:NewSection("Team SpiritHub")

Section6:NewButton("Developed by SpiritHub Team")
Section6:NewButton("Discord: .gg/SpiritHub")
