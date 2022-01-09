function GetIdentifier(src, tipo)
	local src = src 
	local license
	if tipo == 'steam' then 
		for k,v in ipairs(GetPlayerIdentifiers(src)) do
			if string.match(v, 'steam') then
				license = v
				return license
			end
		end
	elseif tipo == 'license' then 
		for k,v in ipairs(GetPlayerIdentifiers(src)) do
			if string.match(v, 'license') then
				license = v
				return license
			end
		end
	elseif tipo == 'discord' then 
		for k,v in ipairs(GetPlayerIdentifiers(src)) do
			if string.match(v, 'discord') then
				license = v
				return license
			end
		end
	end
end


function getUID(src)
    local identifier = GetIdentifier(src, Config.Identifier)
    if Config.Database == 'mysql' then 
        result = MySQL.Sync.fetchAll("SELECT * FROM roda_modernhud WHERE license = @id", {['@id'] = identifier})
        return result[1].UID
    elseif Config.Database == 'oxmysql' then 
        result = exports.oxmysql:fetchSync("SELECT * FROM roda_modernhud WHERE license = @id", {['@id'] = identifier})
        return result[1].UID
    elseif Config.Database == 'ghmattimysql' then 
        result = exports.ghmattimysql.executeSync("SELECT * FROM roda_modernhud WHERE license = @id", {['@id'] = identifier})
        return result[1].UID
    else
        print('Check your Config.Lua')
    end
end