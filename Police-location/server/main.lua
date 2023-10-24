ESX = exports["es_extended"]:getSharedObject()


RegisterServerEvent('requestPoliceWaypoint')
AddEventHandler('requestPoliceWaypoint', function(x, y)
    local source = source
	local xPlayer = ESX.GetPlayerFromId(source)
	local xPlayers = ESX.GetPlayers()
	
	for i=1, #xPlayers, 1 do
		local xPlayer = ESX.GetPlayerFromId(xPlayers[i])
		if xPlayer.job.name == 'police' then
            local Name = xPlayer.getName(xPlayer)
            TriggerClientEvent('setPoliceWaypoint', xPlayers[i], x, y)
            TriggerClientEvent('showPoliceNotification', xPlayers[i], Name)
        end
    end
end)

RegisterServerEvent('removePoliceWaypoint')
AddEventHandler('removePoliceWaypoint', function()
    local sourcePlayer = source
    local players = GetPlayers()

    for _, playerId in ipairs(players) do
        if playersWithWaypoint[playerId] and sourcePlayer ~= playerId then
            if playersWithNotification[playerId] then
                TriggerClientEvent('removePoliceWaypoint', playerId)
            end
        end
    end
end)

AddEventHandler('playerDropped', function()
    local playerId = source
    playersWithWaypoint[playerId] = 0
    playersWithNotification[playerId] = 0
end)


