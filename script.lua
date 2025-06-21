-- Serviços
local Players = game:GetService("Players")
local UserInputService = game:GetService("UserInputService")
local RunService = game:GetService("RunService")
local LocalPlayer = Players.LocalPlayer
local PlayerGui = LocalPlayer:WaitForChild("PlayerGui")
local ClipboardService = setclipboard or toclipboard or (Clipboard and Clipboard.set)

-- Remover UI antiga
local oldGui = PlayerGui:FindFirstChild("EmperorHub")
if oldGui then oldGui:Destroy() end

-- Criar GUI
local gui = Instance.new("ScreenGui")
gui.Name = "EmperorHub"
gui.ResetOnSpawn = false
gui.Parent = PlayerGui

-- Função de Drag
local function makeDraggable(frame)
    local dragging, dragInput, dragStart, startPos

    frame.InputBegan:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
            dragging = true
            dragStart = input.Position
            startPos = frame.Position

            input.Changed:Connect(function()
                if input.UserInputState == Enum.UserInputState.End then
                    dragging = false
                end
            end)
        end
    end)

    frame.InputChanged:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseMovement or input.UserInputType == Enum.UserInputType.Touch then
            dragInput = input
        end
    end)

    UserInputService.InputChanged:Connect(function(input)
        if input == dragInput and dragging then
            local delta = input.Position - dragStart
            local screenSize = workspace.CurrentCamera.ViewportSize
            local newPos = UDim2.new(
                startPos.X.Scale + delta.X / screenSize.X,
                startPos.X.Offset,
                startPos.Y.Scale + delta.Y / screenSize.Y,
                startPos.Y.Offset
            )
            frame.Position = newPos
        end
    end)
end

-- Main Frame
local main = Instance.new("Frame")
main.Size = UDim2.new(0, 350, 0, 250)
main.Position = UDim2.new(0.5, -175, 0.5, -125)
main.BackgroundColor3 = Color3.fromRGB(20, 20, 20)
main.Parent = gui
main.Visible = true
Instance.new("UICorner", main).CornerRadius = UDim.new(0, 15)

local stroke = Instance.new("UIStroke", main)
stroke.Thickness = 4
stroke.Color = Color3.new(0,0,0)

-- Wallpaper
local wallpaper = Instance.new("ImageLabel", main)
wallpaper.Size = UDim2.new(1, -10, 1, -10)
wallpaper.Position = UDim2.new(0, 5, 0, 5)
wallpaper.BackgroundTransparency = 1
wallpaper.Image = "rbxassetid://110536188881147"
wallpaper.ImageTransparency = 0.5
Instance.new("UICorner", wallpaper).CornerRadius = UDim.new(0, 15)

-- Inner Frame
local inner = Instance.new("Frame", main)
inner.Size = UDim2.new(1, -10, 1, -10)
inner.Position = UDim2.new(0, 5, 0, 5)
inner.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
inner.BackgroundTransparency = 0.7
Instance.new("UICorner", inner).CornerRadius = UDim.new(0, 15)

-- Logo no canto
local logo = Instance.new("ImageLabel", inner)
logo.Size = UDim2.new(0, 30, 0, 30)
logo.Position = UDim2.new(0, 10, 0, 5)
logo.BackgroundTransparency = 1
logo.Image = "rbxassetid://110536188881147"
logo.ScaleType = Enum.ScaleType.Fit

-- Title
local title = Instance.new("TextLabel", inner)
title.Size = UDim2.new(1, 0, 0, 40)
title.Position = UDim2.new(0, 0, 0, 0)
title.BackgroundTransparency = 1
title.Text = "Emperor Hub"
title.Font = Enum.Font.GothamBold
title.TextColor3 = Color3.new(1,1,1)
title.TextSize = 24
title.TextXAlignment = Enum.TextXAlignment.Left
title.Position = UDim2.new(0, 45, 0, 0)

-- Tabs
local tabs = Instance.new("Frame", inner)
tabs.Size = UDim2.new(1, -20, 0, 35)
tabs.Position = UDim2.new(0, 10, 0, 45)
tabs.BackgroundTransparency = 1

local stylesBtn = Instance.new("TextButton", tabs)
stylesBtn.Size = UDim2.new(0.5, -5, 1, 0)
stylesBtn.Position = UDim2.new(0, 0, 0, 0)
stylesBtn.Text = "Estilos"
stylesBtn.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
stylesBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
stylesBtn.Font = Enum.Font.GothamBold
stylesBtn.TextSize = 18
Instance.new("UICorner", stylesBtn).CornerRadius = UDim.new(0, 15)

local playerBtn = stylesBtn:Clone()
playerBtn.Parent = tabs
playerBtn.Position = UDim2.new(0.5, 5, 0, 0)
playerBtn.Text = "Jogador"

-- Frames das abas
local stylesTab = Instance.new("Frame", inner)
stylesTab.Size = UDim2.new(1, -20, 1, -90)
stylesTab.Position = UDim2.new(0, 10, 0, 85)
stylesTab.BackgroundTransparency = 1
stylesTab.Visible = true

local playerTab = stylesTab:Clone()
playerTab.Parent = inner
playerTab.Visible = false

-- Função botão externo (Noel e Nel Rin)
local function createExternalStyleButton(parent, name, key, scriptURL, color, textColor, posY, isRGB)
    local btn = Instance.new("TextButton", parent)
    btn.Size = UDim2.new(1, 0, 0, 40)
    btn.Position = UDim2.new(0, 0, 0, posY)
    btn.BackgroundColor3 = color
    btn.TextColor3 = textColor
    btn.Font = Enum.Font.GothamBold
    btn.TextSize = 20
    btn.Text = name
    Instance.new("UICorner", btn).CornerRadius = UDim.new(0, 15)

    if isRGB then
        task.spawn(function()
            local hue = 0
            while task.wait() do
                hue = (hue + 1) % 360
                btn.BackgroundColor3 = Color3.fromHSV(hue/360, 1, 1)
            end
        end)
    end

    btn.MouseButton1Click:Connect(function()
        if ClipboardService then ClipboardService(key) end
        loadstring(game:HttpGet(scriptURL))()
        game.StarterGui:SetCore("SendNotification", {
            Title = "Emperor Hub",
            Text = "Key copiada e script de "..name.." executado 🔥",
            Duration = 3
        })
    end)
end

-- Criar botões estilos
createExternalStyleButton(stylesTab, "Noel Noa", "BESTNOEL",
    "https://raw.githubusercontent.com/stylemakeritosh/Ace/refs/heads/main/NoelNoaV1",
    Color3.fromRGB(0,0,0), Color3.fromRGB(255,255,255), 0, true)

createExternalStyleButton(stylesTab, "NEL Rin V2", "Nelrinv2upd",
    "https://raw.githubusercontent.com/stylemakeritosh/Ace/refs/heads/main/NelRinV2",
    Color3.fromRGB(255,255,255), Color3.fromRGB(0,100,0), 50, false)

-- Inf Stamina
local infStamina = false
local staminaBtn = Instance.new("TextButton", playerTab)
staminaBtn.Size = UDim2.new(1, 0, 0, 40)
staminaBtn.Position = UDim2.new(0, 0, 0, 0)
staminaBtn.BackgroundColor3 = Color3.fromRGB(200, 50, 50)
staminaBtn.TextColor3 = Color3.new(1,1,1)
staminaBtn.Font = Enum.Font.GothamBold
staminaBtn.TextSize = 20
staminaBtn.Text = "Inf Stamina [OFF]"
Instance.new("UICorner", staminaBtn).CornerRadius = UDim.new(0, 15)

local staminaConnection
staminaBtn.MouseButton1Click:Connect(function()
    infStamina = not infStamina
    if infStamina then
        staminaBtn.Text = "Inf Stamina [ON]"
        staminaBtn.BackgroundColor3 = Color3.fromRGB(50, 200, 50)
        staminaConnection = RunService.Heartbeat:Connect(function()
            local stamina = LocalPlayer.PlayerStats:FindFirstChild("Stamina")
            if stamina then stamina.Value = 100 end
        end)
    else
        staminaBtn.Text = "Inf Stamina [OFF]"
        staminaBtn.BackgroundColor3 = Color3.fromRGB(200, 50, 50)
        if staminaConnection then staminaConnection:Disconnect() end
    end
end)

-- No Cooldown
local noCooldownBtn = staminaBtn:Clone()
noCooldownBtn.Parent = playerTab
noCooldownBtn.Position = UDim2.new(0, 0, 0, 50)
noCooldownBtn.Text = "No Cooldown"
noCooldownBtn.BackgroundColor3 = Color3.fromRGB(200, 50, 50)

noCooldownBtn.MouseButton1Click:Connect(function()
    for i,v in pairs(getgc(true)) do
        if typeof(v) == "table" then
            for k,b in pairs(v) do
                if tostring(k):lower():find("cooldown") then
                    if typeof(b) == "number" and b > 0 then
                        v[k] = 0
                    end
                    if typeof(b) == "function" then
                        v[k] = function() return 0 end
                    end
                end
            end
        end
    end
    game.StarterGui:SetCore("SendNotification", {
        Title = "Emperor Hub",
        Text = "Cooldown Zerado 🔥",
        Duration = 3
    })
end)

-- Troca de abas
stylesBtn.MouseButton1Click:Connect(function()
    stylesTab.Visible = true
    playerTab.Visible = false
    stylesBtn.BackgroundColor3 = Color3.fromRGB(70, 70, 70)
    playerBtn.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
end)

playerBtn.MouseButton1Click:Connect(function()
    stylesTab.Visible = false
    playerTab.Visible = true
    stylesBtn.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
    playerBtn.BackgroundColor3 = Color3.fromRGB(70, 70, 70)
end)

-- Toggle UI
local toggleFrame = Instance.new("Frame", gui)
toggleFrame.Size = UDim2.new(0, 60, 0, 28)
toggleFrame.Position = UDim2.new(0, 20, 0, 20)
toggleFrame.BackgroundColor3 = Color3.fromRGB(45, 45, 45)
Instance.new("UICorner", toggleFrame).CornerRadius = UDim.new(0, 14)

local switchBtn = Instance.new("Frame", toggleFrame)
switchBtn.Size = UDim2.new(1, 0, 1, 0)
switchBtn.BackgroundColor3 = Color3.fromRGB(100, 100, 100)
Instance.new("UICorner", switchBtn).CornerRadius = UDim.new(0, 14)

local toggleCircle = Instance.new("Frame", switchBtn)
toggleCircle.Size = UDim2.new(0, 26, 0, 26)
toggleCircle.Position = UDim2.new(0, 2, 0, 1)
toggleCircle.BackgroundColor3 = Color3.fromRGB(230, 230, 230)
Instance.new("UICorner", toggleCircle).CornerRadius = UDim.new(0, 13)

local uiVisible = true
local function updateToggle()
    if uiVisible then
        switchBtn.BackgroundColor3 = Color3.fromRGB(0, 170, 0)
        toggleCircle:TweenPosition(UDim2.new(1, -28, 0, 1), Enum.EasingDirection.Out, Enum.EasingStyle.Quad, 0.3, true)
        main.Visible = true
    else
        switchBtn.BackgroundColor3 = Color3.fromRGB(100, 100, 100)
        toggleCircle:TweenPosition(UDim2.new(0, 2, 0, 1), Enum.EasingDirection.Out, Enum.EasingStyle.Quad, 0.3, true)
        main.Visible = false
    end
end

switchBtn.InputBegan:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.Touch or input.UserInputType == Enum.UserInputType.MouseButton1 then
        uiVisible = not uiVisible
        updateToggle()
    end
end)

-- Ativar drag
makeDraggable(main)
makeDraggable(toggleFrame)

updateToggle()
