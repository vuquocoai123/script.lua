getgenv().Setting = {
    ["Team"] = "Marines",
    ["WhiteScreen"] = false,
    ["FpsBoost"] = false,
    ["TimeReset"] = 4,
    ["ModeFarm"] = {
        ["StopItemLegendary"] = true,
        ["SummonKillDarkbeard"] = true
    },
}

--// White Screen
if getgenv().Setting.WhiteScreen == true then
	    game:GetService("RunService"):Set3dRenderingEnabled(false)
elseif getgenv().Setting.WhiteScreen == false then
	    game:GetService("RunService"):Set3dRenderingEnabled(true)
end

--// Fps Boost
if getgenv().Setting.FpsBoost == true then
	pcall(function()
		game:GetService("Lighting").FantasySky:Destroy()
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
			elseif v:IsA("Decal") or v:IsA("Texture") then
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
		for i, v in pairs(game:GetService("Workspace").Camera:GetDescendants()) do
			if v.Name == ("Water;") then
				v.Transparency = 1
				v.Material = "Plastic"
			end
		end
	end)
end


--// Start Team
repeat wait() until game.Players
repeat wait() until game.Players.LocalPlayer
repeat wait() until game.ReplicatedStorage
repeat wait() until game.ReplicatedStorage:FindFirstChild("Remotes");
repeat wait() until game.Players.LocalPlayer:FindFirstChild("PlayerGui");
repeat wait() until game.Players.LocalPlayer.PlayerGui:FindFirstChild("Main");
repeat wait() until game:GetService("Players")
repeat wait() until game:GetService("Players").LocalPlayer.Character:FindFirstChild("Energy")
if not game:IsLoaded() then repeat game.Loaded:Wait() until game:IsLoaded() end
--Team
if game:GetService("Players").LocalPlayer.PlayerGui.Main:FindFirstChild("ChooseTeam") then
    repeat wait()
        if game:GetService("Players").LocalPlayer.PlayerGui:WaitForChild("Main").ChooseTeam.Visible == true then
            if getgenv().Setting.Team == "Pirates" or getgenv().Setting.Team == nil then
                for i, v in pairs(getconnections(game:GetService("Players").LocalPlayer.PlayerGui.Main.ChooseTeam.Container.Pirates.Frame.ViewportFrame.TextButton.Activated)) do                                                                                                
                    v.Function()
                end
            elseif getgenv().Setting.Team == "Marines" then
                for i, v in pairs(getconnections(game:GetService("Players").LocalPlayer.PlayerGui.Main.ChooseTeam.Container.Marines.Frame.ViewportFrame.TextButton.Activated)) do                                                                                                
                    v.Function()
                end
            else
                for i, v in pairs(getconnections(game:GetService("Players").LocalPlayer.PlayerGui.Main.ChooseTeam.Container.Pirates.Frame.ViewportFrame.TextButton.Activated)) do                                                                                                
                    v.Function()
                end
            end
        end
    until game.Players.LocalPlayer.Team ~= nil and game:IsLoaded()
end

--// Farm Chest [Main]
AutoFarmChest = true
   spawn(function()
        while true do 
                if AutoFarmChest then
                    for i,v in pairs(game:GetService("Workspace"):GetChildren()) do 
                        if v.Name:find("Chest") then
                        	if (game:GetService("Workspace"):FindFirstChild(v.Name)) then
                            	game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = v.CFrame
                            	if string.find(v.Name, "Chest") and v:IsA("TouchTransmitter") then
								   firetouchinterest(game.Players.LocalPlayer.Character.HumanoidRootPart, v.Parent, 0)
							    end
                            end
                        end
						if not (game:GetService("Workspace"):FindFirstChild("Chest1") or game:GetService("Workspace"):FindFirstChild("Chest2") or game:GetService("Workspace"):FindFirstChild("Chest3")) then 
                            starthop = true
                        end
                    end
                end
            task.wait()
        end
    end)
    spawn(function()
        while true do 
                if AutoFarmChest and game:GetService("Players").LocalPlayer.Character:FindFirstChild("Head") then
                	wait(getgenv().Setting.TimeReset)
					if getgenv().Setting.Team == "Pirates" or getgenv().Setting.Team == nil then
                		game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("SetTeam", "Pirates")
						game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("SetTeam", "Marines")
					elseif getgenv().Setting.Team == "Marines" then
						game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("SetTeam", "Marines")
						game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("SetTeam", "Pirates")
					end
                end
			task.wait()
        end
    end)
    spawn(function()
	    while true do
	        if starthop then
	          	HopServer()
	        end
	        wait()
	    end
	end)
	function HopServer(bO)
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
	        wait()
	    end
	end

--// Stop With Strange Item
spawn(function()
	while wait() do
		if getgenv().Setting.ModeFarm.StopItemLegendary == true then
			if game.Players.LocalPlayer.Backpack:FindFirstChild("Fist of Darkness") or game.Players.LocalPlayer.Character:FindFirstChild("Fist of Darkness") or game.Players.LocalPlayer.Backpack:FindFirstChild("God's Chalice") or game.Players.LocalPlayer.Character:FindFirstChild("God's Chalice") then
				AutoFarmChest = false
			end
		end
	end
end)
   
--// Function Tween
function topos(Pos)
	Distance = (Pos.Position - game.Players.LocalPlayer.Character.HumanoidRootPart.Position).Magnitude
	if Distance < 25 then
		Speed = 5000
	elseif Distance < 50 then
		Speed = 2000
	elseif Distance < 150 then
		Speed = 800
	elseif Distance < 250 then
		Speed = 600
	elseif Distance < 500 then
		Speed = 300
	elseif Distance < 750 then
		Speed = 250
	elseif Distance >= 1000 then
		Speed = 200
	end
	game:GetService("TweenService"):Create(
		game:GetService("Players").LocalPlayer.Character.HumanoidRootPart,
		TweenInfo.new(Distance/Speed, Enum.EasingStyle.Linear),
		{CFrame = Pos}
	):Play()
end

--// EquipTool
local function equipToolByToolTip(toolToolTip)
	for i, v in pairs(game.Players.LocalPlayer.Backpack:GetChildren()) do
		if v:IsA("Tool") and v.ToolTip == toolToolTip then
			game.Players.LocalPlayer.Character.Humanoid:EquipTool(v)
			break
		end
	end
end

--// Equip Weapon
function EquipWeapon(ToolSe)
	if not _G.NotAutoEquip then
		if game.Players.LocalPlayer.Backpack:FindFirstChild(ToolSe) then
			Tool = game.Players.LocalPlayer.Backpack:FindFirstChild(ToolSe)
			wait(.1)
			game.Players.LocalPlayer.Character.Humanoid:EquipTool(Tool)
		end
	end
end
 
--// Save Setting
	local foldername = "Apple Hub - Farm Chest"
	local filename = foldername.."/Counter.json"
	 
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
_G.Total = 0
_G.Time = os.time()
loadSettings()
--// Fast Attack
local CameraShaker = require(game.ReplicatedStorage.Util.CameraShaker)
CombatFrameworkR = require(game:GetService("Players").LocalPlayer.PlayerScripts.CombatFramework)
y = debug.getupvalues(CombatFrameworkR)[2]
spawn(function()
    game:GetService("RunService").RenderStepped:Connect(function()
        if FastAttack then
            if typeof(y) == "table" then
                pcall(function()
                    CameraShaker:Stop()
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
        if FastAttack then
            if game.Players.LocalPlayer.Character:FindFirstChild("Stun") then
                game.Players.LocalPlayer.Character.Stun.Value = 0
                game.Players.LocalPlayer.Character.Humanoid.Sit = false
                game.Players.LocalPlayer.Character.Busy.Value = false   
            end    
        end
    end)
end)

local CurveFrame = debug.getupvalues(require(game:GetService("Players").LocalPlayer.PlayerScripts:WaitForChild("CombatFramework")))[2]
local VirtualUser = game:GetService("VirtualUser")
local RigControllerR = debug.getupvalues(require(game:GetService("Players").LocalPlayer.PlayerScripts.CombatFramework.RigController))[2]
local Client = game:GetService("Players").LocalPlayer
local DMG = require(Client.PlayerScripts.CombatFramework.Particle.Damage)
local CameraShaker = require(game.ReplicatedStorage.Util.CameraShaker)
CameraShaker:Stop()
function CurveFuckWeapon()
    local p13 = CurveFrame.activeController
    local wea = p13.blades[1]
    if not wea then
        return
    end
    while wea.Parent ~= game.Players.LocalPlayer.Character do
        wea = wea.Parent
    end
    return wea
end

function getHits(Size)
    local Hits = {}
    local Enemies = workspace.Enemies:GetChildren()
    local Characters = workspace.Characters:GetChildren()
    for i = 1, #Enemies do
        local v = Enemies[i]
        local Human = v:FindFirstChildOfClass("Humanoid")
        if
            Human and Human.RootPart and Human.Health > 0 and
                game.Players.LocalPlayer:DistanceFromCharacter(Human.RootPart.Position) < Size + 5
         then
            table.insert(Hits, Human.RootPart)
        end
    end
    for i = 1, #Characters do
        local v = Characters[i]
        if v ~= game.Players.LocalPlayer.Character then
            local Human = v:FindFirstChildOfClass("Humanoid")
            if
                Human and Human.RootPart and Human.Health > 0 and
                    game.Players.LocalPlayer:DistanceFromCharacter(Human.RootPart.Position) < Size + 5
             then
                table.insert(Hits, Human.RootPart)
            end
        end
    end
    return Hits
end

local cdnormal = 0
local Animation = Instance.new("Animation")


abc = true
task.spawn(function()
    local a = game.Players.LocalPlayer
    local b = require(a.PlayerScripts.CombatFramework.Particle)
    local c = require(game:GetService("ReplicatedStorage").CombatFramework.RigLib)
    if not shared.orl then
        shared.orl = c.wrapAttackAnimationAsync
    end
    if not shared.cpc then
        shared.cpc = b.play
    end
    if abc then
        pcall(function()
            c.wrapAttackAnimationAsync = function(d, e, f, g, h)
            local i = c.getBladeHits(e, f, g)
            if i then
                b.play = function()
                    end
                    d:Play(0.25, 0.25, 0.25)
                    h(i)
                    b.play = shared.cpc
                    wait(.5)
                    d:Stop()
                end
            end
        end)
    end
end)
function AttackHit()
    local CombatFrameworkLib = debug.getupvalues(require(game:GetService("Players").LocalPlayer.PlayerScripts.CombatFramework))
    local CmrFwLib = CombatFrameworkLib[2]
    local plr = game.Players.LocalPlayer
    for i = 1, 1 do
        local bladehit = require(game.ReplicatedStorage.CombatFramework.RigLib).getBladeHits(plr.Character,{plr.Character.HumanoidRootPart},60)
        local cac = {}
        local hash = {}
        for k, v in pairs(bladehit) do
            if v.Parent:FindFirstChild("HumanoidRootPart") and not hash[v.Parent] then
                table.insert(cac, v.Parent.HumanoidRootPart)
                hash[v.Parent] = true
            end
        end
        bladehit = cac
        if #bladehit > 0 then
            pcall(function()
                CmrFwLib.activeController.timeToNextAttack = 1
                CmrFwLib.activeController.attacking = false
                CmrFwLib.activeController.blocking = false
                CmrFwLib.activeController.timeToNextBlock = 0
                CmrFwLib.activeController.increment = 3
                CmrFwLib.activeController.hitboxMagnitude = 100
                CmrFwLib.activeController.focusStart = 0
                game:GetService("ReplicatedStorage").RigControllerEvent:FireServer("weaponChange",tostring(CurveFuckWeapon()))
                game:GetService("ReplicatedStorage").RigControllerEvent:FireServer("hit", bladehit, i, "")
            end)
        end
    end
end

--// Summon And Kill Dark Beard
spawn(function()
	while wait() do
		if getgenv().Setting.ModeFarm.SummonKillDarkbeard == true then
			local g = game.Player.LocalPlayer
        	if game.Players.LocalPlayer.Backpack:FindFirstChild("Fist of Darkness") or game.Players.LocalPlayer.Character:FindFirstChild("Fist of Darkness") then
				AutoFarmChest = false
				EquipWeapon("Fist of Darkness")
				topos(CFrame.new(3777.58618, 14.8764334, -3498.81909, 0.13158533, 1.16175372e-08, -0.991304874, -9.53944035e-10, 1, 1.15928129e-08, 0.991304874, -5.79794768e-10, 0.13158533))
				for i,v in pairs(game.Workspace.Enemies:GetChildren()) do
					if v.Name == "Darkbeard [Lv. 1000] [Raid Boss]" then
						repeat wait(0.1)
							if not game:GetService("Players").LocalPlayer.Character:FindFirstChild("HasBuso") then
								game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("Buso")
							end
							equipToolByToolTip("Melee")
							v.HumanoidRootPart.CanCollide = false
							v.Head.CanCollide = false
							v.WalkSpeed = 0
							topos(v.HumanoidRootPart.CFrame * CFrame.new(0,10,0))
							game:GetService'VirtualUser':CaptureController()
							game:GetService'VirtualUser':Button1Down(Vector2.new(1280, 672))
							FastAttack = true
							AttackHit()
						until not v.Name == "Darkbeard [Lv. 1000] [Raid Boss]" and not v.Parent
						FastAttack = false
					end
				end
			end
		end
    end
end)

--// UI
local ScreenGui = Instance.new("ScreenGui")
local main = Instance.new("Frame")
local UICorner = Instance.new("UICorner")
local logo = Instance.new("ImageLabel")
local line = Instance.new("Frame")
local Name = Instance.new("TextLabel")
local invite = Instance.new("TextLabel")
local Earn = Instance.new("TextLabel")
local UIPadding = Instance.new("UIPadding")
local total = Instance.new("TextLabel")
local UIPadding_2 = Instance.new("UIPadding")
local time = Instance.new("TextLabel")
local UIPadding_3 = Instance.new("UIPadding")
local on = Instance.new("TextButton")
local off = Instance.new("TextButton")
local dis = Instance.new("TextButton")


ScreenGui.Parent = game.CoreGui
ScreenGui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling

main.Name = "main"
main.Parent = ScreenGui
main.Active = true
main.AnchorPoint = Vector2.new(0.5, 0.5)
main.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
main.BorderColor3 = Color3.fromRGB(0, 0, 0)
main.BorderSizePixel = 0
main.Position = UDim2.new(0.5, 0, 0.5, 0)
main.Size = UDim2.new(0, 400, 0, 250)
main.Draggable = true

UICorner.Parent = main
local MainStroke = Instance.new("UIStroke")
MainStroke.Name = "BtnStroke"
MainStroke.Parent = main
MainStroke.ApplyStrokeMode = Enum.ApplyStrokeMode.Border
MainStroke.Color = Color3.fromRGB(255, 255, 255)
MainStroke.LineJoinMode = Enum.LineJoinMode.Round
MainStroke.Thickness = 1
MainStroke.Transparency = 0
MainStroke.Enabled = true
MainStroke.Archivable = true
    

    
logo.Name = "logo"
logo.Parent = main
logo.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
logo.BorderColor3 = Color3.fromRGB(0, 0, 0)
logo.BorderSizePixel = 0
logo.Position = UDim2.new(0.0274999999, 0, 0.0560000017, 0)
logo.Size = UDim2.new(0, 60, 0, 60)
logo.Image = "Apple Hub"
local MainStroke = Instance.new("UIStroke")
MainStroke.Name = "BtnStroke"
MainStroke.Parent = logo
MainStroke.ApplyStrokeMode = Enum.ApplyStrokeMode.Border
MainStroke.Color = Color3.fromRGB(255, 255, 255)
MainStroke.LineJoinMode = Enum.LineJoinMode.Round
MainStroke.Thickness = 1
MainStroke.Transparency = 0
MainStroke.Enabled = true
MainStroke.Archivable = true
    

line.Name = "line"
line.Parent = main
line.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
line.BorderColor3 = Color3.fromRGB(0, 0, 0)
line.BorderSizePixel = 0
line.Position = UDim2.new(0, 0, 0.331999987, 0)
line.Size = UDim2.new(0, 400, 0, 2)

Name.Name = "Name"
Name.Parent = main
Name.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
Name.BackgroundTransparency = 1.000
Name.BorderColor3 = Color3.fromRGB(0, 0, 0)
Name.BorderSizePixel = 0
Name.Position = UDim2.new(0.204999998, 0, 0.0280000009, 0)
Name.Size = UDim2.new(0, 309, 0, 42)
Name.Font = Enum.Font.DenkOne
Name.Text = "Apple Hub - Farm Chest"
Name.TextColor3 = Color3.fromRGB(255, 255, 255)
Name.TextSize = 30.000

invite.Name = "invite"
invite.Parent = main
invite.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
invite.BackgroundTransparency = 1.000
invite.BorderColor3 = Color3.fromRGB(0, 0, 0)
invite.BorderSizePixel = 0
invite.Position = UDim2.new(0.272500008, 0, 0.195999995, 0)
invite.Size = UDim2.new(0, 242, 0, 25)
invite.Font = Enum.Font.DenkOne
invite.Text = "https://discord.gg/JNAB9UDvCx"
invite.TextColor3 = Color3.fromRGB(255, 255, 255)
invite.TextSize = 19.000

Earn.Name = "Earn"
Earn.Parent = main
Earn.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
Earn.BackgroundTransparency = 1.000
Earn.BorderColor3 = Color3.fromRGB(0, 0, 0)
Earn.BorderSizePixel = 0
Earn.Position = UDim2.new(0.0450000018, 0, 0.400000006, 0)
Earn.Size = UDim2.new(0, 242, 0, 31)
Earn.Font = Enum.Font.DenkOne
Earn.Text = "Earn Beli:"
Earn.TextColor3 = Color3.fromRGB(255, 255, 255)
Earn.TextSize = 30.000
Earn.TextXAlignment = Enum.TextXAlignment.Left

UIPadding.Parent = Earn
UIPadding.PaddingLeft = UDim.new(0, 5)

total.Name = "total"
total.Parent = main
total.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
total.BackgroundTransparency = 1.000
total.BorderColor3 = Color3.fromRGB(0, 0, 0)
total.BorderSizePixel = 0
total.Position = UDim2.new(0.0450000018, 0, 0.523999989, 0)
total.Size = UDim2.new(0, 242, 0, 31)
total.Font = Enum.Font.DenkOne
total.Text = "Total Beli:"
total.TextColor3 = Color3.fromRGB(255, 255, 255)
total.TextSize = 30.000
total.TextXAlignment = Enum.TextXAlignment.Left

local old = game:GetService("Players").LocalPlayer.Data.Beli.Value
local oldTotal = _G.Total
TotalNew = oldTotal
spawn(function()
	while wait() do
		newbeli = game:GetService("Players").LocalPlayer.Data.Beli.Value - old
		TotalNew = oldTotal + newbeli
		Earn.Text = "Earn Beli: "..newbeli
		total.Text = "Total Beli: "..TotalNew
		_G.Total = TotalNew
		saveSettings()
	end
end)

UIPadding_2.Parent = total
UIPadding_2.PaddingLeft = UDim.new(0, 5)

time.Name = "time"
time.Parent = main
time.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
time.BackgroundTransparency = 1.000
time.BorderColor3 = Color3.fromRGB(0, 0, 0)
time.BorderSizePixel = 0
time.Position = UDim2.new(0.0450000018, 0, 0.648000002, 0)
time.Size = UDim2.new(0, 242, 0, 31)
time.Font = Enum.Font.DenkOne
time.Text = "Time Elapsed:"
time.TextColor3 = Color3.fromRGB(255, 255, 255)
time.TextSize = 30.000
time.TextXAlignment = Enum.TextXAlignment.Left

--// TIME ELAPSED
oldtime = _G.Time
local function updateElapsedTime(startTime)
    local elapsedTime = os.time() - startTime -- Calculate the elapsed time
    local hours = math.floor(elapsedTime / 3600)
    local minutes = math.floor((elapsedTime % 3600) / 60)
    local seconds = elapsedTime % 60

    time.Text = string.format("Time Elapsed: %dh:%dm:%ds", hours, minutes, seconds) -- Update the TextLabel with the elapsed time
end

spawn(function()
    while wait(1) do
        updateElapsedTime(oldtime)
		_G.Time = oldtime
    end
end)

--// Auto Rejoin
spawn(function()
	while wait() do
	    if getgenv().Setting.AutoRejoin == true then
	        getgenv().rejoin = game:GetService("CoreGui").RobloxPromptGui.promptOverlay.ChildAdded:Connect(function(child)
                if child.Name == 'ErrorPrompt' and child:FindFirstChild('MessageArea') and child.MessageArea:FindFirstChild("ErrorFrame") then
                    game:GetService("TeleportService"):Teleport(game.PlaceId)
                end
            end)
	    end
	end
end)
 
UIPadding_3.Parent = time
UIPadding_3.PaddingLeft = UDim.new(0, 5)

on.Name = "on"
on.Parent = main
on.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
on.BackgroundTransparency = 1.000
on.BorderColor3 = Color3.fromRGB(0, 0, 0)
on.BorderSizePixel = 0
on.Position = UDim2.new(0.0450000018, 0, 0.772000015, 0)
on.Size = UDim2.new(0, 50, 0, 50)
on.Font = Enum.Font.DenkOne
on.Text = "On"
on.TextColor3 = Color3.fromRGB(255, 255, 255)
on.TextSize = 30.000

on.MouseButton1Down:Connect(function()
	AutoFarmChest = true
end)
local MainStroke = Instance.new("UIStroke")
MainStroke.Name = "BtnStroke"
MainStroke.Parent = on
MainStroke.ApplyStrokeMode = Enum.ApplyStrokeMode.Border
MainStroke.Color = Color3.fromRGB(255, 255, 255)
MainStroke.LineJoinMode = Enum.LineJoinMode.Round
MainStroke.Thickness = 1
MainStroke.Transparency = 0
MainStroke.Enabled = true
MainStroke.Archivable = true
    

off.Name = "off"
off.Parent = main
off.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
off.BackgroundTransparency = 1.000
off.BorderColor3 = Color3.fromRGB(0, 0, 0)
off.BorderSizePixel = 0
off.Position = UDim2.new(0.204999998, 0, 0.772000015, 0)
off.Size = UDim2.new(0, 50, 0, 50)
off.Font = Enum.Font.DenkOne
off.Text = "Off"
off.TextColor3 = Color3.fromRGB(255, 255, 255)
off.TextSize = 30.000
off.MouseButton1Down:Connect(function ()
	AutoFarmChest = false
end)

local MainStroke = Instance.new("UIStroke")
MainStroke.Name = "BtnStroke"
MainStroke.Parent = off
MainStroke.ApplyStrokeMode = Enum.ApplyStrokeMode.Border
MainStroke.Color = Color3.fromRGB(255, 255, 255)
MainStroke.LineJoinMode = Enum.LineJoinMode.Round
MainStroke.Thickness = 1
MainStroke.Transparency = 0
MainStroke.Enabled = true
MainStroke.Archivable = true
    

dis.Name = "dis"
dis.Parent = main
dis.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
dis.BackgroundTransparency = 1.000
dis.BorderColor3 = Color3.fromRGB(0, 0, 0)
dis.BorderSizePixel = 0
dis.Position = UDim2.new(0.542500019, 0, 0.772000015, 0)
dis.Size = UDim2.new(0, 174, 0, 50)
dis.Font = Enum.Font.DenkOne
dis.Text = "Copy Discord"
dis.TextColor3 = Color3.fromRGB(255, 255, 255)
dis.TextSize = 30.000
dis.MouseButton1Down:Connnect(function()
	setclipboard("https://discord.gg/JNAB9UDvCx")
end)

local MainStroke = Instance.new("UIStroke")
MainStroke.Name = "BtnStroke"
MainStroke.Parent = dis
MainStroke.ApplyStrokeMode = Enum.ApplyStrokeMode.Border
MainStroke.Color = Color3.fromRGB(255, 255, 255)
MainStroke.LineJoinMode = Enum.LineJoinMode.Round
MainStroke.Thickness = 1
MainStroke.Transparency = 0
MainStroke.Enabled = true
MainStroke.Archivable = true
