local maintenanceMessage = "Warning: Server maintenance in progress. Expect possible lag or restarts."
local maintenanceMessageScript = "Warning: The %s script is currently undergoing maintenance. Expect possible lag or restart."  
local isShowing = false

local rgb = { r = 255, g = 0, b = 0 }
local alpha = 255
local scale = 0.5
local font = 4
local offset = { x = 0.5, y = 0.001 }

Citizen.CreateThread(function()
    while true do
        Wait(1)

        if isShowing then
            SetTextColour(rgb.r, rgb.g, rgb.b, alpha)
            SetTextFont(font)
            SetTextScale(scale, scale)
            SetTextWrap(0.0, 1.0)
            SetTextCentre(true)
            SetTextDropshadow(2, 2, 0, 0, 0)
            SetTextEdge(1, 0, 0, 205)
            SetTextEntry("STRING")

            if scriptname and scriptname ~= "" then
                local message = string.format(maintenanceMessageScript, scriptname)
                AddTextComponentString(message)
            else
                AddTextComponentString(maintenanceMessage)
            end
            
            DrawText(offset.x, offset.y)
        end
    end
end)

RegisterNetEvent('OpenWartungsarbeiten')
AddEventHandler('OpenWartungsarbeiten', function()
    OpenWartungsarbeiten()
end)

function OpenWartungsarbeiten(source)
    local input = lib.inputDialog('maintenance work menu', {
        {
            type = 'input',
            label = 'Enter script name',
            required = false,
        },
        {
            type = 'select',
            label = 'Action',
            required = true,
            options = {
                {value = 'start', label = 'Starting'},
                {value = 'stop', label = 'Stopping'},
            }
        },
    })

    if input then
        local scriptnameInput = input[1]
        local action = input[2]

        scriptname = scriptnameInput

        if action == 'start' then
            TriggerServerEvent('StartWartung')
        elseif action == 'stop' then
            TriggerServerEvent('StopWartung')
        else
            print('Ungültige Aktion ausgewählt.')
        end
    else
        print('Keine Aktion angegeben.')
    end
end

RegisterNetEvent('ShowMaintenanceMessage')
AddEventHandler('ShowMaintenanceMessage', function()
    isShowing = true
    lib.notify({
        title = 'maintenance work menu',
        description = 'You have started the maintenance work.',
        duration = 5000,
        type = 'inform'
    })
end)

RegisterNetEvent('HideMaintenanceMessage')
AddEventHandler('HideMaintenanceMessage', function()
    isShowing = false
    lib.notify({
        title = 'maintenance work menu',
        description = 'You have stopped the maintenance work.',
        duration = 5000,
        type = 'inform'
    })
end)