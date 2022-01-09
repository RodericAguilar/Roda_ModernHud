Citizen.CreateThread(function()
    while true do
        Citizen.Wait(6000) -- in MS
		TriggerClientEvent('getActivePlayer', -1, GetNumPlayerIndices())
    end
end)


-- if GetResourceState("es_extended") == "started" then

-- ESX = nil

-- TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)

-- ESX.RegisterServerCallback('Roda_ModernHud:getMoney', function(source, cb)
--     local source = source
--     while not ESX.GetPlayerFromId(source) do
--         Wait(200)
--     end
--     local xPlayer = ESX.GetPlayerFromId(source)
--     local UID = getUID(source)
--     local money = xPlayer.getAccount('money').money
--     local bank = xPlayer.getAccount('bank').money
--     cb(money, bank, UID)
-- end)

-- elseif GetCurrentResourceName("qb-core") == "started" then 
--     print('qbcore')
-- else
--     print('The server owners has another name in his core, use real core like es_extended or qb-core.')
-- end


