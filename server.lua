ESX = nil

TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)

local lastAdDate = 0

RegisterServerEvent("SyncWerbung")
AddEventHandler('SyncWerbung', function(inputText)
	if os.time(os.date("!*t")) > (lastAdDate + Config.Time) then
		lastAdDate = os.time(os.date("!*t"))
		local _source = source
		local xPlayer = ESX.GetPlayerFromId(_source)
		TriggerClientEvent('DisplayWerbung', -1, inputText, xPlayer.getName())

		local xPlayer = ESX.GetPlayerFromId(source)
		xPlayer.removeMoney(Config.Price)
	else
		TriggerClientEvent('AdError', source, "In den letzten 30 Minuten wurde bereits Werbung geschaltet.")
	end
end)