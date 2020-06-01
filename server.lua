ESX = nil

TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)

ESX.RegisterServerCallback('castro:checkarmoina', function(source, cb)

	local xPlayers = ESX.GetPlayers()
 	local pcountPolice = 0

    for i=1, #xPlayers, 1 do
        local Player = ESX.GetPlayerFromId(xPlayers[i])
        if Player.job.name == 'police' then
           pcountPolice = pcountPolice + 1
        end
    end

	cb(pcountPolice)
end)

RegisterServerEvent('castro:darguito')
AddEventHandler('castro:darguito', function()
	local xPlayer = ESX.GetPlayerFromId(source)
	local dinheiros = math.random(250, 2500)
	xPlayer.addMoney(dinheiros)
	TriggerClientEvent('mythic_notify:client:SendAlert', source, { type = 'inform', text = 'Este assalto deu-te '..dinheiros..'€', length = 2500, style = { ['background-color'] = '#000000', ['color'] = '#ffffff' } })
end)
