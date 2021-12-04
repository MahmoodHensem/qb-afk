# qb-afk
AFK Kicking Script For QB-Core

# how to use the exports
```lua
if not exports['qb-afk']:InAfkZone() then
    --Do your code here
    print('player trying to fail rp in Afk Zone') --Example
end

-- here the exp for the export i use in qb-smallresources/client/handsup.lua
        if not exports['qb-afk']:InAfkZone() then --1
            if handsup then
                TaskPlayAnim(ped, animDict, anim, 1.0, 1.0, 1.0, 49, 0.0, 0, 0, 0)
                if IsPedInAnyVehicle(ped, false) then
                    local vehicle = GetVehiclePedIsIn(ped, false)
                    if GetPedInVehicleSeat(vehicle, -1) == ped then
                        CreateThread(function()
                            while handsup do
                                Wait(1)
                                DisableControlAction(0, 59, true) -- Disable steering in vehicle
                                DisableControlAction(0,21,true) -- disable sprint
                                DisableControlAction(0,24,true) -- disable attack
                                DisableControlAction(0,25,true) -- disable aim
                                DisableControlAction(0,47,true) -- disable weapon
                                DisableControlAction(0,58,true) -- disable weapon
                                DisableControlAction(0,71,true) -- veh forward
                                DisableControlAction(0,72,true) -- veh backwards
                                DisableControlAction(0,63,true) -- veh turn left
                                DisableControlAction(0,64,true) -- veh turn right
                                DisableControlAction(0,263,true) -- disable melee
                                DisableControlAction(0,264,true) -- disable melee
                                DisableControlAction(0,257,true) -- disable melee
                                DisableControlAction(0,140,true) -- disable melee
                                DisableControlAction(0,141,true) -- disable melee
                                DisableControlAction(0,142,true) -- disable melee
                                DisableControlAction(0,143,true) -- disable melee
                                DisableControlAction(0,75,true) -- disable exit vehicle
                                DisableControlAction(27,75,true) -- disable exit vehicle
                            end
                        end)
                    end
                end
            else
                ClearPedTasks(ped)
            end
            print('Handsup') --2
        else
            print('Trying to exploit handsup') --3 --didn't let player put hands up in afk zone
        end
```

# License

    QBCore Framework
    Copyright (C) 2021 Joshua Eger

    This program is free software: you can redistribute it and/or modify
    it under the terms of the GNU General Public License as published by
    the Free Software Foundation, either version 3 of the License, or
    (at your option) any later version.

    This program is distributed in the hope that it will be useful,
    but WITHOUT ANY WARRANTY; without even the implied warranty of
    MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
    GNU General Public License for more details.

    You should have received a copy of the GNU General Public License
    along with this program.  If not, see <https://www.gnu.org/licenses/>

