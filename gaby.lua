-- ==============================================================================
-- ====== INÍCIO SISTEMA DE ALCANCE ESTENDIDO DE HIT (REACH) ===================
-- ==============================================================================
_G.ExtendedReach = false

task.spawn(function()
    while true do
        if _G.ExtendedReach then
            pcall(function()
                local char = LocalPlayer.Character
                if char then
                    -- Procura por ferramentas equipadas (faca, espada, etc.)
                    local tool = char:FindFirstChildOfClass("Tool")
                    if tool then
                        for _, part in pairs(tool:GetDescendants()) do
                            if part:IsA("BasePart") then
                                -- Expande temporariamente o tamanho da hitbox da arma para facilitar o hit
                                part.Size = Vector3.new(4, 4, 4)
                                part.Transparency = 0.9 -- Quase invisível, mas ativa o contato físico/hit
                                part.CanCollide = false
                            end
                        end
                    end
                end
            end)
        end
        task.wait(0.5)
    end
end)
-- ==============================================================================
-- ====== FIM SISTEMA DE ALCANCE ESTENDIDO DE HIT (REACH) ======================
-- ==============================================================================

-- ==============================================================================
-- ====== INÍCIO SISTEMA DE TELEPORTE PARA JOGADORES ==========================
-- ==============================================================================
