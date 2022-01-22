
if Config.UseRodaUID then 

    AddEventHandler("playerConnecting", function(name, setReason, deferrals)
        local player = source
        local identifier = GetIdentifier(player, Config.Identifier)
        local randomuid = math.random(0,99999)
        local uid = randomuid
        local realuid 
        local result
        if Config.Database == 'mysql' then 
            result = MySQL.Sync.fetchAll("SELECT * FROM roda_modernhud WHERE license = @id", {['@id'] = identifier})
        elseif Config.Database == 'oxmysql' then 
            result = exports.oxmysql:fetchSync("SELECT * FROM roda_modernhud WHERE license = @id", {['@id'] = identifier})
        elseif Config.Database == 'ghmattimysql' then 
            result = exports.ghmattimysql.executeSync("SELECT * FROM roda_modernhud WHERE license = @id", {['@id'] = identifier})
        else
            print('Check your Config.Lua')
        end
    
    
        if result[1] == nil  then 
    
            if Config.Database == 'mysql' then 
                resultado = MySQL.Sync.fetchAll("SELECT * FROM roda_modernhud WHERE UID = @id", {['@id'] = uid})
            elseif Config.Database == 'oxmysql' then 
                resultado = exports.oxmysql:fetchSync("SELECT * FROM roda_modernhud WHERE UID = @id", {['@id'] = uid})
            elseif Config.Database == 'ghmattimysql' then 
                resultado = exports.ghmattimysql.executeSync("SELECT * FROM roda_modernhud WHERE UID = @id", {['@id'] = uid})
            else
                print('Check your Config.Lua')
            end
    
            if resultado[1] == nil then 
                if Config.Database== 'mysql' then 
                    MySQL.Async.execute('INSERT INTO roda_modernhud (`UID`, `license`) VALUES (@uid, @license)', {['@uid'] = uid, ['@license'] = identifier})
    
                elseif Config.Database== 'oxmysql' then 
                    exports.oxmysql:execute('INSERT INTO roda_modernhud (`UID`, `license`) VALUES (@uid, @license)', {['@uid'] = uid, ['@license'] = identifier})
    
                elseif Config.Database== 'ghmattimysql' then 
                    exports.ghmattimysql.execute('INSERT INTO roda_modernhud (`UID`, `license`) VALUES (@uid, @license)', {['@uid'] = uid, ['@license'] = identifier})
    
                else
                    print('Check your Config.Lua')
                end  
            else
                uid = uid + math.random(0,6564)
                if Config.Database== 'mysql' then 
                    MySQL.Async.execute('INSERT INTO roda_modernhud (`UID`, `license`) VALUES (@uid, @license)', {['@uid'] = uid, ['@license'] = identifier})
    
                elseif Config.Database== 'oxmysql' then 
                    exports.oxmysql:execute('INSERT INTO roda_modernhud (`UID`, `license`) VALUES (@uid, @license)', {['@uid'] = uid, ['@license'] = identifier})
    
                elseif Config.Database== 'ghmattimysql' then 
                    exports.ghmattimysql.execute('INSERT INTO roda_modernhud (`UID`, `license`) VALUES (@uid, @license)', {['@uid'] = uid, ['@license'] = identifier})
    
                else
                    print('Check your Config.Lua')
                end  
            end
        end
    end)
    
    
    RegisterNetEvent('Roda_GetUID:Server')
    AddEventHandler('Roda_GetUID:Server', function()
        local src = source
        local UID = getUID(src)
        TriggerClientEvent('Roda_ModernHud:SetUID', src, UID)
    end)
end
