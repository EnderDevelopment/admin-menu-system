local ESX = nil

TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)

RegisterServerEvent('adminmenu:revivePlayer')
AddEventHandler('adminmenu:revivePlayer', function(targetId)
    local xPlayer = ESX.GetPlayerFromId(source)
    local targetPlayer = ESX.GetPlayerFromId(targetId)

    if xPlayer.job.name == Config.AdminMenu.Permission then
        if targetPlayer then
            TriggerClientEvent('esx_ambulancejob:revive', targetId)
            MySQL.Async.execute('INSERT INTO admin_menu (player_id, command) VALUES (@player_id, @command)', {
                ['@player_id'] = xPlayer.source,
                ['@command'] = 'revive_player'
            }, function(rowsChanged)
                if rowsChanged == 0 then
                    print('Failed to log admin command.')
                end
            end)
        else
            TriggerClientEvent('esx:showNotification', source, 'Player not found.')
        end
    else
        TriggerClientEvent('esx:showNotification', source, 'You do not have permission to use this command.')
    end
end)

RegisterServerEvent('adminmenu:giveItem')
AddEventHandler('adminmenu:giveItem', function(targetId, itemName, itemCount)
    local xPlayer = ESX.GetPlayerFromId(source)
    local targetPlayer = ESX.GetPlayerFromId(targetId)

    if xPlayer.job.name == Config.AdminMenu.Permission then
        if targetPlayer then
            targetPlayer.addInventoryItem(itemName, itemCount)
            MySQL.Async.execute('INSERT INTO admin_menu (player_id, command) VALUES (@player_id, @command)', {
                ['@player_id'] = xPlayer.source,
                ['@command'] = 'give_item'
            }, function(rowsChanged)
                if rowsChanged == 0 then
                    print('Failed to log admin command.')
                end
            end)
        else
            TriggerClientEvent('esx:showNotification', source, 'Player not found.')
        end
    else
        TriggerClientEvent('esx:showNotification', source, 'You do not have permission to use this command.')
    end
end)

RegisterServerEvent('adminmenu:kickPlayer')
AddEventHandler('adminmenu:kickPlayer', function(targetId, reason)
    local xPlayer = ESX.GetPlayerFromId(source)
    local targetPlayer = ESX.GetPlayerFromId(targetId)

    if xPlayer.job.name == Config.AdminMenu.Permission then
        if targetPlayer then
            DropPlayer(targetId, reason)
            MySQL.Async.execute('INSERT INTO admin_menu (player_id, command) VALUES (@player_id, @command)', {
                ['@player_id'] = xPlayer.source,
                ['@command'] = 'kick_player'
            }, function(rowsChanged)
                if rowsChanged == 0 then
                    print('Failed to log admin command.')
                end
            end)
        else
            TriggerClientEvent('esx:showNotification', source, 'Player not found.')
        end
    else
        TriggerClientEvent('esx:showNotification', source, 'You do not have permission to use this command.')
    end
end)