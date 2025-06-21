-- [SERVIÇOS]
local Players = game:GetService("Players")
local UserInputService = game:GetService("UserInputService")
local RunService = game:GetService("RunService")
local CoreGui = game:GetService("CoreGui")
local LocalPlayer = Players.LocalPlayer
local PlayerGui = LocalPlayer:WaitForChild("PlayerGui")

-- [REMOVE UI ANTIGA]
local oldGui = PlayerGui:FindFirstChild("soyguhMOD")
if oldGui then oldGui:Destroy() end

-- [SCREEN GUI]
local screenGui = Instance.new("ScreenGui")
screenGui.Name = "soyguhMOD"
screenGui.ResetOnSpawn = false
screenGui.Parent = PlayerGui

-- [FUNÇÃO DRAG]
local function makeDraggable(frame)
    local dragging, dragInput, dragStart, startPos = false
    frame.InputBegan:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.Touch or input.UserInputType == Enum.UserInputType.MouseButton1 then
            dragging = true
            dragStart = input.Position
            startPos = frame.Position
            input.Changed:Connect(function()
                if input.UserInputState == Enum.UserInputState.End then dragging = false end
            end)
        end
    end)
    frame.InputChanged:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.Touch or input.UserInputType == Enum.UserInputType.MouseMovement then
            dragInput = input
        end
    end)
    UserInputService.InputChanged:Connect(function(input)
        if input == dragInput and dragging then
            local delta = input.Position - dragStart
            local screenSize = workspace.CurrentCamera.ViewportSize
            local newX = startPos.X.Scale + delta.X / screenSize.X
            local newY = startPos.Y.Scale + delta.Y / screenSize.Y
            local frameSize = frame.Size
            local maxX = 1 - frameSize.X.Scale
            local maxY = 1 - frameSize.Y.Scale
            frame.Position = UDim2.new(math.clamp(newX, 0, maxX), 0, math.clamp(newY, 0, maxY), 0)
        end
    end)
end

-- [MAIN FRAME]
local mainFrame = Instance.new("Frame")
mainFrame.Name = "MainFrame"
mainFrame.Size = UDim2.new(0, 350, 0, 250)
mainFrame.Position = UDim2.new(0.5, -175, 0.5, -125)
mainFrame.BackgroundColor3 = Color3.new(0,0,0)
mainFrame.BorderSizePixel = 0
mainFrame.Parent = screenGui
mainFrame.Active = true
Instance.new("UICorner", mainFrame).CornerRadius = UDim.new(0, 15)
Instance.new("UIStroke", mainFrame).Thickness = 5

-- [WALLPAPER]
local wallpaper = Instance.new("ImageLabel")
wallpaper.Parent = mainFrame
wallpaper.Size = UDim2.new(1, -10, 1, -10)
wallpaper.Position = UDim2.new(0,5,0,5)
wallpaper.Image = "rbxassetid://110536188881147"
wallpaper.ImageTransparency = 0.5
wallpaper.BackgroundTransparency = 1
Instance.new("UICorner", wallpaper).CornerRadius = UDim.new(0, 15)

-- [INNER FRAME]
local innerFrame = Instance.new("Frame")
innerFrame.Parent = mainFrame
innerFrame.Size = wallpaper.Size
innerFrame.Position = wallpaper.Position
innerFrame.BackgroundColor3 = Color3.fromRGB(30,30,30)
innerFrame.BackgroundTransparency = 0.7
innerFrame.BorderSizePixel = 0
Instance.new("UICorner", innerFrame).CornerRadius = UDim.new(0, 15)

-- [TÍTULO]
local titleFrame = Instance.new("Frame")
titleFrame.Parent = innerFrame
titleFrame.Size = UDim2.new(1,0,0,40)
titleFrame.BackgroundTransparency = 1

local logo = Instance.new("ImageLabel")
logo.Parent = titleFrame
logo.Size = UDim2.new(0,30,0,30)
logo.Position = UDim2.new(0,10,0,5)
logo.Image = "rbxassetid://110536188881147"
logo.BackgroundTransparency = 1

local title = Instance.new("TextLabel")
title.Parent = titleFrame
title.Size = UDim2.new(1,-50,1,0)
title.Position = UDim2.new(0,45,0,0)
title.BackgroundTransparency = 1
title.Font = Enum.Font.GothamBold
title.TextSize = 24
title.TextColor3 = Color3.new(1,1,1)
title.Text = "Emperor Hub"
title.TextXAlignment = Enum.TextXAlignment.Left

-- [ABAS]
local tabButtons = Instance.new("Frame")
tabButtons.Parent = innerFrame
tabButtons.Size = UDim2.new(1,-20,0,35)
tabButtons.Position = UDim2.new(0,10,0,45)
tabButtons.BackgroundTransparency = 1

local stylesTabButton = Instance.new("TextButton")
stylesTabButton.Parent = tabButtons
stylesTabButton.Size = UDim2.new(0.5,-5,1,0)
stylesTabButton.Position = UDim2.new(0,0,0,0)
stylesTabButton.Text = "Estilos"
stylesTabButton.BackgroundColor3 = Color3.fromRGB(50,50,50)
stylesTabButton.TextColor3 = Color3.new(1,1,1)
stylesTabButton.Font = Enum.Font.GothamBold
stylesTabButton.TextSize = 18
Instance.new("UICorner", stylesTabButton).CornerRadius = UDim.new(0,15)

local vulnTabButton = stylesTabButton:Clone()
vulnTabButton.Parent = tabButtons
vulnTabButton.Position = UDim2.new(0.5,5,0,0)
vulnTabButton.Text = "Jogador"

-- [ABA ESTILOS]
local stylesTab = Instance.new("Frame")
stylesTab.Parent = innerFrame
stylesTab.Size = UDim2.new(1,-20,1,-90)
stylesTab.Position = UDim2.new(0,10,0,85)
stylesTab.BackgroundTransparency = 1

-- Noel Noa Button com RGB
local noelBtn = Instance.new("TextButton")
noelBtn.Parent = stylesTab
noelBtn.Size = UDim2.new(1,0,0,40)
noelBtn.Position = UDim2.new(0,0,0,0)
noelBtn.BackgroundColor3 = Color3.fromRGB(0,0,0)
noelBtn.TextColor3 = Color3.new(1,1,1)
noelBtn.Font = Enum.Font.GothamBold
noelBtn.TextSize = 20
noelBtn.Text = "Noel Noa"
Instance.new("UICorner", noelBtn).CornerRadius = UDim.new(0,15)

-- RGB
task.spawn(function()
    local hue = 0
    while true do
        hue = (hue + 1) % 360
        noelBtn.BackgroundColor3 = Color3.fromHSV(hue/360,1,1)
        task.wait(0.05)
    end
end)

noelBtn.MouseButton1Click:Connect(function()
    loadstring(game:HttpGet("https://raw.githubusercontent.com/stylemakeritosh/Ace/refs/heads/main/NoelNoaV1"))()
    task.wait(2)
    local gui = CoreGui:FindFirstChild("Rin System") or CoreGui:FindFirstChildWhichIsA("ScreenGui")
    if gui then
        local textBox = gui:FindFirstChildWhichIsA("TextBox", true)
        local checkBtn
        for _,v in pairs(gui:GetDescendants()) do
            if v:IsA("TextButton") or v:IsA("ImageButton") then
                if string.lower(v.Text) == "check key" then
                    checkBtn = v
                    break
                end
            end
        end
        if textBox and checkBtn then
            textBox.Text = "BESTNOEL"
            task.wait(0.5)
            checkBtn:Activate()
        end
    end
end)

-- [ABA JOGADOR]
local vulnTab = Instance.new("Frame")
vulnTab.Parent = innerFrame
vulnTab.Size = stylesTab.Size
vulnTab.Position = stylesTab.Position
vulnTab.BackgroundTransparency = 1
vulnTab.Visible = false

-- INF STAMINA
local infStamina = false
local staminaConn = nil

local infStaminaBtn = Instance.new("TextButton")
infStaminaBtn.Parent = vulnTab
infStaminaBtn.Size = UDim2.new(1,0,0,40)
infStaminaBtn.Position = UDim2.new(0,0,0,0)
infStaminaBtn.BackgroundColor3 = Color3.fromRGB(200,50,50)
infStaminaBtn.TextColor3 = Color3.new(1,1,1)
infStaminaBtn.Font = Enum.Font.GothamBold
infStaminaBtn.TextSize = 20
infStaminaBtn.Text = "Inf Stamina [OFF]"
Instance.new("UICorner", infStaminaBtn).CornerRadius = UDim.new(0,15)

infStaminaBtn.MouseButton1Click:Connect(function()
    infStamina = not infStamina
    if infStamina then
        infStaminaBtn.Text = "Inf Stamina [ON]"
        infStaminaBtn.BackgroundColor3 = Color3.fromRGB(50,200,50)
        staminaConn = RunService.Heartbeat:Connect(function()
            pcall(function()
                local stat = LocalPlayer.PlayerStats:FindFirstChild("Stamina")
                if stat then stat.Value = 100 end
            end)
        end)
    else
        infStaminaBtn.Text = "Inf Stamina [OFF]"
        infStaminaBtn.BackgroundColor3 = Color3.fromRGB(200,50,50)
        if staminaConn then staminaConn:Disconnect() end
    end
end)

-- NO COOLDOWN
local noCooldownBtn = Instance.new("TextButton")
noCooldownBtn.Parent = vulnTab
noCooldownBtn.Size = UDim2.new(1,0,0,40)
noCooldownBtn.Position = UDim2.new(0,0,0,50)
noCooldownBtn.BackgroundColor3 = Color3.fromRGB(200,50,50)
noCooldownBtn.TextColor3 = Color3.new(1,1,1)
noCooldownBtn.Font = Enum.Font.GothamBold
noCooldownBtn.TextSize = 20
noCooldownBtn.Text = "No Cooldown"
Instance.new("UICorner", noCooldownBtn).CornerRadius = UDim.new(0,15)

noCooldownBtn.MouseButton1Click:Connect(function()
    for i,v in pairs(getgc(true)) do
        if typeof(v) == "table" then
            for key,value in pairs(v) do
                if tostring(key):lower():find("cooldown") then
                    if typeof(value) == "number" and value > 0 then
                        v[key] = 0
                    end
                    if typeof(value) == "function" then
                        v[key] = function() return 0 end
                    end
                end
            end
        end
    end
    game.StarterGui:SetCore("SendNotification",{
        Title = "Emperor Hub",
        Text = "Cooldown das Skills Zerado 😈!",
        Duration = 3
    })
end)

-- [SISTEMA DE ABAS]
stylesTabButton.MouseButton1Click:Connect(function()
    stylesTab.Visible = true
    vulnTab.Visible = false
    stylesTabButton.BackgroundColor3 = Color3.fromRGB(70,70,70)
    vulnTabButton.BackgroundColor3 = Color3.fromRGB(50,50,50)
end)

vulnTabButton.MouseButton1Click:Connect(function()
    stylesTab.Visible = false
    vulnTab.Visible = true
    stylesTabButton.BackgroundColor3 = Color3.fromRGB(50,50,50)
    vulnTabButton.BackgroundColor3 = Color3.fromRGB(70,70,70)
end)

-- [TOGGLE UI]
local toggleFrame = Instance.new("Frame")
toggleFrame.Name = "ToggleFrame"
toggleFrame.Size = UDim2.new(0,60,0,28)
toggleFrame.Position = UDim2.new(0,20,0,20)
toggleFrame.BackgroundColor3 = Color3.fromRGB(45,45,45)
toggleFrame.Parent = screenGui
toggleFrame.Active = true
Instance.new("UICorner", toggleFrame).CornerRadius = UDim.new(0,14)

local switchBtn = Instance.new("Frame")
switchBtn.Parent = toggleFrame
switchBtn.Size = UDim2.new(1,0,1,0)
switchBtn.BackgroundColor3 = Color3.fromRGB(100,100,100)
Instance.new("UICorner", switchBtn).CornerRadius = UDim.new(0,14)

local toggleCircle = Instance.new("Frame")
toggleCircle.Parent = switchBtn
toggleCircle.Size = UDim2.new(0,26,0,26)
toggleCircle.Position = UDim2.new(0,2,0,1)
toggleCircle.BackgroundColor3 = Color3.fromRGB(230,230,230)
Instance.new("UICorner", toggleCircle).CornerRadius = UDim.new(0,13)

local uiVisible = true
local function updateToggle()
    if uiVisible then
        switchBtn.BackgroundColor3 = Color3.fromRGB(0,170,0)
        toggleCircle:TweenPosition(UDim2.new(1,-28,0,1),Enum.EasingDirection.Out,Enum.EasingStyle.Quad,0.3,true)
        mainFrame.Visible = true
    else
        switchBtn.BackgroundColor3 = Color3.fromRGB(100,100,100)
        toggleCircle:TweenPosition(UDim2.new(0,2,0,1),Enum.EasingDirection.Out,Enum.EasingStyle.Quad,0.3,true)
        mainFrame.Visible = false
    end
end

switchBtn.InputBegan:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.Touch or input.UserInputType == Enum.UserInputType.MouseButton1 then
        uiVisible = not uiVisible
        updateToggle()
    end
end)

makeDraggable(mainFrame)
makeDraggable(toggleFrame)

updateToggle()
