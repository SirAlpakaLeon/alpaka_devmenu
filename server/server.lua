RegisterCommand(Config.OpenDevCommand, function(source, args, rawCommand)
    if IsPlayerAceAllowed(source, "leonscripts") then
        TriggerClientEvent('OpenWartungsarbeiten', source)
    else
        TriggerClientEvent('ox_lib:notify', source, {
            title = 'maintenance work menu',
            type = 'error',
            icon = 'ban',
            duration = 5000,
            description = 'You do not have permission for this command. Please contact an administrator..'
        })
    end
end, false)

RegisterNetEvent('StartWartung')
AddEventHandler('StartWartung', function()
    TriggerClientEvent('ShowMaintenanceMessage', -1)
end)

RegisterNetEvent('StopWartung')
AddEventHandler('StopWartung', function()
    TriggerClientEvent('HideMaintenanceMessage', -1)
end)
