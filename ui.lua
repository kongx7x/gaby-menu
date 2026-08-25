local CoreGui = game:GetService("CoreGui")
local RunService = game:GetService("RunService")
local UserInputService = game:GetService("UserInputService")

if CoreGui:FindFirstChild("GabyMenu") then
    CoreGui.GabyMenu:Destroy()
end

local ScreenGui = Instance.new("ScreenGui")
ScreenGui.Name = "GabyMenu"
ScreenGui.Parent = CoreGui
ScreenGui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling

-- Janela Principal (Inicia fechada)
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

-- Botão Flutuante Redondo com Imagem
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

-- Imagem de Fundo do Menu
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

-- Container de Abas (Lateral Esquerda)
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

-- Container de Páginas (Conteúdo Direita)
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

-- Lógica do botão flutuante (Arrastar vs Clicar)
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

return {
    ScreenGui = ScreenGui,
    MainFrame = MainFrame,
    Pages = {
        Geral = pageMain,
        Movimento = pageMove,
        Visual = pageVisual,
        Jogadores = pagePlayers
    }
}
