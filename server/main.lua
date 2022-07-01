local NewToken = 'FiveLevel-NehcoAndEnos-'..math.random(999, 99999)

local function GetPlayerXP(identifier)
    local xpAmount = MySQL.Sync.fetchAll("SELECT * FROM users_xp WHERE identifier = @identifier", {
        ["@identifier"] = identifier
    })
    local result = xpAmount[1] and xpAmount[1].xp_amount or nil
    if (result == nil) then
        MySQL.Sync.insert("INSERT INTO users_xp (`identifier`, `xp_amount`) VALUES ('"..identifier.."', '"..(0).."')", {})
        result = 0
    end
    return result
end

RegisterNetEvent("Five:InitPlayerXP")
AddEventHandler("Five:InitPlayerXP", function()
    local source = source
    local xPlayer = ESX.GetPlayerFromId(source)
    local xpAmount = GetPlayerXP(xPlayer.identifier)
    TriggerClientEvent("Five:InitPlayerXP", source, NewToken, xpAmount)
end)

RegisterNetEvent("Five:AddPlayerXP")
AddEventHandler("Five:AddPlayerXP", function(token, id, amount)
    local source = source
    local xPlayer = ESX.GetPlayerFromId(id)
    if (xPlayer) then
        if (NewToken ~= token) then
            DropPlayer(xPlayer.source, 'FiveLevel - AntiTrigger')
            return
        end
        local xpAmount = GetPlayerXP(xPlayer.identifier)
        local newXPAmount = tonumber(xpAmount) + amount
        if (newXPAmount >= 1584350) then
            newXPAmount = 1584350
            amount = 1584350
        end
        MySQL.Sync.fetchAll("UPDATE users_xp SET xp_amount=@xp_amount WHERE identifier = @identifier", {
            ["@identifier"] = xPlayer.identifier,
            ["@xp_amount"] = newXPAmount
        })
        TriggerClientEvent("Five:OnAddPlayerXP", source, amount)
    end
end)

RegisterNetEvent("Five:RemovePlayerXP")
AddEventHandler("Five:RemovePlayerXP", function(token, id, amount)
    local source = source
    local xPlayer = ESX.GetPlayerFromId(id)
    if (xPlayer) then
        if (NewToken ~= token) then
            DropPlayer(xPlayer.source, 'FiveLevel - AntiTrigger')
            return
        end
        local xpAmount = GetPlayerXP(xPlayer.identifier)
        local newXPAmount = tonumber(xpAmount) - amount
        if (newXPAmount <= 0) then
            newXPAmount = 0
            amount = 0
        end
        MySQL.Sync.fetchAll("UPDATE users_xp SET xp_amount=@xp_amount WHERE identifier = @identifier", {
            ["@identifier"] = xPlayer.identifier,
            ["@xp_amount"] = newXPAmount
        })
        TriggerClientEvent("Five:OnRemovePlayerXP", source, amount)
    end
end)