_G.Team = "Pirates" --// Pirates or Marines
_G.FruitList = {
    "Leopard-Leopard",
    "Venom-Venom",
    "Dough-Dough",
    "Portal-Portal"
}
_G.ChatList = {
    ""
}
repeat task.wait() until game:IsLoaded()
repeat task.wait() until game.Players
repeat task.wait() until game.Players.LocalPlayer
repeat task.wait() until game.Players.LocalPlayer:FindFirstChild("PlayerGui")
repeat task.wait() until game.Players.LocalPlayer.PlayerGui:FindFirstChild("Main");
--- Join Team
if game:GetService("Players").LocalPlayer.PlayerGui.Main:FindFirstChild("ChooseTeam") then
    repeat task.wait()
        if game:GetService("Players").LocalPlayer.PlayerGui:WaitForChild("Main").ChooseTeam.Visible == true then
            if _G.Team == "Marines" then
                for i, v in pairs(getconnections(game:GetService("Players").LocalPlayer.PlayerGui.Main.ChooseTeam.Container["Marines"].Frame.TextButton.Activated)) do
                    for a, b in pairs(getconnections(game:GetService("UserInputService").TouchTapInWorld)) do
                       b:Fire() 
                    end
                    v.Function()
                end 
            else
                for i, v in pairs(getconnections(game:GetService("Players").LocalPlayer.PlayerGui.Main.ChooseTeam.Container["Pirates"].Frame.TextButton.Activated)) do
                    for a, b in pairs(getconnections(game:GetService("UserInputService").TouchTapInWorld)) do
                       b:Fire() 
                    end
                    v.Function()
                end 
            end
        end
    until game.Players.LocalPlayer.Team ~= nil and game:IsLoaded()
end
--- Load & Save Setting
local foldername = "Apple Hub - Bounty"
local filename = foldername.."/Setting.json"
function saveSettings()
    local HttpService = game:GetService("HttpService")
    local json = HttpService:JSONEncode(_G)
    if true then
        if isfolder(foldername) then
            if isfile(filename) then
                writefile(filename, json)
            else
                writefile(filename, json)
            end
        else
            makefolder(foldername)
        end
    end
end
function loadSettings()
    local HttpService = game:GetService("HttpService")
    if isfolder(foldername) then
        if isfile(filename) then
            _G = HttpService:JSONDecode(readfile(filename))
        end
    end
end
--- Normal Setting
_G.TotalEarn = 0
_G.Time = 0
_G.StartHunt = true
_G.MinBounty = 0
_G.MaxBounty = 30000000
_G.WebhookUrl = "Enter your webhook here"
_G.UseWebhook = false
_G.SkipV4 = true
_G.SkipFruit = true
_G.UseV3 = true
_G.CustomHealthV3 = 95
_G.CustomHealthEnableV3 = true
_G.UseV4 = true
_G.FastClick = false
_G.AlwaysClick = true
_G.Chat = false
_G.LockCam = true
_G.BypassTP = true
_G.FpsBoost = false
_G.WhiteScreen = false
_G.SafeHealth = 30
-- Weapons
-- Melee
_G.MeleeDelay = 3
_G.UseMelee = true
_G.HoldZMelee = 0
_G.MeleeSkillZ = true
_G.HoldXMelee = 0
_G.MeleeSkillX = true
_G.HoldCMelee = 0
_G.MeleeSkillC = true
_G.HoldVMelee = 0
_G.MeleeSkillV = false
-- Sword
_G.SwordDelay = 2
_G.UseSword = true
_G.UseSwordMethod = true
_G.HoldZSword = 1
_G.SwordSkillZ = true
_G.HoldXSword = 0
_G.SwordSkillX = true
-- Gun
_G.GunDelay = 1
_G.UseGun = true
_G.UseGunMethod = false
_G.HoldZGun = 0
_G.GunSkillZ = true
_G.HoldXGun = 0
_G.GunSkillX = true
-- Fruit
_G.FruitDelay = 3
_G.UseFruit = true
_G.HoldZFruit = 0
_G.FruitSkillZ = true
_G.HoldXFruit = 0
_G.FruitSkillX = true
_G.HoldCFruit = 0
_G.FruitSkillC = true
_G.HoldVFruit = 0
_G.FruitSkillV = true
_G.HoldFFruit = 3
_G.FruitSkillF = false
--- Load
loadSettings()
--- Orion
local OrionLib = loadstring(game:HttpGet("https://raw.githubusercontent.com/memaybeohub/Function-Scripts/main/OrionLib.lua"))()
local Window = OrionLib:MakeWindow({Name = "Apple Hub - Bounty Farm", HidePremium = false, SaveConfig = true, ConfigFolder = "Apple Hub - Config"})
--- Counter
local MainTab = Window:MakeTab({
	Name = "Status",
	PremiumOnly = false
})
MainTab:AddButton({
	Name = "Skip Player",
	Callback = function()
        SkipPlayer()
  	end    
})
MainTab:AddButton({
	Name = "Copy Link Discord",
	Callback = function()
        setclipboard("https://discord.gg/JNAB9UDvCx")
  	end    
})
Earn = MainTab:AddParagraph("Earned","0")
Total = MainTab:AddParagraph("Total Earned","0")
Elapsed = MainTab:AddParagraph("Time","00:00:00")
Current = MainTab:AddParagraph("Current Bounty","0")
local SettingTab = Window:MakeTab({
	Name = "Setting",
	PremiumOnly = false
})
--- Hunt
SettingTab:AddButton({
	Name = "FPS Boost",
	Callback = function(Value)
		local removedecals = false
        local g = game
        local w = g.Workspace
        local l = g.Lighting
        local t = w.Terrain
        t.WaterWaveSize = 0
        t.WaterWaveSpeed = 0
        t.WaterReflectance = 0
        t.WaterTransparency = 0
        l.GlobalShadows = false
        l.FogEnd = 9e9
        l.Brightness = 0
        settings().Rendering.QualityLevel = "Level01"
        for i, v in pairs(g:GetDescendants()) do
            if v:IsA("Part") or v:IsA("Union") or v:IsA("CornerWedgePart") or v:IsA("TrussPart") then
                v.Material = "Plastic"
                v.Reflectance = 0
            elseif v:IsA("Decal") or v:IsA("Texture") and removedecals then
                v.Transparency = 1
            elseif v:IsA("ParticleEmitter") or v:IsA("Trail") then
                v.Lifetime = NumberRange.new(0)
            elseif v:IsA("Explosion") then
                v.BlastPressure = 1
                v.BlastRadius = 1
            elseif v:IsA("Fire") or v:IsA("SpotLight") or v:IsA("Smoke") or v:IsA("Sparkles") then
                v.Enabled = false
            elseif v:IsA("MeshPart") then
                v.Material = "Plastic"
                v.Reflectance = 0
                v.TextureID = 10385902758728957
            end
        end
        for i, e in pairs(l:GetChildren()) do
            if e:IsA("BlurEffect") or e:IsA("SunRaysEffect") or e:IsA("ColorCorrectionEffect") or e:IsA("BloomEffect") or e:IsA("DepthOfFieldEffect") then
                e.Enabled = false
            end
        end
        
        function ObjectRemvoe()
            for i,v in pairs(workspace:GetDescendants()) do
                if string.find(v.Name,"Tree") or string.find(v.Name,"House") then
                    v:Destroy()
                end
            end
        end
        
        function InvisibleObject()
            for i,v in pairs(game:GetService("Workspace"):GetDescendants()) do
                if  (v:IsA("Part") or v:IsA("MeshPart") or v:IsA("BasePart")) and v.Transparency then
                    v.Transparency = 1
                end
            end
        end
        ObjectRemvoe()
        InvisibleObject()
    end    
}) 
SettingTab:AddParagraph("Hunt","Setting Hunt for local player")
SettingTab:AddToggle({
	Name = "Start Hunt",
	Default = _G.StartHunt,
	Callback = function(Value)
		_G.StartHunt = Value
	end    
}) 
SettingTab:AddTextbox({
    Name = "Min Bounty Hunt",
    Default = _G.MinBounty,
    TextDisappear = true,
    Callback = function(Value)
        _G.MinBounty = Value
    end
})
SettingTab:AddTextbox({
    Name = "Max Bounty Target Hunt",
    Default = _G.MaxBounty,
    TextDisappear = true,
    Callback = function(Value)
        _G.MaxBounty = Value
    end
})
-- Hook
SettingTab:AddParagraph("Webhook","Webhook setting")
SettingTab:AddTextbox({
    Name = "Webhook",
    Default = _G.WebhookUrl,
    TextDisappear = true,
    Callback = function(Value)
        _G.WebhookUrl = Value
    end
})
SettingTab:AddButton({
	Name = "Test Webhook",
	Callback = function()
        wTest()
  	end    
})
SettingTab:AddToggle({
	Name = "Enable Webhook",
	Default = _G.UseWebhook,
	Callback = function(Value)
		_G.UseWebhook = Value
	end    
}) 
-- Skip
SettingTab:AddParagraph("Skip","Skip setting")
SettingTab:AddToggle({
	Name = "V4",
	Default = _G.SkipV4,
	Callback = function(Value)
		_G.SkipV4 = Value
	end    
}) 
SettingTab:AddToggle({
	Name = "Fruit",
	Default = _G.SkipFruit,
	Callback = function(Value)
		_G.SkipFruit = Value
	end    
}) 
-- Race
SettingTab:AddParagraph("Use Race","Race setting")
SettingTab:AddToggle({
	Name = "Use V3",
	Default = _G.UseV3,
	Callback = function(Value)
		_G.UseV3 = Value
	end    
}) 
SettingTab:AddSlider({
	Name = "Custom Health",
	Min = 0,
	Max = 100,
	Default = _G.CustomHealthV3,
	Color = Color3.fromRGB(255,255,255),
	Increment = 1,
	ValueName = "% Health",
	Callback = function(Value)
		_G.CustomHealthV3 = Value
	end    
})
SettingTab:AddToggle({
	Name = "Custom Health Enable",
	Default = _G.CustomHealthEnableV3,
	Callback = function(Value)
		_G.CustomHealthEnableV3 = Value
	end    
}) 
SettingTab:AddToggle({
	Name = "Use V4",
	Default = _G.UseV4,
	Callback = function(Value)
		_G.UseV4 = Value
	end    
}) 
-- Click
SettingTab:AddParagraph("Vitural User","About Player")
SettingTab:AddToggle({
	Name = "Fast Click",
	Default = _G.FastClick,
	Callback = function(Value)
		_G.FastClick = Value
	end    
}) 
SettingTab:AddToggle({
	Name = "Always Click",
	Default = _G.AlwaysClick,
	Callback = function(Value)
		_G.AlwaysClick = Value
	end    
}) 
-- Another
SettingTab:AddParagraph("Another","Can choose or not")
SettingTab:AddToggle({
	Name = "Chat",
	Default = _G.Chat,
	Callback = function(Value)
		_G.Chat = Value
	end    
}) 
SettingTab:AddToggle({
	Name = "Lock Camera",
	Default = _G.LockCam,
	Callback = function(Value)
		_G.LockCam = Value
	end    
}) 
SettingTab:AddToggle({
	Name = "Bypass TP",
	Default = _G.BypassTP,
	Callback = function(Value)
		_G.BypassTP = Value
	end    
}) 
SettingTab:AddToggle({
	Name = "White Screen",
	Default = _G.WhiteScreen,
	Callback = function(Value)
        _G.WhiteScreen = Value
		game.RunService:Set3dRenderingEnabled(not Value)
	end    
}) 
SettingTab:AddSlider({
	Name = "Safe Health",
	Min = 0,
	Max = 100,
	Default = _G.SafeHealth,
	Color = Color3.fromRGB(255,255,255),
	Increment = 1,
	ValueName = "% Health",
	Callback = function(Value)
		_G.SafeHealth = Value
	end    
})
-- Melee
SettingTab:AddParagraph("Melee","Setting for Melee")
SettingTab:AddSlider({
	Name = "Delay",
	Min = 0,
	Max = 5,
	Default = _G.MeleeDelay,
	Color = Color3.fromRGB(255,255,255),
	Increment = 1,
	ValueName = "Second",
	Callback = function(Value)
		_G.MeleeDelay = Value
	end    
})
SettingTab:AddToggle({
	Name = "Use Melee",
	Default = _G.UseMelee,
	Callback = function(Value)
		_G.UseMelee = Value
	end    
}) 
SettingTab:AddSlider({
	Name = "Hold Skill Z",
	Min = 0,
	Max = 5,
	Default = _G.HoldZMelee,
	Color = Color3.fromRGB(255,255,255),
	Increment = 1,
	ValueName = "Second",
	Callback = function(Value)
		_G.HoldZMelee = Value
	end    
})
SettingTab:AddToggle({
	Name = "Use Skill Z",
	Default = _G.MeleeSkillZ,
	Callback = function(Value)
		_G.MeleeSkillZ = Value
	end    
}) 
SettingTab:AddSlider({
	Name = "Hold Skill X",
	Min = 0,
	Max = 5,
	Default = _G.HoldXMelee,
	Color = Color3.fromRGB(255,255,255),
	Increment = 1,
	ValueName = "Second",
	Callback = function(Value)
		_G.HoldXMelee = Value
	end    
})
SettingTab:AddToggle({
	Name = "Use Skill X",
	Default = _G.MeleeSkillX,
	Callback = function(Value)
		_G.MeleeSkillX = Value
	end    
}) 
SettingTab:AddSlider({
	Name = "Hold Skill C",
	Min = 0,
	Max = 5,
	Default = _G.HoldCMelee,
	Color = Color3.fromRGB(255,255,255),
	Increment = 1,
	ValueName = "Second",
	Callback = function(Value)
		_G.HoldCMelee = Value
	end    
})
SettingTab:AddToggle({
	Name = "Use Skill C",
	Default = _G.MeleeSkillC,
	Callback = function(Value)
		_G.MeleeSkillC = Value
	end    
}) 
SettingTab:AddSlider({
	Name = "Hold Skill V",
	Min = 0,
	Max = 5,
	Default = _G.HoldVMelee,
	Color = Color3.fromRGB(255,255,255),
	Increment = 1,
	ValueName = "Second",
	Callback = function(Value)
		_G.HoldVMelee = Value
	end    
})
SettingTab:AddToggle({
	Name = "Use Skill V",
	Default = _G.MeleeSkillV,
	Callback = function(Value)
		_G.MeleeSkillV = Value
	end    
}) 
--- Sword
SettingTab:AddParagraph("Sword","Setting for Sword") 
SettingTab:AddSlider({
	Name = "Delay",
	Min = 0,
	Max = 5,
	Default = _G.SwordDelay,
	Color = Color3.fromRGB(255,255,255),
	Increment = 1,
	ValueName = "Second",
	Callback = function(Value)
		_G.SwordDelay = Value
	end    
})
SettingTab:AddToggle({
	Name = "Use Sword",
	Default = _G.UseSword,
	Callback = function(Value)
		_G.UseSword = Value
	end    
}) 
SettingTab:AddToggle({
	Name = "Use Sword Method",
	Default = _G.UseSwordMethod,
	Callback = function(Value)
		_G.UseSwordMethod = Value
	end    
}) 
SettingTab:AddSlider({
	Name = "Hold Skill Z",
	Min = 0,
	Max = 5,
	Default = _G.HoldZSword,
	Color = Color3.fromRGB(255,255,255),
	Increment = 1,
	ValueName = "Second",
	Callback = function(Value)
		_G.HoldZSword = Value
	end    
})
SettingTab:AddToggle({
	Name = "Use Skill Z",
	Default = _G.SwordSkillZ,
	Callback = function(Value)
		_G.SwordSkillZ = Value
	end    
}) 
SettingTab:AddSlider({
	Name = "Hold Skill X",
	Min = 0,
	Max = 5,
	Default = _G.HoldXSword,
	Color = Color3.fromRGB(255,255,255),
	Increment = 1,
	ValueName = "Second",
	Callback = function(Value)
		_G.HoldXSword = Value
	end    
})
SettingTab:AddToggle({
	Name = "Use Skill X",
	Default = _G.SwordSkillX,
	Callback = function(Value)
		_G.SwordSkillX = Value
	end    
}) 
--- Gun
SettingTab:AddParagraph("Gun","Setting for Gun") 
SettingTab:AddSlider({
	Name = "Delay",
	Min = 0,
	Max = 5,
	Default = _G.GunDelay,
	Color = Color3.fromRGB(255,255,255),
	Increment = 1,
	ValueName = "Second",
	Callback = function(Value)
		_G.GunDelay = Value
	end    
})
SettingTab:AddToggle({
	Name = "Use Gun",
	Default = _G.UseGun,
	Callback = function(Value)
		_G.UseGun = Value
	end    
})
SettingTab:AddToggle({
	Name = "Use Gun Method",
	Default = _G.UseGunMethod,
	Callback = function(Value)
		_G.UseGunMethod = Value
	end    
}) 
SettingTab:AddSlider({
	Name = "Hold Skill Z",
	Min = 0,
	Max = 5,
	Default = _G.HoldZGun,
	Color = Color3.fromRGB(255,255,255),
	Increment = 1,
	ValueName = "Second",
	Callback = function(Value)
		_G.HoldZGun = Value
	end    
})
SettingTab:AddToggle({
	Name = "Use Skill Z",
	Default = _G.GunSkillZ,
	Callback = function(Value)
		_G.GunSkillZ = Value
	end    
}) 
SettingTab:AddSlider({
	Name = "Hold Skill X",
	Min = 0,
	Max = 5,
	Default = _G.HoldXGun,
	Color = Color3.fromRGB(255,255,255),
	Increment = 1,
	ValueName = "Second",
	Callback = function(Value)
		_G.HoldXGun = Value
	end    
})
SettingTab:AddToggle({
	Name = "Use Skill X",
	Default = _G.GunSkillX,
	Callback = function(Value)
		_G.GunSkillX = Value
	end    
}) 
-- Fruit
SettingTab:AddParagraph("Fruit","Setting for Melee") 
SettingTab:AddSlider({
	Name = "Delay",
	Min = 0,
	Max = 5,
	Default = _G.FruitDelay,
	Color = Color3.fromRGB(255,255,255),
	Increment = 1,
	ValueName = "Second",
	Callback = function(Value)
		_G.FruitDelay = Value
	end    
})
SettingTab:AddToggle({
	Name = "Use Fruit",
	Default = _G.UseFruit,
	Callback = function(Value)
		_G.UseFruit = Value
	end    
}) 
SettingTab:AddSlider({
	Name = "Hold Skill Z",
	Min = 0,
	Max = 5,
	Default = _G.HoldZFruit,
	Color = Color3.fromRGB(255,255,255),
	Increment = 1,
	ValueName = "Second",
	Callback = function(Value)
		_G.HoldZFruit = Value
	end    
})
SettingTab:AddToggle({
	Name = "Use Skill Z",
	Default = _G.FruitSkillZ,
	Callback = function(Value)
		_G.FruitSkillZ = Value
	end    
}) 
SettingTab:AddSlider({
	Name = "Hold Skill X",
	Min = 0,
	Max = 5,
	Default = _G.HoldXFruit,
	Color = Color3.fromRGB(255,255,255),
	Increment = 1,
	ValueName = "Second",
	Callback = function(Value)
		_G.HoldXFruit = Value
	end    
})
SettingTab:AddToggle({
	Name = "Use Skill X",
	Default = _G.FruitSkillX ,
	Callback = function(Value)
		_G.FruitSkillX = Value
	end    
}) 
SettingTab:AddSlider({
	Name = "Hold Skill C",
	Min = 0,
	Max = 5,
	Default = _G.HoldCFruit,
	Color = Color3.fromRGB(255,255,255),
	Increment = 1,
	ValueName = "Second",
	Callback = function(Value)
		_G.HoldCFruit = Value
	end    
})
SettingTab:AddToggle({
	Name = "Use Skill C",
	Default = _G.FruitSkillC,
	Callback = function(Value)
		_G.FruitSkillC = Value
	end    
}) 
SettingTab:AddSlider({
	Name = "Hold Skill V",
	Min = 0,
	Max = 5,
	Default = 0,
	Color = Color3.fromRGB(255,255,255),
	Increment = 1,
	ValueName = "Second",
	Callback = function(Value)
		_G.HoldVFruit = Value
	end    
})
SettingTab:AddToggle({
	Name = "Use Skill V",
	Default = false,
	Callback = function(Value)
		_G.UseSkillV = Value
	end    
}) 
SettingTab:AddSlider({
	Name = "Hold Skill F",
	Min = 0,
	Max = 5,
	Default = 0,
	Color = Color3.fromRGB(255,255,255),
	Increment = 1,
	ValueName = "Second",
	Callback = function(Value)
		_G.HoldFFruit = Value
	end    
})
SettingTab:AddToggle({
	Name = "Use Skill F",
	Default = false,
	Callback = function(Value)
		_G.UseSkillF = Value
	end    
}) 
function Notify(content)
    content = tostring(content)
    OrionLib:MakeNotification({
        Name = "Apple Hub Auto Bounty",
        Content = content,
        Time = 5
    })
end
--- Tween + Bypass
local p = game.Players
local lp = p.LocalPlayer

local rs = game.RunService
local hb = rs.Heartbeat
local rends = rs.RenderStepped
local webhook = {} 

getgenv().weapon = nil
getgenv().targ = nil 
getgenv().checked = {}
getgenv().pl = p:GetPlayers()
getgenv().incheck = nil
--- Tween / Bypass ---
local w = game.PlaceId
if w == 2753915549 then
    distbyp = 1500
    gQ = {
        Vector3.new(-7894.6201171875, 5545.49169921875, -380.246346191406),
        Vector3.new(-4607.82275390625, 872.5422973632812, -1667.556884765625),
        Vector3.new(61163.8515625, 11.759522438049316, 1819.7841796875),
        Vector3.new(3876.280517578125, 35.10614013671875, -1939.3201904296875)
    }
elseif w == 4442272183 then
    distbyp = 3500
    gQ = {
        Vector3.new(-288.46246337890625, 306.130615234375, 597.9988403320312),
        Vector3.new(2284.912109375, 15.152046203613281, 905.48291015625),
        Vector3.new(923.21252441406, 126.9760055542, 32852.83203125),
        Vector3.new(-6508.5581054688, 89.034996032715, -132.83953857422)
    }
elseif w == 7449423635 then
    distbyp = 7000
    gQ = {
        Vector3.new(-5058.77490234375, 314.5155029296875, -3155.88330078125),
        Vector3.new(5756.83740234375, 610.4240112304688, -253.9253692626953),
        Vector3.new(-12463.8740234375, 374.9144592285156, -7523.77392578125),
        Vector3.new(28282.5703125, 14896.8505859375, 105.1042709350586),
        Vector3.new(-11993.580078125, 334.7812805175781, -8844.1826171875),
        Vector3.new(5314.58203125, 25.419387817382812, -125.94227600097656)
    }
else
    lp:Kick("Game not supported!")
end
function bypass(is)                 
    repeat task.wait()
        lp.Character.HumanoidRootPart.CFrame = is  
    until lp.Character.PrimaryPart.CFrame == is  
    game:GetService("Players").LocalPlayer.Character:WaitForChild("Humanoid", 9):ChangeState(15)
    lp.Character:SetPrimaryPartCFrame(is)
    wait(0.1)
    lp.Character.Head:Destroy()
    repeat task.wait() until lp.Character:FindFirstChild("Humanoid").Health <= 0
    repeat task.wait()
        lp.Character.PrimaryPart.CFrame = is  
    until lp.Character:FindFirstChild("Head") and lp.Character:FindFirstChild("Humanoid").Health > 0
    wait(0.5)
end 
function getSpawn(wtf)
    local a, b = nil, math.huge
    for i,v in pairs(game.Workspace._WorldOrigin.PlayerSpawns:FindFirstChild(tostring(lp.Team)):GetChildren()) do
        if tostring(v) ~= "Leviathan" and (v:GetModelCFrame().Position-wtf.Position).Magnitude < b then
            table.insert(gQ,v)
            a = v:GetModelCFrame()
            b = (v:GetModelCFrame().Position-wtf.Position).Magnitude
        end
    end
    return a
end
function getPortal(check2)
    local check3 = check2.Position
    local aM, aN = Vector3.new(0,0,0), math.huge
    for _, aL in pairs(gQ) do
        if (aL-check3).Magnitude < aN and aM ~= aL then
            aM, aN = aL,  (aL-check3).Magnitude
        end 
    end
    return aM
end 
function request(check1)
    game.ReplicatedStorage.Remotes.CommF_:InvokeServer(unpack({"requestEntrance", check1}))
end

function calcpos(I, II) 
    if not II then 
        II = game.Players.LocalPlayer.Character.PrimaryPart.CFrame 
    end 
    return (Vector3.new(I.X, 0, I.Z)-Vector3.new(II.X, 0, II.Z)).Magnitude 
end 
function checkincombat()
    return (game:GetService("Players").LocalPlayer.PlayerGui.Main.InCombat.Visible and game:GetService("Players").LocalPlayer.PlayerGui.Main.InCombat.Text and (string.find(string.lower(game:GetService("Players").LocalPlayer.PlayerGui.Main.InCombat.Text),"risk")))
end 
function to(Pos)
    pcall(function()
        if lp.Character:FindFirstChild("HumanoidRootPart") and lp.Character:FindFirstChild("Humanoid").Health > 0 then
            Distance = calcpos(game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame, Pos)
            for a, b in pairs(game.Players.LocalPlayer.Character:GetDescendants()) do
                if b:IsA"BasePart" then
                    b.CanCollide = false
                end
            end
            if not game.Players.LocalPlayer.Character.Head:FindFirstChild("Rimus") then
                local ngu = Instance.new("BodyVelocity", game.Players.LocalPlayer.Character.Head)
                ngu.Name = "Rimus"
                ngu.MaxForce = Vector3.new(0,math.huge,0)
                ngu.Velocity = Vector3.new(0,0,0)
            end
            if game.Players.LocalPlayer.Character.Humanoid.Sit == true then
                game.Players.LocalPlayer.Character.Humanoid.Sit = false
            end
            if Distance < 500 then
                Speed = 400
            elseif Distance < 1000 then
                Speed = 375
            elseif Distance >= 1000 then
                Speed = 350
            end
            Portal = getPortal(Pos) 
            Spawn = getSpawn(Pos)
            if Distance > calcpos(Portal, Spawn) and Distance > calcpos(Portal, Pos) and calcpos(Portal,Spawn) <= 500 then
                return request(Portal) 
            end
            if calcpos(Portal,Spawn) > 500 and _G.BypassTP and not checkincombat() and Distance > calcpos(Spawn, Pos) and calcpos(game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame, Spawn) > distbyp then
                return bypass(Spawn)
            end
            pcall(function()
                tween = game:GetService("TweenService"):Create(game.Players.LocalPlayer.Character.HumanoidRootPart,TweenInfo.new(Distance / Speed, Enum.EasingStyle.Linear),{CFrame = Pos})
                tween:Play()
            end)
            game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame.X, Pos.Y, game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame.Z)
        end
    end)
end
--- Buso ---
function buso()
    if (not (game.Players.LocalPlayer.Character:FindFirstChild("HasBuso"))) then
        local rel = game.ReplicatedStorage
        rel.Remotes.CommF_:InvokeServer("Buso")
    end
end
--- Ken ---
function Ken()
    if game:GetService("Players").LocalPlayer:FindFirstChild("PlayerGui") and game.Players.LocalPlayer.PlayerGui:FindFirstChild("ScreenGui") and game.Players.LocalPlayer.PlayerGui.ScreenGui:FindFirstChild("ImageLabel") then
        buoi = true
    else
        game:service("VirtualUser"):CaptureController()
        game:service("VirtualUser"):SetKeyDown("0x65")
        game:service("VirtualUser"):SetKeyUp("0x65")
    end
end
--- Sent Key To Cilent ---
function down(use)
    pcall(function()
        game:GetService("VirtualInputManager"):SendKeyEvent(true,use,false,game.Players.LocalPlayer.Character.HumanoidRootPart)
        task.wait(l)
        game:GetService("VirtualInputManager"):SendKeyEvent(false,use,false,game.Players.LocalPlayer.Character.HumanoidRootPart)
    end)
end
--- Equip ---
function equip(tooltip)
    local player = game.Players.LocalPlayer
    local character = player.Character or player.CharacterAdded:wait()
    for _, item in pairs(player.Backpack:GetChildren()) do
        if item:IsA("Tool") and item.ToolTip == tooltip then
            local humanoid = character:FindFirstChildOfClass("Humanoid")
            if humanoid and not humanoid:IsDescendantOf(item) then
                game.Players.LocalPlayer.Character.Humanoid:EquipTool(item)
                return true
            end
        end
    end
    return false
end
function EquipWeapon(Tool)
    pcall(
        function()
            if game.Players.LocalPlayer.Backpack:FindFirstChild(Tool) then
                local ToolHumanoid = game.Players.LocalPlayer.Backpack:FindFirstChild(Tool)
                ToolHumanoid.Parent = lp.Character
            end
        end
    )
end
function EquipWeaponTool(Tool)
    for _, item in pairs(lp.Backpack:GetChildren()) do
        if item:IsA("Tool") and item.ToolTip == Tool then
            item.Parent = lp.Character
            return true
        end
    end
    return false
end
--- Click ---
function Click()
    game:GetService("VirtualUser"):CaptureController()
    game:GetService("VirtualUser"):Button1Down(Vector2.new(0,1,0,1))
end
--- Check Fruit
function hasValue(array, targetString)
    for _, value in ipairs(array) do
        if value == targetString then
            return true
        end
    end
    return false
end
--- Fast Attack
if _G.FastClick then
    local CameraShaker = require(game.ReplicatedStorage.Util.CameraShaker)
    CameraShaker:Stop()
    fastattack = true
    CombatFrameworkR = require(game:GetService("Players").LocalPlayer.PlayerScripts.CombatFramework)
    y = debug.getupvalues(CombatFrameworkR)[2]
    spawn(function()
        game:GetService("RunService").RenderStepped:Connect(function()
            if fastattack then
                if typeof(y) == "table" then
                    pcall(function()
                        y.activeController.timeToNextAttack = 0
                        y.activeController.hitboxMagnitude = 60
                        y.activeController.active = false
                        y.activeController.timeToNextBlock = 0
                        y.activeController.focusStart = 1655503339.0980349
                        y.activeController.increment = 1
                        y.activeController.blocking = false
                        y.activeController.attacking = false
                        y.activeController.humanoid.AutoRotate = true
                    end)
                end
            end
        end)
    end)
    spawn(function()
        game:GetService("RunService").RenderStepped:Connect(function()
            if fastattack == true then
                if game.Players.LocalPlayer.Character:FindFirstChild("Stun") then
                    game.Players.LocalPlayer.Character.Stun.Value = 0
                    game.Players.LocalPlayer.Character.Busy.Value = false 
                end
            end
        end)
    end)
else
    local CameraShaker = require(game.ReplicatedStorage.Util.CameraShaker)
    CameraShaker:Stop()
    CombatFrameworkR = require(game:GetService("Players").LocalPlayer.PlayerScripts.CombatFramework)
    y = debug.getupvalues(CombatFrameworkR)[2]
    spawn(function()
        game:GetService("RunService").RenderStepped:Connect(function()
            if typeof(y) == "table" then
                pcall(function()
                    y.activeController.hitboxMagnitude = 60
                    y.activeController.active = false
                    y.activeController.timeToNextBlock = 0
                    y.activeController.focusStart = 1655503339.0980349
                    y.activeController.increment = 1
                    y.activeController.blocking = false
                    y.activeController.attacking = false
                    y.activeController.humanoid.AutoRotate = true
                end)
            end
        end)
    end)
end
--- Hop Server ---
spawn(function()
    while task.wait() do
        if hopserver then
            stopbypass = true
            starthop = true
        end
    end
end)
spawn(function()
    while task.wait() do
        if starthop and getgenv().targ == nil then
            repeat task.wait()
            to(lp.Character.HumanoidRootPart.CFrame*CFrame.new(0,math.random(500,10000),0))
            until (game:GetService("Players").LocalPlayer.PlayerGui.Main.InCombat.Visible and not string.find(string.lower(game:GetService("Players").LocalPlayer.PlayerGui.Main.InCombat.Text), "risk")) or (not game:GetService("Players").LocalPlayer.PlayerGui.Main.InCombat.Visible)
            to(CFrame.new(0,10000,0))
            HopServer()
            to(lp.Character.HumanoidRootPart.CFrame*CFrame.new(0,math.random(500,10000),0))
        end
    end
end)
function HopServer(bO)
    pcall(function()
        if not bO then
            bO = 10
        end
        ticklon = tick()
        repeat
            task.wait()
        until tick() - ticklon >= 1
        local function Hop()
            for r = 1, math.huge do
                if ChooseRegion == nil or ChooseRegion == "" then
                    ChooseRegion = "Singapore"
                else
                    game:GetService("Players").LocalPlayer.PlayerGui.ServerBrowser.Frame.Filters.SearchRegion.TextBox.Text =
                        ChooseRegion
                end
                local bP = game:GetService("ReplicatedStorage").__ServerBrowser:InvokeServer(r)
                for k, v in pairs(bP) do
                    if k ~= game.JobId and v["Count"] < bO then
                    game:GetService("ReplicatedStorage").__ServerBrowser:InvokeServer("teleport", k)
                    end
                end
            end
            return false
        end
        if not getgenv().Loaded then
            local function bQ(v)
                if v.Name == "ErrorPrompt" then
                    if v.Visible then
                        if v.TitleFrame.ErrorTitle.Text == "Teleport Failed" then
                            HopServer()
                            v.Visible = false
                        end
                    end
                    v:GetPropertyChangedSignal("Visible"):Connect(
                        function()
                            if v.Visible then
                                if v.TitleFrame.ErrorTitle.Text == "Teleport Failed" then
                                    HopServer()
                                    v.Visible = false
                                end
                            end
                        end
                    )
                end
            end
            for k, v in pairs(game.CoreGui.RobloxPromptGui.promptOverlay:GetChildren()) do
                bQ(v)
            end
            game.CoreGui.RobloxPromptGui.promptOverlay.ChildAdded:Connect(bQ)
            getgenv().Loaded = true
        end
        while not Hop() do
            task.wait()
        end
    end)
end
--- Skip Player
function SkipPlayer()
    getgenv().killed = getgenv().targ 
    task.wait()
    table.insert(getgenv().checked, getgenv().killed)
    getgenv().targ = nil
    target()
end
--- Circular Tween
local radius = 15
local angle = 0
function getNextPosition(center)
    angle = angle + 20
    return center + Vector3.new(math.sin(math.rad(angle)) * radius, 15, math.cos(math.rad(angle)) * radius)
end
--- Main
task.wait(0.5)
function target() 
    pcall(function()
        d = math.huge
        p = nil
        getgenv().targ = nil
        for i, v in pairs(game.Players:GetPlayers()) do 
            if v.Team ~= nil and (tostring(lp.Team) == "Pirates" or (tostring(v.Team) == "Pirates" and tostring(lp.Team) ~= "Pirates")) then
                if v and v:FindFirstChild("Data") and ((_G.SkipFruit and hasValue(_G.FruitList, v.Data.DevilFruit.Value) == false) or not _G.SkipFruit) then
                    if v ~= lp and v ~= getgenv().targ and (v.Character:FindFirstChild("HumanoidRootPart").CFrame.Position - game.Players.LocalPlayer.Character:FindFirstChild("HumanoidRootPart").CFrame.Position).Magnitude < d and hasValue(getgenv().checked, v) == false and v.Character.HumanoidRootPart.CFrame.Y <= 12000 then
                        if (tonumber(game.Players.LocalPlayer.Data.Level.Value) - 250) < v.Data.Level.Value and v.Data.Level.Value > 20 then
                            if v.leaderstats["Bounty/Honor"].Value >= tonumber(_G.MinBounty) and v.leaderstats["Bounty/Honor"].Value <= tonumber(_G.MaxBounty) and not hopserver then 
                                if (_G.SkipV4 and not v.Character:FindFirstChild("RaceTransformed")) or not _G.SkipV4 then
                                    if calcpos(getSpawn(v.Character.HumanoidRootPart.CFrame), v.Character.HumanoidRootPart.CFrame) < distbyp then
                                        p = v 
                                        d = (v.Character.HumanoidRootPart.CFrame.Position - game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame.Position).Magnitude 
                                        if _G.Chat then
                                            game:GetService("ReplicatedStorage"):WaitForChild("DefaultChatSystemChatEvents"):FindFirstChild("SayMessageRequest"):FireServer(_G.ChatList[math.random(0, #_G.ChatList)], "All")
                                        end
                                    end
                                end
                            end
                        end
                    end 
                end
            end
        end 
        if p == nil then hopserver = true end 
        getgenv().targ = p
    end)
end
spawn(function()
    while task.wait() do
        pcall(function()
	        if _G.StartHunt then
                if getgenv().targ and getgenv().targ.Character and (getgenv().targ.Character.HumanoidRootPart.CFrame.Position - game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame.Position).Magnitude < 40 then
                    Ken()
                end
	        end
        end)
    end
end)
spawn(function()
    while task.wait() do
        pcall(function()
            if _G.StartHunt then
                if getgenv().targ.Character:FindFirstChild("HumanoidRootPart") and game.Players.LocalPlayer.Character:FindFirstChild("HumanoidRootPart") then
                    if (getgenv().targ.Character:WaitForChild("HumanoidRootPart").CFrame.Position - game.Players.LocalPlayer.Character:WaitForChild("HumanoidRootPart").CFrame.Position).Magnitude < 40 then 
                        if _G.UseGunMethod and not _G.UseSwordMethod then
                            EquipWeaponTool("Melee")
                            EquipWeaponTool("Gun") 
                        elseif not _G.UseGunMethod and _G.UseSwordMethod then
                            EquipWeaponTool("Melee")
                            EquipWeaponTool("Sword") 
                        elseif _G.UseGunMethod and _G.UseSwordMethod then
                            EquipWeaponTool("Melee")
                            EquipWeaponTool("Sword")
                            EquipWeaponTool("Gun") 
                        else
                            if _G.UseMelee then
                                getgenv().weapon = "Melee"
                                task.wait(_G.MeleeDelay)
                            end
                            if _G.UseSword then
                                getgenv().weapon = "Sword"
                                task.wait(_G.SwordDelay)
                            end
                            if _G.UseGun then
                                getgenv().weapon = "Gun"
                                task.wait(_G.GunDelay)
                            end
                            if _G.UseFruit then
                                getgenv().weapon = "Blox Fruit"
                                task.wait(_G.FruitDelay)
                            end
                        end
                    end
                end
            end
        end)
    end
end)
spawn(function()
    while task.wait() do 
        pcall(function()
	        if _G.StartHunt then
                if game:GetService("Players").LocalPlayer.PlayerGui.Main.PvpDisabled.Visible == true then
                    game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("EnablePvp")
                end
                if getgenv().targ ~= nil and getgenv().targ.Character and (getgenv().targ.Character.HumanoidRootPart.CFrame.Position - game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame.Position).Magnitude < 60 then
                    buso()
                    if _G.UseV3 then
                        if _G.CustomHealthEnableV3 and lp.Character.Humanoid.Health <= lp.Character.Humanoid.MaxHealth * (_G.CustomHealthV3/100) then
                            l = 0.1
                            down("T")
                        end
                    end
                    if _G.UseV4 then
                        l = 0.1
                        down("Y")
                    end  
                    for i, v in pairs(game.Players.LocalPlayer.PlayerGui.Notifications:GetChildren()) do 
                        local gay = v:GetChildren() 
                        if v:IsA("TextLabel") and (string.find(string.lower(v.Text), "player") or string.find(string.lower(v.Text), "người chơi")) then 
                            SkipPlayer()
                            v:Destroy()
                            Notify("PVP Dislable")
                        end
                    end 
                end
	        end
        end)
    end
end)
spawn(function()
    while task.wait() do
        if _G.StartHunt then
            pcall(function()
                if getgenv().targ ~= nil and (getgenv().targ.Character:WaitForChild("HumanoidRootPart").CFrame.Position - game.Players.LocalPlayer.Character:WaitForChild("HumanoidRootPart").CFrame.Position).Magnitude < 20 then 
                    task.wait(1)
                    if game:GetService("Players").LocalPlayer.PlayerGui.Main.SafeZone.Visible == true then
                        SkipPlayer()
                        Notify("Player In Safe Zone")
                    end 
                end
            end)
        end
    end
end)
-- spawn sea beast
spawn(function()
    while task.wait() do
        if _G.StartHunt then
            if getgenv().targ == nil or not getgenv().targ or not getgenv().targ.Character then target() end
            if getgenv().targ == nil then hopserver = true end 
            pcall(function()
                if getgenv().targ.Character:FindFirstChild("HumanoidRootPart") and game.Players.LocalPlayer.Character:FindFirstChild("HumanoidRootPart") then
                    if (getgenv().targ.Character:WaitForChild("HumanoidRootPart").CFrame.Position - game.Players.LocalPlayer.Character:WaitForChild("HumanoidRootPart").CFrame.Position).Magnitude < 40 then 
                        spawn(function()
                            if not _G.UseGunMethod and not _G.UseSwordMethod then
                                EquipWeapon("Summon Sea Beast")
                                equip(getgenv().weapon)
                                for i, v in pairs(game.Players.LocalPlayer.Character:GetChildren()) do 
                                    if v:IsA("Tool") and v.ToolTip == "Melee" then
                                        if _G.UseMelee then
                                            if game.Players.LocalPlayer.PlayerGui.Main.Skills[v.Name]:FindFirstChild("Z").Cooldown.AbsoluteSize.X <= 0 and _G.MeleeSkillZ then	
                                                l = _G.HoldZMelee
                                                down("Z")
                                            elseif game.Players.LocalPlayer.PlayerGui.Main.Skills[v.Name]:FindFirstChild("X").Cooldown.AbsoluteSize.X <= 0 and _G.MeleeSkillX then	
                                                l = _G.HoldXMelee
                                                down("X")
                                            elseif game.Players.LocalPlayer.PlayerGui.Main.Skills[v.Name]:FindFirstChild("C").Cooldown.AbsoluteSize.X <= 0 and _G.MeleeSkillC then	
                                                l = _G.HoldCMelee
                                                down("C")
                                            elseif _G.MeleeSkillV then
                                                if game.Players.LocalPlayer.PlayerGui.Main.Skills[v.Name]:FindFirstChild("V").Cooldown.AbsoluteSize.X <= 0 then	
                                                    l = _G.HoldVMelee
                                                    down("V")
                                                else 
                                                    Click()
                                                end
                                            else 
                                                Click()
                                            end
                                        end
                                    elseif v:IsA("Tool") and v.ToolTip == "Gun" then
                                        if _G.UseGun then
                                            if game.Players.LocalPlayer.PlayerGui.Main.Skills[v.Name]:FindFirstChild("Z").Cooldown.AbsoluteSize.X <= 0 and _G.GunSkillZ then	
                                                l = _G.HoldZGun
                                                down("Z")
                                            elseif game.Players.LocalPlayer.PlayerGui.Main.Skills[v.Name]:FindFirstChild("X").Cooldown.AbsoluteSize.X <= 0 and _G.GunSkillX then	
                                                l = _G.HoldXGun
                                                down("X")
                                            else
                                                Click()
                                            end
                                        end
                                    elseif v:IsA("Tool") and v.ToolTip == "Sword" then
                                        if _G.UseSword then
                                            if game.Players.LocalPlayer.PlayerGui.Main.Skills[v.Name]:FindFirstChild("Z").Cooldown.AbsoluteSize.X <= 0 and _G.SwordSkillZ then	
                                                l = _G.HoldZSword
                                                down("Z")
                                            elseif game.Players.LocalPlayer.PlayerGui.Main.Skills[v.Name]:FindFirstChild("X").Cooldown.AbsoluteSize.X <= 0 and _G.SwordSkillX then	
                                                l = _G.HoldXSword
                                                down("X")
                                            else
                                                Click()
                                            end
                                        end
                                    elseif v:IsA("Tool") and v.ToolTip == "Blox Fruit" then
                                        if _G.UseFruit then
                                            if game.Players.LocalPlayer.PlayerGui.Main.Skills[v.Name]:FindFirstChild("Z").Cooldown.AbsoluteSize.X <= 0 and _G.FruitSkillZ then	
                                                l = _G.HoldZFruit
                                                down("Z")
                                            elseif game.Players.LocalPlayer.PlayerGui.Main.Skills[v.Name]:FindFirstChild("X").Cooldown.AbsoluteSize.X <= 0 and _G.FruitSkillX then	
                                                l = _G.HoldXFruit
                                                down("X")
                                            elseif game.Players.LocalPlayer.PlayerGui.Main.Skills[v.Name]:FindFirstChild("C").Cooldown.AbsoluteSize.X <= 0 and _G.FruitSkillC then	
                                                l = _G.HoldCFruit
                                                down("C")
                                            elseif game.Players.LocalPlayer.PlayerGui.Main.Skills[v.Name]:FindFirstChild("V").Cooldown.AbsoluteSize.X <= 0 and _G.FruitSkillV then	
                                                l = _G.HoldVFruit
                                                down("V")
                                            elseif _G.FruitSkillF then
                                                if game.Players.LocalPlayer.PlayerGui.Main.Skills[v.Name]:FindFirstChild("F").Cooldown.AbsoluteSize.X <= 0 then	
                                                    l = _G.HoldFFruit
                                                    down("F")
                                                end
                                            else
                                                Click()
                                            end
                                        end
                                    end
                                end
                            elseif _G.UseGunMethod or _G.UseSwordMethod then
                                if _G.UseMelee then
                                    if _G.MeleeSkillZ then	
                                        l = _G.HoldZMelee
                                        down("Z")
                                    elseif _G.MeleeSkillX then	
                                        l = _G.HoldXMelee
                                        down("X")
                                    elseif _G.MeleeSkillC then	
                                        l = _G.HoldCMelee
                                        down("C")
                                    elseif _G.MeleeSkillV then	
                                        l = _G.HoldVMelee
                                        down("V")
                                    end
                                end
                                Click()
                            end
                        end)
                    end
                end
            end)
        end
    end
end)
function n4(g1)
    if not og1 then
        return Vector3.new(0, 0, 0)
    end
    checking = (g1 - og1)
    if checking == Vector3.new(0, 0, 0) then
        return Vector3.new(0, 0, -4)
    else
        return (g1 - og1)*((g1-og1).Magnitude + 5)
    end
end
function shitpredict(plr)
    if not plr then
        return Vector3.new(0, 0, 0)
    end
    ai1 = n4(plr.Character.Head.Position)
    og1 = plr.Character.Head.Position
    return ai1
end
spawn(function()
    while task.wait(0.05) do
        if _G.StartHunt then
            if getgenv().targ == nil then target() end
            if getgenv().targ == nil then hopserver = true end 
            pcall(function()
                if getgenv().targ.Character:FindFirstChild("HumanoidRootPart") and game.Players.LocalPlayer.Character:FindFirstChild("HumanoidRootPart") then
                    if game.Players.LocalPlayer.Character:FindFirstChild("Humanoid").Health > (game.Players.LocalPlayer.Character:FindFirstChild("Humanoid").MaxHealth * (_G.SafeHealth/100)) then
                        stopbypass = false  
                        if not (game:GetService("Workspace")["_WorldOrigin"].Locations:FindFirstChild("Island 1") and getgenv().targ:DistanceFromCharacter(game:GetService("Workspace")["_WorldOrigin"].Locations:FindFirstChild("Island 1").Position) < 10000) then
                            if (getgenv().targ.Character:WaitForChild("HumanoidRootPart").CFrame.Position - game.Players.LocalPlayer.Character:WaitForChild("HumanoidRootPart").CFrame.Position).Magnitude < 60 then 
                                nguvl = CFrame.new(getgenv().targ.Character.HumanoidRootPart.Position + shitpredict(getgenv().targ))
                                if getgenv().targ.Character.Humanoid.Health > 0 then
                                    if _G.AlwaysClick then
                                        Click()
                                    end
                                    if getgenv().targ.Character.Busy.Value then
                                        if helloae then
                                            to(getNextPosition(nguvl))
                                        else
                                            to(nguvl)
                                        end
                                    else
                                        if helloae then
                                            to(nguvl*CFrame.new(getgenv().targ.Character.HumanoidRootPart.Position.Unit))
                                        else
                                            to(nguvl)
                                        end
                                    end
                                else 
                                    SkipPlayer()
                                    Notify("Player Died")
                                end
                            else
                                if getgenv().targ.Character.Humanoid.Health > 0 then
                                    to(getgenv().targ.Character.HumanoidRootPart.CFrame*CFrame.new(0,10,10))
                                else
                                    SkipPlayer()
                                    Notify("Player Died")
                                end
                            end
                        else
                            SkipPlayer()
                            Notify("Player in Raid")
                        end
                        if getgenv().targ.Character.HumanoidRootPart.CFrame.Y >= 10 then
                            helloae = true
                        else
                            helloae = false
                        end
                    else
                        stopbypass = true
                        to(getgenv().targ.Character.HumanoidRootPart.CFrame*CFrame.new(0,math.random(5000,100000),0))
                    end
                end
            end)
        end
    end
end)
function GetTimeCheck(startTime)
    local elapsedTime = tick() - startTime
    local minutes = math.floor((elapsedTime % 3600) / 60)
    return minutes
end
spawn(function()
    while task.wait() do 
        if _G.StartHunt and getgenv().targ ~= nil then 
            getgenv().incheck = getgenv().targ
            checktime = tick()
            repeat task.wait()
            until (getgenv().incheck ~= getgenv().targ) or tonumber(GetTimeCheck(checktime)) == 2
            if getgenv().incheck == getgenv().targ then 
                SkipPlayer()
                Notify("Player Died")
            end
        end
    end
end)
--- Aim
spawn(function()
    while task.wait() do 
        if _G.StartHunt and getgenv().targ ~= nil and (getgenv().targ.Character:WaitForChild("HumanoidRootPart").CFrame.Position - game.Players.LocalPlayer.Character:WaitForChild("HumanoidRootPart").CFrame.Position).Magnitude < 40 then 
            aim = true 
            if _G.UseGun and _G.UseGunMethod then
                CFrameHunt = CFrame.new(getgenv().targ.Character.HumanoidRootPart.Position + getgenv().targ.Character.HumanoidRootPart.CFrame.LookVector * 2, getgenv().targ.Character.HumanoidRootPart.Position)
            else
                CFrameHunt = CFrame.new(getgenv().targ.Character.HumanoidRootPart.Position + getgenv().targ.Character.HumanoidRootPart.CFrame.LookVector * 4, getgenv().targ.Character.HumanoidRootPart.Position)
            end
        else
            aim = false
        end
    end
end)
spawn(function()
    local gg = getrawmetatable(game)
    local old = gg.__namecall
    setreadonly(gg,false)
    gg.__namecall = newcclosure(function(...)
        local method = getnamecallmethod()
        local args = {...}
        if tostring(method) == "FireServer" then
            if tostring(args[1]) == "RemoteEvent" then
                if tostring(args[2]) ~= "true" and tostring(args[2]) ~= "false" then
                    if aim then
                        args[2] = CFrameHunt.Position
                        return old(unpack(args))
                    end
                end
            end
        end
        return old(...)
    end)
end)
local Mouse = lp:GetMouse()
Mouse.Button1Down:Connect(function()
    pcall(function()
        if getgenv().targ ~= nil and aim then
            local args = {
                 [1] = CFrameHunt.Position,
                 [2] = getgenv().targ.Character.HumanoidRootPart
               }
             game:GetService("Players").LocalPlayer.Character[game.Players.LocalPlayer.Character:FindFirstChildOfClass("Tool").Name].RemoteFunctionShoot:InvokeServer(unpack(args))
         end
    end)
end)
spawn(function()
    while task.wait() do
        if _G.LockCam and _G.StartHunt then
            local targetPlayer = getgenv().targ
            if targetPlayer ~= nil then
                local targetCharacter = targetPlayer.Character
                local camera = game.Workspace.CurrentCamera
                if targetCharacter then
                    local lookAtPos = targetCharacter.HumanoidRootPart.Position
                    local cameraPos = camera.CFrame.Position
                    local newLookAt = CFrame.new(cameraPos, lookAtPos)
                    camera.CFrame = newLookAt
                end
            end
        end
    end
end)
--  Rejoin
game:GetService("CoreGui").RobloxPromptGui.promptOverlay.ChildAdded:Connect(function(child)
    if not hopserver and child.Name == 'ErrorPrompt' and child:FindFirstChild('MessageArea') and child.MessageArea:FindFirstChild("ErrorFrame") then
        game:GetService("TeleportService"):Teleport(game.PlaceId)
        Notify("Apple Hub | Rejoin from kicked!")
    end
end)
--- Webhook
function wSend(main)
    spawn(function()
        local Data = game:GetService("HttpService"):JSONEncode(main)
        local Head = {["content-type"] = "application/json"}
        Send = http_request or request or HttpPost or syn.request 
        Send({Url = _G.WebhookUrl, Body = Data, Method = "POST", Headers = Head})
    end)
end 
function wTest() 
    local data = {
        ["content"] = "",
        ["embeds"] = {
            {
                ["title"] = "**Apple Hub | Auto Bounty**",
                ["color"] = 0000000,
                ["fields"] = {
                    {
                        ["name"] = "Test Webhook",
                        ["value"] = "Apple Hub Webhook Test :eyes:",
                        ["inline"] = false,
                    },
                },
                ["thumbnail"] = {
                    ["url"] = "https://cdn.discordapp.com/attachments/1184024538065944626/1185194585874513970/20231212_231304.png?ex=658eb979&is=657c4479&hm=8481be1090b5e3322d54395dc7836139faccd3d883005d0f756aa9472468e39b&",
                },
                ["footer"] = {
                    ["text"] = "Apple Hub - https://discord.gg/JNAB9UDvCx",
                },
                ["timestamp"] = os.date("!%Y-%m-%dT%H:%M:%SZ"),
            }
        }
    }
    wSend(data)
end
function wEarn(targ, earn,total) 
    if _G.UseWebhook and targ ~= nil then
        local data = {
            ["content"] = "",
            ["embeds"] = {
                {
                    ["title"] = "**Apple Hub | Auto Bounty**",
                    ["color"] = 0x58b9ff,
                    ["fields"] = {
                        {
                            ["name"] = "Account: ",
                            ["value"] = "||"..game.Players.LocalPlayer.Name.."||",
                            ["inline"] = true,
                        },
                        {
                            ["name"] = "Target: ",
                            ["value"] = "```"..targ.Name.."```",
                            ["inline"] = true,
                        },
                        {
                            ["name"] = "Server Bounty Count: ",
                            ["value"] = "```Earned: "..earn.."```",
                            ["inline"] = true,
                        },
                        {
                            ["name"] = "Account Total: ",
                            ["value"] = "```Earned: "..total.."```",
                            ["inline"] = true,
                        },
                        {
                            ["name"] = "Current Bounty: ",
                            ["value"] = "```"..(math.round((game.Players.LocalPlayer.leaderstats["Bounty/Honor"].Value / 1000000)*100)/100).."M```",
                            ["inline"] = true,
                        }
                    },
                    ["thumbnail"] = {
                        ["url"] = "https://cdn.discordapp.com/attachments/1184024538065944626/1185194585874513970/20231212_231304.png?ex=658eb979&is=657c4479&hm=8481be1090b5e3322d54395dc7836139faccd3d883005d0f756aa9472468e39b&",
                    },
                    ["footer"] = {
                        ["text"] = "Apple Hub - https://discord.gg/JNAB9UDvCx",
                    },
                    ["timestamp"] = os.date("!%Y-%m-%dT%H:%M:%SZ"),
                }
            }
        }
        wSend(data)
    end
end
--- Counter
Bounty = game:GetService("Players").LocalPlayer.leaderstats["Bounty/Honor"].value
Earned = game:GetService("Players").LocalPlayer.leaderstats["Bounty/Honor"].value - Bounty
Earned2 = game:GetService("Players").LocalPlayer.leaderstats["Bounty/Honor"].value - Bounty
startTime = tick() - _G.Time
OldTotalEarned = _G.TotalEarn 
TotalEarned = _G.TotalEarn 
function GetElapsedTime(startTime)
    local elapsedTime = tick() - startTime
    local hours = math.floor(elapsedTime / 3600)
    local minutes = math.floor((elapsedTime % 3600) / 60)
    local seconds = math.floor(elapsedTime % 60)
    _G.Time = elapsedTime
    local formattedTime = string.format("%02d:%02d:%02d", hours, minutes, seconds)
    return formattedTime
end
spawn(function()
    while task.wait() do
        if _G.StartHunt then
            Earned = game:GetService("Players").LocalPlayer.leaderstats["Bounty/Honor"].value - Bounty
            if Earned ~= Earned2 then
                TotalEarned = OldTotalEarned + Earned
                wait()
                Earned2 = Earned
                saveSettings()
                wEarn(getgenv().killed, Earned, TotalEarned)  
            end
            Earn:Set((tostring(Earned)))
            Total:Set((tostring(TotalEarned)))
            Current:Set((tostring(game:GetService("Players").LocalPlayer.leaderstats["Bounty/Honor"].value)))
            _G.TotalEarn = TotalEarned 
        end
    end
end)
spawn(function()
    while task.wait() do
        if _G.StartHunt then
            Elapsed:Set(tostring(GetElapsedTime(startTime)))
            saveSettings()
            task.wait(1)
        end
    end
end)
game.RunService:Set3dRenderingEnabled(not _G.WhiteScreen)
