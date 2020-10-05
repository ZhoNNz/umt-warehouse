ESX = nil
local display = false


Citizen.CreateThread(function()
    while ESX == nil do
		TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
        Citizen.Wait(0)
    end
end)



-- ITEM USABLE


RegisterCommand("laptop", function(source, args, rawCommand)
    Citizen.Wait(200)
    openLaptop(true)

end)

RegisterCommand('whlaptop', function (coords, source, args, rawCommand)
    -- for k, v in pairs(Config.Houses) do   --- Sahip olmaları açmak isterseniz =
        -- if OwnedHouse.houseId == k then
            for k , v in pairs(Config.HouseSpawns) do -- Yeni
                if Vdist2(GetEntityCoords(PlayerPedId()), v['coords']) <= 90.0 then -- housespawn yeni eklendi
                    openLaptop(true)
                -- return
                -- else 
                    -- exports['mythic_notify']:SendAlert('error', 'Warehouse içerisinde olmalısın!')
                    -- return
                end
            end
        -- else     ---    --- Sahip olmaları açmak isterseniz =
            -- exports['mythic_notify']:SendAlert('error', 'Warehouse sahip olmalısın!')  --- Sahip olmaları açmak isterseniz =
        -- end 
    -- end
end)


RegisterNUICallback("exit", function(data)
    SetNuiFocus(false, false)
    SendNUIMessage({
        type = "ui",
        status = false
    })
    display = false
end)

function openLaptop(bool)
    display = bool
    SetNuiFocus(bool, bool)
    SendNUIMessage({
        type = "ui",
        status = bool,
    })
end

Citizen.CreateThread(function()
    while display do
        Citizen.Wait(0)

        DisableControlAction(0, 1, display) -- LookLeftRight
        DisableControlAction(0, 2, display) -- LookUpDown
        DisableControlAction(0, 142, display) -- MeleeAttackAlternate
        DisableControlAction(0, 18, display) -- Enter
        DisableControlAction(0, 322, display) -- ESC
        DisableControlAction(0, 106, display) -- VehicleMouseControlOverride
    end
end)







-- warehouse app 

local warehouseActive = true
local weapontruefalse = false
local vehicletruefalse = false
local weaponbuyingtruefalse = false
local weaponsellingtruefalse = false
local weaponbuyingnpctruefalse = false
local vehiclesellingtruefalse = false
local itemchallengetruefalse = false
local itembuyingchallengetruefalse = false

Citizen.CreateThread(function()
	while true do
		Citizen.Wait(0)

        local coords = GetEntityCoords(PlayerPedId())
        local weaponChallenge = GetDistanceBetweenCoords(coords, Config.challengeCoords.weaponChallenge.coords, true)
        local weaponbuyingChallenge = GetDistanceBetweenCoords(coords, Config.challengeCoords.weaponbuyingChallenge.coords, true)
        local lesterDistance = GetDistanceBetweenCoords(coords, Config.lesterCoords.lesterNPC.coords, true)
        local vehiclecarChallenge = GetDistanceBetweenCoords(coords, Config.challengeCoords.vehiclechallengecar.coords, true)
        local vehiclecarsellingChallenge = GetDistanceBetweenCoords(coords, Config.challengeCoords.vehiclesellingChallenge.coords, true)
        local itemChallenge = GetDistanceBetweenCoords(coords, Config.challengeCoords.itemchallenge.coords, true)
        local itembuyingChallenge = GetDistanceBetweenCoords(coords, Config.challengeCoords.itembuyingChallenge.coords, true)

        -- Weapon Challenge
        if weaponChallenge < 100.0 and weapontruefalse == true then
            DrawMarker(2, Config.challengeCoords.weaponChallenge.coords, 0.0, 0.0, 0.0, 0.0, 0.0, 110.0, 0.55, 0.75, 0.25, 202, 0, 0, 255, false, false, 2, false, false, false, false)
        end
        
        if weaponChallenge < 1.5 and weapontruefalse == true then
            ESX.ShowHelpNotification("Silahları almak için ~INPUT_PICKUP~ tuşuna basınız.")
            weaponbuyingtruefalse = true
        end

        if IsControlJustPressed(1, 38) and weaponChallenge < 1.5 and weapontruefalse == true then
            warehouseweaponChallenge()
            weapontruefalse = false
        end
        -- Weapon Challenge

        -- Weapon Buying Challenge
        if weaponbuyingChallenge < 1.5 and weaponbuyingtruefalse == true then
            ESX.ShowHelpNotification("Silahları teslim almak için ~INPUT_PICKUP~ tuşuna basınız.")
        end

        if IsControlJustPressed(1, 38) and weaponbuyingChallenge < 1.5 and weaponbuyingtruefalse == true then
            warehousebuyingChallenge()
        end
        -- Weapon Buying Challenge

        -- Weapon Selling Challenge
        if weaponChallenge < 100.0 and weaponsellingtruefalse == true then
            DrawMarker(2, Config.challengeCoords.weaponChallenge.coords, 0.0, 0.0, 0.0, 0.0, 0.0, 110.0, 0.55, 0.75, 0.25, 202, 0, 0, 255, false, false, 2, false, false, false, false)
        end
        
        if weaponChallenge < 1.5 and weaponsellingtruefalse == true then
            ESX.ShowHelpNotification("Silahları teslim etmek için ~INPUT_PICKUP~ tuşuna basınız.")
        end

        if IsControlJustPressed(1, 38) and weaponChallenge < 1.5 and weaponsellingtruefalse == true then
            weaponsellingtruefalse = false
            warehouseActive = true
            TriggerServerEvent('warehouse:sellingWeapon', source)
        end
        -- Weapon Selling Challenge

        -- Vehicle Challenge
        if vehiclecarChallenge < 2.5 and vehicletruefalse == true then
            ESX.ShowHelpNotification("Aracı almak için ~INPUT_ENTER~ tuşuna basınız.")
        end

        if IsControlJustPressed(1, 23) and vehiclecarChallenge < 2.5 and vehicletruefalse == true then
            vehicletruefalse = false
            exports['mythic_notify']:SendAlert('error', 'Görev: Aracı teslim et!')
            exports['mythic_notify']:SendAlert('inform', 'Görev: Bölge GPS\'e tanımlandı.')
            SetNewWaypoint(Config.challengeCoords.vehiclesellingChallenge.coords)
        end
        -- Vehicle Challenge

        -- Vehicle Selling Challenge
        if vehiclecarsellingChallenge < 100.0 and vehiclesellingtruefalse == true then
            DrawMarker(2, Config.challengeCoords.vehiclesellingChallenge.coords, 0.0, 0.0, 0.0, 0.0, 0.0, 110.0, 0.55, 0.75, 0.25, 202, 0, 0, 255, false, false, 2, false, false, false, false)
        end
        
        if vehiclecarsellingChallenge < 1.5 and vehiclesellingtruefalse == true then
            ESX.ShowHelpNotification("Aracı teslim etmek için ~INPUT_PICKUP~ tuşuna basınız.")
        end

        if IsControlJustPressed(1, 38) and vehiclecarsellingChallenge < 1.5 and vehiclesellingtruefalse == true then
            vehiclesellingtruefalse = false
            warehouseActive = true
            vehiclesellingChallenge()
        end
        -- Vehicle Selling Challenge

        -- İtem Selling Challenge
        if itemChallenge < 100.0 and itemchallengetruefalse == true then
            DrawMarker(2, Config.challengeCoords.itemchallenge.coords, 0.0, 0.0, 0.0, 0.0, 0.0, 110.0, 0.55, 0.75, 0.25, 202, 0, 0, 255, false, false, 2, false, false, false, false)
        end
        
        if itemChallenge < 1.5 and itemchallengetruefalse == true then
            ESX.ShowHelpNotification("Eşyayı almak için ~INPUT_PICKUP~ tuşuna basınız.")
        end

        if IsControlJustPressed(1, 38) and itemChallenge < 1.5 and itemchallengetruefalse == true then
            itemchallengetruefalse = false
            itemsellingChallenge()
        end
        -- İtem Selling Challenge

        -- İtem Buying Challenge
        if itembuyingChallenge < 2.5 and itembuyingchallengetruefalse == true then
            ESX.ShowHelpNotification("Eşyayı teslim etmek için ~INPUT_PICKUP~ tuşuna basınız.")
        end

        if IsControlJustPressed(1, 38) and itembuyingChallenge < 2.5 and itembuyingchallengetruefalse == true then
            itembuyingchallengetruefalse = false
            warehouseActive = true
            TriggerServerEvent('warehouse:itembuyingChallenge', source)
        end
        -- İtem Buying Challenge

        -- Lester NPC
        if lesterDistance < 1.5 then
            ESX.ShowHelpNotification("Lester ile konuşmak için ~INPUT_PICKUP~ tuşuna basınız.")
        end

        if IsControlJustPressed(1, 38) and lesterDistance < 1.5 then
            warehousemenuOpen()
        end
        -- Lester NPC
        
	end
end)

-- Lester Ped
Citizen.CreateThread(function()
    local ped_hash = 0xB594F5C3
    local ped_coords = Config.lesterCoords.lesterNPC.coords

    RequestModel(ped_hash)
    while not HasModelLoaded(ped_hash) do
        Citizen.Wait(1)
    end

    ped_info = CreatePed(1, ped_hash, ped_coords, 115.0, false, true)
    SetBlockingOfNonTemporaryEvents(ped_info, true)
    SetEntityInvincible(ped_info, true)
    FreezeEntityPosition(ped_info, true)
end)
-- Lester Ped

-- Weapon Buying Ped
Citizen.CreateThread(function()
    local ped_hash = 0xF63DE8E1
    local ped_coords = Config.challengeCoords.weaponbuyingChallenge.coords
    
    RequestModel(ped_hash)
    while not HasModelLoaded(ped_hash) do
        Citizen.Wait(1)
    end
    
    ped_info = CreatePed(1, ped_hash, ped_coords, 125.0, false, true)
    SetBlockingOfNonTemporaryEvents(ped_info, true)
    SetEntityInvincible(ped_info, true)
    FreezeEntityPosition(ped_info, true)
end)
-- Weapon Buying Ped

-- İtem Buying Ped
Citizen.CreateThread(function()
    local ped_hash = 0x37FACDA6
    local ped_coords = Config.challengeCoords.itembuyingChallenge.coords
    
    RequestModel(ped_hash)
    while not HasModelLoaded(ped_hash) do
        Citizen.Wait(1)
    end
    
    ped_info = CreatePed(1, ped_hash, ped_coords, 125.0, false, true)
    SetBlockingOfNonTemporaryEvents(ped_info, true)
    SetEntityInvincible(ped_info, true)
    FreezeEntityPosition(ped_info, true)
end)
-- İtem Buying Ped

function warehousemenuOpen()
    if warehouseActive then
        ESX.UI.Menu.CloseAll()
        ESX.UI.Menu.Open('default', GetCurrentResourceName(), 'equipfbi', {
            title = 'Lester Menüsü',
            align = 'top-left',
            elements = {
                {label = 'Görev: Silah Teslimatı', value = 'weaponchallenge'},
                {label = 'Görev: Araç Teslimatı', value = 'vehiclechallange'},
                {label = 'Görev: Eşya Teslimatı', value = 'itemchallenge'}
            }
        }, function(data, menu)
            
            if data.current.value == 'weaponchallenge' then
                weapontruefalse = true
                exports['mythic_notify']:SendAlert('error', 'Görev: Silah Teslimatı')
                exports['mythic_notify']:SendAlert('inform', 'Bölge GPS\'e işaretlendi.')
                SetNewWaypoint(Config.challengeCoords.weaponChallenge.coords)
                menu.close()
                warehouseActive = false
            end
            
            if data.current.value == 'vehiclechallange' then
                exports['mythic_notify']:SendAlert('error', 'Görev: Araç Teslimatı')
                exports['mythic_notify']:SendAlert('inform', 'Bölge GPS\'e işaretlendi.')
                SetNewWaypoint(Config.challengeCoords.vehiclechallengecar.coords)
                menu.close()
                vehicleChallenge()
                warehouseActive = false
            end
    
            if data.current.value == 'itemchallenge' then
                exports['mythic_notify']:SendAlert('error', 'Görev: Eşya Teslimatı')
                exports['mythic_notify']:SendAlert('inform', 'Bölge GPS\'e işaretlendi.')
                SetNewWaypoint(Config.challengeCoords.itemchallenge.coords)
                menu.close()
                itemchallengetruefalse = true
                warehouseActive = false
            end
    
        end, function(data, menu)
            menu.close()
        end)
    else
        exports['mythic_notify']:SendAlert('error', 'Zaten teslimat aldın, işini bitirdikten sonra tekrar alabilirsin!')
    end
end

function warehouseweaponChallenge()
    exports['mythic_notify']:SendAlert('error', 'Görev: Silahları al!')
    exports['mythic_notify']:SendAlert('inform', 'Silahları alıcağın bölge gps\'e tanımlandı.')
    SetNewWaypoint(Config.challengeCoords.weaponbuyingChallenge.coords)
end

function warehousebuyingChallenge()
    ESX.UI.Menu.CloseAll()
	ESX.UI.Menu.Open('default', GetCurrentResourceName(), 'equipfbi', {
		title = 'Lester Job (Silah Alış Menüsü)',
		align = 'top-left',
		elements = {
			{label = '1. Pistol - Alış: ' .. Config.weaponchallangeMoney.PistolBuying .. '$ - Teslimat: ' .. Config.weaponchallangeMoney.PistolReward ..' $', value = 'pistol'},
			{label = '2. Micro SMG - Alış: ' .. Config.weaponchallangeMoney.MicroSMGBuying .. '$ - Teslimat: ' .. Config.weaponchallangeMoney.MicroSMGReward ..' $', value = 'microsmg'},
			{label = '3. SMG - Alış: ' .. Config.weaponchallangeMoney.SMGBuying .. '$ - Teslimat: ' .. Config.weaponchallangeMoney.SMGReward ..' $', value = 'smg'}
		}
    }, function(data, menu)
        
        if data.current.value == 'pistol' then
            TriggerServerEvent('warehouse:pistol', source)
            weaponbuyingtruefalse = false
            menu.close()
        end

        if data.current.value == 'microsmg' then
            TriggerServerEvent('warehouse:microsmg', source)
            weaponbuyingtruefalse = false
            menu.close()
        end

        if data.current.value == 'smg' then
            TriggerServerEvent('warehouse:smg', source)
            weaponbuyingtruefalse = false
            menu.close()
        end

	end, function(data, menu)
		menu.close()
	end)
end

RegisterNetEvent('warehouse:weaponbuyingComplete')
AddEventHandler('warehouse:weaponbuyingComplete', function()
    exports['mythic_notify']:SendAlert('error', 'Görev: Silahları teslim et!')
    exports['mythic_notify']:SendAlert('inform', 'Silahları teslim ediceğin bölge gps\'e tanımlandı.')
    SetNewWaypoint(Config.challengeCoords.weaponChallenge.coords)
    weaponsellingtruefalse = true
end)

RegisterNetEvent('warehouse:spawntheCar')
AddEventHandler('warehouse:spawntheCar', function(coords, model, heading)
    local playerPed = PlayerPedId()
    local coords = GetEntityCoords(playerPed)

    ESX.Game.SpawnVehicle(model, coords, heading, function(vehicle)
    end)
end)

function vehicleChallenge()
    local playerPed = PlayerPedId()
    local coords = GetEntityCoords(playerPed)

    vehicletruefalse = true

    ESX.Game.SpawnVehicle("seven70", Config.challengeCoords.vehiclechallengecar.coords, 313.46, function(vehicle)
    end)

    SetNewWaypoint(Config.challengeCoords.vehiclechallengecar.coords)
    TriggerEvent('warehouse:spawntheCar', source, coords, model, heading)

    vehiclesellingtruefalse = true
end

function vehiclesellingChallenge()
    local money = Config.vehiclechallengeMoney.vehiclesellingMoney
    local ped = PlayerPedId(-1)
    local vehicle = GetVehiclePedIsIn(ped)
    
    if warehousevehicleCheck(GetVehiclePedIsIn(ped)) then
        ESX.Game.DeleteVehicle(vehicle)
        TriggerServerEvent('warehouse:giveMoney', money)
        exports['mythic_notify']:SendAlert('success', 'Görev başarıyla tamamlandı, ' .. money .. '$ kazandın.')
    else
        exports['mythic_notify']:SendAlert('error', 'Yanlış aracı teslim almışsın ve görev iptal edildi!')
    end
end

function warehousevehicleCheck(using)
	local cars = Config.vehicle
  
	for i=1, #cars, 1 do
	  if IsVehicleModel(using, GetHashKey(cars[i])) then
		return true
	  end
	end
end

function itemsellingChallenge()
    local item = "phone" -- yItem (Eşya)
    TriggerServerEvent('warehouse:giveItem', item)
    exports['mythic_notify']:SendAlert('error', 'Görev: Eşyayı teslim et!')
    exports['mythic_notify']:SendAlert('inform', 'Bölge GPS\'e tanımlandı.')
    SetNewWaypoint(Config.challengeCoords.itembuyingChallenge.coords)

    itembuyingchallengetruefalse = true
end




RegisterNUICallback('aracteslimat', function ()
    exports['mythic_notify']:SendAlert('error', 'Görev: Araç Teslimatı')
    exports['mythic_notify']:SendAlert('inform', 'Bölge GPS\'e işaretlendi.')
    SetNewWaypoint(Config.challengeCoords.vehiclechallengecar.coords)
    vehicleChallenge()
    warehouseActive = false
    SetNuiFocus(false, false)
end)


RegisterNUICallback('esyateslimat', function ()
    exports['mythic_notify']:SendAlert('error', 'Görev: Eşya Teslimatı')
    exports['mythic_notify']:SendAlert('inform', 'Bölge GPS\'e işaretlendi.')
    SetNewWaypoint(Config.challengeCoords.itemchallenge.coords)
    itemchallengetruefalse = true
    warehouseActive = false
    SetNuiFocus(false, false)
end)



RegisterNUICallback('silahteslimat', function()
    weapontruefalse = true
    exports['mythic_notify']:SendAlert('error', 'Görev: Silah Teslimatı')
    exports['mythic_notify']:SendAlert('inform', 'Bölge GPS\'e işaretlendi.')
    SetNewWaypoint(Config.challengeCoords.weaponChallenge.coords)
    warehouseActive = false
    SetNuiFocus(false, false)
end)





--Blackmarket

local obj = {}
local pilot, aircraft, parachute, crate, pickup, blip, soundID
local requiredModels = {"p_cargo_chute_s", "ex_prop_adv_case_sm", "cuban800", "s_m_m_pilot_02", "prop_box_wood02a_pu"} -- parachute, pickup case, plane, pilot, crate



RegisterNUICallback('methal', function(data)
    SetNuiFocus(false,false)
    ESX.TriggerServerCallback("itemcheck", function (s,i, f)
        if s then
            Citizen.Wait(30000)
            TriggerEvent("crateDrop:meth", i)
            -- print('true geldi')
        else
            -- print('false geldi')
        end
    end, data.i,data.f)
end)



RegisterNetEvent("crateDrop:meth")
AddEventHandler("crateDrop:meth", function(item) -- all of the error checking is done here before passing the parameters to the function itself
    Citizen.CreateThread(function()
        local dropCoords = vector3(1879.577, 291.4017, 164.27)
        

        -- print(item)
        -- print("AMMO: " .. ammo)

        if dropCoords.x and dropCoords.y and dropCoords.z and tonumber(dropCoords.x) and tonumber(dropCoords.y) and tonumber(dropCoords.z) then
            -- print(("DROP COORDS: success, X = %.4f; Y = %.4f; Z = %.4f"):format(dropCoords.x, dropCoords.y, dropCoords.z))
        else
            dropCoords = {0.0, 0.0, 72.0}
            -- print("DROP COORDS: fail, defaulting to X = 0; Y = 0")
        end

        if roofCheck and roofCheck ~= "false" then  -- if roofCheck is not false then a check will be performed if a plane can drop a crate to the specified location before actually spawning a plane, if it can't, function won't be called
            -- print("ROOFCHECK: true")
            local ray = StartShapeTestRay(vector3(dropCoords.x, dropCoords.y, dropCoords.z) + vector3(0.0, 0.0, 500.0), vector3(dropCoords.x, dropCoords.y, dropCoords.z), -1, -1, 0)
            local _, hit, impactCoords = GetShapeTestResult(ray)
            -- print("HIT: " .. hit)
            -- print(("IMPACT COORDS: X = %.4f; Y = %.4f; Z = %.4f"):format(impactCoords.x, impactCoords.y, impactCoords.z))
            -- print("DISTANCE BETWEEN DROP AND IMPACT COORDS: " ..  #(vector3(dropCoords.x, dropCoords.y, dropCoords.z) - vector3(impactCoords)))
            if hit == 0 or (hit == 1 and #(vector3(dropCoords.x, dropCoords.y, dropCoords.z) - vector3(impactCoords)) < 10.0) then -- ± 10 units
                -- print("ROOFCHECK: success")
                CrateDrop(dropCoords, item)
            else
                -- print("ROOFCHECK: fail")
                return
            end
        else
            -- print("ROOFCHECK: false")
            CrateDrop(dropCoords, item)
        end

    end)
end)

function CrateDrop(dropCoords, item)
    Citizen.CreateThread(function()

        for i = 1, #requiredModels do
            RequestModel(GetHashKey(requiredModels[i]))
            while not HasModelLoaded(GetHashKey(requiredModels[i])) do
                Wait(0)
            end
        end

        --[[
        RequestAnimDict("P_cargo_chute_S")
        while not HasAnimDictLoaded("P_cargo_chute_S") do -- wasn't able to get animations working
            Wait(0)
        end
        ]]

        RequestWeaponAsset(GetHashKey("weapon_flare")) -- flare won't spawn later in the script if we don't request it right now
        while not HasWeaponAssetLoaded(GetHashKey("weapon_flare")) do
            Wait(0)
        end

        local rHeading = math.random(0, 360) + 0.0
        local planeSpawnDistance = (planeSpawnDistance and tonumber(planeSpawnDistance) + 0.0) or 500.0 -- this defines how far away the plane is spawned
        local theta = (rHeading / 180.0) * 3.14
        local rPlaneSpawn = vector3(dropCoords.x, dropCoords.y, dropCoords.z) - vector3(math.cos(theta) * planeSpawnDistance, math.sin(theta) * planeSpawnDistance, -500.0) -- the plane is spawned at

        -- print(("PLANE COORDS: X = %.4f; Y = %.4f; Z = %.4f"):format(rPlaneSpawn.x, rPlaneSpawn.y, rPlaneSpawn.z))
        -- print("PLANE SPAWN DISTANCE: " .. #(vector2(rPlaneSpawn.x, rPlaneSpawn.y) - vector2(dropCoords.x, dropCoords.y)))

        local dx = dropCoords.x - rPlaneSpawn.x
        local dy = dropCoords.y - rPlaneSpawn.y
        local heading = GetHeadingFromVector_2d(dx, dy) -- determine plane heading from coordinates

        aircraft = CreateVehicle(GetHashKey("cuban800"), rPlaneSpawn, heading, true, true)
        SetEntityHeading(aircraft, heading)
        SetVehicleDoorsLocked(aircraft, 2) -- lock the doors so pirates don't get in
        SetEntityDynamic(aircraft, true)
        ActivatePhysics(aircraft)
        SetVehicleForwardSpeed(aircraft, 60.0)
        SetHeliBladesFullSpeed(aircraft) -- works for planes I guess
        SetVehicleEngineOn(aircraft, true, true, false)
        ControlLandingGear(aircraft, 3) -- retract the landing gear
        OpenBombBayDoors(aircraft) -- opens the hatch below the plane for added realism
        SetEntityProofs(aircraft, true, false, true, false, false, false, false, false)

        pilot = CreatePedInsideVehicle(aircraft, 1, GetHashKey("s_m_m_pilot_02"), -1, true, true)
        SetBlockingOfNonTemporaryEvents(pilot, true) -- ignore explosions and other shocking events
        SetPedRandomComponentVariation(pilot, false)
        SetPedKeepTask(pilot, true)
        SetPlaneMinHeightAboveTerrain(aircraft, 50) -- the plane shouldn't dip below the defined altitude

        TaskVehicleDriveToCoord(pilot, aircraft, vector3(dropCoords.x, dropCoords.y, dropCoords.z) + vector3(0.0, 0.0, 500.0), 60.0, 0, GetHashKey("cuban800"), 262144, 15.0, -1.0) -- to the dropsite, could be replaced with a task sequence

        local droparea = vector2(dropCoords.x, dropCoords.y)
        local planeLocation = vector2(GetEntityCoords(aircraft).x, GetEntityCoords(aircraft).y)
        while not IsEntityDead(pilot) and #(planeLocation - droparea) > 5.0 do -- wait for when the plane reaches the dropCoords ± 5 units
            Wait(100)
            planeLocation = vector2(GetEntityCoords(aircraft).x, GetEntityCoords(aircraft).y) -- update plane coords for the loop
        end

        if IsEntityDead(pilot) then -- I think this will end the script if the pilot dies, no idea how to return works
            print("PILOT: dead")
            do return end
        end

        TaskVehicleDriveToCoord(pilot, aircraft, 0.0, 0.0, 500.0, 60.0, 0, GetHashKey("cuban800"), 262144, -1.0, -1.0) -- disposing of the plane like Rockstar does, send it to 0; 0 coords with -1.0 stop range, so the plane won't be able to achieve its task
        SetEntityAsNoLongerNeeded(pilot) 
        SetEntityAsNoLongerNeeded(aircraft)

        local crateSpawn = vector3(dropCoords.x, dropCoords.y, GetEntityCoords(aircraft).z - 5.0) -- crate will drop to the exact position as planned, not at the plane's current position

        crate = CreateObject(GetHashKey("prop_box_wood02a_pu"), crateSpawn, true, true, true) -- a breakable crate to be spawned directly under the plane, probably could be spawned closer to the plane
        SetEntityLodDist(crate, 1000) -- so we can see it from the distance
        ActivatePhysics(crate)
        SetDamping(crate, 2, 0.1) -- no idea but Rockstar uses it
        SetEntityVelocity(crate, 0.0, 0.0, -0.2) -- I think this makes the crate drop down, not sure if it's needed as many times in the script as I'm using

        parachute = CreateObject(GetHashKey("p_cargo_chute_s"), crateSpawn, true, true, true) -- create the parachute for the crate, location isn't too important as it'll be later attached properly
        SetEntityLodDist(parachute, 1000)
        SetEntityVelocity(parachute, 0.0, 0.0, -0.2)

        -- PlayEntityAnim(parachute, "P_cargo_chute_S_deploy", "P_cargo_chute_S", 1000.0, false, false, false, 0, 0)
        -- ForceEntityAiAndAnimationUpdate(parachute)

        -- pickup = CreateAmbientPickup(GetHashKey(weapon_), crateSpawn, 0, ammo, GetHashKey("ex_prop_adv_case_sm"), true, true) -- create the pickup itself, location isn't too important as it'll be later attached properly


        soundID = GetSoundId() -- we need a sound ID for calling the native below, otherwise we won't be able to stop the sound later
        PlaySoundFromEntity(soundID, "Crate_Beeps", pickup, "MP_CRATE_DROP_SOUNDS", true, 0) -- crate beep sound emitted from the pickup

        blip = AddBlipForEntity(crate)
        SetBlipSprite(blip, 408) -- 351 or 408 are both fine, 408 is just bigger
        SetBlipNameFromTextFile(blip, "AMD_BLIPN")
        SetBlipScale(blip, 0.7)
        SetBlipColour(blip, 2)
        SetBlipAlpha(blip, 120) -- blip will be semi-transparent

        -- local crateBeacon = StartParticleFxLoopedOnEntity_2("scr_crate_drop_beacon", pickup, 0.0, 0.0, 0.2, 0.0, 0.0, 0.0, 1065353216, 0, 0, 0, 1065353216, 1065353216, 1065353216, 0)--1.0, false, false, false)
        -- SetParticleFxLoopedColour(crateBeacon, 0.8, 0.18, 0.19, false)
        local son = nil
        AttachEntityToEntity(parachute, pickup, 0, 0.0, 0.0, 0.1, 0.0, 0.0, 0.0, false, false, false, false, 2, true) -- attach the crate to the pickup
        AttachEntityToEntity(pickup, crate, 0, 0.0, 0.0, 0.3, 0.0, 0.0, 0.0, false, false, true, false, 2, true) -- attach the pickup to the crate, doing it in any other order makes the crate drop spazz out

        while HasObjectBeenBroken(crate) == false do -- wait till the crate gets broken (probably on impact), then continue with the script
            Wait(0)
            son = vector3(GetEntityCoords(crate))
        end
        pickup = CreateObject(GetHashKey("prop_box_ammo03a"), son, true, true, true) 
        ActivatePhysics(pickup)
        SetDamping(pickup, 2, 0.0245)
        SetEntityVelocity(pickup, 0.0, 0.0, -0.2)

        local parachuteCoords = vector3(GetEntityCoords(parachute)) -- we get the parachute dropCoords so we know where to drop the flare
        ShootSingleBulletBetweenCoords(parachuteCoords, parachuteCoords - vector3(0.0001, 0.0001, 0.0001), 0, false, GetHashKey("weapon_flare"), 0, true, false, -1.0) -- flare needs to be dropped with dropCoords like that, otherwise it remains static and won't remove itself later
        DetachEntity(parachute, true, true)
        -- SetEntityCollision(parachute, false, true) -- pointless right now but would be cool if animations would work and you'll be able to walk through the parachute while it's disappearing
        -- PlayEntityAnim(parachute, "P_cargo_chute_S_crumple", "P_cargo_chute_S", 1000.0, false, false, false, 0, 0)
        DeleteEntity(parachute)
        DetachEntity(pickup) -- will despawn on its own
        SetBlipAlpha(blip, 255) -- make the blip fully visible


        while DoesObjectOfTypeExistAtCoords(son, 10.0, GetHashKey("prop_box_ammo03a"), true) do -- BB
            Wait(0)
            local prop = GetClosestObjectOfType(parachuteCoords, 10.0, GetHashKey("w_am_flare"), false, false, false)
            RemoveParticleFxFromEntity(prop)-----
            SetEntityAsMissionEntity(prop, true, true)
            local playerPed = GetPlayerPed(-1)
            local pos = GetEntityCoords(playerPed)
            local cakam= GetClosestObjectOfType(pos.x, pos.y, pos.z, 2.0, GetHashKey('prop_box_ammo03a'), false, false ,false)      
              if cakam ~= 0 then
                ESX.ShowHelpNotification('Push [E]')
                if IsControlJustPressed(0,38) then
                    DeleteObject(pickup)
                    DeleteObject(prop)
                    TriggerServerEvent('crateDrop:methal', item)
                end
                
            end
            -- local kutu = CreateObject(GetHashKey("prop_box_ammo03a"), crateSpawn, true, true, true)
        end

        if DoesBlipExist(blip) then -- remove the blip, should get removed when the pickup gets picked up anyway, but isn't a bad idea to make sure of it
            RemoveBlip(blip)
        end

        StopSound(soundID) -- stop the crate beeping sound
        ReleaseSoundId(soundID) -- won't need this sound ID any longer

        for i = 1, #requiredModels do
            Wait(0)
            SetModelAsNoLongerNeeded(GetHashKey(requiredModels[i]))
        end

        RemoveWeaponAsset(GetHashKey("weapon_flare"))
    end)
end

AddEventHandler("onResourceStop", function(resource)
    if resource == GetCurrentResourceName() then

        SetEntityAsMissionEntity(pilot, false, true)
        DeleteEntity(pilot)
        SetEntityAsMissionEntity(aircraft, false, true)
        DeleteEntity(aircraft)
        DeleteEntity(parachute)
        DeleteEntity(crate)
        RemovePickup(pickup)
        RemoveBlip(blip)
        StopSound(soundID)
        ReleaseSoundId(soundID)

        for i = 1, #requiredModels do
            Wait(0)
            SetModelAsNoLongerNeeded(GetHashKey(requiredModels[i]))
        end

    end
end)