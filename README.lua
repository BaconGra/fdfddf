local ReplicatedStorage = game:GetService("ReplicatedStorage")

-- Najpierw próbujemy starego hooka (na wszelki wypadek)
local modulePath = ReplicatedStorage:WaitForChild("framework", 15)
    :WaitForChild("modules", 10)
    :WaitForChild("1 | Directory", 10)
    :WaitForChild("Areas", 10)
    :WaitForChild("areas | Spawn World", 10)

local modifiedAreas = {
    ["Ice Tech"] = {
        name = "Tech Entry",
        world = "Spawn",
        mult = 1,
        gate = { cost = 0, currency = "Coins" },
        isShop = false,
        teleportPrice = 50000,
        hidden = false
    }
}

if modulePath then
    local oldRequire = require
    hookfunction(require, function(mod)
        if mod == modulePath then
            print("🚀 Hook require zadziałał – Ice Tech podmieniony!")
            return modifiedAreas
        end
        return oldRequire(mod)
    end)
end

-- NOWA, NAJLEPSZA METODA: przeszukujemy całą pamięć gry (getgc)
local function findAndModifyIceTech()
    local found = false
    for _, obj in ipairs(getgc(false)) do
        if typeof(obj) == "table" and obj["Ice Tech"] then
            local ice = obj["Ice Tech"]
            if ice.gate then
                ice.gate.currency = "Coins"   -- <<< zmieniamy na normalne Coins
                -- ice.gate.cost = 0          -- możesz odkomentować jeśli chcesz darmowy wjazd
                print("✅ ZNALEZIONO i ZMIENIONO Ice Tech w pamięci gry!")
                print("   Teraz pokazuje Coins zamiast Tech/Fantasy Coins")
                found = true
            end
        end
    end
    return found
end

-- Uruchamiamy co 1 sekundę aż znajdzie (na wypadek ładowania)
local attempts = 0
task.spawn(function()
    repeat
        attempts = attempts + 1
        if findAndModifyIceTech() then
            break
        end
        task.wait(1)
    until attempts > 15
    
    if attempts > 15 then
        warn("❌ Nie znaleziono tabeli Ice Tech w pamięci – gra może mieć inną strukturę")
    else
        print("🎉 CHEAT W PEŁNI AKTYWNY! Wejdź do Ice Tech i sprawdź gate.")
    end
end)

print("✅ SKRYPT URUCHOMIONY – czekam na załadowanie tabeli...")
