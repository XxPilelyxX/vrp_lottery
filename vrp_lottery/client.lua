RegisterCommand("lotto", function()
	TriggerServerEvent("vrp_lottery:kupontjek")
end,false)

RegisterNetEvent("vrp_lottery:progressbar")
AddEventHandler("vrp_lottery:progressbar", function()
    Progressbar()
end)

function Progressbar()
    local ped = GetPlayerPed(-1)
    exports['pp_progressbar']:startUI(2000, "Skraber kupon...")
    Citizen.Wait(2000)
    TriggerServerEvent("vrp_lottery:skrab")
    Citizen.Wait(100)
end