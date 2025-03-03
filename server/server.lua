-- Server Side
local VORPcore = exports.vorp_core:GetCore()

--- Kill Logs

RegisterServerEvent('mms-logger:server:PlayerKiller',function (killersrc, causeofdeath, DeathLogData)
    local src = source
    local DeathReason = _U('NoReasonFound')
    local WeaponModel = _U('NoReasonFound')
    for h,v in ipairs(Config.DeathReasons) do
        if v.WeaponDecimal == causeofdeath then
            DeathReason = v.WeaponName
            WeaponModel = v.WeaponModel
        end
    end
    if killersrc > 0 then
        local DeathChar = VORPcore.getUser(src).getUsedCharacter
        local DeathName = DeathChar.firstname .. ' ' .. DeathChar.lastname
        local KillerChar = VORPcore.getUser(killersrc).getUsedCharacter
        local KillerName = KillerChar.firstname .. ' ' .. KillerChar.lastname
        VORPcore.AddWebhook(DeathLogData.WHTitle, DeathLogData.WHLink, _U('Victim') .. DeathName .. _U('VictimPlayer') .. KillerName .. _U('DeathReason') .. DeathReason .. _U('WeaponModelName') .. WeaponModel, DeathLogData.WHColor, DeathLogData.WHName, DeathLogData.WHLogo, DeathLogData.WHFooterLogo, DeathLogData.WHAvatar)
    else
        local DeathChar = VORPcore.getUser(src).getUsedCharacter
        local DeathName = DeathChar.firstname .. ' ' .. DeathChar.lastname
        VORPcore.AddWebhook(DeathLogData.WHTitle, DeathLogData.WHLink, _U('Victim') .. DeathName .. _U('DiesAt') .. _U('DeathReason') .. DeathReason .. _U('WeaponModelName') .. WeaponModel, DeathLogData.WHColor, DeathLogData.WHName, DeathLogData.WHLogo, DeathLogData.WHFooterLogo, DeathLogData.WHAvatar)
    end
end)

-- Charakter Choosen Logs

RegisterServerEvent('mms-logger:server:CharakterChoosen',function(PickCharData)
    local src = source
    local PName = GetPlayerName(src)
    local User = VORPcore.getUser(src)
    local Character = User.getUsedCharacter
    local CharName = Character.firstname .. ' ' .. Character.lastname
    local Identifier = Character.identifier
    local CharId = Character.charIdentifier
    VORPcore.AddWebhook(PickCharData.WHTitle, PickCharData.WHLink, _U('Player') .. PName .. _U('WithId') .. Identifier .. _U('PickedChar') .. CharName .. _U('CharID') .. CharId, PickCharData.WHColor, PickCharData.WHName, PickCharData.WHLogo, PickCharData.WHFooterLogo, PickCharData.WHAvatar)
end)

-- Player Left

RegisterNetEvent('playerDropped')
AddEventHandler("playerDropped", function()
    local src = source
    local PName = GetPlayerName(src)
    if Config.LeaveLogs[1].WHActive then
        local LeaveLogData = Config.LeaveLogs[1]
        VORPcore.AddWebhook(LeaveLogData.WHTitle, LeaveLogData.WHLink, _U('Player') .. PName .. _U('WithServerID') .. src .. _U('LeftTheGame'), LeaveLogData.WHColor, LeaveLogData.WHName, LeaveLogData.WHLogo, LeaveLogData.WHFooterLogo, LeaveLogData.WHAvatar)
    end
end)

-- Player Joined

RegisterNetEvent('playerJoining')
AddEventHandler('playerJoining', function()
    local src = source
    local PName = GetPlayerName(src)
    if Config.JoinLogs[1].WHActive then
        local JoinLogData = Config.JoinLogs[1]
        VORPcore.AddWebhook(JoinLogData.WHTitle, JoinLogData.WHLink, _U('Player') .. PName .. _U('WithServerID') .. src ..  _U('JoinedTheServer'), JoinLogData.WHColor, JoinLogData.WHName, JoinLogData.WHLogo, JoinLogData.WHFooterLogo, JoinLogData.WHAvatar)
    end
end)

-- Resource Start Logs

AddEventHandler('onResourceStart', function(resourceName)
    if Config.ResourceStartLogs[1].WHActive then
        local ResourceStartLogData = Config.ResourceStartLogs[1]
        VORPcore.AddWebhook(ResourceStartLogData.WHTitle, ResourceStartLogData.WHLink, _U('ResourceGotStarted') .. resourceName, ResourceStartLogData.WHColor, ResourceStartLogData.WHName, ResourceStartLogData.WHLogo, ResourceStartLogData.WHFooterLogo, ResourceStartLogData.WHAvatar)
    end
end)

-- Resource Stop Logs

AddEventHandler('onResourceStop', function(resourceName)
    if Config.ResourceStopLogs[1].WHActive then
        local ResourceStopLogData = Config.ResourceStopLogs[1]
        VORPcore.AddWebhook(ResourceStopLogData.WHTitle, ResourceStopLogData.WHLink, _U('ResourceGotStopped') .. resourceName, ResourceStopLogData.WHColor, ResourceStopLogData.WHName, ResourceStopLogData.WHLogo, ResourceStopLogData.WHFooterLogo, ResourceStopLogData.WHAvatar)
    end
end)

-- Chat Message Logs

RegisterNetEvent('chatMessage')
AddEventHandler('chatMessage', function(source, author, text)
    local src = source
    local Character = VORPcore.getUser(src).getUsedCharacter
    local Name = Character.firstname .. ' ' .. Character.lastname
    if Config.ChatLogs[1].WHActive then
        local ChatLogData = Config.ChatLogs[1]
        VORPcore.AddWebhook(ChatLogData.WHTitle, ChatLogData.WHLink, _U('Character') .. Name .. _U('SendChatMessage') .. text, ChatLogData.WHColor, ChatLogData.WHName, ChatLogData.WHLogo, ChatLogData.WHFooterLogo, ChatLogData.WHAvatar)
    end
end)

-- Player Revived Logs

RegisterServerEvent('mms-logger:server:OnPlayerRevive',function()
    local src = source
    local Character = VORPcore.getUser(src).getUsedCharacter
    local Name = Character.firstname .. ' ' .. Character.lastname
    if Config.ReviveLogs[1].WHActive then
        local ReviveLogData = Config.ReviveLogs[1]
        VORPcore.AddWebhook(ReviveLogData.WHTitle, ReviveLogData.WHLink, _U('Player') .. Name .. _U(('WithServerID')) .. src .. _U('GotRevived'), ReviveLogData.WHColor, ReviveLogData.WHName, ReviveLogData.WHLogo, ReviveLogData.WHFooterLogo, ReviveLogData.WHAvatar)
    end
end)

-- Player Respawn Logs

AddEventHandler("vorp_core:Server:OnPlayerRespawn",function(source)
    local src = source
    local Character = VORPcore.getUser(src).getUsedCharacter
    local Name = Character.firstname .. ' ' .. Character.lastname
    if Config.RespawnLogs[1].WHActive then
        local RespawnLogData = Config.RespawnLogs[1]
        VORPcore.AddWebhook(RespawnLogData.WHTitle, RespawnLogData.WHLink, _U('Player') .. Name .. _U(('WithServerID')) .. src .. _U('GotRespawned'), RespawnLogData.WHColor, RespawnLogData.WHName, RespawnLogData.WHLogo, RespawnLogData.WHFooterLogo, RespawnLogData.WHAvatar)
    end
end)

-- Player Heal Logs

AddEventHandler("vorp_core:Server:OnPlayerHeal",function(source)
    local src = source
    local Character = VORPcore.getUser(src).getUsedCharacter
    local Name = Character.firstname .. ' ' .. Character.lastname
    if Config.HealLogs[1].WHActive then
        local HealLogData = Config.HealLogs[1]
        VORPcore.AddWebhook(HealLogData.WHTitle, HealLogData.WHLink, _U('Player') .. Name .. _U(('WithServerID')) .. src .. _U('GotHealed'), HealLogData.WHColor, HealLogData.WHName, HealLogData.WHLogo, HealLogData.WHFooterLogo, HealLogData.WHAvatar)
    end
end)

-- Player Job Change Logs

AddEventHandler("vorp:playerJobChange", function(source, newjob,oldjob)
    local src = source
    local Character = VORPcore.getUser(src).getUsedCharacter
    local Name = Character.firstname .. ' ' .. Character.lastname
    if Config.JobChangeLogs[1].WHActive then
        local JobChangeData = Config.JobChangeLogs[1]
        VORPcore.AddWebhook(JobChangeData.WHTitle, JobChangeData.WHLink, _U('Player') .. Name .. _U(('WithServerID')) .. src .. _U('ChangedJobFrom') .. oldjob .. _U('To') .. newjob, JobChangeData.WHColor, JobChangeData.WHName, JobChangeData.WHLogo, JobChangeData.WHFooterLogo, JobChangeData.WHAvatar)
    end
end)

-- Player Group Change Logs

AddEventHandler("vorp:playerGroupChange",function(source, newgroup,oldgroup)
    local src = source
    local Character = VORPcore.getUser(src).getUsedCharacter
    local Name = Character.firstname .. ' ' .. Character.lastname
    if Config.GroupChangeLogs[1].WHActive then
        local GroupChangeData = Config.GroupChangeLogs[1]
        VORPcore.AddWebhook(GroupChangeData.WHTitle, GroupChangeData.WHLink, _U('Player') .. Name .. _U(('WithServerID')) .. src .. _U('ChangedGroupFrom') .. oldgroup .. _U('To') .. newgroup, GroupChangeData.WHColor, GroupChangeData.WHName, GroupChangeData.WHLogo, GroupChangeData.WHFooterLogo, GroupChangeData.WHAvatar)
    end
end)

-- Character Created Logs

RegisterServerEvent('mms-logger:server:CharacterCreated',function(CreateCharData)
    local src = source
    local SteamName = GetPlayerName(src)
    local Character = VORPcore.getUser(src).getUsedCharacter
    local Name = Character.firstname .. ' ' .. Character.lastname
    local CharID = Character.charIdentifier
    VORPcore.AddWebhook(CreateCharData.WHTitle, CreateCharData.WHLink, _U('Player') .. SteamName .. _U(('WithServerID')) .. src .. _U('CreatedCharacter') .. Name .. _U('AndCharId') .. CharID, CreateCharData.WHColor, CreateCharData.WHName, CreateCharData.WHLogo, CreateCharData.WHFooterLogo, CreateCharData.WHAvatar)
end)

-- On Item Use Logs

AddEventHandler("vorp_inventory:Server:OnItemUse",function(data)
    print('Test On Item Use')
    local src = data.source
    local itemName = data.item.name
    local Character = VORPcore.getUser(src).getUsedCharacter
    local Name = Character.firstname .. ' ' .. Character.lastname
    if Config.ItemUseLogs[1].WHActive then
        local ItemUseData = Config.ItemUseLogs[1]
        VORPcore.AddWebhook(ItemUseData.WHTitle, ItemUseData.WHLink, _U('Player') .. Name .. _U(('WithServerID')) .. src .. _U('UsedItem') .. itemName, ItemUseData.WHColor, ItemUseData.WHName, ItemUseData.WHLogo, ItemUseData.WHFooterLogo, ItemUseData.WHAvatar)
    end
end)

-- On Item Created

AddEventHandler("vorp_inventory:Server:OnItemCreated",function(data,source)
    print('Test On Item Created')
    local src = source
    local Count = data.count
    local itemName = data.name
    local Character = VORPcore.getUser(src).getUsedCharacter
    local Name = Character.firstname .. ' ' .. Character.lastname
    if Config.ItemCreateLogs[1].WHActive then
        local ItemCreateData = Config.ItemCreateLogs[1]
        VORPcore.AddWebhook(ItemCreateData.WHTitle, ItemCreateData.WHLink, _U('Player') .. Name .. _U(('WithServerID')) .. src .. _U('CreatedItem') .. itemName .. _U('ItemAmount') .. Count, ItemCreateData.WHColor, ItemCreateData.WHName, ItemCreateData.WHLogo, ItemCreateData.WHFooterLogo, ItemCreateData.WHAvatar)
    end
end)

-- On Item Removed 

AddEventHandler("vorp_inventory:Server:OnItemRemoved",function(data,source)
    print('Test On Item Remove')
    local src = source
    local Count = data.count
    local itemName = data.name
    local Character = VORPcore.getUser(src).getUsedCharacter
    local Name = Character.firstname .. ' ' .. Character.lastname
    if Config.ItemRemoveLogs[1].WHActive then
        local ItemRemoveData = Config.ItemRemoveLogs[1]
        VORPcore.AddWebhook(ItemRemoveData.WHTitle, ItemRemoveData.WHLink, _U('Player') .. Name .. _U(('WithServerID')) .. src .. _U('RemovedItem') .. itemName .. _U('ItemAmount') .. Count, ItemRemoveData.WHColor, ItemRemoveData.WHName, ItemRemoveData.WHLogo, ItemRemoveData.WHFooterLogo, ItemRemoveData.WHAvatar)
    end
end)
