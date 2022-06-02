ESX = nil

TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)

local lastAdDate 			   = 0

RegisterServerEvent("SyncWerbung")
AddEventHandler('SyncWerbung', function(inputText)
	if os.time(os.date("!*t")) > (lastAdDate + Config.Time) then
		lastAdDate = os.time(os.date("!*t"))
		local _source = source
		local xPlayer = ESX.GetPlayerFromId(_source)
		TriggerClientEvent('DisplayWerbung', -1, inputText, xPlayer.getName())
				PerformHttpRequest(Config.Webhook, function(e,r,h) end, "POST", json.encode({
					["username"] = "Weazel News",
					["content"] = "```diff\n+ [LifeInvader News] " .. xPlayer.name .. " hat werbung geschaltet: " .. inputText .."```"
				}), {["Content-Type"] = "application/json"})
		local xPlayer = ESX.GetPlayerFromId(source)
		xPlayer.removeMoney(Config.Price)
		TriggerClientEvent("notifications", -1, "#fc8c03", "Justiz", "Das ist ein Test ihr keks")
	else
		TriggerClientEvent('FehlerWerbung', source, "In den letzten 30 Minuten wurde bereits Werbung geschaltet.")
	end
end)