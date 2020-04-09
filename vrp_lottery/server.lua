--[[
───────────────────────────────────────────────────────────────────────────────────────────
─██████████████─██████████─██████─────────██████████████─██████─────────████████──████████─
─██░░░░░░░░░░██─██░░░░░░██─██░░██─────────██░░░░░░░░░░██─██░░██─────────██░░░░██──██░░░░██─
─██░░██████░░██─████░░████─██░░██─────────██░░██████████─██░░██─────────████░░██──██░░████─
─██░░██──██░░██───██░░██───██░░██─────────██░░██─────────██░░██───────────██░░░░██░░░░██───
─██░░██████░░██───██░░██───██░░██─────────██░░██████████─██░░██───────────████░░░░░░████───
─██░░░░░░░░░░██───██░░██───██░░██─────────██░░░░░░░░░░██─██░░██─────────────████░░████─────
─██░░██████████───██░░██───██░░██─────────██░░██████████─██░░██───────────────██░░██───────
─██░░██───────────██░░██───██░░██─────────██░░██─────────██░░██───────────────██░░██───────
─██░░██─────────████░░████─██░░██████████─██░░██████████─██░░██████████───────██░░██───────
─██░░██─────────██░░░░░░██─██░░░░░░░░░░██─██░░░░░░░░░░██─██░░░░░░░░░░██───────██░░██───────
─██████─────────██████████─██████████████─██████████████─██████████████───────██████───────
───────────────────────────────────────────────────────────────────────────────────────────
]]--

local Tunnel = module("vrp", "lib/Tunnel")
local Proxy = module("vrp", "lib/Proxy")

vRP = Proxy.getInterface("vRP")
vRPclient = Tunnel.getInterface("vRP","vrp_lottery")

RegisterNetEvent("vrp_lottery:skrab")
AddEventHandler("vrp_lottery:skrab", function(item, count)
local lillepris = Config.Lille
local mellempris = Config.Mellem
local jackpot = Config.Stor
local user_id = vRP.getUserId({source})
local Player = vRP.getUserSource({user_id})
local randomChance = math.random(1, 100)
    if Player ~= nil then
        if vRP.tryGetInventoryItem({user_id,"lottokupon",1,true}) then
            if randomChance < 70 then
                TriggerClientEvent("pNotify:SendNotification", source, {text = "0 bedre held næste gang", type = "info", timeout = (3000), layout = "bottomCenter", queue = "global"})
            elseif randomChance >= 70 and mysteryboxchance <= 90 then
                vRP.giveBankMoney({user_id,Config.Lille})
                TriggerClientEvent("pNotify:SendNotification", source, {text = "Du vandt " ..lillepris.. "DKK", type = "info", timeout = (3000), layout = "bottomCenter", queue = "global"})
            elseif randomChance > 90 and mysteryboxchance < 99 then
                vRP.giveBankMoney({user_id,Config.Mellem})
                TriggerClientEvent("pNotify:SendNotification", source, {text = "Du vandt " ..mellempris.. "DKK", type = "info", timeout = (3000), layout = "bottomCenter", queue = "global"})
            elseif randomChance >= 99 then
                vRP.giveBankMoney({user_id,Config.Stor})
                TriggerClientEvent("pNotify:SendNotification", source, {text = "Du vandt jackpot " ..jackpot.. "DKK", type = "info", timeout = (3000), layout = "bottomCenter", queue = "global"})
            end
        end
    end
end)


RegisterNetEvent("vrp_lottery:kupontjek")
AddEventHandler("vrp_lottery:kupontjek", function(item, count)
local user_id = vRP.getUserId({source})
local Player = vRP.getUserSource({user_id})
    if Player ~= nil then
        if vRP.getInventoryItemAmount({user_id, 'lottokupon'}) > 0 then
            TriggerClientEvent("vrp_lottery:progressbar", source)
        elseif vRP.getInventoryItemAmount({user_id, 'lottokupon'}) < 1 then
            TriggerClientEvent("pNotify:SendNotification", source, {text = "Du har ikke en lotto kupon", type = "info", timeout = (3000), layout = "bottomCenter", queue = "global"})
        end
    end
end)
