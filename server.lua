ESX = nil

TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)

local lastAdDate = 0

RegisterServerEvent("SyncWerbung")
AddEventHandler('SyncWerbung', function(inputText)
	if os.time(os.date("!*t")) > (lastAdDate + Config.Time) then
		lastAdDate = os.time(os.date("!*t"))


		local xPlayer = ESX.GetPlayerFromId(source)
		if xPlayer.getMoney() >= Config.Price then
			xPlayer.removeMoney(Config.Price)

			local _source = source
			local xPlayer = ESX.GetPlayerFromId(_source)
			TriggerClientEvent('DisplayWerbung', -1, inputText, xPlayer.getName())
		else
			TriggerClientEvent('AdError', source, "Du hast nicht genug Geld dabei.")
		end
	else
		TriggerClientEvent('AdError', source, "In den letzten 30 Minuten wurde bereits Werbung geschaltet.")
	end
end)
