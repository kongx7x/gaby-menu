local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local UserInputService = game:GetService("UserInputService")
local Workspace = game:GetService("Workspace")
local LocalPlayer = Players.LocalPlayer
local Camera = Workspace.CurrentCamera

return function(UIModule)
    local pages = UIModule.Pages

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

    -- 1. SUPER VELOCIDADE
    createToggle(pages.Movimento, "Super Velocidade", function(state)
        task.spawn(function()
            while true do
                local char = LocalPlayer.Character
                local hum = char and char:FindFirstChildOfClass("Humanoid")
                if hum then
                    if state then
                        hum.WalkSpeed = 100
                    else
                        if hum.WalkSpeed == 100 then
                            hum.WalkSpeed = 16
                        end
                        break
                    end
                end
                task.run(RunService.RenderStepped)
            end
        end)
    end)

    -- 2. SUPER PULO
    createToggle(pages.Movimento, "Super Pulo", function(state)
        local hum = LocalPlayer.Character and LocalPlayer.Character:FindFirstChildOfClass("Humanoid")
        if hum then
            hum.UseJumpPower = true
            hum.JumpPower = state and 120 or 50
        end
    end)

    -- 3. PULO INFINITO
    local infJumpEnabled = false
    createToggle(pages.Movimento, "Pulo Infinito", function(state)
        infJumpEnabled = state
    end)
    UserInputService.JumpRequest:Connect(function()
        local hum = LocalPlayer.Character and LocalPlayer.Character:FindFirstChildOfClass("Humanoid")
        if infJumpEnabled and hum then
            hum:ChangeState(Enum.HumanoidStateType.Jumping)
        end
    end)

    -- 4. MODO VOO (FLY)
    local flyEnabled = false
    createToggle(pages.Movimento, "Modo Voo (Fly)", function(state)
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

    -- 5. ATRAVESSAR PAREDES (NOCLIP)
    createToggle(pages.Geral, "Atravessar Paredes", function(state)
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

    -- 6. BRILHO TOTAL (FULLBRIGHT)
    createToggle(pages.Visual, "Brilho Total", function(state)
        game.Lighting.Brightness = state and 2 or 1
        game.Lighting.GlobalShadows = not state
        game.Lighting.ClockTime = state and 14 or 12
    end)

    -- 7. ESP JOGADORES
    createToggle(pages.Visual, "ESP Jogadores", function(state)
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

    -- 8. VIDA INFINITA (GODMODE)
    createToggle(pages.Geral, "Vida Infinita (Godmode)", function(state)
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

    -- 9. CÂMERA LIVRE
    createToggle(pages.Visual, "Câmera Livre", function(state)
        Camera.CameraType = state and Enum.CameraType.Scriptable or Enum.CameraType.Custom
    end)

    -- 10. TELEPORTE PARA JOGADORES
    local function refreshPlayerList()
        for _, child in pairs(pages.Jogadores:GetChildren()) do
            if child:IsA("TextButton") then child:Destroy() end
        end
        
        for _, p in pairs(Players:GetPlayers()) do
            if p ~= LocalPlayer then
                local tpBtn = Instance.new("TextButton")
                tpBtn.Parent = pages.Jogadores
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
end
