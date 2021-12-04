-- AFK Kick Time Limit (in seconds)
local QBCore = exports['qb-core']:GetCoreObject()

local group = 'user'
local secondsUntilKick = 1800
local prevPos, time = nil, nil

RegisterNetEvent('QBCore:Client:OnPlayerLoaded')
AddEventHandler('QBCore:Client:OnPlayerLoaded', function()
    QBCore.Functions.TriggerCallback('qb-afkkick:server:GetPermissions', function(UserGroup)
        group = UserGroup
    end)
end)

RegisterNetEvent('QBCore:Client:OnPermissionUpdate')
AddEventHandler('QBCore:Client:OnPermissionUpdate', function(UserGroup)
    group = UserGroup
end)

-- AfkZone

local inAfk = false

local afkZone = PolyZone:Create({
    vector2(1075.6956787109, -707.99176025391),
    vector2(1082.1788330078, -711.89923095703),
    vector2(1088.7055664062, -710.36047363281),
    vector2(1097.9268798828, -711.86950683594),
    vector2(1106.8038330078, -709.28308105469),
    vector2(1105.1436767578, -698.86328125),
    vector2(1096.4185791016, -692.72448730469),
    vector2(1094.3006591797, -686.60913085938),
    vector2(1089.8312988281, -676.99761962891),
    vector2(1079.4432373047, -672.03570556641),
    vector2(1071.1309814453, -672.56335449219),
    vector2(1062.1279296875, -676.46722412109),
    vector2(1061.8375244141, -686.33453369141),
    vector2(1062.3450927734, -689.74884033203),
    vector2(1061.6577148438, -694.02062988281),
    vector2(1068.0780029297, -702.24658203125)
  }, {
    name="AfkZone",
    minZ = 55.82,
    maxZ = 62.09
  })

afkZone:onPlayerInOut(function(isPointInside)
    if LocalPlayer.state['isLoggedIn'] then
        local veh = GetVehiclePedIsUsing(PlayerPedId())
        if isPointInside then
            print('In Afk Active')
		    inAfk = true
            SetEntityHealth(PlayerPedId(), PlayerPedId())
            SetCanAttackFriendly(PlayerPedId(), false, true)
            NetworkSetFriendlyFireOption(false)
            SetCurrentPedWeapon(PlayerPedId(), 0xA2719263, true)
        else
            print('In Afk Deactive')
            inAfk = false
            SetCanAttackFriendly(PlayerPedId(), true, false)
            NetworkSetFriendlyFireOption(true)
        end
    end
end)

function InAfkZone()
    return inAfk
end

exports('InAfkZone', InAfkZone)

-- Code

CreateThread(function()
    while true do
        Wait(1000)
        local playerPed = PlayerPedId()
        if LocalPlayer.state['isLoggedIn'] then
            if group == 'user' then
                currentPos = GetEntityCoords(playerPed, true)
                if prevPos ~= nil then
                    if currentPos == prevPos then
                        if time ~= nil then
                            if not inAfk then
                                if time > 0 then
                                    if time == (900) then
                                        QBCore.Functions.Notify('You are AFK and will be kicked in ' .. math.ceil(time / 60) .. ' minutes!', 'error', 10000)
                                    elseif time == (600) then
                                        QBCore.Functions.Notify('You are AFK and will be kicked in ' .. math.ceil(time / 60) .. ' minutes!', 'error', 10000)
                                    elseif time == (300) then
                                        QBCore.Functions.Notify('You are AFK and will be kicked in ' .. math.ceil(time / 60) .. ' minutes!', 'error', 10000)
                                    elseif time == (150) then
                                        QBCore.Functions.Notify('You are AFK and will be kicked in ' .. math.ceil(time / 60) .. ' minutes!', 'error', 10000)   
                                    elseif time == (60) then
                                        QBCore.Functions.Notify('You are AFK and will be kicked in ' .. math.ceil(time / 60) .. ' minute!', 'error', 10000) 
                                    elseif time == (30) then
                                        QBCore.Functions.Notify('You are AFK and will be kicked in ' .. time .. ' seconds!', 'error', 10000)  
                                    elseif time == (20) then
                                        QBCore.Functions.Notify('You are AFK and will be kicked in ' .. time .. ' seconds!', 'error', 10000)    
                                    elseif time == (10) then
                                        QBCore.Functions.Notify('You are AFK and will be kicked in ' .. time .. ' seconds!', 'error', 10000)                                                                                                            
                                    end
                                    time = time - 1
                                else
                                    TriggerServerEvent('KickForAFK')
                                end
                                --print('Player not in the right zone, Able to drop')
                            else
                                --print('Player in the right zone, Unable to drop')
                            end
                        else
                            time = secondsUntilKick
                        end
                    else
                        time = secondsUntilKick
                    end
                end
                prevPos = currentPos
            end
        end
    end
end)