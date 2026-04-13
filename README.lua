local player = game.Players.LocalPlayer

-- Dokładna ścieżka do Coins (działa dla Twojego nicku i każdego innego)
local coinsContainer = player:WaitForChild("PlayerScripts")
    :WaitForChild("Scripts")
    :WaitForChild("Game")
    :WaitForChild("Coins")

print("✅ Znaleziono Coins!")

-- ==================== FUNKCJA DO DODAWANIA COINÓW ====================
local function addCoins(amount)
    local added = false

    for _, obj in ipairs(getgc(false)) do
        if typeof(obj) == "table" then
            if obj.Coins and typeof(obj.Coins) == "number" then
                obj.Coins = obj.Coins + amount
                added = true
            end
            if obj.coins and typeof(obj.coins) == "number" then
                obj.coins = obj.coins + amount
                added = true
            end
            if obj.currentCoins and typeof(obj.currentCoins) == "number" then
                obj.currentCoins = obj.currentCoins + amount
                added = true
            end
            if obj.Value and typeof(obj.Value) == "number" and tostring(obj):find("Coins") then
                obj.Value = obj.Value + amount
                added = true
            end
        end
    end

    if coinsContainer:IsA("ModuleScript") then
        local success, coinModule = pcall(require, coinsContainer)
        if success and typeof(coinModule) == "table" then
            local func = coinModule.Add or coinModule.addCoins or coinModule.giveCoins
            if func then
                pcall(func, player, amount)
                added = true
            end
        end
    end

    if added then
        print("🚀 DODANO " .. tostring(amount) .. " Coins! (10 miliardów)")
    else
        warn("❌ Nie znaleziono Coins w pamięci – gra może mieć inną nazwę")
    end
end

-- ====================== AUTOMATYCZNE DODANIE 10 MILIARDÓW ======================
addCoins(10000000000)   -- <<< 10B Coins dodawane automatycznie po wklejeniu skryptu

print("💰 Gotowe! Automatycznie dodano 10 miliardów Coins.")
print("   Możesz wkleić skrypt jeszcze raz żeby dodać kolejne 10B.")
