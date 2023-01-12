local QBCore = exports['qb-core']:GetCoreObject()

GlobalState.IsFightClubStarted = false

QBCore.Commands.Add('fightclub', 'Toggle Fightclub Event', {}, false, function(source, args)
    if GlobalState.IsFightClubStarted then
        GlobalState.IsFightClubStarted = false
        TriggerClientEvent("QBCore:Notify", source, "Boxing Event Ended", "error")
    else
        GlobalState.IsFightClubStarted = true
        TriggerClientEvent("QBCore:Notify", source, "Boxing Event Started", "success")
    end
end, 'admin')

RegisterNetEvent("fightclub:removebuff", function()
    local src = source
    local Player = QBCore.Functions.GetPlayer(src)
    exports["ps-buffs"]:RemoveBuff(Player.PlayerData.citizenid, "super-health")
end)