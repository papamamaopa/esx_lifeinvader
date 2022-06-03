local Keys = {
	["ESC"] = 322, ["F1"] = 288, ["F2"] = 289, ["F3"] = 170, ["F5"] = 166, ["F6"] = 167, ["F7"] = 168, ["F8"] = 169, ["F9"] = 56, ["F10"] = 57,
	["~"] = 243, ["1"] = 157, ["2"] = 158, ["3"] = 160, ["4"] = 164, ["5"] = 165, ["6"] = 159, ["7"] = 161, ["8"] = 162, ["9"] = 163, ["-"] = 84, ["="] = 83, ["BACKSPACE"] = 177,
	["TAB"] = 37, ["Q"] = 44, ["W"] = 32, ["E"] = 38, ["R"] = 45, ["T"] = 245, ["Y"] = 246, ["U"] = 303, ["P"] = 199, ["["] = 39, ["]"] = 40, ["ENTER"] = 18,
	["CAPS"] = 137, ["A"] = 34, ["S"] = 8, ["D"] = 9, ["F"] = 23, ["G"] = 47, ["H"] = 74, ["K"] = 311, ["L"] = 182,
	["LEFTSHIFT"] = 21, ["Z"] = 20, ["X"] = 73, ["C"] = 26, ["V"] = 0, ["B"] = 29, ["N"] = 249, ["M"] = 244, [","] = 82, ["."] = 81,
	["LEFTCTRL"] = 36, ["LEFTALT"] = 19, ["SPACE"] = 22, ["RIGHTCTRL"] = 70,
	["HOME"] = 213, ["PAGEUP"] = 10, ["PAGEDOWN"] = 11, ["DELETE"] = 178,
	["LEFT"] = 174, ["RIGHT"] = 175, ["TOP"] = 27, ["DOWN"] = 173,
	["NENTER"] = 201, ["N4"] = 108, ["N5"] = 60, ["N6"] = 107, ["N+"] = 96, ["N-"] = 97, ["N7"] = 117, ["N8"] = 61, ["N9"] = 118
}


local CurrentActionMsg = ''
local ui               = false;
ESX                    = nil
local PlayerData       = {}

Citizen.CreateThread(function()
	while ESX == nil do
		TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
		Citizen.Wait(0)
	end
end)

RegisterNetEvent('esx:playerLoaded')
AddEventHandler('esx:playerLoaded', function(xPlayer)
	PlayerData = xPlayer
end)


RegisterNetEvent("AdError")
AddEventHandler("AdError", function(inputText)
	SetNotificationTextEntry("STRING");
	AddTextComponentString(inputText);
	SetNotificationMessage("CHAR_LIFEINVADER", "CHAR_LIFEINVADER", true, 1, "~w~LifeInvader ~r~News:~w~", "~r~Ein Fehler ist aufgetreten~s~", "");
	DrawNotification(false, true);
end)

--TriggerServerEvent('SyncWerbung', inputText)

CreateThread(function()
	while true do
		local sleep = 1500

		if ui then
			sleep = 0
			DisableControlAction(0, 1, true) -- LookLeftRight
			DisableControlAction(0, 2, true) -- LookUpDown
			DisableControlAction(0, 106, true) -- VehicleMouseControlOverride
			DisableControlAction(0, 142, true) -- MeleeAttackAlternate
			DisableControlAction(0, 30, true) -- MoveLeftRight
			DisableControlAction(0, 31, true) -- MoveUpDown
			DisableControlAction(0, 21, true) -- disable sprint
			DisableControlAction(0, 24, true) -- disable attack
			DisableControlAction(0, 25, true) -- disable aim
			DisableControlAction(0, 47, true) -- disable weapon
			DisableControlAction(0, 58, true) -- disable weapon
			DisableControlAction(0, 263, true) -- disable melee
			DisableControlAction(0, 264, true) -- disable melee
			DisableControlAction(0, 257, true) -- disable melee
			DisableControlAction(0, 140, true) -- disable melee
			DisableControlAction(0, 141, true) -- disable melee
			DisableControlAction(0, 143, true) -- disable melee
			DisableControlAction(0, 75, true) -- disable exit vehicle
			DisableControlAction(27, 75, true) -- disable exit vehicle
		end
		Wait(sleep)
	end
end)

RegisterNetEvent("test")
AddEventHandler("test", function()
	print("Läuft")
end)

RegisterNetEvent("nui:on")
AddEventHandler("nui:on", function(value)
	print("läuft der 2.")
	SendNUIMessage({ showUI = true })
	ui = true
	SetNuiFocus(
		true, true
	)
end)

RegisterNUICallback("lifeoff", function(data, cb)

	SendNUIMessage({ showUI = false })
	ui = false
	SetNuiFocus(
		false, false
	)
	TriggerServerEvent('SyncWerbung', data.value)

end)

RegisterNUICallback("nuioff", function(data, cb)

	SendNUIMessage({ showUI = false })
	ui = false
	SetNuiFocus(
		false, false
	)

end)

RegisterNetEvent("nuioff")
AddEventHandler("nuioff", function(value)
	SendNUIMessage({ showUI = false })
	ui = false
	SetNuiFocus(
		false, false
	)
end)


RegisterNetEvent('DisplayWerbung')
AddEventHandler('DisplayWerbung', function(inputText)
	SetNotificationTextEntry("STRING");
	AddTextComponentString(inputText);
	SetNotificationMessage("CHAR_LIFEINVADER", "CHAR_LIFEINVADER", true, 1, "~w~LifeInvader ~r~News:~w~", "Es wurde eine ~g~Werbung geschalten!~w~", "");
	DrawNotification(false, true);
end)


--- Marker

Citizen.CreateThread(function()
	while true do

		local isInMarker = false
		local playerPed  = PlayerPedId()
		local coords     = GetEntityCoords(playerPed)

		Wait(0)
		DrawMarker(1, -1081.86, -248.59, 36.80, 0.0, 0.0, 0.0, 0, 0.0, 0.0, 1.5, 1.5, 0.5, 200, 55, 50, 100, false, true, 2, false, false, false, false)

		if GetDistanceBetweenCoords(coords, -1081.86, -248.59, 36.80, true) < 1.5 then
			isInMarker = true
			ESX.ShowHelpNotification('Drücke ~INPUT_CONTEXT~ um eine Anzeige zu schalten!')
		else
			isInMarker = false
		end
		if IsControlJustReleased(0, Keys['E']) and isInMarker == true then
			TriggerEvent('nui:on', true)
			print("läuft")
		end

	end
end)

-- Blip
Citizen.CreateThread(function()
	if Config.BlipActive then
		for k, v in ipairs(Config.BlipCoords) do
			local blip = AddBlipForCoord(v.x, v.y, v.z)
			SetBlipSprite(blip, Config.BlipID)
			SetBlipDisplay(blip, 4)
			SetBlipScale(blip, 0.9)
			SetBlipColour(blip, Config.BlipColour)
			SetBlipAsShortRange(blip, true)
			BeginTextCommandSetBlipName("STRING")
			AddTextComponentString(Config.BlipName)
			EndTextCommandSetBlipName(blip)
		end
	end
end)
