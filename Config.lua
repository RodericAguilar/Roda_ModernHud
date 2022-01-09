Config = {}

Config.MaxPlayers = 32

Config.CommandDesign = 'changedesign'

Config.BeltCommand = 'cinturon' -- command for seat belt
Config.UseBeltKey = true -- if true put key down
Config.BeltKey = 'K' -- key from : https://docs.fivem.net/docs/game-references/input-mapper-parameter-ids/keyboard/

Config.BatteryCommand = 'motor'
Config.UseBatteryKey = true
Config.BatteryKey = 'F4'


Config.CommandHud = 'hud'
Config.UseHudKey = true
Config.HudKey = 'CAPITAL'

---This is only for UID, if u have your own system you can put this in false and use your own system in Server/UID.lua
Config.UseRodaUID = true -- If false u need to implement your system, if true insert the Sql.sql
Config.Database = 'mysql' -- mysql, ghmattimysql, oxmysql  
Config.Identifier = 'license' -- discord, license or steam


-- This is for thirst and hunger of ESX.

Config.StatusUpdateInterval = 2000 -- Time it takes for status to update (lowering this value adds ms)

function GetStatus(cb)

    TriggerEvent("esx_status:getStatus", "hunger", function(h)
        TriggerEvent("esx_status:getStatus", "thirst", function(t)
            local hunger = h.getPercent()
            local thirst = t.getPercent()
            cb({hunger, thirst})
        end)
    end)

end
