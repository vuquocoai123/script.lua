local Fluent = loadstring(game:HttpGet("https://github.com/dawid-scripts/Fluent/releases/latest/download/main.lua"))()
local SaveManager = loadstring(game:HttpGet("https://raw.githubusercontent.com/dawid-scripts/Fluent/master/Addons/SaveManager.lua"))()
local InterfaceManager = loadstring(game:HttpGet("https://raw.githubusercontent.com/dawid-scripts/Fluent/master/Addons/InterfaceManager.lua"))()

local runService = game:GetService("RunService")
local players = game:GetService("Players")
local localPlayer = players.LocalPlayer
local character = localPlayer.Character or localPlayer.CharacterAdded:Wait()
local abilitiesFolder = character:WaitForChild("Abilities")
local UserInputService = game:GetService("UserInputService")
local replicatedStorage = game:GetService("ReplicatedStorage")
local heartbeatConnection
local upgrades = localPlayer.Upgrades
local UseRage = false
local autoParrySize = 35
local ascendBall = false
local spamSounds = false
local goingBack = false
local orginCFrame
local frameType
local parriesPerSecond = 0
local parrySpamming = false
local parryButtonPress = replicatedStorage.Remotes.ParryButtonPress
local lagStrength = 35
local AutoLag = false
local AutoLagNumber = 0
local autoLagStrength = 15
local waitTimeSpike = 0.1
local isPreventing = false
local fakeCharacter
local saveCharacter
local autoCurve = false
local canCurve = true

local DoCurve = function()
    spawn(function()
        if canCurve then
            spawn(function()
                canCurve = false
                wait(1)
                canCurve = true
            end)
            local currentCamera = workspace.CurrentCamera
            local cameraCFrame = currentCamera.CFrame
            local lastCFrame = currentCamera.CFrame
            runService.Stepped:Wait()
            runService.Stepped:Wait()
            runService.Stepped:Wait()
            currentCamera.CFrame = CFrame.lookAt(cameraCFrame.Position, cameraCFrame.Position + Vector3.new(0, 0.1, 0))
            wait(0.3)
            currentCamera.CFrame = lastCFrame
        end
    end)
    runService.Stepped:Wait()
end

local startPreventLag = function(noCooldown)
end

local endPreventLag = function(noCooldown)
end

local DoAutoLag = function()
    spawn(function()
        AutoLagNumber = AutoLagNumber + 1
        local localCharacter = game:GetService("Players").LocalPlayer.Character
        if localCharacter and AutoLagNumber == 6 then
            AutoLagNumber = 0
            wait(waitTimeSpike)
            startPreventLag()
            for loopAmount = 1,2 do
                for loopAmount = 1, autoLagStrength do
                    game:GetService("ReplicatedStorage").Remotes.CustomEmote:FireServer(true, "Wavelight")
                    game:GetService("ReplicatedStorage").Remotes.CustomEmote:FireServer(false, "Wavelight")
                end
            end
            game:GetService("ReplicatedStorage").Remotes.CustomEmote:FireServer(true, "Wavelight")
            endPreventLag()
        end
    end)
end

local function onCharacterAdded(newCharacter)
    character = newCharacter
    abilitiesFolder = character:WaitForChild("Abilities")
end

localPlayer.CharacterAdded:Connect(onCharacterAdded)

local TruValue = Instance.new("StringValue")
if workspace:FindFirstChild("AbilityThingyk1212") then
    workspace:FindFirstChild("AbilityThingyk1212"):Remove()
    task.wait(0.1)
    TruValue.Parent = game:GetService("Workspace")
        TruValue.Name = "AbilityThingyk1212"
        TruValue.Value = "Dash" --Change to Use other ability
    else
        TruValue.Parent = game:GetService("Workspace")
        TruValue.Name = "AbilityThingyk1212"
        TruValue.Value = "Dash" --Change to Use other ability
end

local Window = Fluent:CreateWindow({
    Title = "Blade Ball - Nemo Hub |",
    SubTitle = "By Nemo",
    TabWidth = 150,
    Size = UDim2.fromOffset(580, 460),
    Acrylic = true, -- The blur may be detectable, setting this to false disables blur entirely
    Theme = "Rose",
    MinimizeKey = Enum.KeyCode.LeftControl -- Used when theres no MinimizeKeybind
})

--Fluent provides Lucide Icons https://lucide.dev/icons/ for the tabs, icons are optional
local Tabs = {
    Main = Window:AddTab({ Title = "Auto Parry", Icon = "" }),
    Trolling = Window:AddTab({ Title = "Fun/Troll", Icon = "" }),
    Abilities = Window:AddTab({ Title = "Abilities", Icon = "" }),
    Emotes = Window:AddTab({ Title = "Emotes/Animations", Icon = "" }),
    Settings = Window:AddTab({ Title = "Settings", Icon = "settings" }),
}

local function startAutoParry()
    local character = localPlayer.Character or localPlayer.CharacterAdded:Wait()
    local ballsFolder = workspace:WaitForChild("Balls")
    local abilityButtonPress = replicatedStorage.Remotes.AbilityButtonPress

    print("Script successfully ran.")

    local function onCharacterAdded(newCharacter)
        character = newCharacter
    end
    localPlayer.CharacterAdded:Connect(onCharacterAdded)

    if character then
        print("Character found.")
    else
        print("Character not found.")
        return
    end
    
local function chooseNewFocusedBall()
    local balls = ballsFolder:GetChildren()
    for _, ball in ipairs(balls) do
        if ball:GetAttribute("realBall") ~= nil and ball:GetAttribute("realBall") == true then
            focusedBall = ball
            print(focusedBall.Name)
            break
        elseif ball:GetAttribute("target") ~= nil then
            focusedBall = ball
            print(focusedBall.Name)
            break
        end
    end
    
    if focusedBall == nil then
        print("Debug: Could not find a ball that's the realBall or has a target.")
    end
    return focusedBall
end

    chooseNewFocusedBall()

    local BASE_THRESHOLD = 0.15
    local VELOCITY_SCALING_FACTOR_FAST = 0.050
    local VELOCITY_SCALING_FACTOR_SLOW = 0.1

    local function getDynamicThreshold(ballVelocityMagnitude)
        if ballVelocityMagnitude > 60 then
            return math.max(0.20, BASE_THRESHOLD - (ballVelocityMagnitude * VELOCITY_SCALING_FACTOR_FAST))
        else
            return math.min(0.01, BASE_THRESHOLD + (ballVelocityMagnitude * VELOCITY_SCALING_FACTOR_SLOW))
        end
    end

    local function timeUntilImpact(ballVelocity, distanceToPlayer, playerVelocity)
        local directionToPlayer = (character.HumanoidRootPart.Position - focusedBall.Position).Unit
        local velocityTowardsPlayer = ballVelocity:Dot(directionToPlayer) - playerVelocity:Dot(directionToPlayer)
        
        if velocityTowardsPlayer <= 0 then
            return math.huge
        end
        
        return (distanceToPlayer - autoParrySize) / velocityTowardsPlayer
    end

    local function isWalkSpeedZero()
        local humanoid = character:FindFirstChildOfClass("Humanoid")
        if humanoid then
            return humanoid.WalkSpeed == 0
        end
        return false
    end


    local function checkBallDistance()
        if not character or not character:FindFirstChild("Highlight") then return end

        local charPos = character.PrimaryPart.Position
        local charVel = character.PrimaryPart.Velocity

        if focusedBall and not focusedBall.Parent then
            -- print("Focused ball lost parent. Choosing a new focused ball.")
            chooseNewFocusedBall()
        end
        if not focusedBall then 
            -- print("No focused ball.")
            chooseNewFocusedBall()
        end

        local ball = focusedBall
        local distanceToPlayer = (ball.Position - charPos).Magnitude
        local ballVelocityTowardsPlayer = ball.Velocity:Dot((charPos - ball.Position).Unit)
        
        if distanceToPlayer < autoParrySize and not (UseRage and character.Abilities["Raging Deflection"].Enabled) then
            if AutoCurve then
                DoCurve()
            end
            parryButtonPress:Fire()
            parriesPerSecond = parriesPerSecond + 0.25
            spawn(function()
                if AutoLag then
                    DoAutoLag()
                end
            end)
        end
        local isCheckingRage = false

        if timeUntilImpact(ball.Velocity, distanceToPlayer, charVel) < getDynamicThreshold(ballVelocityTowardsPlayer) then
            if character.Abilities["Raging Deflection"].Enabled and UseRage == true then
                if not isCheckingRage then
                    isCheckingRage = true
                    abilityButtonPress:Fire()
                    parriesPerSecond = parriesPerSecond + 0.25
                    if AutoCurve then
                        DoCurve()
                    end
                    spawn(function()
                        if AutoLag then
                            DoAutoLag()
                        end
                    end)
                    if not isWalkSpeedZero() then
                        parryButtonPress:Fire()
                    end
                    isCheckingRage = false
                end
            else
                parriesPerSecond = parriesPerSecond + 0.25
                if AutoLag then
                    DoAutoLag()
                end
                if AutoCurve then
                    DoCurve()
                end
                parryButtonPress:Fire()
            end
        end
    end

    heartbeatConnection = game:GetService("RunService").RenderStepped:Connect(function()
        checkBallDistance()
    end)
end

local function stopAutoParry()
    if heartbeatConnection then
        heartbeatConnection:Disconnect()
        heartbeatConnection = nil
    end
end

local Options = Fluent.Options

do
    Fluent:Notify({
        Title = "Blade Ball - Nemo Hub",
        Content = "Nemo Hub has successfully loaded!",
        SubContent = "", -- Optional
        Duration = 5 -- Set to nil to make the notification not disappear
    })
    local AutoParryToggle = Tabs.Main:AddToggle("AutoParryToggle", {Title = "Auto Parry", Default = false })
    local AutoRageToggle = Tabs.Main:AddToggle("AutoRageToggle", {Title = "Auto Parry (Rage Deflection)", Default = false })
    local AutoLagToggle = Tabs.Trolling:AddToggle("AutoLagToggle", {Title = "Auto Lag On Parry", Default = false })
    local AutoCurveToggle = Tabs.Main:AddToggle("AutoCurveToggle", {Title = "Auto Curve On Parry", Default = false })
    AutoParryToggle:OnChanged(function(Value)
        if Value then
            startAutoParry()
        else
            stopAutoParry()
        end
    end)
    AutoRageToggle:OnChanged(function(Value)
        UseRage = not UseRage
    end)
    AutoLagToggle:OnChanged(function(Value)
        AutoLag = not AutoLag
    end)
    AutoCurveToggle:OnChanged(function(Value)
        AutoCurve = not AutoCurve
    end)
    Options.AutoParryToggle:SetValue(false)
    Options.AutoRageToggle:SetValue(false)
    Options.AutoLagToggle:SetValue(false)
    Options.AutoCurveToggle:SetValue(false)
    local ParrySlider = Tabs.Main:AddSlider("Slider", {
        Title = "Auto Parry",
        Description = "Detection Range",
        Default = 35,
        Min = 10,
        Max = 100,
        Rounding = 1,
    })
    local LagSlider = Tabs.Trolling:AddSlider("Slider", {
        Title = "Lag Spike",
        Description = "Lag Strength",
        Default = 35,
        Min = 10,
        Max = 100,
        Rounding = 1,
    })
    local AutoLagSlider = Tabs.Trolling:AddSlider("Slider", {
        Title = "Auto Lag Spike",
        Description = "Lag Strength",
        Default = 35,
        Min = 10,
        Max = 100,
        Rounding = 1,
    })
    local AutoLagTimeSlider = Tabs.Trolling:AddSlider("Slider", {
        Title = "Auto Lag Spike",
        Description = "Time Until Spike",
        Default = 0.5,
        Min = 0.1,
        Max = 2,
        Rounding = 1,
    })
    ParrySlider:OnChanged(function(Value)
        autoParrySize = tonumber(Value)
    end)
    LagSlider:OnChanged(function(Value)
        lagStrength = tonumber(Value)
    end)
    AutoLagSlider:OnChanged(function(Value)
        autoLagStrength = tonumber(Value)
    end)
    AutoLagTimeSlider:OnChanged(function(Value)
        waitTimeSpike = tonumber(Value)
    end)
    ParrySlider:SetValue(35)
    LagSlider:SetValue(35)
    AutoLagSlider:SetValue(15)
    AutoLagTimeSlider:SetValue(0.5)
    local SpamParry = Tabs.Main:AddKeybind("SpamParry", {
        Title = "Spam Parry ( Autoclicker )",
        Mode = "Hold", -- Always, Toggle, Hold
        Default = "C", -- String as the name of the keybind (MB1, MB2 for mouse buttons)
    })
    local PlusDistance = Tabs.Main:AddKeybind("PlusDistance", {
        Title = "+ 1 | Auto Parry Distance",
        Mode = "Hold", -- Always, Toggle, Hold
        Default = "Z", -- String as the name of the keybind (MB1, MB2 for mouse buttons)
    })
    local MinusDistance = Tabs.Main:AddKeybind("MinusDistance", {
        Title = "- 1 | Auto Parry Distance",
        Mode = "Hold", -- Always, Toggle, Hold
        Default = "X", -- String as the name of the keybind (MB1, MB2 for mouse buttons)
    })
    local BallAscension = Tabs.Trolling:AddKeybind("BallAscension", {
        Title = "Make the ball ascend (Builds up speed)",
        Mode = "Toggle", -- Always, Toggle, Hold
        Default = "E", -- String as the name of the keybind (MB1, MB2 for mouse buttons),
        Callback = function()
            
        end,
        ChangedCallback = function()
            
        end
    })
    Tabs.Emotes:AddButton({
        Title = "Stop Animations + Music",
        Description = "",
        Callback = function()
            for loopAmount, animationTrack in pairs(localPlayer.Character.Humanoid:GetPlayingAnimationTracks()) do
                animationTrack:Stop()
            end
            local animationInstance = Instance.new("Animation")
            animationInstance.AnimationId = "rbxassetid://13772440420"
            local animationTrack = game:GetService("Players").LocalPlayer.Character.Humanoid:LoadAnimation(animationInstance)
            animationTrack:Play()
            game:GetService("ReplicatedStorage").Remotes.CustomEmote:FireServer(false, "Empyrean")
            game:GetService("ReplicatedStorage").Remotes.CustomEmote:FireServer(false, "Wavelight")
        end
    })
    Tabs.Emotes:AddButton({
        Title = "Stop Animations",
        Description = "",
        Callback = function()
            for loopAmount, animationTrack in pairs(localPlayer.Character.Humanoid:GetPlayingAnimationTracks()) do
                animationTrack:Stop()
            end
            local animationInstance = Instance.new("Animation")
            animationInstance.AnimationId = "rbxassetid://13772440420"
            local animationTrack = game:GetService("Players").LocalPlayer.Character.Humanoid:LoadAnimation(animationInstance)
            animationTrack:Play()
        end
    })
    Tabs.Emotes:AddButton({
        Title = "Stop Music",
        Description = "",
        Callback = function()
            game:GetService("ReplicatedStorage").Remotes.CustomEmote:FireServer(false, "Empyrean")
            game:GetService("ReplicatedStorage").Remotes.CustomEmote:FireServer(false, "Wavelight")
        end
    })
    Tabs.Emotes:AddButton({
        Title = "Take The L",
        Description = "",
        Callback = function()
            local animationInstance = Instance.new("Animation")
            animationInstance.AnimationId = "rbxassetid://14351095988"
            local animationTrack = game:GetService("Players").LocalPlayer.Character.Humanoid:LoadAnimation(animationInstance)
            animationTrack:Play()
        end
    })
    Tabs.Emotes:AddButton({
        Title = "Take The L (With Music)",
        Description = "",
        Callback = function()
            local animationInstance = Instance.new("Animation")
            animationInstance.AnimationId = "rbxassetid://14351095988"
            local animationTrack = game:GetService("Players").LocalPlayer.Character.Humanoid:LoadAnimation(animationInstance)
            animationTrack:Play()
            game:GetService("ReplicatedStorage").Remotes.CustomEmote:FireServer(true, "Wavelight")
        end
    })
    Tabs.Emotes:AddButton({
        Title = "Default Dance",
        Description = "",
        Callback = function()
            local animationInstance = Instance.new("Animation")
            animationInstance.AnimationId = "rbxassetid://14351118998"
            local animationTrack = game:GetService("Players").LocalPlayer.Character.Humanoid:LoadAnimation(animationInstance)
            animationTrack:Play()
        end
    })
    Tabs.Emotes:AddButton({
        Title = "Default Dance (With Music)",
        Description = "",
        Callback = function()
            local animationInstance = Instance.new("Animation")
            animationInstance.AnimationId = "rbxassetid://14351118998"
            local animationTrack = game:GetService("Players").LocalPlayer.Character.Humanoid:LoadAnimation(animationInstance)
            animationTrack:Play()
            game:GetService("ReplicatedStorage").Remotes.CustomEmote:FireServer(true, "Wavelight")
        end
    })
    Tabs.Emotes:AddButton({
        Title = "Gamepass Emote 1",
        Description = "",
        Callback = function()
            local animationInstance = Instance.new("Animation")
            animationInstance.AnimationId = "rbxassetid://14557192252"
            local animationTrack = game:GetService("Players").LocalPlayer.Character.Humanoid:LoadAnimation(animationInstance)
            animationTrack:Play()
        end
    })
    Tabs.Emotes:AddButton({
        Title = "Gamepass Emote 1 (With Effects)",
        Description = "",
        Callback = function()
            local animationInstance = Instance.new("Animation")
            animationInstance.AnimationId = "rbxassetid://14557192252"
            local animationTrack = game:GetService("Players").LocalPlayer.Character.Humanoid:LoadAnimation(animationInstance)
            animationTrack:Play()
            game:GetService("ReplicatedStorage").Remotes.CustomEmote:FireServer(true, "Empyrean")
        end
    })
    Tabs.Emotes:AddButton({
        Title = "Gamepass Emote 2",
        Description = "",
        Callback = function()
            local animationInstance = Instance.new("Animation")
            animationInstance.AnimationId = "rbxassetid://14848907792"
            local animationTrack = game:GetService("Players").LocalPlayer.Character.Humanoid:LoadAnimation(animationInstance)
            animationTrack:Play()
        end
    })
    Tabs.Emotes:AddButton({
        Title = "Gamepass Emote 2 (With Effects)",
        Description = "",
        Callback = function()
            local animationInstance = Instance.new("Animation")
            animationInstance.AnimationId = "rbxassetid://14848907792"
            local animationTrack = game:GetService("Players").LocalPlayer.Character.Humanoid:LoadAnimation(animationInstance)
            animationTrack:Play()
            game:GetService("ReplicatedStorage").Remotes.CustomEmote:FireServer(true, "Wavelight")
        end
    })
    local SpamSounds = Tabs.Trolling:AddKeybind("SpamSounds", {
        Title = "Spam sounds and effects (Serversided)",
        Mode = "Toggle", -- Always, Toggle, Hold
        Default = "M", -- String as the name of the keybind (MB1, MB2 for mouse buttons)
        Callback = function()
                
        end,
        ChangedCallback = function()
            
        end
    })
    local LagSpike = Tabs.Trolling:AddKeybind("LagSpike", {
        Title = "Gives everyone in the server a lag spike",
        Mode = "Toggle", -- Always, Toggle, Hold
        Default = "T", -- String as the name of the keybind (MB1, MB2 for mouse buttons)
    })
    LagSpike:OnClick(function()
        startPreventLag()
        for mainAmount = 1,10 do
            for requestAmount = 1,lagStrength do
                game:GetService("ReplicatedStorage").Remotes.CustomEmote:FireServer(true, "Wavelight")
                game:GetService("ReplicatedStorage").Remotes.CustomEmote:FireServer(true, "Empyrean")
            end
            runService.Stepped:Wait()
        end
        endPreventLag()
    end)
    BallAscension:OnClick(function()
        ascendBall = not ascendBall
        if ascendBall then
            orginCFrame = localPlayer.Character.HumanoidRootPart.CFrame
            wait()
            local rootPart = localPlayer.Character.HumanoidRootPart
            local cameraPart = Instance.new("Part")
            cameraPart.Name = "ascendBallCameraPart"
            cameraPart.Parent = workspace
            cameraPart.Transparency = 1
            cameraPart.CanCollide = false
            cameraPart.Anchored = true
            cameraPart.CFrame = orginCFrame
            workspace.CurrentCamera.CameraSubject = cameraPart
        else
            workspace.CurrentCamera.CameraSubject = localPlayer.Character.Humanoid
            workspace.ascendBallCameraPart:Destroy()
        end
    end)
    SpamSounds:OnClick(function()
        spamSounds = not spamSounds
    end)
    task.spawn(function()
        while true do
            runService.Stepped:Wait()
            local state = SpamParry:GetState()
            if state then
                local simulateClick = function(buttonInstance)
                    game:GetService("VirtualInputManager"):SendMouseButtonEvent(buttonInstance.AbsolutePosition.X+buttonInstance.AbsoluteSize.X/2,buttonInstance.AbsolutePosition.Y+50,0,true,buttonInstance,1)
                    game:GetService("VirtualInputManager"):SendMouseButtonEvent(buttonInstance.AbsolutePosition.X+buttonInstance.AbsoluteSize.X/2,buttonInstance.AbsolutePosition.Y+50,0,false,buttonInstance,1)
                end
                simulateClick(game:GetService("Players").LocalPlayer.PlayerGui.Hotbar.Block.Pressable1)
            end
            if Fluent.Unloaded then
                break
            end
        end
    end)
    task.spawn(function()
        while true do
            wait(0.05)
            local state = PlusDistance:GetState()
            if state then
                ParrySlider:SetValue(autoParrySize + 1)
                Fluent:Notify({
                    Title = "Auto-Parry Distance Changed",
                    Content = "Auto-Parry Distance: "..tostring(autoParrySize),
                    SubContent = "", -- Optional
                    Duration = 1 -- Set to nil to make the notification not disappear
                })
            end
            if Fluent.Unloaded then
                break
            end
        end
    end)
    task.spawn(function()
        while true do
            wait(0.05)
            local state = MinusDistance:GetState()
            if state then
                ParrySlider:SetValue(autoParrySize - 1)
                Fluent:Notify({
                    Title = "Auto-Parry Distance Changed",
                    Content = "Auto-Parry Distance: "..tostring(autoParrySize),
                    SubContent = "", -- Optional
                    Duration = 1 -- Set to nil to make the notification not disappear
                })
            end
            if Fluent.Unloaded then
                break
            end
        end
    end)
    SpamParry:SetValue("C", "Hold")
end

SaveManager:SetLibrary(Fluent)
InterfaceManager:SetLibrary(Fluent)
SaveManager:IgnoreThemeSettings()
SaveManager:SetIgnoreIndexes({})
InterfaceManager:SetFolder("Nemo")
SaveManager:SetFolder("Nemo/bladeball")
Window:SelectTab(5)
--InterfaceManager:BuildInterfaceSection(Tabs.Settings)
--SaveManager:BuildConfigSection(Tabs.Settings)
--SaveManager:LoadAutoloadConfig()

spawn(function()
    while true do
        runService.Stepped:Wait()
        if ascendBall then
            pcall(function()
                if localPlayer.Character.HumanoidRootPart and ascendBall then
                    frameType = not frameType
                    if frameType then
                        localPlayer.Character.HumanoidRootPart.Velocity = Vector3.new(0, 2500, 0)
                        localPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(0, 99999, 0)
                    else
                        goingBack = true
                        localPlayer.Character.HumanoidRootPart.Velocity = Vector3.new(0, 0, 0)
                        localPlayer.Character.HumanoidRootPart.CFrame = orginCFrame
                    end
                end
            end)
        elseif goingBack then
            goingBack = false
            for loopAmount = 1, 18 do
                pcall(function()
                    runService.Stepped:Wait()
                    localPlayer.Character.HumanoidRootPart.Velocity = Vector3.new(0, 0, 0)
                    localPlayer.Character.HumanoidRootPart.CFrame = orginCFrame
                end)
            end
        end 
        if Fluent.Unloaded then
            break
        end
    end
end)

spawn(function()
    while true do
        runService.Stepped:Wait()
        runService.Stepped:Wait()
        runService.Stepped:Wait()
        runService.Stepped:Wait()
        runService.Stepped:Wait()
        if spamSounds then
            game:GetService("ReplicatedStorage").Remotes.CustomEmote:FireServer(true, "Empyrean")
            game:GetService("ReplicatedStorage").Remotes.CustomEmote:FireServer(true, "Wavelight")
        end 
        if Fluent.Unloaded then
            break
        end
    end
end)

spawn(function()
    while true do
        runService.RenderStepped:Wait()
        if parrySpamming then
            spawn(function()
                for loopAmount = 1,1 do
                    parryButtonPress:Fire()
                end
            end)
        end
        if Fluent.Unloaded then
            break
        end
    end
end)

spawn(function()
    while true do
        wait(0.03)
        print(parriesPerSecond)
        if parriesPerSecond > 1 then
            parrySpamming = true
        else
            parrySpamming = false
        end
        parriesPerSecond = 0
        if Fluent.Unloaded then
            break
        end
    end
end)

local AliveFolder = Tabs.Abilities:AddButton({
    Title = "Allow Use abilities/parry in lobby",
    Description = "Very important button",
    Callback = function()
    character.Parent = workspace.Alive
        Window:Dialog({
            Title = "Use of Abilities in lobby",
            Content = "Allows you to use whatever ability that is equipted in the lobby",
            Buttons = {
                {
                    Title = "Confirm",
                    Callback = function()
                        print("Confirmed the dialog.")
                    end
                },
                {
                    Title = "Cancel",
                    Callback = function()
                        print("Cancelled the dialog.")
                    end
                }
            }
        })
    end
})

local InfShadowStep = Tabs.Abilities:AddButton({
    Title = "InfShadowStep",
    Description = "Very important button",
    Callback = function() 
    upgrades:WaitForChild("Shadow Step").Value = 999999999999999999
        Window:Dialog({
            Title = "InfShadowStep",
            Content = "Lets you infinitely use ShadowStep.",
            Buttons = {
                {
                    Title = "Confirm",
                    Callback = function()
                        print("Confirmed the dialog.")
                    end
                },
                {
                    Title = "Cancel",
                    Callback = function()
                        print("Cancelled the dialog.")
                    end
                }
            }
        })
    end
})

local InfDash = Tabs.Abilities:AddButton({
    Title = "InfDash",
    Description = "InfDash",
    Callback = function() 
    upgrades:WaitForChild("Dash").Value = 999999999999999999
        Window:Dialog({
            Title = "InfDash",
            Content = "Lets you dash Infinitely",
            Buttons = {
                {
                    Title = "Confirm",
                    Callback = function()
                        print("Confirmed the dialog.")
                    end
                },
                {
                    Title = "Cancel",
                    Callback = function()
                        print("Cancelled the dialog.")
                    end
                }
            }
        })
    end
})


local infForcefield2 = Tabs.Abilities:AddButton({
    Title = "infForcefield",
    Description = "infForcefield",
    Callback = function() 
    upgrades:WaitForChild("Forcefield").Value = 999999999999999999
        Window:Dialog({
            Title = "infForcefield",
            Content = "Lets you have forcefield for long time",
            Buttons = {
                {
                    Title = "Confirm",
                    Callback = function()
                        print("Confirmed the dialog.")
                    end
                },
                {
                    Title = "Cancel",
                    Callback = function()
                        print("Cancelled the dialog.")
                    end
                }
            }
        })
    end
})

local infInvisibility2 = Tabs.Abilities:AddButton({
    Title = "infInvisibility",
    Description = "infInvisibility",
    Callback = function() 
    upgrades:WaitForChild("Invisibility").Value = 999999999999999999
        Window:Dialog({
            Title = "infInvisibility",
            Content = "Lets you have Invisibility for long time",
            Buttons = {
                {
                    Title = "Confirm",
                    Callback = function()
                        print("Confirmed the dialog.")
                    end
                },
                {
                    Title = "Cancel",
                    Callback = function()
                        print("Cancelled the dialog.")
                    end
                }
            }
        })
    end
})

local InfSuperJump = Tabs.Abilities:AddButton({
    Title = "InfSuperJump",
    Description = "InfSuperJump",
    Callback = function() 
    upgrades:WaitForChild("Super Jump").Value = 999999999999999999
        Window:Dialog({
            Title = "InfSuperJump",
            Content = "Lets you spam Super Jump (USE CAREFULLY!)",
            Buttons = {
                {
                    Title = "Confirm",
                    Callback = function()
                        print("Confirmed the dialog.")
                    end
                },
                {
                    Title = "Cancel",
                    Callback = function()
                        print("Cancelled the dialog.")
                    end
                }
            }
        })
    end
})

local InfRagingDeflection = Tabs.Abilities:AddButton({
    Title = "InfRagingDeflection",
    Description = "InfRagingDeflection",
    Callback = function() 
    upgrades:WaitForChild("Raging Deflection").Value = 10
        Window:Dialog({
            Title = "InfRagingDeflection",
            Content = "Lets you use raging deflect no cooldown (USE CAREFULLY!)",
            Buttons = {
                {
                    Title = "Confirm",
                    Callback = function()
                        print("Confirmed the dialog.")
                    end
                },
                {
                    Title = "Cancel",
                    Callback = function()
                        print("Cancelled the dialog.")
                    end
                }
            }
        })
    end
})

local Slider = Tabs.Trolling:AddSlider("Walkspeed", {
    Title = "Walkspeed",
    Description = "This is a slider",
    Default = 30,
    Min = 5,
    Max = 200,
    Rounding = 1,
    Callback = function(Value)
        game.Players.LocalPlayer.Character.Humanoid.WalkSpeed = Value
    end
})

Slider:OnChanged(function(Value)
    
end)

Slider:SetValue(false)

-- Addons:
-- SaveManager (Allows you to have a configuration system)
-- InterfaceManager (Allows you to have a interface managment system)

-- Hand the library over to our managers
SaveManager:SetLibrary(Fluent)
InterfaceManager:SetLibrary(Fluent)

-- Ignore keys that are used by ThemeManager.
-- (we dont want configs to save themes, do we?)
SaveManager:IgnoreThemeSettings()

-- You can add indexes of elements the save manager should ignore
SaveManager:SetIgnoreIndexes({})

-- use case for doing it this way:
-- a script hub could have themes in a global folder
-- and game configs in a separate folder per game
InterfaceManager:SetFolder("Nemo")
SaveManager:SetFolder("Nemo/bladeball")

InterfaceManager:BuildInterfaceSection(Tabs.Settings)
SaveManager:BuildConfigSection(Tabs.Settings)


Window:SelectTab(1)

Fluent:Notify({
Title = "Nemo Hub",
Content = "The script has been loaded.",
Duration = 8
})

-- You can use the SaveManager:LoadAutoloadConfig() to load a config
-- which has been marked to be one that auto loads!
SaveManager:LoadAutoloadConfig()
