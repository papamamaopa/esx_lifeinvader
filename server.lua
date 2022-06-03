ESX = nil

TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)

local lastAdDate = 0

RegisterServerEvent("SyncWerbung")
AddEventHandler('SyncWerbung', function(inputText)
	local _source = source
	local xPlayerSendedBy = ESX.GetPlayerFromId(_source)
	local xPlayer = ESX.GetPlayerFromId(source)
	lastAdDate = os.time(os.date("!*t"))
	if os.time(os.date("!*t")) > (lastAdDate + Config.Time) then
		if xPlayer.getMoney() >= Config.price then
			TriggerClientEvent('DisplayWerbung', -1, inputText, xPlayerSendedBy.getName())

			xPlayer.removeMoney(Config.Price)
		else
			TriggerClientEvent('AdError', source, "Du hast nicht genug Geld dabei!.")
		end
	else
		TriggerClientEvent('AdError', source, "In den letzten 30 Minuten wurde bereits Werbung geschaltet.")
	end
end)
