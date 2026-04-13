local ReplicatedStorage = game:GetService("ReplicatedStorage")

-- Poprawiona wersja z timeoutem (nie będzie infinite yield)
local framework = ReplicatedStorage:WaitForChild("framework", 30) -- max 30 sekund czekania

if not framework then
    return warn("❌ Nie znaleziono 'framework' w ReplicatedStorage po 30 sekundach!")
end

local modulePath = framework
    :WaitForChild("modules", 10)
    :WaitForChild("1 | Directory", 10)
    :WaitForChild("Areas", 10)
    :WaitForChild("areas | Spawn World", 10)

if not modulePath or not modulePath:IsA("ModuleScript") then
    return warn("❌ Nie znaleziono modułu 'areas | Spawn World' – sprawdź nazwę/path")
end

local modifiedAreas = {
    Shop = { name = "Shop", world = "Spawn", mult = 1, isShop = true, teleportPrice = 25000, hidden = false },
    VIP = { name = "VIP", world = "Spawn", mult = 1, isShop = false, teleportPrice = 5000, hidden = false },
    Town = { name = "Town", world = "Spawn", mult = 1, gate = { cost = 0, currency = "Coins" }, isShop = false, teleportPrice = 6000, hidden = false },
    Forest = { name = "Forest", world = "Spawn", mult = 2, gate = { cost = 10000, currency = "Coins" }, isShop = false, teleportPrice = 7500, hidden = false },
    Beach = { name = "Beach", world = "Spawn", mult = 3.5, gate = { cost = 75000, currency = "Coins" }, isShop = false, teleportPrice = 10000, hidden = false },
    Mine = { name = "Mine", world = "Spawn", mult = 5, gate = { cost = 400000, currency = "Coins" }, isShop = false, teleportPrice = 12500, hidden = false },
    Winter = { name = "Winter", world = "Spawn", mult = 6.5, gate = { cost = 1250000, currency = "Coins" }, isShop = false, teleportPrice = 12500, hidden = false },
    Glacier = { name = "Glacier", world = "Spawn", mult = 8.25, gate = { cost = 5500000, currency = "Coins" }, isShop = false, teleportPrice = 12500, hidden = false },
    Desert = { name = "Desert", world = "Spawn", mult = 10, gate = { cost = 16500000, currency = "Coins" }, isShop = false, teleportPrice = 12500, hidden = false },
    Volcano = { name = "Volcano", world = "Spawn", mult = 11.5, gate = { cost = 50000000, currency = "Coins" }, isShop = false, teleportPrice = 25000, hidden = false },
    Cave = { name = "Cave", world = "Spawn", mult = 1, gate = { cost = 250000000, currency = "Coins" }, isShop = false, teleportPrice = 20000, hidden = false },
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

local oldRequire = require
local hooked = false

local function hookedRequire(mod)
    if mod == modulePath then
        if not hooked then
            hooked = true
            print("🚀 Ice Tech currency zmieniony na Coins – cheat aktywny!")
        end
        return modifiedAreas
    end
    return oldRequire(mod)
end

hookfunction(require, hookedRequire)

print("✅ CHEAT ZAŁADOWANY! (framework znaleziony)")
print("   Wejdź w Ice Tech – gate powinien brać normalne Coins")
