ESX = nil

TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)

--WAREHOUSE

ESX = nil

TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)

RegisterServerEvent('warehouse:pistol')
AddEventHandler('warehouse:pistol', function()
    local xPlayer = ESX.GetPlayerFromId(source)
    local moneyCheck = xPlayer.getMoney()

    if moneyCheck >= 500 then
        xPlayer.addInventoryItem('yPistol', 1)
        xPlayer.removeMoney(500)
        TriggerClientEvent('warehouse:weaponbuyingComplete', source)
    else
        TriggerClientEvent('mythic_notify:client:SendAlert', source, { type = 'error', text = 'Yeterli paran yok.' })
    end

end)

RegisterServerEvent('warehouse:microsmg')
AddEventHandler('warehouse:microsmg', function()
    local xPlayer = ESX.GetPlayerFromId(source)
    local moneyCheck = xPlayer.getMoney()

    if moneyCheck >= 1500 then
        xPlayer.addInventoryItem('yMicroSMG', 1)
        xPlayer.removeMoney(1500)
        TriggerClientEvent('warehouse:weaponbuyingComplete', source)
    else
        TriggerClientEvent('mythic_notify:client:SendAlert', source, { type = 'error', text = 'Yeterli paran yok.' })
    end

end)

RegisterServerEvent('warehouse:smg')
AddEventHandler('warehouse:smg', function()
    local xPlayer = ESX.GetPlayerFromId(source)
    local moneyCheck = xPlayer.getMoney()

    if moneyCheck >= 2500 then
        xPlayer.addInventoryItem('ySMG', 1)
        xPlayer.removeMoney(2500)
        TriggerClientEvent('warehouse:weaponbuyingComplete', source)
    else
        TriggerClientEvent('mythic_notify:client:SendAlert', source, { type = 'error', text = 'Yeterli paran yok.' })
    end

end)

RegisterServerEvent('warehouse:sellingWeapon')
AddEventHandler('warehouse:sellingWeapon', function()
    local xPlayer = ESX.GetPlayerFromId(source)
    local yPistolcheck = xPlayer.getInventoryItem('yPistol').count
    local yMicroSMGcheck = xPlayer.getInventoryItem('yMicroSMG').count
    local ySMGcheck = xPlayer.getInventoryItem('ySMG').count

    if yPistolcheck >= 1 then
        xPlayer.addMoney(2500)
        xPlayer.removeInventoryItem('yPistol', 1)
        TriggerClientEvent('mythic_notify:client:SendAlert', source, {type = 'success', text = 'Başarıyla 2500$ kazandın, pistol silahını teslim ederek.'})
    end

    if yMicroSMGcheck >= 1 then
        xPlayer.addMoney(4000)
        xPlayer.removeInventoryItem('yMicroSMG', 1)
        TriggerClientEvent('mythic_notify:client:SendAlert', source, {type = 'success', text = 'Başarıyla 4000$ kazandın, micro smg silahını teslim ederek.'})
    end

    if yMicroSMGcheck >= 1 then
        xPlayer.addMoney(7500)
        xPlayer.removeInventoryItem('ySMG', 1)
        TriggerClientEvent('mythic_notify:client:SendAlert', source, {type = 'success', text = 'Başarıyla 7500$ kazandın, smg silahını teslim ederek.'})
    end

end)

RegisterServerEvent('warehouse:giveMoney')
AddEventHandler('warehouse:giveMoney', function(money)
    local xPlayer = ESX.GetPlayerFromId(source)
    xPlayer.addMoney(money)
end)

ESX = nil

TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)

RegisterServerEvent('warehouse:pistol')
AddEventHandler('warehouse:pistol', function()
    local xPlayer = ESX.GetPlayerFromId(source)
    local moneyCheck = xPlayer.getMoney()

    if moneyCheck >= 500 then
        xPlayer.addInventoryItem('yPistol', 1)
        xPlayer.removeMoney(500)
        TriggerClientEvent('warehouse:weaponbuyingComplete', source)
    else
        TriggerClientEvent('mythic_notify:client:SendAlert', source, { type = 'error', text = 'Yeterli paran yok.' })
    end

end)

RegisterServerEvent('warehouse:microsmg')
AddEventHandler('warehouse:microsmg', function()
    local xPlayer = ESX.GetPlayerFromId(source)
    local moneyCheck = xPlayer.getMoney()

    if moneyCheck >= 1500 then
        xPlayer.addInventoryItem('yMicroSMG', 1)
        xPlayer.removeMoney(1500)
        TriggerClientEvent('warehouse:weaponbuyingComplete', source)
    else
        TriggerClientEvent('mythic_notify:client:SendAlert', source, { type = 'error', text = 'Yeterli paran yok.' })
    end

end)

RegisterServerEvent('warehouse:smg')
AddEventHandler('warehouse:smg', function()
    local xPlayer = ESX.GetPlayerFromId(source)
    local moneyCheck = xPlayer.getMoney()

    if moneyCheck >= 2500 then
        xPlayer.addInventoryItem('ySMG', 1)
        xPlayer.removeMoney(2500)
        TriggerClientEvent('warehouse:weaponbuyingComplete', source)
    else
        TriggerClientEvent('mythic_notify:client:SendAlert', source, { type = 'error', text = 'Yeterli paran yok.' })
    end

end)

RegisterServerEvent('warehouse:sellingWeapon')
AddEventHandler('warehouse:sellingWeapon', function()
    local xPlayer = ESX.GetPlayerFromId(source)
    local yPistolcheck = xPlayer.getInventoryItem('yPistol').count
    local yMicroSMGcheck = xPlayer.getInventoryItem('yMicroSMG').count
    local ySMGcheck = xPlayer.getInventoryItem('ySMG').count

    if yPistolcheck >= 1 then
        xPlayer.addMoney(2500)
        xPlayer.removeInventoryItem('yPistol', 1)
        TriggerClientEvent('mythic_notify:client:SendAlert', source, {type = 'success', text = 'Başarıyla 2500$ kazandın, pistol silahını teslim ederek.'})
    end

    if yMicroSMGcheck >= 1 then
        xPlayer.addMoney(4000)
        xPlayer.removeInventoryItem('yMicroSMG', 1)
        TriggerClientEvent('mythic_notify:client:SendAlert', source, {type = 'success', text = 'Başarıyla 4000$ kazandın, micro smg silahını teslim ederek.'})
    end

    if yMicroSMGcheck >= 1 then
        xPlayer.addMoney(7500)
        xPlayer.removeInventoryItem('ySMG', 1)
        TriggerClientEvent('mythic_notify:client:SendAlert', source, {type = 'success', text = 'Başarıyla 7500$ kazandın, smg silahını teslim ederek.'})
    end

end)

RegisterServerEvent('warehouse:giveItem')
AddEventHandler('warehouse:giveItem', function(item)
    local xPlayer = ESX.GetPlayerFromId(source)
    xPlayer.addInventoryItem(item, 1)
end)

RegisterServerEvent('warehouse:itembuyingChallenge')
AddEventHandler('warehouse:itembuyingChallenge', function()
    local item = "phone"
    local xPlayer = ESX.GetPlayerFromId(source)
    local itemCheck = xPlayer.getInventoryItem(item).count

    if itemCheck >= 1 then
        xPlayer.addMoney(7500)
        xPlayer.removeInventoryItem(item, 1)
        TriggerClientEvent('mythic_notify:client:SendAlert', source, {type = 'success', text = 'Başarıyla eşyayı teslim ettin ve 7500$ kazandın.'})
    else
        TriggerClientEvent('mythic_notify:client:SendAlert', source, {type = 'error', text = 'Yanlış eşyayı getirdin ve görev iptal edildi!'})
    end

end)


---- blackmarket

ESX.RegisterUsableItem('whtablet', function(source)
	local xPlayer = ESX.GetPlayerFromId(source)
    TriggerClientEvent('client_opentablet', soruce)
end)


RegisterServerEvent('crateDrop:methal')
AddEventHandler('crateDrop:methal', function (i)
    local xPlayer = ESX.GetPlayerFromId(source)
    print(f)
    xPlayer.addInventoryItem(i, 1)
    TriggerClientEvent('mythic_notify:client:SendAlert', source, {type = 'error', text = i.. ' aldın'})
end)


ESX.RegisterServerCallback('itemcheck', function (source, cb, i, f)
    local xPlayer = ESX.GetPlayerFromId(source)
    local durum = false
    print(f)
    print(xPlayer.getMoney())
    if xPlayer.getMoney() >= f then
        TriggerClientEvent('mythic_notify:client:SendAlert', source, {type = 'error', text = 'Satın Alındı'})
        durum = true
        xPlayer.removeMoney(f)
    else
        TriggerClientEvent('mythic_notify:client:SendAlert', source, {type = 'error', text = 'Yetersiz Miktar.'})
        durum = false
    end
 cb(durum, i, f)
end)