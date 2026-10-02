local ESX = nil

Citizen.CreateThread(function()
    while ESX == nil do
        TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
        Citizen.Wait(0)
    end

    RegisterCommand(Config.AdminMenu.Command, function(source, args, rawCommand)
        local playerData = ESX.GetPlayerData()

        if playerData.job.name == Config.AdminMenu.Permission then
            OpenAdminMenu()
        else
            ESX.ShowNotification('You do not have permission to use this command.')
        end
    end, false)

    function OpenAdminMenu()
        local elements = {
            {label = 'Teleport to Waypoint', value = 'teleport_to_waypoint'},
            {label = 'Revive Player', value = 'revive_player'},
            {label = 'Give Item', value = 'give_item'},
            {label = 'Kick Player', value = 'kick_player'}
        }

        ESX.UI.Menu.Open('default', GetCurrentResourceName(), 'admin_menu', {
            title    = 'Admin Menu',
            align    = 'top-left',
            elements = elements
        }, function(data, menu)
            if data.current.value == 'teleport_to_waypoint' then
                TeleportToWaypoint()
            elseif data.current.value == 'revive_player' then
                RevivePlayer()
            elseif data.current.value == 'give_item' then
                GiveItem()
            elseif data.current.value == 'kick_player' then
                KickPlayer()
            end
        end, function(data, menu)
            menu.close()
        end)
    end

    function TeleportToWaypoint()
        local waypointBlip = GetFirstBlipInfoId(8)
        if DoesBlipExist(waypointBlip) then
            local waypointCoords = GetBlipInfoIdCoord(waypointBlip)
            SetEntityCoords(PlayerPedId(), waypointCoords.x, waypointCoords.y, waypointCoords.z, false, false, false, true)
            ESX.ShowNotification('Teleported to waypoint.')
        else
            ESX.ShowNotification('No waypoint set.')
        end
    end

    function RevivePlayer()
        ESX.UI.Menu.Open('dialog', GetCurrentResourceName(), 'revive_player', {
            title = 'Enter Player ID'
        }, function(data, menu)
            local playerId = tonumber(data.value)
            if playerId then
                TriggerServerEvent('adminmenu:revivePlayer', playerId)
            else
                ESX.ShowNotification('Invalid player ID.')
            end
            menu.close()
        end, function(data, menu)
            menu.close()
        end)
    end

    function GiveItem()
        ESX.UI.Menu.Open('dialog', GetCurrentResourceName(), 'give_item', {
            title = 'Enter Player ID'
        }, function(data, menu)
            local playerId = tonumber(data.value)
            if playerId then
                ESX.UI.Menu.Open('dialog', GetCurrentResourceName(), 'give_item_item', {
                    title = 'Enter Item Name'
                }, function(data2, menu2)
                    local itemName = data2.value
                    if itemName then
                        ESX.UI.Menu.Open('dialog', GetCurrentResourceName(), 'give_item_count', {
                            title = 'Enter Item Count'
                        }, function(data3, menu3)
                            local itemCount = tonumber(data3.value)
                            if itemCount then
                                TriggerServerEvent('adminmenu:giveItem', playerId, itemName, itemCount)
                            else
                                ESX.ShowNotification('Invalid item count.')
                            end
                            menu3.close()
                        end, function(data3, menu3)
                            menu3.close()
                        end)
                    else
                        ESX.ShowNotification('Invalid item name.')
                    end
                    menu2.close()
                end, function(data2, menu2)
                    menu2.close()
                end)
            else
                ESX.ShowNotification('Invalid player ID.')
            end
            menu.close()
        end, function(data, menu)
            menu.close()
        end)
    end

    function KickPlayer()
        ESX.UI.Menu.Open('dialog', GetCurrentResourceName(), 'kick_player', {
            title = 'Enter Player ID'
        }, function(data, menu)
            local playerId = tonumber(data.value)
            if playerId then
                ESX.UI.Menu.Open('dialog', GetCurrentResourceName(), 'kick_player_reason', {
                    title = 'Enter Kick Reason'
                }, function(data2, menu2)
                    local reason = data2.value
                    if reason then
                        TriggerServerEvent('adminmenu:kickPlayer', playerId, reason)
                    else
                        ESX.ShowNotification('Invalid kick reason.')
                    end
                    menu2.close()
                end, function(data2, menu2)
                    menu2.close()
                end)
            else
                ESX.ShowNotification('Invalid player ID.')
            end
            menu.close()
        end, function(data, menu)
            menu.close()
        end)
    end
end)