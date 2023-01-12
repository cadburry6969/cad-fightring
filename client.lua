local QBCore = exports['qb-core']:GetCoreObject()
local inMainFightZone = false
local isInFightZone = false

local function loadAnimDict(dict)
	while(not HasAnimDictLoaded(dict)) do
		RequestAnimDict(dict)
		Wait(1)
	end
end

local function InFightZone()
    return isInFightZone
end
exports("InFightZone", InFightZone)

CreateThread(function()
    local fightZone = PolyZone:Create({
        vector2(-481.79537963867, -1766.9912109375),
        vector2(-514.99530029297, -1760.9230957031),
        vector2(-600.92608642578, -1698.7825927734),
        vector2(-579.57434082031, -1682.2628173828),
        vector2(-555.07934570312, -1668.7601318359),
        vector2(-542.28125, -1683.2932128906),
        vector2(-519.51257324219, -1667.9427490234),
        vector2(-492.99890136719, -1704.9211425781)
    }, {
        name="fightZone",
        minZ = 18.280469894409,
        maxZ = 30.865571975708
    })
    fightZone:onPlayerInOut(function(isPointInside)
        if isPointInside then
            inMainFightZone = true
        else
            inMainFightZone = false
        end
    end)
    local ringZone = BoxZone:Create(vector3(-517.23, -1710.71, 20.15), 6.8, 7, {
        name="ringZone",
        heading=319,
        --debugPoly=true,
        minZ=19.15,
        maxZ=21.95
    })
    ringZone:onPlayerInOut(function(isPointInside)
        if isPointInside then
            isInFightZone = true
            if GlobalState.IsFightClubStarted and inMainFightZone then
                if not exports['ps-buffs']:HasBuff("super-health") then
                    local time = (5*60*1000)
                    exports['ps-buffs']:AddHealthBuff(time, 6)
                end
            end
        else
            isInFightZone = false
            if GlobalState.IsFightClubStarted and inMainFightZone then
                TriggerServerEvent("fightclub:removebuff")
            end
        end
    end)
end)

RegisterNetEvent("playerDeadTriggeredEvent", function()
    if isInFightZone and GlobalState.IsFightClubStarted then
        isInFightZone = false
        QBCore.Functions.Progressbar("fight_revive", "Taking you to dipensary for treatment!", 5000, false, false, {
            disableMovement = true,
            disableCarMovement = true,
            disableMouse = false,
            disableCombat = true,
        }, {}, {}, {}, function() -- Done
            DoScreenFadeOut(500)
            Wait(1000)
            local bedObject = GetClosestObjectOfType(-546.094116, -1693.158813, 18.540911, 1.0, -1673752417, false, false, false)
            SetEntityCoords(PlayerPedId(), -546.094116, -1693.158813, 18.540911 + 1.0)
            FreezeEntityPosition(PlayerPedId(), true)
            TriggerEvent("hospital:client:Revive")
            loadAnimDict("mini@cpr@char_b@cpr_def")
            TaskPlayAnim(PlayerPedId(), "mini@cpr@char_b@cpr_def" , "cpr_pumpchest_idle", 8.0, 1.0, -1, 1, 0, 0, 0, 0 )
            SetEntityHeading(PlayerPedId(), 24.189786911011)
            Wait(1000)
            DoScreenFadeIn(500)
            Wait(2000)
            FreezeEntityPosition(PlayerPedId(), false)
            ClearPedTasks(PlayerPedId())
        end, function() -- Cancel            
        end)
    end
end)