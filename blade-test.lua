if game.Placeid == 13772394625 then
local OrionLib = loadstring(game:HttpGet(('https://raw.githubusercontent.com/shlexware/Orion/main/source')))()
local Window = OrionLib:MakeWindow({Name = "Title of the library", HidePremium = false, SaveConfig = true, ConfigFolder = "OrionTest"})



local Tab = Window:MakeTab({
    Name = "Main",
    Icon = "rbxassetid://4483345998",
    PremiumOnly = false
})



Main:AddButton({
    Name = "Auto Parry",
    Callback = function()
              print("button pressed")
              game:GetService("ReplicatedStorage").Remotes.ParryAttempt:FireServer(0.5,CFrame.new(-150.914352, 47.023819, -79.6698456, -0.114269011, -0.551743269, 0.826148927, 0, 0.831596076, 0.55538106, -0.993449926, 0.063462846, -0.0950256363),{["UwUf736"] = ,["didge46s"] = ,["Nerv_nd15duhund"] = ,["jamesthefast6"] = ,["Dannny7788"] = ,["bliskijan"] = ,["masondegekkert2"] = ,["DaCapo2012"] = ,["Ramamal46"] = ,["udnner"] = ,["1kz38p"] = ,["igowem1lky"] = },{553,150})
      end    
})

Main:AddButton({
    Name = "Auto Spam",
    Callback = function()
    local gui = Instance.new("ScreenGui")
gui.ResetOnSpawn = false 
gui.Parent = game.CoreGui 

local frame = Instance.new("Frame")
frame.Position = UDim2.new(0, 50, 0, 10)
frame.Size = UDim2.new(0, 100, 0, 75)
frame.BackgroundColor3 = Color3.new(0, 0, 0)
frame.BorderSizePixel = 0
frame.Parent = gui

local button = Instance.new("TextButton")
button.Text = "off spam"
button.Size = UDim2.new(1, -10, 1, -20)
button.Position = UDim2.new(0, 10, 0, 10)
button.BackgroundColor3 = Color3.new(1, 1, 1)
button.BorderColor3 = Color3.new(0, 0, 0)
button.BorderSizePixel = 2
button.Font = Enum.Font.SourceSans
button.TextColor3 = Color3.new(0, 0, 0)
button.TextSize = 16
button.Parent = frame

local activated = true

local function toggle()
    activated = not activated
    button.Text = activated and "on spam" or "off spam"
    
    while activated do
        local args = {
            [1] = 1.4,
            [2] = CFrame.new(-254.2939910888672, 112.13581848144531, -119.27256774902344) * CFrame.Angles(-2.029526710510254, 0.5662040710449219, 2.314905881881714),
            [3] = {
                ["2617721424"] = Vector3.new(-273.400146484375, -724.8031005859375, -20.92414093017578),
                
            },
            [4] = {
                [1] = 910,
                [2] = 154
            }
        }

        game:GetService("ReplicatedStorage").Remotes.ParryAttempt:FireServer(unpack(args))
        game:GetService("RunService").Heartbeat:Wait()
    end
end

button.MouseButton1Click:Connect(toggle)
      end    
})
