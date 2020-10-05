-- --------

-- --- TABLET KISMI

-- --------

-- ESX = nil

-- Citizen.CreateThread(function()
-- 	while ESX == nil do
-- 		TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
-- 		Citizen.Wait(0)
-- 	end
-- end)

-- local open = false
-- local warehouseActive = true
-- local weapontruefalse = false
-- local vehicletruefalse = false
-- local weaponbuyingtruefalse = false
-- local weaponsellingtruefalse = false
-- local weaponbuyingnpctruefalse = false
-- local vehiclesellingtruefalse = false
-- local itemchallengetruefalse = false
-- local itembuyingchallengetruefalse = false



-- function opentablet()
--     local ped = PlayerPedId()
--     open = true
--     SetNuiFocus(true, true)
--     SendNUIMessage({
--       action = "open"
--     })    
--     if IsPedInAnyVehicle(ped, true) then
--     else 
--         RequestAnimDict("amb@world_human_seat_wall_tablet@female@base")
--         FreezeEntityPosition(ped, true)
--         attachObject()
--         ClearPedTasksImmediately(ped)
--         TaskPlayAnim(ped, "amb@world_human_seat_wall_tablet@female@base", "base" ,8.0, -8.0, -1, 50, 0, true, true, true)
--     end
-- end

-- RegisterNUICallback('esc', function(data, cb) -- ESC ile laptobu kapatma
-- 	SetNuiFocus(false, false)
--     open = false
--     RequestAnimDict("amb@world_human_seat_wall_tablet@female@base")
--     StopAnimTask(GetPlayerPed(-1), "amb@world_human_seat_wall_tablet@female@base", "base" ,8.0, -8.0, -1, 50, 0, true, true, true)
--     DeleteEntity(tab)
--     FreezeEntityPosition(GetPlayerPed(-1), false)
-- end)



-- RegisterNUICallback('arabateslimat', function()

--     SetNuiFocus(false, false)
--     open = false
--     exports['mythic_notify']:SendAlert('error', 'Görev: Araç Teslimatı')
--     exports['mythic_notify']:SendAlert('inform', 'Bölge GPS\'e işaretlendi.')
--     SetNewWaypoint(Config.challengeCoords.vehiclechallengecar.coords)
--     vehicleChallenge()
--     warehouseActive = false
--     RequestAnimDict("amb@world_human_seat_wall_tablet@female@base")
--     StopAnimTask(GetPlayerPed(-1), "amb@world_human_seat_wall_tablet@female@base", "base" ,8.0, -8.0, -1, 50, 0, true, true, true)
--     DeleteEntity(tab)
--     FreezeEntityPosition(GetPlayerPed(-1), false)
-- end)

-- RegisterNUICallback('silahteslimat', function()
--     weapontruefalse = true
--     exports['mythic_notify']:SendAlert('error', 'Görev: Silah Teslimatı')
--     exports['mythic_notify']:SendAlert('inform', 'Bölge GPS\'e işaretlendi.')
--     SetNewWaypoint(Config.challengeCoords.weaponChallenge.coords)
--     warehouseActive = false
--     RequestAnimDict("amb@world_human_seat_wall_tablet@female@base")
--     StopAnimTask(GetPlayerPed(-1), "amb@world_human_seat_wall_tablet@female@base", "base" ,8.0, -8.0, -1, 50, 0, true, true, true)
--     DeleteEntity(tab)
--     FreezeEntityPosition(GetPlayerPed(-1), false)
-- end)

-- RegisterNUICallback('esyateslimat', function()
--     exports['mythic_notify']:SendAlert('error', 'Görev: Eşya Teslimatı')
--     exports['mythic_notify']:SendAlert('inform', 'Bölge GPS\'e işaretlendi.')
--     SetNewWaypoint(Config.challengeCoords.itemchallenge.coords)
--     menu.close()
--     itemchallengetruefalse = true
--     warehouseActive = false
--     RequestAnimDict("amb@world_human_seat_wall_tablet@female@base")
--     StopAnimTask(GetPlayerPed(-1), "amb@world_human_seat_wall_tablet@female@base", "base" ,8.0, -8.0, -1, 50, 0, true, true, true)
--     DeleteEntity(tab)
--     FreezeEntityPosition(GetPlayerPed(-1), false)
-- end)



-- function attachObject()
-- 	tab = CreateObject(GetHashKey("prop_cs_tablet"), 0, 0, 0, true, true, true)
-- 	AttachEntityToEntity(tab, GetPlayerPed(-1), GetPedBoneIndex(GetPlayerPed(-1), 57005), 0.17, 0.10, -0.13, 20.0, 180.0, 180.0, true, true, false, true, 1, true)
-- end



-- Citizen.CreateThread(function()
-- 	while true do
-- 		Citizen.Wait(0)

--         local coords = GetEntityCoords(PlayerPedId())
--         local weaponChallenge = GetDistanceBetweenCoords(coords, Config.challengeCoords.weaponChallenge.coords, true)
--         local weaponbuyingChallenge = GetDistanceBetweenCoords(coords, Config.challengeCoords.weaponbuyingChallenge.coords, true)
--         local lesterDistance = GetDistanceBetweenCoords(coords, Config.lesterCoords.lesterNPC.coords, true)
--         local vehiclecarChallenge = GetDistanceBetweenCoords(coords, Config.challengeCoords.vehiclechallengecar.coords, true)
--         local vehiclecarsellingChallenge = GetDistanceBetweenCoords(coords, Config.challengeCoords.vehiclesellingChallenge.coords, true)
--         local itemChallenge = GetDistanceBetweenCoords(coords, Config.challengeCoords.itemchallenge.coords, true)
--         local itembuyingChallenge = GetDistanceBetweenCoords(coords, Config.challengeCoords.itembuyingChallenge.coords, true)

--         -- Weapon Challenge
--         if weaponChallenge < 100.0 and weapontruefalse == true then
--             DrawMarker(2, Config.challengeCoords.weaponChallenge.coords, 0.0, 0.0, 0.0, 0.0, 0.0, 110.0, 0.55, 0.75, 0.25, 232, 126, 4, 255, false, false, 2, false, false, false, false)
--         end
        
--         if weaponChallenge < 1.5 and weapontruefalse == true then
--             ESX.ShowHelpNotification("Silahları almak için ~INPUT_PICKUP~ tuşuna basınız.")
--             weaponbuyingtruefalse = true
--         end

--         if IsControlJustPressed(1, 38) and weaponChallenge < 1.5 and weapontruefalse == true then
--             warehouseweaponChallenge()
--             weapontruefalse = false
--         end
--         -- Weapon Challenge

--         -- Weapon Buying Challenge
--         if weaponbuyingChallenge < 1.5 and weaponbuyingtruefalse == true then
--             ESX.ShowHelpNotification("Silahları teslim almak için ~INPUT_PICKUP~ tuşuna basınız.")
--         end

--         if IsControlJustPressed(1, 38) and weaponbuyingChallenge < 1.5 and weaponbuyingtruefalse == true then
--             warehousebuyingChallenge()
--         end
--         -- Weapon Buying Challenge

--         -- Weapon Selling Challenge
--         if weaponChallenge < 100.0 and weaponsellingtruefalse == true then
--             DrawMarker(2, Config.challengeCoords.weaponChallenge.coords, 0.0, 0.0, 0.0, 0.0, 0.0, 110.0, 0.55, 0.75, 0.25, 232, 126, 4, 255, false, false, 2, false, false, false, false)
--         end
        
--         if weaponChallenge < 1.5 and weaponsellingtruefalse == true then
--             ESX.ShowHelpNotification("Silahları teslim etmek için ~INPUT_PICKUP~ tuşuna basınız.")
--         end

--         if IsControlJustPressed(1, 38) and weaponChallenge < 1.5 and weaponsellingtruefalse == true then
--             weaponsellingtruefalse = false
--             warehouseActive = true
--             TriggerServerEvent('umt-warehouse:sellingWeapon', source)
--         end
--         -- Weapon Selling Challenge

--         -- Vehicle Challenge
--         if vehiclecarChallenge < 2.5 and vehicletruefalse == true then
--             ESX.ShowHelpNotification("Aracı almak için ~INPUT_ENTER~ tuşuna basınız.")
--         end

--         if IsControlJustPressed(1, 23) and vehiclecarChallenge < 2.5 and vehicletruefalse == true then
--             vehicletruefalse = false
--             exports['mythic_notify']:SendAlert('error', 'Görev: Aracı teslim et!')
--             exports['mythic_notify']:SendAlert('inform', 'Görev: Bölge GPS\'e tanımlandı.')
--             SetNewWaypoint(Config.challengeCoords.vehiclesellingChallenge.coords)
--         end
--         -- Vehicle Challenge

--         -- Vehicle Selling Challenge
--         if vehiclecarsellingChallenge < 100.0 and vehiclesellingtruefalse == true then
--             DrawMarker(2, Config.challengeCoords.vehiclesellingChallenge.coords, 0.0, 0.0, 0.0, 0.0, 0.0, 110.0, 0.55, 0.75, 0.25, 232, 126, 4, 255, false, false, 2, false, false, false, false)
--         end
        
--         if vehiclecarsellingChallenge < 1.5 and vehiclesellingtruefalse == true then
--             ESX.ShowHelpNotification("Aracı teslim etmek için ~INPUT_PICKUP~ tuşuna basınız.")
--         end

--         if IsControlJustPressed(1, 38) and vehiclecarsellingChallenge < 1.5 and vehiclesellingtruefalse == true then
--             vehiclesellingtruefalse = false
--             warehouseActive = true
--             vehiclesellingChallenge()
--         end
--         -- Vehicle Selling Challenge

--         -- İtem Selling Challenge
--         if itemChallenge < 100.0 and itemchallengetruefalse == true then
--             DrawMarker(2, Config.challengeCoords.itemchallenge.coords, 0.0, 0.0, 0.0, 0.0, 0.0, 110.0, 0.55, 0.75, 0.25, 232, 126, 4, 255, false, false, 2, false, false, false, false)
--         end
        
--         if itemChallenge < 1.5 and itemchallengetruefalse == true then
--             ESX.ShowHelpNotification("Eşyayı almak için ~INPUT_PICKUP~ tuşuna basınız.")
--         end

--         if IsControlJustPressed(1, 38) and itemChallenge < 1.5 and itemchallengetruefalse == true then
--             itemchallengetruefalse = false
--             itemsellingChallenge()
--         end
--         -- İtem Selling Challenge

--         -- İtem Buying Challenge
--         if itembuyingChallenge < 2.5 and itembuyingchallengetruefalse == true then
--             ESX.ShowHelpNotification("Eşyayı teslim etmek için ~INPUT_PICKUP~ tuşuna basınız.")
--         end

--         if IsControlJustPressed(1, 38) and itembuyingChallenge < 2.5 and itembuyingchallengetruefalse == true then
--             itembuyingchallengetruefalse = false
--             warehouseActive = true
--             TriggerServerEvent('umt-warehouse:itembuyingChallenge', source)
--         end
--         -- İtem Buying Challenge

--         -- Lester NPC
--         if lesterDistance < 1.5 then
--             ESX.ShowHelpNotification("Lester ile konuşmak için ~INPUT_PICKUP~ tuşuna basınız.")
--         end

--         if IsControlJustPressed(1, 38) and lesterDistance < 1.5 then
--             warehousemenuOpen()
--         end
--         -- Lester NPC
        
-- 	end
-- end)

-- -- Lester Ped
-- Citizen.CreateThread(function()
--     local ped_hash = 0xB594F5C3
--     local ped_coords = Config.lesterCoords.lesterNPC.coords

--     RequestModel(ped_hash)
--     while not HasModelLoaded(ped_hash) do
--         Citizen.Wait(1)
--     end

--     ped_info = CreatePed(1, ped_hash, ped_coords, 115.0, false, true)
--     SetBlockingOfNonTemporaryEvents(ped_info, true)
--     SetEntityInvincible(ped_info, true)
--     FreezeEntityPosition(ped_info, true)
-- end)
-- -- Lester Ped

-- -- Weapon Buying Ped
-- Citizen.CreateThread(function()
--     local ped_hash = 0xF63DE8E1
--     local ped_coords = Config.challengeCoords.weaponbuyingChallenge.coords
    
--     RequestModel(ped_hash)
--     while not HasModelLoaded(ped_hash) do
--         Citizen.Wait(1)
--     end
    
--     ped_info = CreatePed(1, ped_hash, ped_coords, 125.0, false, true)
--     SetBlockingOfNonTemporaryEvents(ped_info, true)
--     SetEntityInvincible(ped_info, true)
--     FreezeEntityPosition(ped_info, true)
-- end)
-- -- Weapon Buying Ped

-- -- İtem Buying Ped
-- Citizen.CreateThread(function()
--     local ped_hash = 0x37FACDA6
--     local ped_coords = Config.challengeCoords.itembuyingChallenge.coords
    
--     RequestModel(ped_hash)
--     while not HasModelLoaded(ped_hash) do
--         Citizen.Wait(1)
--     end
    
--     ped_info = CreatePed(1, ped_hash, ped_coords, 125.0, false, true)
--     SetBlockingOfNonTemporaryEvents(ped_info, true)
--     SetEntityInvincible(ped_info, true)
--     FreezeEntityPosition(ped_info, true)
-- end)




-- RegisterNetEvent('umt-warehouse:weaponbuyingComplete')
-- AddEventHandler('umt-warehouse:weaponbuyingComplete', function()
--     exports['mythic_notify']:SendAlert('error', 'Görev: Silahları teslim et!')
--     exports['mythic_notify']:SendAlert('inform', 'Silahları teslim ediceğin bölge gps\'e tanımlandı.')
--     SetNewWaypoint(Config.challengeCoords.weaponChallenge.coords)
--     weaponsellingtruefalse = true
-- end)

-- RegisterNetEvent('umt-warehouse:spawntheCar')
-- AddEventHandler('umt-warehouse:spawntheCar', function(coords, model, heading)
--     local playerPed = PlayerPedId()
--     local coords = GetEntityCoords(playerPed)

--     ESX.Game.SpawnVehicle(model, coords, heading, function(vehicle)
--     end)
-- end)

-- function vehicleChallenge()
--     local playerPed = PlayerPedId()
--     local coords = GetEntityCoords(playerPed)

--     vehicletruefalse = true

--     ESX.Game.SpawnVehicle("seven70", Config.challengeCoords.vehiclechallengecar.coords, 313.46, function(vehicle)
--     end)

--     SetNewWaypoint(Config.challengeCoords.vehiclechallengecar.coords)
--     TriggerEvent('umt-warehouse:spawntheCar', source, coords, model, heading)

--     vehiclesellingtruefalse = true
-- end

-- function vehiclesellingChallenge()
--     local money = Config.vehiclechallengeMoney.vehiclesellingMoney
--     local ped = PlayerPedId(-1)
--     local vehicle = GetVehiclePedIsIn(ped)
    
--     if warehousevehicleCheck(GetVehiclePedIsIn(ped)) then
--         ESX.Game.DeleteVehicle(vehicle)
--         TriggerServerEvent('umt-warehouse:giveMoney', money)
--         exports['mythic_notify']:SendAlert('success', 'Görev başarıyla tamamlandı, ' .. money .. '$ kazandın.')
--     else
--         exports['mythic_notify']:SendAlert('error', 'Yanlış aracı teslim almışsın ve görev iptal edildi!')
--     end
-- end

-- function warehousevehicleCheck(using)
-- 	local cars = Config.vehicle
  
-- 	for i=1, #cars, 1 do
-- 	  if IsVehicleModel(using, GetHashKey(cars[i])) then
-- 		return true
-- 	  end
-- 	end
-- end

-- function itemsellingChallenge()
--     local item = "phone" -- yItem (Eşya)
--     TriggerServerEvent('umt-warehouse:giveItem', item)
--     exports['mythic_notify']:SendAlert('error', 'Görev: Eşyayı teslim et!')
--     exports['mythic_notify']:SendAlert('inform', 'Bölge GPS\'e tanımlandı.')
--     SetNewWaypoint(Config.challengeCoords.itembuyingChallenge.coords)

--     itembuyingchallengetruefalse = true
-- end