ESX = exports["es_extended"]:getSharedObject()


RegisterNetEvent('esx:playerLoaded')
AddEventHandler('esx:playerLoaded', function(xPlayer)
	ESX.PlayerData = xPlayer
	ESX.PlayerLoaded = true
end)

RegisterNetEvent('esx:onPlayerLogout')
AddEventHandler('esx:onPlayerLogout', function()
	ESX.PlayerLoaded = false
	ESX.PlayerData = {}
end)

RegisterNetEvent('esx:setJob')
AddEventHandler('esx:setJob', function(job)
  ESX.PlayerData.job = job
end)

local waypointSet = false

RegisterNetEvent('setPoliceWaypoint')
AddEventHandler('setPoliceWaypoint', function(x, y)
    SetNewWaypoint(x, y)
    waypointSet = true
end)

RegisterNetEvent('removePoliceWaypoint')
AddEventHandler('removePoliceWaypoint', function()
    local playerCoords = GetEntityCoords(PlayerPedId())
    SetNewWaypoint(playerCoords.x, playercoords.y)
    waypointSet = false
end)



timenotify = 0
Citizen.CreateThreadNow(function()
    while true do
        local playerCoords = GetEntityCoords(PlayerPedId()) 
        Citizen.Wait(2)
        if ESX.PlayerLoaded == true then 
            if IsControlJustReleased(0, Frz.sendlockey) and ESX.PlayerData.job.name == Frz.job1 or ESX.PlayerData.job.name == Frz.job2 then
                local playerCoords = GetEntityCoords(PlayerPedId())
                TriggerServerEvent('requestPoliceWaypoint', playerCoords.x, playerCoords.y)
                waypointSet = true
            end
            if IsControlJustReleased(0, Frz.removewaypointkey) and ESX.PlayerData.job.name == Frz.job1 or ESX.PlayerData.job.name == Frz.job2 then
                if waypointSet then
                    DeleteWaypoint()
                    ESX.ShowNotification("Waypoint Deleated")
                    waypointSet = false
                end
            end
        end
    end
end)
RegisterNetEvent('showPoliceNotification')
AddEventHandler('showPoliceNotification', function(Name)
    timenotify = timenotify + 1
    if timenotify == timenotify then 
        ESX.ShowNotification("Agent " .. Name .. " sent a location. The location is on your GPS.")
        ESX.ShowNotification("Click 'DEL' to remove the GPS marker.")
    else
        Citizen.Wait(3000)
        timenotify = 0
    end
end)



