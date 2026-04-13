local player = game.Players.LocalPlayer

-- Dokładna ścieżka, którą podałeś (zamiast hardcoded nicka)
local coinsContainer = player:WaitForChild("PlayerScripts")
    :WaitForChild("Scripts")
    :WaitForChild("Game")
    :WaitForChild("Coins")

print("✅ Znaleziono Coins w: " .. coinsContainer:GetFullName())

-- ==================== FUNKCJA DO DODAWANIA COINÓW ====================
local function addCoins(amount)
    local added = false

    -- 1. Szukamy w całej pamięci gry (getgc) – najskuteczniejsza metoda
    for _, obj in ipairs(getgc(false)) do
        if typeof(obj) == "table" then
            
            -- Najczęstsze klucze w tego typu grach
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

            -- Leaderstats (jeśli gra używa standardowego leaderstats)
            if obj.Value and typeof(obj.Value) == "number" and tostring(obj):find("Coins") then
                obj.Value = obj.Value + amount
                added = true
            end
        end
    end

    -- 2. Dodatkowa próba – jeśli Coins to ModuleScript
    if coinsContainer:IsA("ModuleScript") then
        local success, coinModule = pcall(require, coinsContainer)
        if success and typeof(coinModule) == "table" then
            if coinModule.Add or coinModule.addCoins or coinModule.giveCoins then
                local func = coinModule.Add or coinModule.addCoins or coinModule.giveCoins
                pcall(func, player, amount)
                added = true
            end
        end
    end

    if added then
        print("🚀 Dodano " .. tostring(amount) .. " Coins! Sprawdź stan konta.")
    else
        warn("❌ Nie znaleziono tabeli z Coins – gra może mieć inną nazwę zmiennej")
    end
end

-- ====================== PRZYKŁADY UŻYCIA ======================
addCoins(1000000000)        -- +1 miliard Coins (jednorazowo)
-- addCoins(5000000000)     -- +5 miliardów (odkomentuj jak chcesz)

-- Jeśli chcesz dodawać co chwilę (np. co 3 sekundy):
-- task.spawn(function()
--     while true do
--         addCoins(250000000)   -- co 3 sekundy +250 milionów
--         task.wait(3)
--     end
-- end)

print("💰 Skrypt gotowy!")
print("   Aby dodać dowolną ilość wpisz w executorze:")
print("   addCoins(ILE_CHCESZ)   <-- np. addCoins(9999999999)")
