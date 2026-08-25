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

-- Efeito 3D Teia de Aranha
local WebContainer = Instance.new("Folder")
WebContainer.Name = "WebEffect"
WebContainer.Parent = MainFrame

local nodes = {}
local mathRandom = math.random
local mathSqrt = math.sqrt
local mathMin = math.min

for i = 1, 12 do
    local node = Instance.new("Frame")
    node.Parent = WebContainer
    node.BackgroundColor3 = Color3.fromRGB(255, 105, 180)
    node.BackgroundTransparency = 0.3
    node.Size = UDim2.new(0, 4, 0, 4)
    node.ZIndex = 1
    
    local corner = Instance.new("UICorner")
    corner.CornerRadius = UDim.new(1, 0)
    corner.Parent = node
    
    table.insert(nodes, {
        object = node,
        posX = mathRandom(20, 400),
        posY = mathRandom(50, 330),
        dirX = (mathRandom() - 0.5) * 0.8,
        dirY = (mathRandom() - 0.5) * 0.8
    })
end

local lines = {}
for i = 1, 15 do
    local line = Instance.new("Frame")
    line.Parent = WebContainer
    line.BackgroundColor3 = Color3.fromRGB(255, 182, 193)
    line.BackgroundTransparency = 0.6
    line.BorderSizePixel = 0
    line.Size = UDim2.new(0, 0, 0, 1)
    line.ZIndex = 1
    table.insert(lines, line)
end

task.spawn(function()
    while MainFrame.Parent do
        for _, n in ipairs(nodes) do
            n.posX = n.posX + n.dirX
            n.posY = n.posY + n.dirY
            if n.posX < 10 or n.posX > 410 then n.dirX = -n.dirX end
            if n.posY < 45 or n.posY > 340 then n.dirY = -n.dirY end
            n.object.Position = UDim2.new(0, n.posX, 0, n.posY)
        end
        
        local lineIdx = 1
        for i = 1, #nodes do
            for j = i + 1, #nodes do
                if lineIdx <= #lines then
                    local n1, n2 = nodes[i], nodes[j]
                    local dx, dy = n2.posX - n1.posX, n2.posY - n1.posY
                    local dist = mathSqrt(dx*dx + dy*dy)
                    if dist < 80 then
                        local line = lines[lineIdx]
                        line.Visible = true
                        line.Size = UDim2.new(0, dist, 0, 1)
                        line.Position = UDim2.new(0, n1.posX, 0, n1.posY)
                        line.Rotation = math.deg(math.atan2(dy, dx))
                        line.BackgroundTransparency = mathMin(0.3 + (dist / 100), 0.9)
                        lineIdx = lineIdx + 1
                    end
                end
            end
        end
        for k = lineIdx, #lines do lines[k].Visible = false end
        RunService.RenderStepped:Wait()
    end
end)

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

-- Container de Abas
local TabBar = Instance.new("Frame")
TabBar.Parent = MainFrame
TabBar.BackgroundColor3 = Color3.fromRGB(30, 15, 25)
TabBar.BackgroundTransparency = 0.4
TabBar.Position = UDim2.new(0, 10, 0, 50)
TabBar.Size = UDim2.new(0, 110, 1, -100) -- Ajustado para dar espaço ao perfil embaixo
TabBar.ZIndex = 2

local UICornerTab = Instance.new("UICorner")
UICornerTab.CornerRadius = UDim.new(0, 8)
UICornerTab.Parent = TabBar

local TabListLayout = Instance.new("UIListLayout")
TabListLayout.Parent = TabBar
TabListLayout.SortOrder = Enum.SortOrder.LayoutOrder
TabListLayout.Padding = UDim.new(0, 5)
TabListLayout.HorizontalAlignment = Enum.HorizontalAlignment.Center

-- ==================== [NOVO: PASSO 5] PERFIL DO USUÁRIO NO MENU ====================
local UserProfileFrame = Instance.new("Frame")
UserProfileFrame.Parent = MainFrame
UserProfileFrame.BackgroundColor3 = Color3.fromRGB(30, 15, 25)
UserProfileFrame.BackgroundTransparency = 0.4
UserProfileFrame.Position = UDim2.new(0, 10, 1, -45)
UserProfileFrame.Size = UDim2.new(0, 110, 0, 35)
UserProfileFrame.ZIndex = 2

local UserProfileCorner = Instance.new("UICorner")
UserProfileCorner.CornerRadius = UDim.new(0, 8)
UserProfileCorner.Parent = UserProfileFrame

local UserAvatar = Instance.new("ImageLabel")
UserAvatar.Parent = UserProfileFrame
UserAvatar.BackgroundTransparency = 1
UserAvatar.Position = UDim2.new(0, 3, 0, 3)
UserAvatar.Size = UDim2.new(0, 29, 0, 29)
UserAvatar.ZIndex = 2
pcall(function()
    UserAvatar.Image = Players:GetUserThumbnailAsync(LocalPlayer.UserId, Enum.ThumbnailType.HeadShot, Enum.ThumbnailSize.Size420x420)
end)

local UserNameLabel = Instance.new("TextLabel")
UserNameLabel.Parent = UserProfileFrame
UserNameLabel.BackgroundTransparency = 1
UserNameLabel.Position = UDim2.new(0, 35, 0, 0)
UserNameLabel.Size = UDim2.new(1, -38, 1, 0)
UserNameLabel.Font = Enum.Font.SourceSansBold
UserNameLabel.Text = LocalPlayer.Name
UserNameLabel.TextColor3 = Color3.fromRGB(255, 220, 230)
UserNameLabel.TextSize = 11
UserNameLabel.ZIndex = 2
UserNameLabel.TextXAlignment = Enum.TextXAlignment.Left
UserNameLabel.TextTruncate = Enum.TextTruncate.AtEnd

-- Container de Páginas
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
    page.CanvasSize = UDim2.new(0, 0, 0, 0)
    page.AutomaticCanvasSize = Enum.AutomaticSize.Y
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
pages["Geral"].Visible = true

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
    
    local stroke = Instance.new("UIStroke")
    stroke.Color = Color3.fromRGB(255, 105, 180)
    stroke.Transparency = 0.5
    stroke.Thickness = 1
    stroke.Parent = btn
    
    btn.MouseButton1Click:Connect(function()
        for _, p in pairs(pages) do p.Visible = false end
        targetPage.Visible = true
    end)
end

createTabButton("Geral", pageMain)
createTabButton("Movimento", pageMove)
createTabButton("Visual", pageVisual)
createTabButton("Jogadores", pagePlayers)

local function createToggle(page, text, callback)
    local btn = Instance.new("TextButton")
    btn.Parent = page
    btn.BackgroundColor3 = Color3.fromRGB(40, 20, 30)
    btn.Size = UDim2.new(1, -5, 0, 35)
    btn.Font = Enum.Font.SourceSansSemibold
    btn.Text = text .. ": [OFF]"
    btn.TextColor3 = Color3.fromRGB(255, 220, 230)
    btn.TextSize = 14
    btn.ZIndex = 2
    
    local corner = Instance.new("UICorner")
    corner.CornerRadius = UDim.new(0, 6)
    corner.Parent = btn
    
    local stroke = Instance.new("UIStroke")
    stroke.Color = Color3.fromRGB(255, 105, 180)
    stroke.Transparency = 0.3
    stroke.Thickness = 1
    stroke.Parent = btn
    
    local state = false
    btn.MouseButton1Click:Connect(function()
        state = not state
        btn.Text = text .. (state and ": [ON]" or ": [OFF]")
        btn.BackgroundColor3 = state and Color3.fromRGB(180, 50, 95) or Color3.fromRGB(40, 20, 30)
        stroke.Color = state and Color3.fromRGB(255, 20, 147) or Color3.fromRGB(255, 105, 180)
        callback(state)
    end)
    return btn
end

-- SLIDER DE VELOCIDADE
local function createSlider(page, text, min, max, default, callback)
    local container = Instance.new("Frame")
    container.Parent = page
    container.BackgroundColor3 = Color3.fromRGB(40, 20, 30)
    container.Size = UDim2.new(1, -5, 0, 50)
    container.ZIndex = 2
    
    local corner = Instance.new("UICorner")
    corner.CornerRadius = UDim.new(0, 6)
    corner.Parent = container
    
    local stroke = Instance.new("UIStroke")
    stroke.Color = Color3.fromRGB(255, 105, 180)
    stroke.Transparency = 0.3
    stroke.Thickness = 1
    stroke.Parent = container
    
    local label = Instance.new("TextLabel")
    label.Parent = container
    label.BackgroundTransparency = 1
    label.Position = UDim2.new(0, 10, 0, 5)
    label.Size = UDim2.new(1, -20, 0, 20)
    label.Font = Enum.Font.SourceSansSemibold
    label.Text = text .. ": " .. default
    label.TextColor3 = Color3.fromRGB(255, 220, 230)
    label.TextSize = 14
    label.ZIndex = 2
    label.TextXAlignment = Enum.TextXAlignment.Left
    
    local sliderBar = Instance.new("TextButton")
    sliderBar.Parent = container
    sliderBar.BackgroundColor3 = Color3.fromRGB(60, 30, 45)
    sliderBar.Position = UDim2.new(0, 10, 0, 30)
    sliderBar.Size = UDim2.new(1, -20, 0, 10)
    sliderBar.Text = ""
    sliderBar.ZIndex = 2
    
    local barCorner = Instance.new("UICorner")
    barCorner.CornerRadius = UDim.new(1, 0)
    barCorner.Parent = sliderBar
    
    local fill = Instance.new("Frame")
    fill.Parent = sliderBar
    fill.BackgroundColor3 = Color3.fromRGB(255, 105, 180)
    fill.Size = UDim2.new((default - min) / (max - min), 0, 1, 0)
    fill.ZIndex = 2
    
    local fillCorner = Instance.new("UICorner")
    fillCorner.CornerRadius = UDim.new(1, 0)
    fillCorner.Parent = fill
    
    local draggingSlider = false
    sliderBar.InputBegan:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
            draggingSlider = true
        end
    end)
    
    UserInputService.InputEnded:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
            draggingSlider = false
        end
    end)
    
    UserInputService.InputChanged:Connect(function(input)
        if draggingSlider and (input.UserInputType == Enum.UserInputType.MouseMovement or input.UserInputType == Enum.UserInputType.Touch) then
            local pos = math.clamp((input.Position.X - sliderBar.AbsolutePosition.X) / sliderBar.AbsoluteSize.X, 0, 1)
            fill.Size = UDim2.new(pos, 0, 1, 0)
            local val = math.floor(min + ((max - min) * pos))
            label.Text = text .. ": " .. val
            callback(val)
        end
    end)
end

-- ==================== SISTEMAS ====================

createSlider(pageMove, "Velocidade", 16, 100, 16, function(value)
    task.spawn(function()
        local char = LocalPlayer.Character
        local hum = char and char:FindFirstChildOfClass("Humanoid")
        if hum then
            hum.WalkSpeed = value
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

local infJumpEnabled = false
createToggle(pageMove, "Pulo Infinito", function(state)
    infJumpEnabled = state
end)
UserInputService.JumpRequest:Connect(function()
    local hum = LocalPlayer.Character and LocalPlayer.Character:FindFirstChildOfClass("Humanoid")
    if infJumpEnabled and hum then
        hum:ChangeState(Enum.HumanoidStateType.Jumping)
    end
end)

local flyEnabled = false
createToggle(pageMove, "Modo Voo (Fly)", function(state)
    flyEnabled = state
    local char = LocalPlayer.Character
    local root = char and char:FindFirstChild("HumanoidRootPart")
    local hum = char and char:FindFirstChildOfClass("Humanoid")
    
    if not root or not hum then return end
    
    if flyEnabled then
        hum.PlatformStand = true
        task.spawn(function()
            while flyEnabled and char and root and hum.Parent do
                local moveDir = Vector3.new()
                if UserInputService:IsKeyDown(Enum.KeyCode.W) then moveDir = moveDir + Camera.CFrame.LookVector end
                if UserInputService:IsKeyDown(Enum.KeyCode.S) then moveDir = moveDir - Camera.CFrame.LookVector end
                if UserInputService:IsKeyDown(Enum.KeyCode.A) then moveDir = moveDir - Camera.CFrame.RightVector end
                if UserInputService:IsKeyDown(Enum.KeyCode.D) then moveDir = moveDir + Camera.CFrame.RightVector end
                
                if moveDir.Magnitude > 0 then
                    root.AssemblyLinearVelocity = moveDir.Unit * 50
                else
                    root.AssemblyLinearVelocity = Vector3.new(0, 0, 0)
                end
                RunService.RenderStepped:Wait()
            end
            hum.PlatformStand = false
            if root then root.AssemblyLinearVelocity = Vector3.new(0, 0, 0) end
        end)
    else
        hum.PlatformStand = false
    end
end)

local noclipConnection = nil
createToggle(pageMain, "Atravessar Paredes", function(state)
    if state then
        noclipConnection = RunService.Stepped:Connect(function()
            local char = LocalPlayer.Character
            if char then
                for _, part in pairs(char:GetDescendants()) do
                    if part:IsA("BasePart") then 
                        part.CanCollide = false 
                    end
                end
            end
        end)
    else
        if noclipConnection then
            noclipConnection:Disconnect()
            noclipConnection = nil
        end
        local char = LocalPlayer.Character
        if char then
            for _, part in pairs(char:GetDescendants()) do
                if part:IsA("BasePart") then 
                    part.CanCollide = true 
                end
            end
        end
    end
end)

createToggle(pageVisual, "Brilho Total", function(state)
    game.Lighting.Brightness = state and 2 or 1
    game.Lighting.GlobalShadows = not state
    game.Lighting.ClockTime = state and 14 or 12
end)

createToggle(pageVisual, "ESP Jogadores", function(state)
    for _, p in pairs(Players:GetPlayers()) do
        if p ~= LocalPlayer and p.Character then
            if state then
                if not p.Character:FindFirstChild("GabyESP") then
                    local hl = Instance.new("Highlight")
                    hl.Name = "GabyESP"
                    hl.FillColor = Color3.fromRGB(255, 105, 180)
                    hl.OutlineColor = Color3.fromRGB(255, 255, 255)
                    hl.Parent = p.Character
                end
            else
                if p.Character:FindFirstChild("GabyESP") then
                    p.Character.GabyESP:Destroy()
                end
            end
        end
    end
end)

createToggle(pageMain, "Vida Infinita (Godmode)", function(state)
    task.spawn(function()
        while state do
            local hum = LocalPlayer.Character and LocalPlayer.Character:FindFirstChildOfClass("Humanoid")
            if hum then
                hum.Health = hum.MaxHealth
            end
            RunService.RenderStepped:Wait()
        end
    end)
end)

createToggle(pageVisual, "Câmera Livre", function(state)
    Camera.CameraType = state and Enum.CameraType.Scriptable or Enum.CameraType.Custom
end)

local function refreshPlayerList()
    for _, child in pairs(pagePlayers:GetChildren()) do
        if child:IsA("TextButton") then child:Destroy() end
    end
    
    for _, p in pairs(Players:GetPlayers()) do
        if p ~= LocalPlayer then
            local tpBtn = Instance.new("TextButton")
            tpBtn.Parent = pagePlayers
            tpBtn.BackgroundColor3 = Color3.fromRGB(40, 20, 30)
            tpBtn.Size = UDim2.new(1, -5, 0, 35)
            tpBtn.Font = Enum.Font.SourceSansSemibold
            tpBtn.Text = "Teleportar para: " .. p.Name
            tpBtn.TextColor3 = Color3.fromRGB(255, 220, 230)
            tpBtn.TextSize = 13
            tpBtn.ZIndex = 2
            
            local corner = Instance.new("UICorner")
            corner.CornerRadius = UDim.new(0, 6)
            corner.Parent = tpBtn
            
            local stroke = Instance.new("UIStroke")
            stroke.Color = Color3.fromRGB(255, 105, 180)
            stroke.Transparency = 0.3
            stroke.Thickness = 1
            stroke.Parent = tpBtn
            
            tpBtn.MouseButton1Click:Connect(function()
                if p.Character and p.Character:FindFirstChild("HumanoidRootPart") and LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("HumanoidRootPart") then
                    LocalPlayer.Character.HumanoidRootPart.CFrame = p.Character.HumanoidRootPart.CFrame + Vector3.new(0, 3, 0)
                end
            end)
        end
    end
end

Players.PlayerAdded:Connect(refreshPlayerList)
Players.PlayerRemoving:Connect(refreshPlayerList)
refreshPlayerList()

-- ==================== [NOVO: PASSO 4] TECLA DE ATALHO (RIGHT SHIFT) ====================
UserInputService.InputBegan:Connect(function(input, gameProcessed)
    if not gameProcessed and input.KeyCode == Enum.KeyCode.RightShift then
        MainFrame.Visible = not MainFrame.Visible
    end
end)

-- Sistema anti-conflito para arrastar vs tocar no celular
local dragging = false
local dragInput, dragStart, startPos
local touchMoved = false

ToggleButton.InputBegan:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
        dragging = true
        touchMoved = false
        dragStart = input.Position
        startPos = ToggleButton.Position
        
        input.Changed:Connect(function()
            if input.UserInputState == Enum.UserInputState.End then
                dragging = false
            end
        end)
    end
end)

ToggleButton.InputChanged:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseMovement or input.UserInputType == Enum.UserInputType.Touch then
        dragInput = input
    end
end)

UserInputService.InputChanged:Connect(function(input)
    if input == dragInput and dragging then
        local delta = input.Position - dragStart
        if math.abs(delta.X) > 5 or math.abs(delta.Y) > 5 then
            touchMoved = true
        end
        ToggleButton.Position = UDim2.new(startPos.X.Scale, startPos.X.Offset + delta.X, startPos.Y.Scale, startPos.Y.Offset + delta.Y)
    end
end)

ToggleButton.MouseButton1Up:Connect(function()
    if not touchMoved then
        MainFrame.Visible = not MainFrame.Visible
    end
end)

ToggleButton.TouchEnded:Connect(function()
    if not touchMoved then
        MainFrame.Visible = not MainFrame.Visible
    end
end)
