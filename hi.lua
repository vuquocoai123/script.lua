--// Setting
_G.AutoFarmLevel = true

local plrs = game.Players 
local lp = plrs.LocalPlayer 
--- Check Quest
function CheckQuest()
    local Lvl = game:GetService("Players").LocalPlayer.Data.Level.Value
    if Lvl >= 1 and Lvl <= 9 then
        if tostring(game.Players.LocalPlayer.Team) == "Marines" then
            NameMon = "Trainee"
            NameQuest = "MarineQuest"
            LevelQuest = 1
            Mon = "Trainee"
            CFrameQuest = CFrame.new(-2709.67944, 24.5206585, 2104.24585, -0.744724929, -3.97967455e-08, -0.667371571, 4.32403588e-08, 1, -1.07884304e-07, 0.667371571, -1.09201515e-07, -0.744724929)
        elseif tostring(game.Players.LocalPlayer.Team) == "Pirates" then
            NameMon = "Bandit"
            Mon = "Bandit"
            NameQuest = "BanditQuest1"
            LevelQuest = 1
            CFrameQuest = CFrame.new(1059.99731, 16.9222069, 1549.28162, -0.95466274, 7.29721794e-09, 0.297689587, 1.05190106e-08, 1, 9.22064114e-09, -0.297689587, 1.19340022e-08, -0.95466274)
        end
        return {
            [1] = LevelQuest,
            [2] = CFrameQuest,
            [3] = NameMon,
            [4] = NameQuest,
            [5] = LevelRequire,
            [6] = Mon,
            [7] = CFrameMon
        }
    end

    if Lvl >= 15 and Lvl <= 29 then
        NameMon = "Gorilla"
        NameQuest = "JungleQuest"
        LevelQuest = 2
        Mon = "Gorilla"
        CFrameQuest = CFrame.new(-1604.12012, 36.8521118, 154.23732, 0.0648873374, -4.70858913e-06, -0.997892559, 1.41431883e-07, 1, -4.70933674e-06, 0.997892559, 1.64442184e-07, 0.0648873374)
        CFrameMon = CFrame.new(-1142.0293, 40.5877495, -516.118103, 0.55559355, 7.58965513e-08, 0.831454039, 1.24594361e-08, 1, -9.96073553e-08, -0.831454039, 6.57006538e-08, 0.55559355)
        return {
            [1] = LevelQuest,
            [2] = CFrameQuest,
            [3] = NameMon,
            [4] = NameQuest,
            [5] = LevelRequire,
            [6] = Mon,
            [7] = CFrameMon
        }
    end

    
    local GuideModule = require(game:GetService("ReplicatedStorage").GuideModule)
    local Quests = require(game:GetService("ReplicatedStorage").Quests)
    for i,v in pairs(GuideModule["Data"]["NPCList"]) do
        for i1,v1 in pairs(v["Levels"]) do
            if Lvl >= v1 then
                if not LevelRequire then
                    LevelRequire = 0
                end
                if v1 > LevelRequire then
                    CFrameQuest = i["CFrame"]
                    LevelQuest = i1
                    LevelRequire = v1
                end
                if #v["Levels"] == 3 and LevelQuest == 3 then
                    CFrameQuest = i["CFrame"]
                    LevelQuest = 2
                    LevelRequire = v["Levels"][2]
                end
            end
        end
    end
    for i,v in pairs(Quests) do
        for i1,v1 in pairs(v) do
            if v1["LevelReq"] == LevelRequire and i ~= "CitizenQuest" then
                NameQuest = i
                for i2,v2 in pairs(v1["Task"]) do
                    NameMon = i2
                    Mon = string.split(i2," [Lv. ".. v1["LevelReq"] .. "]")[1]
                end
            end
        end
    end
    if NameQuest == "MarineQuest2" then
        NameQuest = "MarineQuest2"
        LevelQuest = 1
        NameMon = "Chief Petty Officer"
        Mon = "Chief Petty Officer"
        LevelRequire = 120
    elseif NameQuest == "ImpelQuest" then
        NameQuest = "PrisonerQuest"
        LevelQuest = 2
        NameMon = "Dangerous Prisoner"
        Mon = "Dangerous Prisoner"
        LevelRequire = 210
        CFrameQuest = CFrame.new(5310.60547, 0.350014925, 474.946594, 0.0175017118, 0, 0.999846935, 0, 1, 0, -0.999846935, 0, 0.0175017118)
    elseif NameQuest == "SkyExp1Quest" then
        if LevelQuest == 1 then
            CFrameQuest = CFrame.new(-4721.88867, 843.874695, -1949.96643, 0.996191859, -0, -0.0871884301, 0, 1, -0, 0.0871884301, 0, 0.996191859)
        elseif LevelQuest == 2 then
            CFrameQuest = CFrame.new(-7859.09814, 5544.19043, -381.476196, -0.422592998, 0, 0.906319618, 0, 1, 0, -0.906319618, 0, -0.422592998)
        end
    elseif NameQuest == "Area2Quest" and LevelQuest == 2 then
        NameQuest = "Area2Quest"
        LevelQuest = 1
        NameMon = "Swan Pirate"
        Mon = "Swan Pirate"
        LevelRequire = 775
    end
    NameMon = NameMon:sub(1,#NameMon)
    if not NameMon:find("Lv") then
        for i,v in pairs(game:GetService("Workspace").Enemies:GetChildren()) do
            MonLV = string.match(v.Name, "%d+")
            if v.Name:find(NameMon) and #v.Name > #NameMon and tonumber(MonLV) <= Lvl + 50 then
                NameMon = v.Name
            end
        end
    end
    if not NameMon:find("Lv") then
        for i,v in pairs(game:GetService("ReplicatedStorage"):GetChildren()) do
            MonLV = string.match(v.Name, "%d+")
            if v.Name:find(NameMon) and #v.Name > #NameMon and tonumber(MonLV) <= Lvl + 50 then
                NameMon = v.Name
                Mon = a
            end
        end
    end
    for _,v in pairs(workspace._WorldOrigin.EnemySpawns:GetChildren()) do
        if v.Name == NameMon then
            CFrameMon = v.CFrame * CFrame.new(0,30,0)
        end
    end

    return {
        [1] = LevelQuest,
        [2] = CFrameQuest,
        [3] = NameMon,
        [4] = NameQuest,
        [5] = LevelRequire,
        [6] = Mon,
        [7] = CFrameMon
    }
end
--- Tween / Bypass
function getPortal(check2)
    local check3 = check2.Position
    local w = game.PlaceId
    if w == 2753915549 then
        gQ = {
            Vector3.new(-7894.6201171875, 5545.49169921875, -380.246346191406),
            Vector3.new(-4607.82275390625, 872.5422973632812, -1667.556884765625),
            Vector3.new(61163.8515625, 11.759522438049316, 1819.7841796875),
            Vector3.new(3876.280517578125, 35.10614013671875, -1939.3201904296875)
        }
    elseif w == 4442272183 then
        gQ = {
            Vector3.new(-288.46246337890625, 306.130615234375, 597.9988403320312),
            Vector3.new(2284.912109375, 15.152046203613281, 905.48291015625),
            Vector3.new(923.21252441406, 126.9760055542, 32852.83203125),
            Vector3.new(-6508.5581054688, 89.034996032715, -132.83953857422)
        }
    elseif w == 7449423635 then
        gQ = {
            Vector3.new(-5058.77490234375, 314.5155029296875, -3155.88330078125),
            Vector3.new(5756.83740234375, 610.4240112304688, -253.9253692626953),
            Vector3.new(-12463.8740234375, 374.9144592285156, -7523.77392578125),
            Vector3.new(28282.5703125, 14896.8505859375, 105.1042709350586),
            Vector3.new(-11993.580078125, 334.7812805175781, -8844.1826171875),
            Vector3.new(5314.58203125, 25.419387817382812, -125.94227600097656)
        }
    end
    local aM, aN = Vector3.new(0,0,0), math.huge

    for _, aL in pairs(gQ) do
        if (aL-check3).Magnitude < aN and aM ~= aL then
            aM, aN = aL,  (aL-check3).Magnitude
        end 
    end
    return aM
end 
function bypass(is)
    if tween then
        tween:Cancel()
    end
    repeat task.wait()
        lp.Character.HumanoidRootPart.CFrame = is  
    until lp.Character.PrimaryPart.CFrame == is  
    game:GetService("Players").LocalPlayer.Character:WaitForChild("Humanoid"):ChangeState(15)
    lp.Character:SetPrimaryPartCFrame(is)
    task.wait(0.1)
    lp.Character.HumanoidRootPart.CFrame = is  
    lp.Character:SetPrimaryPartCFrame(is)
    lp.Character.Head:Destroy()
    task.wait(0.5)
    repeat task.wait()
        lp.Character.HumanoidRootPart.CFrame = is 
        lp.Character.PrimaryPart.CFrame = is  
    until lp.Character:FindFirstChild("Head")
    task.wait(0.5)
end 
function getSpawn(wtf)
    local a, b = nil, math.huge
    for i,v in pairs(game.Workspace._WorldOrigin.PlayerSpawns:FindFirstChild(tostring(lp.Team)):GetChildren()) do
        if tostring(v) ~= "Leviathan" and (v:GetModelCFrame().Position-wtf.Position).Magnitude < b then
            a = v:GetModelCFrame()
            b = (v:GetModelCFrame().Position-wtf.Position).Magnitude
        end
    end
    return a
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
function checkcombat()
    return game:GetService("Players").LocalPlayer.PlayerGui.Main.InCombat.Visible and game:GetService("Players").LocalPlayer.PlayerGui.Main.InCombat.Text and (string.find(string.lower(game:GetService("Players").LocalPlayer.PlayerGui.Main.InCombat.Text),"risk"))
end 
function to(Pos)
    if not Pos then return end 
    for _, v in pairs(game:GetService("Players").LocalPlayer.Character:GetDescendants()) do
        if v:IsA("BasePart") then
            v.CanCollide = false    
        end
    end
    if not game.Players.LocalPlayer.Character.HumanoidRootPart:FindFirstChild("Rimus") then
        local ngu = Instance.new("BodyVelocity", game.Players.LocalPlayer.Character.HumanoidRootPart)
        ngu.Name = "Rimus"
        ngu.MaxForce = Vector3.new(0,math.huge,0)
        ngu.Velocity = Vector3.new(0,0,0)
    end 
    Portal = getPortal(Pos) 
    Spawn = getSpawn(Pos) 
    for mm = 0,3,1 do 
        if getSpawn(Pos) ~= Spawn then 
            return 
        end 
    end 
    MyCFrame = game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame
    Distance = calcpos(MyCFrame, Pos)
    if Distance > calcpos(Portal, Pos) and Distance > 300 then
        return request(Portal) 
    end
    if Spawn then 
        Pos0 = calcpos(Spawn, Pos)
        if not checkcombat() and Pos0 < Distance and Distance > 1200 and calcpos(MyCFrame, Spawn) > 500 and Pos0 < (calcpos(Portal, Pos)+800) then
            return bypass(Spawn)
        end
    end
    if Distance < 100 then
        lp.Character.HumanoidRootPart.CFrame = Pos
    end
    if Distance < 250 then
        Speed = 400
    elseif Distance < 1000 then
        Speed = 375
    elseif Distance >= 1000 then
        Speed = 350
    end
    if Speed ~= nil then
        tween = game:GetService("TweenService"):Create(game.Players.LocalPlayer.Character.HumanoidRootPart,TweenInfo.new(Distance / Speed, Enum.EasingStyle.Linear),{CFrame = Pos})
        tween:Play() 
    end
    game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame.X, Pos.Y, game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame.Z)
end
--// Buso
function Buso()
    if (not (game.Players.LocalPlayer.Character:FindFirstChild("HasBuso"))) then
        local rel = game.ReplicatedStorage
        rel.Remotes.CommF_:InvokeServer("Buso")
    end
end
--// Fast Attack
function GetCurrentBlade()
    local CombatFrameworkLib = debug.getupvalues(require(game:GetService("Players").LocalPlayer.PlayerScripts.CombatFramework))
    local CmrFwLib = CombatFrameworkLib[2]
    local p13 = CmrFwLib.activeController
    local weapon = p13.blades[1]
    if not weapon then 
        return weapon
    end
    while weapon.Parent ~= game.Players.LocalPlayer.Character do
        weapon = weapon.Parent 
    end
    return weapon
end
function Attack()
    local CbFw = debug.getupvalues(require(lp.PlayerScripts.CombatFramework))
    local CbFw2 = CbFw[2]
    local AC = CbFw2.activeController
    for i = 1, 1 do 
        local bladehit = require(game.ReplicatedStorage.CombatFramework.RigLib).getBladeHits(
        lp.Character,
        {lp.Character.HumanoidRootPart},
        60
        )
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
            local u8 = debug.getupvalue(AC.attack, 5)
            local u9 = debug.getupvalue(AC.attack, 6)
            local u7 = debug.getupvalue(AC.attack, 4)
            local u10 = debug.getupvalue(AC.attack, 7)
            local u12 = (u8 * 798405 + u7 * 727595) % u9
            local u13 = u7 * 798405
            (function()
                u12 = (u12 * u9 + u13) % 1099511627776
                u8 = math.floor(u12 / u9)
                u7 = u12 - u8 * u9
            end)()
            u10 = u10 + 1
            debug.setupvalue(AC.attack, 5, u8)
            debug.setupvalue(AC.attack, 6, u9)
            debug.setupvalue(AC.attack, 4, u7)
            debug.setupvalue(AC.attack, 7, u10)
            pcall(function()
                for k, v in pairs(AC.animator.anims.basic) do
                    v:Play()
                end                  
            end)
            if lp.Character:FindFirstChildOfClass("Tool") and AC.blades and AC.blades[1] then 
                game:GetService("ReplicatedStorage").RigControllerEvent:FireServer("weaponChange",tostring(GetCurrentBlade()))
                game.ReplicatedStorage.Remotes.Validator:FireServer(math.floor(u12 / 1099511627776 * 16777215), u10)
                game:GetService("ReplicatedStorage").RigControllerEvent:FireServer("hit", bladehit, i, "")
            end
        end
    end
end
spawn(function()
    game:GetService("RunService").RenderStepped:Connect(function()
        if Fastattack then
            game:GetService("VirtualUser"):CaptureController()
            game:GetService("VirtualUser"):Button1Down(Vector2.new(0,1,0,1))
            Attack()
            task.wait(0.1)
        end
    end)
end)
--// equip
function equip(tooltip)
    local player = game.Players.LocalPlayer
    local character = player.Character or player.CharacterAdded:Wait()
    for _, item in pairs(player.Backpack:GetChildren()) do
        if item:IsA("Tool") and item.ToolTip == tooltip then
            local humanoid = character:FindFirstChildOfClass("Humanoid")
            if humanoid and not humanoid:IsDescendantOf(item) then
                humanoid:UnequipTools()
                game.Players.LocalPlayer.Character.Humanoid:EquipTool(item)
                return true
            end
        end
    end
    return false
end
--// Main
function checkfunc(a)
    if a and a.Parent and a:FindFirstChild("Humanoid") and a:FindFirstChild("HumanoidRootPart") and a.Humanoid.Health >= 0 and (a.HumanoidRootPart or a.Character.HumanoidRootPart).CFrame then
        return true
    else
        return false
    end
end 
function FindPosBring(positionList)
    local totalPosition = Vector3.new()
    local validCount = 0
    for i = 1, #positionList do
        local position = positionList[i]
        local isFarEnough = true
        for j = 1, #positionList do
            if i ~= j then
                local distance = (position - positionList[j]).Magnitude
                if distance >= (350 * j) then
                    isFarEnough = false
                    break
                end
            end
        end
        if isFarEnough then
            totalPosition = totalPosition + position
            validCount = validCount + 1
        end
    end
    local averagePosition = totalPosition / validCount
    return averagePosition
end
function DefeatMob(MobList,Quest,Stopfunction)
    if not Stopfunction then return end
    for i, v in pairs(game:GetService("Workspace").Enemies:GetChildren()) do
        if checkfunc(v) and table.find(MobList, v.Name) then
            repeat task.wait()
                BringList = {}
                BringPos = nil
                for j, k in pairs(game:GetService("Workspace").Enemies:GetChildren()) do
                    if checkfunc(k) and table.find(MobList, k.Name) then
                        table.insert(BringList, k.HumanoidRootPart.Position)
                    end
                end
                BringPos = FindPosBring(BringList)
                if BringPos == nil then return end
                for j, k in pairs(game:GetService("Workspace").Enemies:GetChildren()) do
                    if checkfunc(k) and table.find(MobList, k.Name) and (k.HumanoidRootPart.Position - BringPos).Magnitude <= 350 then
                        k.PrimaryPart.Position = BringPos
                        k.Humanoid.JumpPower = 0
                        k.Humanoid.WalkSpeed = 0
                        k.HumanoidRootPart.CanCollide = false
                        sethiddenproperty(game.Players.LocalPlayer, "SimulationRadius", math.huge)
                        k.Humanoid:ChangeState(14)
                    end
                end
                to(CFrame.new(BringPos + Vector3.new(0, 30, 0)))
                equip("Melee")
                Buso()
                Fastattack = true
            until not checkfunc(v) or (Quest and game:GetService("Players").LocalPlayer.PlayerGui.Main.Quest.Visible == false) or not Stopfunction
            Fastattack = false
        end
    end
end
spawn(function()
    while task.wait() do
        if _G.AutoFarmLevel then
            CheckQuest()
            if game:GetService("Players").LocalPlayer.PlayerGui.Main.Quest.Visible == false then
                to(CFrameQuest)
                if (CFrameQuest.Position - game:GetService("Players").LocalPlayer.Character.HumanoidRootPart.Position).Magnitude <= 10 then
                    game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("StartQuest",NameQuest,LevelQuest)
                end
            elseif game:GetService("Players").LocalPlayer.PlayerGui.Main.Quest.Visible then
                if string.find(game:GetService("Players").LocalPlayer.PlayerGui.Main.Quest.Container.QuestTitle.Title.Text,NameMon) then
                    Fastattack = false
                    DefeatMob({NameMon},true, function() 
                        return _G.AutoFarmLevel
                    end)
                else
                    game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("StartQuest",NameQuest,LevelQuest)
                end
            end
        end
    end
end)
