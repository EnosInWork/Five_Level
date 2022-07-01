RegisterNetEvent("Five:InitPlayerXP")
AddEventHandler("Five:InitPlayerXP", function(_token, _xp)
    Config.Token = _token
    Config.xpAmount = _xp
end)

RegisterNetEvent("Five:OnAddPlayerXP")
AddEventHandler("Five:OnAddPlayerXP", function(xpAmount)
    Rank.AddPlayerXP(xpAmount)
end)

RegisterNetEvent("Five:OnRemovePlayerXP")
AddEventHandler("Five:OnRemovePlayerXP", function(xpAmount)
    Rank.RemovePlayerXP(xpAmount)
end)

AddEventHandler("esx:onPlayerSpawn", function(xpAmount)
    ESX.PlayerLoaded = true
end)

Citizen.CreateThread(function()
    while not ESX.PlayerLoaded do Citizen.Wait(0) end
    TriggerServerEvent("Five:InitPlayerXP")
end)

