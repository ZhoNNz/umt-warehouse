ESX = nil
TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
local instances = {}
local houses = {}

RegisterServerEvent('umt-warehouse:enterHouse')
AddEventHandler('umt-warehouse:enterHouse', function(id)
    local src = source
    local xPlayer = ESX.GetPlayerFromId(src)
    MySQL.Async.fetchAll("SELECT * FROM users WHERE identifier = @identifier", {['@identifier'] = xPlayer.identifier}, function(result)
        local house = json.decode(result[1].house)
        local furniture = json.decode(result[1]['bought_furniture'])
        if house.houseId == id then
            for k, v in pairs(Config.HouseSpawns) do

                if not v['taken'] then
                        TriggerClientEvent('umt-warehouse:spawnHouse', xPlayer.source, v['coords'], furniture)
                        instances[src] = {['id'] = id, ['owner'] = src, ['coords'] = v['coords'], ['housespawn'] = k, ['players'] = {}}
                        instances[src]['players'][src] = src
                        houses[id] = src
                        v['taken'] = true
                        return
                    end
                end
            else
            print(('Problem var'):format(GetCurrentResourceName(), xPlayer.identifier, id, id))
        end
    end)
end)

RegisterServerEvent('umt-warehouse:changeHousePassword')
AddEventHandler('umt-warehouse:changeHousePassword', function(houseid, password)

    MySQL.Async.execute("UPDATE bought_houses SET housepassword=@password WHERE houseid=@houseid",
    {['@password'] = password,
     ['@houseid'] = houseid})
     print(houseid,'burasi ev')
     print(password, 'burasi password')
end)


ESX.RegisterServerCallback('umt-warehouse:getHousePassword', function(source, cb, houseid) 

    MySQL.Async.fetchAll('SELECT housepassword FROM bought_houses WHERE houseid=@houseid', 
        {['@houseid'] = houseid},
            function(result)
                if result[1] ~= nil then
                    print(result[1].housepassword)

                    
                cb(tonumber(result[1].housepassword))
                 end
            end)
    end)

-- ESX.RegisterServerCallback('umt-warehouse:getHousePassword', function(source, password)
    
--     -- TO DO GET PASSWORD
--     MySQL.Async.fetchAll("SELECT housepassword FROM bought_houses WHERE housepassword=@password",
--     {['@password'] = password})
--     print(password, 'callback paswordu')
-- end)
-- RegisterServerEvent('umt-warehouse:getHousePassword')
-- AddEventHandler('umt-warehouse:getHousePassword', function( houseid, password)

--     MySQL.Async.fetchAll('SELECT * FROM bought_houses WHERE housepassword=@password AND houseid=@houseid', 
--     {['@password'] = password,
--     ['@houseid'] = houseid})

--         print(houseid, password)
-- end)



RegisterServerEvent('umt-warehouse:leaveHouse')
AddEventHandler('umt-warehouse:leaveHouse', function(house)
    local src = source
    if instances[houses[house]]['players'][src] then
        local oldPlayers = instances[houses[house]]['players']
        local newPlayers = {}
        for k, v in pairs(oldPlayers) do
            if v ~= src then
                newPlayers[k] = v
            end
        end
        instances[houses[house]]['players'] = newPlayers
    end
end)

RegisterServerEvent('umt-warehouse:deleteInstance')
AddEventHandler('umt-warehouse:deleteInstance', function()
    local src = source
    if instances[src] then
        Config.HouseSpawns[instances[src]['housespawn']]['taken'] = false
        for k, v in pairs(instances[src]['players']) do
            TriggerClientEvent('umt-warehouse:leaveHouse', v, instances[src]['id'])
        end
        instances[src] = {}
    end
end)

RegisterServerEvent('umt-warehouse:letIn')
AddEventHandler('umt-warehouse:letIn', function(plr, storage)
    local src = source
    local xPlayer = ESX.GetPlayerFromId(src)
    if instances[src] then
        if not instances[src]['players'][plr] then 
            instances[src]['players'][plr] = plr

            local spawnpos = instances[src]['housecoords']
            local furniture = instances[src]['furniture']
            TriggerClientEvent('umt-warehouse:knockAccept', plr, instances[src]['coords'], instances[src]['id'], storage, spawnpos, furniture, src)
        end
    end
end)


RegisterServerEvent('umt-warehouse:setInstanceCoords')
AddEventHandler('umt-warehouse:setInstanceCoords', function(coords, housecoords, prop, placedfurniture)
    local src = source
    if instances[src] then
        instances[src]['coords'] = coords
        instances[src]['housecoords'] = housecoords
        instances[src]['furniture'] = placedfurniture
    end
end)

RegisterServerEvent('umt-warehouse:exitHouse')
AddEventHandler('umt-warehouse:exitHouse', function(id)
    local src = source
    if instances[src] then
        for k, v in pairs(instances['players']) do
            TriggerClientEvent('umt-warehouse:exitHouse', v, id)
            table.remove(instances, src)
            table.remove(houses, id)
        end
    else
        for k, v in pairs(instances) do
            if v['players'][src] then
                table.remove(v['players'], src)
            end
        end
    end
end)

RegisterServerEvent('umt-warehouse:buyHouse')
AddEventHandler('umt-warehouse:buyHouse', function(id)
    local src = source
    local xPlayer = ESX.GetPlayerFromId(src)
    MySQL.Async.fetchAll("SELECT * FROM users WHERE identifier = @identifier", {['@identifier'] = xPlayer.identifier}, function(result)
        local house = json.decode(result[1].house)
        if house.houseId == 0 then
            MySQL.Async.fetchAll("SELECT * FROM bought_houses WHERE houseid=@houseid", {['@houseid'] = id}, function(result)
                local newHouse = ('{"owns":false,"furniture":[],"houseId":%s}'):format(id)
                if not result[1] then
                    if xPlayer.getAccount('bank').money >= Config.Houses[id]['price'] then
                        xPlayer.removeAccountMoney('bank', Config.Houses[id]['price'])
                        MySQL.Async.execute("UPDATE users SET house=@house WHERE identifier=@identifier", {['@identifier'] = xPlayer.identifier, ['@house'] = newHouse}) 
                        MySQL.Sync.execute("INSERT INTO bought_houses (houseid) VALUES (@houseid)", {['houseid'] = id})
                        Citizen.Wait(60) 
                        -- TriggerClientEvent('evsifresi', Config.Houses[id])
                    else
                        if xPlayer.getMoney() >= Config.Houses[id]['price'] then
                            xPlayer.removeMoney(Config.Houses[id]['price'])
                            MySQL.Sync.execute("INSERT INTO bought_houses (houseid) VALUES (@houseid)", {['houseid'] = id})
                            MySQL.Async.execute("UPDATE users SET house=@house WHERE identifier=@identifier", {['@identifier'] = xPlayer.identifier, ['@house'] = newHouse})
                            Citizen.Wait(60) 
                            -- TriggerClientEvent('evsifresi', Config.Houses[id])
                        else
                            TriggerClientEvent('notification', src, 'Paran yok', 1)
                        end
                    end
                end
            end)
        end
    end)
    Wait(600)
    TriggerClientEvent('umt-warehouse:reloadHouses', -1)
end)

RegisterServerEvent('umt-warehouse:server:viewHouse')
AddEventHandler('umt-warehouse:server:viewHouse', function(house)
	local src     		= source
	local pData 		= ESX.GetPlayerFromId(src)

	local houseprice   	= Config.Houses[house.houseId]['price']
	local brokerfee 	= (houseprice / 100 * 5)
	local bankfee 		= (houseprice / 100 * 10) 
	local taxes 		= (houseprice / 100 * 6)

	TriggerClientEvent('umt-warehouse:client:viewHouse', src, houseprice, brokerfee, bankfee, taxes, firstname, lastname)
end)

function getIdentity(source)
	local identifier = GetPlayerIdentifiers(source)[1]
	local result = MySQL.Sync.fetchAll("SELECT * FROM users WHERE identifier = @identifier", {['@identifier'] = identifier})
	if result[1] ~= nil then
		local identity = result[1]

		return {
			identifier = identity['identifier'],
			firstname = identity['firstname'],
			lastname = identity['lastname'],
			dateofbirth = identity['dateofbirth'],
			sex = identity['sex'],
			height = identity['height']
			
		}
	else
		return nil
	end
end



RegisterServerEvent('umt-warehouse:giveWarehouse')
AddEventHandler('umt-warehouse:giveWarehouse', function(id)
    local src = source
    local xPlayer = ESX.GetPlayerFromId(src)

    MySQL.Async.fetchAll("SELECT * FROM users WHERE identifier = @identifier", {['@identifier'] = xPlayer.identifier}, function(result)
        local house = json.decode(result[1].house)
        if house.houseId == 0 then
            MySQL.Async.fetchAll("SELECT * FROM bought_houses WHERE houseid=@houseid", {['@houseid'] = id}, function(result)
                local newHouse = ('{"owns":false,"furniture":[],"houseId":%s}'):format(id)
                if not result[1] then
                    MySQL.Async.execute("UPDATE users SET house=@house WHERE identifier=@identifier", {['@identifier'] = xPlayer.identifier, ['@house'] = newHouse}) 
                    MySQL.Sync.execute("INSERT INTO bought_houses (houseid) VALUES (@houseid)", {['houseid'] = id})
                end
            end)
        end
    end)
    Wait(600)
    TriggerClientEvent('umt-warehouse:reloadHouses', -1)
end)


RegisterServerEvent('umt-warehouse:sellHouse')
AddEventHandler('umt-warehouse:sellHouse', function()
    local src = source
    local xPlayer = ESX.GetPlayerFromId(src)
    MySQL.Async.fetchAll("SELECT * FROM users WHERE identifier = @identifier", {['@identifier'] = xPlayer.identifier}, function(result)
        local house = json.decode(result[1].house)
        if Config.Houses[house.houseId]['price'] then
            xPlayer.addMoney(Config.Houses[house.houseId]['price'] * (Config.SellPercentage/100))
            TriggerClientEvent('notification', 'Evini sattın ' .. math.floor(Config.Houses[house.houseId]['price'] * (Config.SellPercentage/100)), 1)
            -- TriggerClientEvent('esx:showNotification', xPlayer.source, (Strings['Sold_House']):format(math.floor(Config.Houses[house.houseId]['price'] * (Config.SellPercentage/100))))
            
            MySQL.Async.execute("UPDATE users SET house=@house WHERE identifier=@identifier", {['@identifier'] = xPlayer.identifier, ['@house'] = '{"owns":false,"furniture":[],"houseId":0}'}) 
            MySQL.Async.execute("DELETE FROM bought_houses WHERE houseid=@houseid", {['@houseid'] = house.houseId}) 
        end
    end)
    Wait(600)
    TriggerClientEvent('umt-warehouse:reloadHouses', -1)
end)

RegisterServerEvent('umt-warehouse:getOwned')
AddEventHandler('umt-warehouse:getOwned', function()
    local src = source
    local xPlayer = ESX.GetPlayerFromId(src)
    MySQL.Async.fetchAll("SELECT * FROM users WHERE identifier = @identifier", {['@identifier'] = xPlayer.identifier}, function(result)
        local house = json.decode(result[1].house)
        MySQL.Async.fetchAll("SELECT * FROM bought_houses", {}, function(result)
            TriggerClientEvent('umt-warehouse:setHouse', xPlayer.source, house, result)
        end)
    end)
end)

RegisterServerEvent('umt-warehouse:furnish')
AddEventHandler('umt-warehouse:furnish', function(house, furniture)
    local src = source
    local xPlayer = ESX.GetPlayerFromId(src)
    MySQL.Async.execute("UPDATE users SET house=@house WHERE identifier=@identifier", {['@identifier'] = xPlayer.identifier, ['@house'] = json.encode(house)}) 
    MySQL.Async.execute("UPDATE users SET bought_furniture=@bought_furniture WHERE identifier=@identifier", {['@identifier'] = xPlayer.identifier, ['@bought_furniture'] = json.encode(furniture)}) 
end)

ESX.RegisterServerCallback('umt-warehouse:hasGuests', function(source, cb)
    local hasGuest = false
    for k, v in pairs(instances[source]['players']) do
        local playerlist = GetPlayers()
        for id, src in pairs(playerlist) do
            if v ~= source and v == tonumber(src) then
                hasGuest = true
                break
            end
        end
    end
    cb(hasGuest)
end)

ESX.RegisterServerCallback('umt-warehouse:hostOnline', function(source, cb, host)
    local online = false
    if instances[host] then
        local playerlist = GetPlayers()
        for id, src in pairs(playerlist) do
            if host == tonumber(src) then
                online = true
                break
            end
        end
        if not online then
            Config.HouseSpawns[instances[host]['housespawn']]['taken'] = false
            instances[host] = {}
        end
    end
    cb(online)
end)

ESX.RegisterServerCallback('umt-warehouse:getInventory', function(source, cb)
    local xPlayer = ESX.GetPlayerFromId(source)
    
    cb({['items'] = xPlayer.inventory, ['weapons'] = xPlayer.getLoadout()})
end)

ESX.RegisterServerCallback('umt-warehouse:getHouseInv', function(source, cb, owner)
	local xPlayer = ESX.GetPlayerFromId(source)
    local items, weapons = {}, {}
    
    if houses[owner] then
        if instances[houses[owner]] then
            local identifier = ESX.GetPlayerFromId(houses[owner])['identifier']

            TriggerEvent('esx_addoninventory:getInventory', 'housing', identifier, function(inventory)
                items = inventory.items
            end)

            TriggerEvent('esx_datastore:getDataStore', 'housing', identifier, function(storage)
                weapons = storage.get('weapons') or {}
            end)

            cb({['items'] = items, ['weapons'] = weapons})
        end
    end
end)

RegisterServerEvent('umt-warehouse:withdrawItem')
AddEventHandler('umt-warehouse:withdrawItem', function(type, item, amount, owner)
	local src = source
    local xPlayer = ESX.GetPlayerFromId(src)

    if houses[owner] then
        if instances[houses[owner]] then
            local identifier = ESX.GetPlayerFromId(houses[owner])['identifier']
            if type == 'item' then

                TriggerEvent('esx_addoninventory:getInventory', 'housing', identifier, function(inventory)
                    if inventory.getItem(item)['count'] >= amount then
                        -- TriggerClientEvent('esx:showNotification', src, (Strings['You_Withdrew']):format(amount, inventory.getItem(item)['label']))
                        TriggerClientEvent('notification', 'Eşyayı koydun ' .. format(amount, inventory.getItem(item)['label'], 1))

                        xPlayer.addInventoryItem(item, amount)
                        inventory.removeItem(item, amount)
                    else
                        TriggerClientEvent('esx:showNotification', src, Strings['Not_Enough_House'])
                    end
                end)

            elseif type == 'weapon' then

                TriggerEvent('esx_datastore:getDataStore', 'housing', identifier, function(weapons)
                    local loadout = weapons.get('weapons') or {}

                    for i = 1, #loadout do
                        if loadout[i]['name'] == item then
                            
                            table.remove(loadout, i)
                            weapons.set('weapons', loadout)
                            xPlayer.addWeapon(item, amount)

                            break
                        end
                    end
                end)
            end
        end

    end
    
end)

RegisterServerEvent('umt-warehouse:storeItem')
AddEventHandler('umt-warehouse:storeItem', function(type, item, amount, owner)
	local src = source
	local xPlayer = ESX.GetPlayerFromId(src)

    if houses[owner] then
        if instances[houses[owner]] then
            local identifier = ESX.GetPlayerFromId(houses[owner])['identifier']
            if type == 'item' then

                if xPlayer.getInventoryItem(item)['count'] >= amount then
                    TriggerEvent('esx_addoninventory:getInventory', 'housing', identifier, function(inventory)
                        xPlayer.removeInventoryItem(item, amount)
                        inventory.addItem(item, amount)
                        TriggerClientEvent('esx:showNotification', src, (Strings['You_Stored']):format(amount, inventory.getItem(item)['label']))
                    end)
                else
                    TriggerClientEvent('esx:showNotification', src, Strings['Not_Enough'])
                end

            elseif type == 'weapon' then

                local loadout, hasweapon = xPlayer.getLoadout(), false
                for k, v in pairs(loadout) do
                    if v['name'] == item then
                        hasweapon = true
                        break
                    end
                end

                if hasweapon then
                    TriggerEvent('esx_datastore:getDataStore', 'housing', identifier, function(weapons)
                        local storage = weapons.get('weapons') or {}

                        table.insert(storage, {name = item, ammo = amount})

                        weapons.set('weapons', storage)
                        xPlayer.removeWeapon(item)
                    end)
                else
                    TriggerClientEvent('esx:showNotification', src, Strings['No_Weapon'])
                end
            end
        end

	end
end)