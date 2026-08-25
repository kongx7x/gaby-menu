local CoreGui = game:GetService("CoreGui")
local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local UserInputService = game:GetService("UserInputService")
local Workspace = game:GetService("Workspace")
local LocalPlayer = Players.LocalPlayer
local Camera = Workspace.CurrentCamera

if CoreGui:FindFirstChild("GabyMenu") then
    CoreGui.GabyMenu:Destroy()
end

local ScreenGui = Instance.new("ScreenGui")
ScreenGui.Name = "GabyMenu"
ScreenGui.Parent = CoreGui
ScreenGui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling

-- Janela Principal
local MainFrame = Instance.new("Frame")
MainFrame.Name = "MainFrame"
MainFrame.Parent = ScreenGui
MainFrame.BackgroundColor3 = Color3.fromRGB(20, 15, 20)
MainFrame.Position = UDim2.new(0.5, -200, 0.5, -175)
MainFrame.Size = UDim2.new(0, 420, 0, 350)
MainFrame.Active = true
MainFrame.Draggable = true
MainFrame.ClipsDescendants = true
MainFrame.Visible = false

local UICornerMain = Instance.new("UICorner")
UICornerMain.CornerRadius = UDim.new(0, 12)
UICornerMain.Parent = MainFrame

local UIStrokeMain = Instance.new("UIStroke")
UIStrokeMain.Color = Color3.fromRGB(255, 105, 180)
UIStrokeMain.Thickness = 2
UIStrokeMain.Parent = MainFrame

-- Botão Flutuante
local ToggleButton = Instance.new("ImageButton")
ToggleButton.Name = "ToggleButton"
ToggleButton.Parent = ScreenGui
ToggleButton.BackgroundColor3 = Color3.fromRGB(255, 105, 180)
ToggleButton.Position = UDim2.new(0.05, 0, 0.1, 0)
ToggleButton.Size = UDim2.new(0, 50, 0, 50)
ToggleButton.Image = "rbxassetid://132025334560451"
ToggleButton.Active = true

local UICornerBtn = Instance.new("UICorner")
UICornerBtn.CornerRadius = UDim.new(1, 0)
UICornerBtn.Parent = ToggleButton

local UIStrokeBtn = Instance.new("UIStroke")
UIStrokeBtn.Color = Color3.fromRGB(255, 20, 147)
UIStrokeBtn.Thickness = 2
UIStrokeBtn.Parent = ToggleButton

-- Imagem de Fundo
local BackgroundImage = Instance.new("ImageLabel")
BackgroundImage.Parent = MainFrame
BackgroundImage.BackgroundTransparency = 1
BackgroundImage.Size = UDim2.new(1, 0, 1, 0)
BackgroundImage.Image = "rbxassetid://132025334560451"
BackgroundImage.ImageTransparency = 0.8
BackgroundImage.ZIndex = 0

local UICornerBg = Instance.new("UICorner")
UICornerBg.CornerRadius = UDim.new(0, 12)
UICornerBg.Parent = BackgroundImage

-- Título
local Title = Instance.new("TextLabel")
Title.Parent = MainFrame
Title.BackgroundColor3 = Color3.fromRGB(50, 20, 35)
Title.BackgroundTransparency = 0.2
Title.Size = UDim2.new(1, 0, 0, 40)
Title.Font = Enum.Font.SourceSansBold
Title.Text = "GABY MENU | YT"
Title.TextColor3 = Color3.fromRGB(255, 182, 193)
Title.TextSize = 18
Title.ZIndex = 2

local UICornerTitle = Instance.new("UICorner")
UICornerTitle.CornerRadius = UDim.new(0, 12)
UICornerTitle.Parent = Title

local UIStrokeTitle = Instance.new("UIStroke")
UIStrokeTitle.Color = Color3.fromRGB(255, 105, 180)
UIStrokeTitle.Thickness = 1
UIStrokeTitle.Parent = Title

-- Menu Lateral de Abas
local TabBar = Instance.new("Frame")
TabBar.Parent = MainFrame
TabBar.BackgroundColor3 = Color3.fromRGB(30, 15, 25)
TabBar.BackgroundTransparency = 0.4
TabBar.Position = UDim2.new(0, 10, 0, 50)
TabBar.Size = UDim2.new(0, 110, 1, -60)
TabBar.ZIndex = 2

local UICornerTab = Instance.new("UICorner")
UICornerTab.CornerRadius = UDim.new(0, 8)
UICornerTab.Parent = TabBar

local TabListLayout = Instance.new("UIListLayout")
TabListLayout.Parent = TabBar
TabListLayout.SortOrder = Enum.SortOrder.LayoutOrder
TabListLayout.Padding = UDim.new(0, 5)
TabListLayout.HorizontalAlignment = Enum.HorizontalAlignment.Center

-- Área de Conteúdo
local ContentArea = Instance.new("Frame")
ContentArea.Parent = MainFrame
ContentArea.BackgroundTransparency = 1
ContentArea.Position = UDim2.new(0, 130, 0, 50)
ContentArea.Size = UDim2.new(1, -140, 1, -60)
ContentArea.ZIndex = 2

local pages = {}
local function createPage(name)
    local page = Instance.new("ScrollingFrame")
    page.Name = name .. "Page"
    page.Parent = ContentArea
    page.BackgroundTransparency = 1
    page.Size = UDim2.new(1, 0, 1, 0)
    page.CanvasSize = UDim2.new(0, 0, 0, 500) -- Força tamanho para caber os botões
    page.ScrollBarThickness = 3
    page.Visible = false
    page.ZIndex = 2
    
    local layout = Instance.new("UIListLayout")
    layout.Parent = page
    layout.SortOrder = Enum.SortOrder.LayoutOrder
    layout.Padding = UDim.new(0, 8)
    
    pages[name] = page
    return page
end

local pageMain = createPage("Geral")
local pageMove = createPage("Movimento")
local pageVisual = createPage("Visual")
local pagePlayers = createPage("Jogadores")
pageMain.Visible = true -- Garante que a primeira aba abre visível

local function createTabButton(name, targetPage)
    local btn = Instance.new("TextButton")
    btn.Parent = TabBar
    btn.BackgroundColor3 = Color3.fromRGB(45, 20, 35)
    btn.Size = UDim2.new(0.9, 0, 0, 35)
    btn.Font = Enum.Font.SourceSansSemibold
    btn.Text = name
    btn.TextColor3 = Color3.fromRGB(255, 220, 230)
    btn.TextSize = 14
    btn.ZIndex = 2
    
    local corner = Instance.new("UICorner")
    corner.CornerRadius = UDim.new(0, 6)
    corner.Parent = btn
    
    btn.MouseButton1Click:Connect(function()
        for _, p in pairs(pages) do p.Visible = false end
        targetPage.Visible = true
    end)
end

createTabButton("Geral", pageMain)
createTabButton("Movimento", pageMove)
createTabButton("Visual", pageVisual)
createTabButton("Jogadores", pagePlayers)

-- Arrastar e Minimizar
local dragging = false
local dragInput, dragStart, startPos
local touchMoved = false

ToggleButton.InputBegan:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
        dragging = true
        touchMoved = false
        dragStart = input.Position
        startPos = ToggleButton.Position
    end
end)

UserInputService.InputChanged:Connect(function(input)
    if dragging and (input.UserInputType == Enum.UserInputType.MouseMovement or input.UserInputType == Enum.UserInputType.Touch) then
        local delta = input.Position - dragStart
        if math.abs(delta.X) > 5 or math.abs(delta.Y) > 5 then
            touchMoved = true
        end
        ToggleButton.Position = UDim2.new(startPos.X.Scale, startPos.X.Offset + delta.X, startPos.Y.Scale, startPos.Y.Offset + delta.Y)
    end
end)

ToggleButton.MouseButton1Up:Connect(function()
    if not touchMoved then MainFrame.Visible = not MainFrame.Visible end
end)
ToggleButton.TouchEnded:Connect(function()
    if not touchMoved then MainFrame.Visible = not MainFrame.Visible end
end)

-- CRIAÇÃO DOS BOTÕES DE SISTEMAS
local function createToggle(page, text, callback)
    local btn = Instance.new("TextButton")
    btn.Parent = page
    btn.BackgroundColor3 = Color3.fromRGB(120, 30, 70) -- Cor forte para destacar
    btn.Size = UDim2.new(1, -10, 0, 35)
    btn.Font = Enum.Font.SourceSansBold
    btn.Text = text .. ": [OFF]"
    btn.TextColor3 = Color3.fromRGB(255, 255, 255)
    btn.TextSize = 14
    btn.ZIndex = 5
    
    local corner = Instance.new("UICorner")
    corner.CornerRadius = UDim.new(0, 6)
    corner.Parent = btn
    
    local state = false
    btn.MouseButton1Click:Connect(function()
        state = not state
        btn.Text = text .. (state and ": [ON]" or ": [OFF]")
        callback(state)
    end)
    return btn
end

-- Adicionando Sistemas nas Abas
createToggle(pageMove, "Super Velocidade", function(state)
    task.spawn(function()
        while true do
            local hum = LocalPlayer.Character and LocalPlayer.Character:FindFirstChildOfClass("Humanoid")
            if hum then
                if state then hum.WalkSpeed = 100 else hum.WalkSpeed = 16 break end
            end
            task.run(RunService.RenderStepped)
        end
    end)
end)

createToggle(pageMove, "Super Pulo", function(state)
    local hum = LocalPlayer.Character and LocalPlayer.Character:FindFirstChildOfClass("Humanoid")
    if hum then
        hum.UseJumpPower = true
        hum.JumpPower = state and 120 or 50
    end
end)

createToggle(pageMain, "Atravessar Paredes", function(state)
    task.spawn(function()
        while state do
            local char = LocalPlayer.Character
            if char then
                for _, part in pairs(char:GetDescendants()) do
                    if part:IsA("BasePart") then part.CanCollide = false end
                end
            end
            RunService.Stepped:Wait()
        end
    end)
end)

createToggle(pageVisual, "Brilho Total", function(state)
    game.Lighting.Brightness = state and 2 or 1
    game.Lighting.GlobalShadows = not state
end)

createToggle(pageMain, "Vida Infinita (Godmode)", function(state)
    task.spawn(function()
        while state do
            local hum = LocalPlayer.Character and LocalPlayer.Character:FindFirstChildOfClass("Humanoid")
            if hum then hum.Health = hum.MaxHealth end
            RunService.RenderStepped:Wait()
        end
    end)
end)
