ESX = exports["es_extended"]:getSharedObject()

local playersWithWaypoint = {}
local playersWithNotification = {}

RegisterServerEvent('requestPoliceWaypoint')
AddEventHandler('requestPoliceWaypoint', function(x, y)
    local targetPlayer = nil
    local xPlayer = ESX.GetPlayerFromId(source)
    local sourcePlayer = source
    local players = GetPlayers()
    local Name = xPlayer.getName(xPlayer)
    local playerJob = xPlayer.job.name

    for _, playerId in ipairs(players) do
        local playerPed = GetPlayerPed(playerId)
        local targetPlayer = ESX.GetPlayerFromId(playerId)
        local targetJob = targetPlayer.job

        if playerPed ~= nil and playerPed ~= -1 and targetJob ~= nil and targetJob.name == "police" and sourcePlayer ~= playerId then
            TriggerClientEvent('setPoliceWaypoint', playerId, x, y)
            TriggerClientEvent('showPoliceNotification', playerId, Name)
            playersWithWaypoint[playerId] = true

            if not playersWithNotification[playerId] then
                playersWithNotification[playerId] = true
            end
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
                playersWithNotification[playerId] = nil
                playersWithWaypoint[playerId] = nil
            end
        end
    end
end)

AddEventHandler('playerDropped', function()
    local playerId = source
    playersWithWaypoint[playerId] = nil
    playersWithNotification[playerId] = nil
end)


