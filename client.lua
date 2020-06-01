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

ESX                             = nil
local PlayerData                = {}
local incollect                 = false
local estouaqui                 = false
local cordinaterinas            = {}

RegisterNetEvent('esx:playerLoaded')
AddEventHandler('esx:playerLoaded', function(xPlayer)
    PlayerData = xPlayer
end)

Citizen.CreateThread(function()
	while ESX == nil do
		TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
		Citizen.Wait(0)
	end
end)

RegisterCommand('roubarcaixa', function(source, args, raw)

  if estouaqui then
    ESX.TriggerServerCallback('castro:checkarmoina', function(countPolice)
      if countPolice >=1 then
        comecar()
        TriggerServerEvent('InteractSound_SV:PlayWithinDistance', 30.0, 'Alarme', 0.3)
        TriggerServerEvent('esx_addons_gcphone:startCall', 'police', 'Um roubo foi detectado em' , { x = cordinaterinas.x, y = cordinaterinas.y, z = cordinaterinas.z })
      else
        exports['mythic_notify']:DoHudText('inform', 'Tem de haver pelo menos um policia ON!', { ['background-color'] = '#ff0000', ['color'] = '#ffffff' })
      end
    end)

  end

end)


Citizen.CreateThread(function()
    while true do
        Wait(0)
		local coords = GetEntityCoords(GetPlayerPed(-1))
		for k,v in pairs(Config.Zone) do
			if (GetDistanceBetweenCoords(coords, v.x, v.y, v.z, true) < 1.0) then
				DrawText3D(v.x, v.y, v.z, '~w~Roubar ~g~Caixa ', 0.4)
        if (GetDistanceBetweenCoords(coords, v.x, v.y, v.z, true) < 1.0) then
        estouaqui = true
        cordinaterinas = v
      else
        estouaqui = false
        cordinaterinas = {}
    end
  end
  end
end
end)

function chekarmoina()
  TriggerServerEvent('castro:vermoina')
end

function comecar()
  exports['mythic_progbar']:Progress({
                    name = "unique_action_name",
                    duration = 120000,
                    label = 'Roubando a Caixa',
                    useWhileDead = true,
                    canCancel = true,
                    controlDisables = {
                        disableMovement = true,
                        disableCarMovement = true,
                        disableMouse = false,
                        disableCombat = true,
                    },
                    animation = {
                        animDict = "oddjobs@shop_robbery@rob_till",
                        anim = "loop",
                        flags = 49,
                    },
                }, function(cancelled)
                    if not cancelled then
                        TriggerServerEvent('castro:darguito')
                    else
                        --nada
                    end
                end)


end



function DrawText3D(x, y, z, text, scale)
local onScreen, _x, _y = World3dToScreen2d(x, y, z)
	local pX, pY, pZ = table.unpack(GetGameplayCamCoords())
	SetTextScale(scale, scale)
	SetTextFont(4)
	SetTextProportional(1)
	SetTextEntry("STRING")
	SetTextCentre(1)
	SetTextColour(255, 255, 255, 255)
	SetTextOutline()
	AddTextComponentString(text)
	DrawText(_x, _y)
  local factor = (string.len(text)) / 370
  DrawRect(_x, _y + 0.0125, 0.015 + factor, 0.03, 41, 11, 41, 90)
end
