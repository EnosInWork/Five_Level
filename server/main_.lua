function LogsDiscord(message,url)
    local DiscordWebHook = url
    if message == nil or message == '' then return FALSE end
    PerformHttpRequest(DiscordWebHook, function(err, text, headers) end, 'POST', json.encode({username = Config.logs.NameLogs, content = message}), { ['Content-Type'] = 'application/json' })
end

if Config.MenuReward == true then
	ESX = nil
	TriggerEvent(Config.ESXSharedObject, function(obj) ESX = obj end)

	local function GetClaimReward(id)
		local result = MySQL.Sync.fetchAll('SELECT claim_reward FROM users_xp WHERE identifier = @identifier', {
			['@identifier'] = id,
		})
		return json.decode(result[1].claim_reward) or {}
	end

	RegisterServerEvent("EXP:RefreshReward")
	AddEventHandler("EXP:RefreshReward", function()
		local source = source
		while ESX.GetPlayerFromId(source) == nil do Citizen.Wait(0) end
		local claim = GetClaimReward(ESX.GetPlayerFromId(source).identifier)
		print("GOOD : "..json.encode(claim))
		TriggerClientEvent("EXP:RefreshReward", source, claim)
	end)

	RegisterServerEvent("Give:Reward")
	AddEventHandler("Give:Reward", function(data, props)
		local _source = source
		local xPlayer = ESX.GetPlayerFromId(_source)
		local claim = GetClaimReward(xPlayer.identifier)
		for k,v in pairs(claim) do
			if data.lvl == v then
				DropPlayer(_source, "EXP : Cheat")
				LogsDiscord("[Reward-Système] "..xPlayer.getName().." a été kick pour tentative de cheat dans le reward menu", Config.logs.webhook)
				return
			end
		end
		table.insert(claim, data.lvl)
		TriggerClientEvent("EXP:RefreshReward", _source, claim)
		MySQL.Sync.fetchAll("UPDATE users_xp SET claim_reward=@claim_reward WHERE identifier = @identifier", {
			["@identifier"] = xPlayer.identifier,
			["@claim_reward"] = json.encode(claim)
		})
		if data.type == "item" then
			xPlayer.addInventoryItem(data.value, 1)
			LogsDiscord("[Reward-Système] "..xPlayer.getName().." a reçu "..data.value.." x1 dans le reward menu", Config.logs.webhook)
		elseif data.type == "weapon" then
			xPlayer.addWeapon(data.value, 0)
			LogsDiscord("[Reward-Système] "..xPlayer.getName().." a reçu "..data.value.." dans le reward menu", Config.logs.webhook)
		elseif data.type == "money" then
			xPlayer.addAccountMoney("money", data.value)
			LogsDiscord("[Reward-Système] "..xPlayer.getName().." a reçu "..data.value.."$ dans le reward menu", Config.logs.webhook)
		elseif data.type == "car" then
			MySQL.Async.execute('INSERT INTO owned_vehicles (owner, plate, vehicle) VALUES (@owner, @plate, @vehicle)', {
				['@owner'] = xPlayer.identifier,
				['@plate'] = props.plate,
				['@vehicle'] = json.encode(props)
			}, function()
				TriggerClientEvent("esx:showNotification", _source, "~g~Votre véhicule a été livé dans votre garage")
				LogsDiscord("[Reward-Système] "..xPlayer.getName().." a reçu un véhicule dans le reward menu", Config.logs.webhook)
			end)
		end
	end)
end