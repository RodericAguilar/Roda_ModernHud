
local ped, id, position, streetName, zone, zoneLabel, _sleep
local playersCount = 10
local mostrar = true
local cinturon = false 
local bateria = true
local UID = 1

function Cinturon(ped)
    while true do 
        if cinturon then 
            DisableControlAction(0, 75, true)  -- Disable exit vehicle when stop
            DisableControlAction(27, 75, true) -- Disable exit vehicle when Driving
        else
            Citizen.Wait(1000)
        end
        Citizen.Wait(0)
    end
end

RegisterNetEvent('Roda_ModernHud:SetUID')
AddEventHandler('Roda_ModernHud:SetUID', function(realuid)
    UID = realuid
end)

if GetResourceState("es_extended") == "started" then
    local ESX = exports["es_extended"]:getSharedObject()

AddEventHandler('playerSpawned', function()
    
Citizen.CreateThread(function ()
    while true do 
    if mostrar and not IsPauseMenuActive() then 
        _sleep = 2000
        ped = PlayerPedId()
        id = GetPlayerServerId(PlayerId())
        position = GetEntityCoords(ped)
        streetName = GetStreetNameFromHashKey(GetStreetNameAtCoord(position.x, position.y, position.z))
        zone = GetNameOfZone(position.x, position.y, position.z)
        zoneLabel = GetLabelText(zone)
        local data = ESX.GetPlayerData()
        local money, bank = 0, 0
        for i = 1, #data.accounts do 
            if data.accounts[i].name == 'money' then 
                money = data.accounts[i].money
            elseif data.accounts[i].name == 'bank' then
                bank = data.accounts[i].money
            end
        end

        SendNUIMessage({
            show = true;
            playerid = id;
            health = GetEntityHealth(ped) - 100; 
            armor = GetPedArmour(ped);
            rotation = GetGameplayCamRot().z;
            players = playersCount;
            stamina = 100 - GetPlayerSprintStaminaRemaining(PlayerId());
            voice = NetworkIsPlayerTalking(PlayerId());
            food = food;
            oxigen = GetPlayerUnderwaterTimeRemaining(PlayerId())*10;
            showOxigen = IsPedSwimming(ped);
            thirst = agua;
            showmoney = true;
            money = money;
            maxplayers = Config.MaxPlayers;
            bank = bank;
            uid = UID;
        })

        if IsPedArmed(ped, 7) then
            _sleep = 500
            local weapon = GetSelectedPedWeapon(ped)
            local ammoTotal = GetAmmoInPedWeapon(ped,weapon)
            local bool,ammoClip = GetAmmoInClip(ped,weapon)
            local ammoRemaining = math.floor(ammoTotal - ammoClip)
            for k,v in pairs(WeaponList) do 
                if weapon == v.hash then 
                    SendNUIMessage({
                        showweapon = true;
                        arma = v.name;
                        cargada = ammoClip;
                        resta = ammoRemaining;
                    })
                end
            end
        else
            SendNUIMessage({
                showweapon = false;
            })
            _sleep = 1000
        end

        if IsPedInAnyVehicle(ped) then
            _sleep = 200
            local vehiculo = GetVehiclePedIsUsing(ped)
            local velo = (GetEntitySpeed(vehiculo)* 3.6)
            local gaso = GetVehicleFuelLevel(vehiculo)
            local coche = IsPedSittingInAnyVehicle(ped)
            local gear = GetVehicleCurrentGear(vehiculo)
            
            SendNUIMessage({
                coche = coche;
                vel = velo; 
                gasolina = gaso;
                gear = gear;
                cinturon = cinturon;
                bateria = bateria;
                s1 = streetName;
                s2 = zoneLabel;
            })
        else
            _sleep = 1000
            SendNUIMessage({
                coche = false;
            })
        end
    else
        SendNUIMessage({
            show = false;
        })
    end

        Citizen.Wait(_sleep)
    end
end)


TriggerServerEvent('Roda_GetUID:Server')

Citizen.CreateThread(
    function()
        while true do
            Citizen.Wait(Config.StatusUpdateInterval)
            GetStatus(
                    function(data)
                    food = data[1]
                    agua = data[2]
            end)
        end
end)

end)

elseif GetResourceState("qb-core") == "started" then 

 QBCore = exports["qb-core"]:GetCoreObject()
 local isLoggedIn = false

-- Events

RegisterNetEvent('hud:client:UpdateNeeds') -- Triggered in qb-core
AddEventHandler('hud:client:UpdateNeeds', function(newHunger, newThirst)
    hunger = newHunger
    thirst = newThirst
end)

RegisterNetEvent('QBCore:Client:OnPlayerUnload')
AddEventHandler('QBCore:Client:OnPlayerUnload', function()
    isLoggedIn = false
end)

RegisterNetEvent('QBCore:Client:OnPlayerLoaded')
AddEventHandler('QBCore:Client:OnPlayerLoaded', function()
    TriggerServerEvent('Roda_GetUID:Server')
    isLoggedIn = true
end)

    Citizen.CreateThread(function ()
        while true do 
        if mostrar and not IsPauseMenuActive() and isLoggedIn  then 
            _sleep = 2000
            ped = PlayerPedId()
            id = GetPlayerServerId(PlayerId())
            position = GetEntityCoords(ped)
            streetName = GetStreetNameFromHashKey(GetStreetNameAtCoord(position.x, position.y, position.z))
            zone = GetNameOfZone(position.x, position.y, position.z)
            zoneLabel = GetLabelText(zone)
            local Player = QBCore.Functions.GetPlayerData()    
            SendNUIMessage({
                show = true;
                playerid = id;
                health = GetEntityHealth(ped) - 100; 
                armor = GetPedArmour(ped);
                rotation = GetGameplayCamRot().z;
                players = playersCount;
                stamina = 100 - GetPlayerSprintStaminaRemaining(PlayerId());
                voice = NetworkIsPlayerTalking(PlayerId());
                food = hunger;
                oxigen = GetPlayerUnderwaterTimeRemaining(PlayerId())*10;
                showOxigen = IsPedSwimming(ped);
                thirst = thirst;
                showmoney = true;
                maxplayers = Config.MaxPlayers;
                money =  Player.money['cash'];
                bank = Player.money['bank'];
                uid = UID;
            })
    
            if IsPedArmed(ped, 7) then
                _sleep = 500
                local weapon = GetSelectedPedWeapon(ped)
                local ammoTotal = GetAmmoInPedWeapon(ped,weapon)
                local bool,ammoClip = GetAmmoInClip(ped,weapon)
                local ammoRemaining = math.floor(ammoTotal - ammoClip)
                for k,v in pairs(WeaponList) do 
                    if weapon == v.hash then 
                        SendNUIMessage({
                            showweapon = true;
                            arma = v.name;
                            cargada = ammoClip;
                            resta = ammoRemaining;
                        })
                    end
                end
            else
                SendNUIMessage({
                    showweapon = false;
                })
                _sleep = 1000
            end
    
            if IsPedInAnyVehicle(ped) then
                _sleep = 200
                local vehiculo = GetVehiclePedIsUsing(ped)
                local velo = (GetEntitySpeed(vehiculo)* 3.6)
                local gaso = GetVehicleFuelLevel(vehiculo)
                local coche = IsPedSittingInAnyVehicle(ped)
                local gear = GetVehicleCurrentGear(vehiculo)
                
                SendNUIMessage({
                    coche = coche;
                    vel = velo; 
                    gasolina = gaso;
                    gear = gear;
                    cinturon = cinturon;
                    bateria = bateria;
                    s1 = streetName;
                    s2 = zoneLabel;
                })
            else
                _sleep = 1000
                SendNUIMessage({
                    coche = false;
                })
            end
        else
            SendNUIMessage({
                show = false;
            })
        end
    
            Citizen.Wait(_sleep)
        end
    end)
    
else
    print('The server owners has another name in his core, use real core like es_extended or qb-core.')
end

RegisterNetEvent('getActivePlayer')
AddEventHandler('getActivePlayer', function(players)
	playersCount = players
end)



function EngineControl()
    local veh = GetVehiclePedIsIn(PlayerPedId(), false)
    if veh ~= nil and veh ~= 0 and GetPedInVehicleSeat(veh, 0) then
       if GetIsVehicleEngineRunning(veh) then
            SetVehicleEngineOn(veh, false, false, true)
            bateria = false
       else
            SetVehicleEngineOn(veh, true, false, true)
            bateria = true
       end
    end
end

--[[
██████  ██████  ███    ███ ███    ███  █████  ███    ██ ██████  ███████ 
██      ██    ██ ████  ████ ████  ████ ██   ██ ████   ██ ██   ██ ██      
██      ██    ██ ██ ████ ██ ██ ████ ██ ███████ ██ ██  ██ ██   ██ ███████ 
██      ██    ██ ██  ██  ██ ██  ██  ██ ██   ██ ██  ██ ██ ██   ██      ██ 
 ██████  ██████  ██      ██ ██      ██ ██   ██ ██   ████ ██████  ███████ 
                                                                         
                                                                         
-- ]]


RegisterCommand(Config.BeltCommand, function ()
    local jugador = PlayerPedId()
    if IsPedInAnyVehicle(jugador) then
        if cinturon then 
            cinturon = false
            Cinturon(jugador)
        else
            cinturon = true
            Cinturon(jugador)
        end
    end
end)


RegisterCommand(Config.CommandHud, function ()
    if mostrar then 
         mostrar = false
         DisplayRadar(false)
    else 
        mostrar = true
        DisplayRadar(true)
    end
end)

RegisterCommand(Config.BatteryCommand, function ()
    EngineControl()
end)

if Config.UseBeltKey then 
    RegisterKeyMapping(Config.BeltCommand, 'Car Belt', 'keyboard', Config.BeltKey)
end
  

if Config.UseBatteryKey then 
    RegisterKeyMapping(Config.BatteryCommand, 'Turn ON/OFF the car', 'keyboard', Config.BatteryKey)
end
  

if Config.UseHudKey then 
    RegisterKeyMapping(Config.CommandHud, 'Show/Hide the HUD', 'keyboard', Config.HudKey)
end

RegisterNetEvent('ModernHud:RadioOn', function (toggle)
    print(toggle)
    SendNUIMessage({
        radioon = toggle;
    })
end)

RegisterCommand(Config.CommandDesign, function ()
    SetNuiFocus(true, true)
    SendNUIMessage({
        font = true;
    })
end)

RegisterNUICallback("exit" , function(data, cb)
    SetNuiFocus(false, false)
    SendNUIMessage({
        font = false;
    })
end)


RegisterNUICallback("real" , function(data, cb)
    SetNuiFocus(false, false)
    SendNUIMessage({
        hudreal = true;
    })
end)


RegisterNUICallback("animado" , function(data, cb)
    SetNuiFocus(false, false)
    SendNUIMessage({
        hudfalse = true;
    })
end)