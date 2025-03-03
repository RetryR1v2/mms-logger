local VORPcore = exports.vorp_core:GetCore()

AddEventHandler("vorp_core:Client:OnPlayerDeath", function(killerserverid, causeofdeath)
    if Config.DeathLogs[1].WHActive then
        local DeathLogData = Config.DeathLogs[1]
        TriggerServerEvent('mms-logger:server:PlayerKiller',killerserverid, causeofdeath, DeathLogData)
    end
end)

RegisterNetEvent('vorp:SelectedCharacter')
AddEventHandler('vorp:SelectedCharacter', function()
    if Config.PickCharLogs[1].WHActive then
        Citizen.Wait(10000)
        local PickCharData = Config.PickCharLogs[1]
        TriggerServerEvent('mms-logger:server:CharakterChoosen',PickCharData)
    end
end)

AddEventHandler("vorp:initNewCharacter", function()
    if Config.CreateCharLogs[1].WHActive then
        Citizen.Wait(10000)
        local CreateCharData = Config.CreateCharLogs[1]
        TriggerServerEvent('mms-logger:server:CharacterCreated',CreateCharData)
    end
end)

RegisterNetEvent("vorp_core:Client:OnPlayerRevive",function()
    Citizen.Wait(200)
    TriggerServerEvent('mms-logger:server:OnPlayerRevive')
end)