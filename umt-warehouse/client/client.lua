-- AreCoordsCollidingWithExterior()
local OwnedHouse = nil
local AvailableHouses = {}
local blips = {}
local Knockings = {}
local housespawn = false






Citizen.CreateThread(function()
    while ESX == nil do TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end) Wait(0) end
    while ESX.GetPlayerData().job == nil do Wait(0) end
    TriggerServerEvent('umt-warehouse:getOwned')

    while OwnedHouse == nil do Wait(0) end

    
    local WareHouse = AddBlipForCoord(vector3(Config.WareHouseBB["x"], Config.WareHouseBB["y"], Config.WareHouseBB["z"]))
    SetBlipSprite(WareHouse, 369)
    SetBlipColour(WareHouse, 2)
    SetBlipAsShortRange(WareHouse, true)
    SetBlipScale(WareHouse, 0.7)
    BeginTextCommandSetBlipName("STRING")
    AddTextComponentString("Warehouse")
    EndTextCommandSetBlipName(WareHouse)

end)




-- RegisterCommand('whout', function(coords)
--     local in_house = true
--     local player = PlayerPedId()
--     local prop = Config.Houses[OwnedHouse.houseId]['prop']
--     local house = EnterHouse(Config.Props[prop], coords)
--     -- ESX.TriggerServerCallback('umt-warehouse:hasGuests', function(has)

--     TriggerServerEvent('umt-warehouse:deleteInstance')
--     in_house = false
--     Wait(12)
--     DeleteObject(house)
--     print(DeleteObject(house))
-- end)







RegisterCommand('whenter', function()
    for k, v in pairs(Config.Houses) do
        if Vdist2(GetEntityCoords(PlayerPedId()), v['door']) <= 6.5 then
            -- HelpText('Warehouse gir /enter', k)
            toggleField(true)

        end
    end
end)

-- Citizen.CreateThread(function()
--     local player = PlayerPedId()
--     local bb = {
--         ["x"] = 500.13,
--         ["y"] = -652.07,
--         ["z"] = 24.91    }

--     while true do
--         Citizen.Wait(1)
--         local distance = #(GetEntityCoords(PlayerPedId()) - vector3(Config.WareHouseBB["x"], Config.WareHouseBB["y"], Config.WareHouseBB["z"]))
--         if distance < 3 then
--             -- DrawText3Dplayer["x"], player["y"], player["z"]+0.1, "[E] Tedavi ol | 2.000$")
--             DrawMarker(21, Config.WareHouseBB["x"], Config.WareHouseBB["y"], Config.WareHouseBB["z"]-0.25, vector3(0.0, 0.0, 0.0), vector3(0.0, 0.0, 0.0), vector3(0.5, 0.5, 0.5), 255, 0, 0, 150, false, true, 2, false, false, false)
--             HelpText('[E] Warehouse Satın al', bb)
--             if IsControlJustReleased(0, 38) then
--                 HouseBuyMenu()
--             end
--         end
--     end
-- end)

function HouseBuyMenu()
    ESX.UI.Menu.CloseAll()
    ESX.UI.Menu.Open('default', GetCurrentResourceName(), 'houseBuyFirstMenu',
    {
        title    = 'Warehouses',
        align    = 'left',
        elements = {
            {label = "Warehouse Satın Al", value = "warehouse_buy"},
            {label = "Satın Aldığım Warehouse", value = "evlerim"},
            {label = "Satın Alınabilen Warehouseleri Göster/Gizle", value = "evgoster"}
        }
    },function(data, menu)
        if data.current.value == "warehouse_buy" then
            BuyHouse()
        elseif data.current.value == "evlerim" then
            myHouse()
        elseif data.current.value == "evgoster" then  
            menu.close()
            satilanEvler()
        end
    end,function(data, menu)
        menu.close()
    end)
end




-- RegisterNUICallback('buy', function()
--     local Houses = Config.Houses
--     for x, y in pairs(Houses) do
--     openContract(false)
--         if purchased == true then
--         TriggerServerEvent('umt-warehouse:buyHouse', evNo)
--         PlaySoundFrontend(-1, "LOOSE_MATCH", "HUD_MINI_GAME_SOUNDSET", 0)
--         ChangePassword(evNo)
--         purchased = false
--         end
--     end
-- end)




function BuyHouse()
    local elements = {}
    local Houses = Config.Houses
    local doorID   = Config.Houses[i]
    
    for x, y in pairs(Houses) do
        table.insert(elements, {label =  x .." Nolu Warehouse Satın Al $".. Houses[x]["price"], value = x})
    end


    ESX.UI.Menu.Open('default', GetCurrentResourceName(), 'buyHouse',
    {
        title    = 'Depo Evi Satın Al',
        align    = 'left',
        elements = elements
    },function(data, menu)
        if data.current.value then
            local evNo = data.current.value
            ESX.UI.Menu.Open('default', GetCurrentResourceName(), 'buyHouseSoru',
            {
                title    = evNo .. ' Nolu Warehouse Satın Almak İçin Emin misin',
                align    = 'left',
                elements = {
                    {label =  "Evet", value = "yes"},
                    {label =  "Hayır", value = "no"}
                }
            },function(data2, menu2)
                menu2.close()
                if data2.current.value == "yes" then
                    ESX.UI.Menu.CloseAll()
                    TriggerServerEvent('umt-warehouse:buyHouse', evNo)
                    PlaySoundFrontend(-1, "LOOSE_MATCH", "HUD_MINI_GAME_SOUNDSET", 0)
                    ChangePassword(evNo)
                end
            end,function(data2, menu2)
                menu2.close()
            end)
        end
    end,function(data, menu)
        menu.close()
    end)
end




function ChangePassword(evNo)
	ESX.UI.Menu.Open('dialog', GetCurrentResourceName(), 'Ev Şifresi', {
		title = "Ev Şifresini Giriniz",
	}, function (data2, menu)
        local password  = data2.value

        if password  ~= nil then -- and newpassword == ''
            TriggerServerEvent("umt-warehouse:changeHousePassword", evNo, password )
            TriggerEvent('notification', 'Şifreniz kayıt oldu!  '.. '=> ' .. password, 2)
            menu.close()
        else
            TriggerEvent('notification', 'Geçersiz şifre!', 2)
            menu.close()
		end
	end, function (data2, menu)
        menu.close()
	end)
end

-- Kendi evini gösterme ve satma
function myHouse()
    local elements = {}
    local evNo = OwnedHouse.houseId

    for k, v in pairs(Config.Houses) do
        if OwnedHouse.houseId == k then
            fiyat = math.floor(Config.Houses[k]['price']*(Config.SellPercentage/100))
            if anahtar then
                table.insert(elements, {label =  OwnedHouse.houseId .." Nolu Warehouse Anahtarını Bırak", value = OwnedHouse.houseId, durum = "sat"})
            else
                table.insert(elements, {label =  OwnedHouse.houseId .." Nolu Warehouseni Sat $".. fiyat, value = OwnedHouse.houseId, durum = "sat"})
                table.insert(elements, {label =  "Warehouse Şifresini Oluştur/Değiştir", value = OwnedHouse.houseId, durum = "sifre_degis"})
                table.insert(elements, {label =  "", value = OwnedHouse.houseId, durum = ""})
                table.insert(elements, {label =  "GARAJ (Yakında)", value = OwnedHouse.houseId, durum = "opengaragemenu"})

            end
        end
    end
    
    ESX.UI.Menu.Open('default', GetCurrentResourceName(), 'myHouse',
    {
        title    = 'Warehouse System',
        align    = 'left',
        elements = elements
    },function(data, menu)
        if data.current.value then
            if data.current.durum == "sat" then
                if anahtar then 
                    yazi = data.current.value .. " Nolu Warehousenin Anahtarını Bırak"
                else
                    yazi = data.current.value .. " Nolu Warehouse ".. fiyat .."$ Karşılığında Satmak İstediğinden Eminmisin"
                end

                ESX.UI.Menu.Open('default', GetCurrentResourceName(), 'myHouseSoruMenu',
                {
                    title    = yazi,
                    align    = 'left',
                    elements = {
                        {label =  "Evet", value = "yes"},
                        {label =  "Hayır", value = "no"}
                    }
                },function(data2, menu2)
                    menu2.close()
                    if data2.current.value == "yes" then
                        ESX.UI.Menu.CloseAll()
                        TriggerServerEvent('umt-warehouse:sellHouse', data.current.value, anahtar)
                        satinalindi = true
                    end
                end,function(data2, menu2)
                    menu2.close()
                end)
            elseif data.current.durum == "anahtar" then
                local player, distance = ESX.Game.GetClosestPlayer()
                if distance ~= -1 and distance <= 3.0 then
                    TriggerServerEvent('umt-warehouse:anahtar-ver',  GetPlayerServerId(player), data.current.value)
                else
                    ESX.ShowNotification('Yakınlarda Kimse Yok')
                end
            elseif data.current.durum == "sifre_degis" then
                ESX.UI.Menu.CloseAll()
                ChangePassword(evNo)
            elseif data.current.durum == "opengaragemenu" then
                OpenGarageMenu()
            end    
        end
    end,function(data, menu)
        menu.close()
    end)
end

function OpenGarageMenu()
    ESX.UI.Menu.CloseAll()

    ESX.UI.Menu.Open(
        'default', GetCurrentResourceName(), 'pawn_sell_menu',
        {
            title    = 'Araç garajı',
            elements = {
                {label = 'Garaja gir', value = 'opengarage'},
                {label = '', value = ''},
                {label = 'Aracını garaja çek', value = 'putgarage'},
            }
        },
        function(data, menu)
            if data.current.value == 'opengarage' then
                local coords = Config.Houses[OwnedHouse.houseId]['door']
                local found, coords, heading = GetClosestVehicleNodeWithHeading(coords.x, coords.y, coords.z, 3.0, 100.0, 2.5)
                if found then
                    ESX.UI.Menu.CloseAll()
                    TriggerServerEvent('esx_garage:viewVehicles', coords, heading, 'housing')
                    return
                else
                    ESX.ShowNotification(Strings['No_Spawn'])
                end
            elseif data.current.value == 'putgarage' then
                if OwnedHouse.houseId == k then
                    TriggerEvent('esx_garage:storeVehicle', 'housing')
                end
            end
        end,
        function(data, menu)
            menu.close()
        end
    )
end



function satilanEvler()
    if not goster then
        goster = true
        for k, v in pairs(Config.Houses) do
            CreateBlip(v['door'], 374, 0, 0.45, '')
        end

        TriggerEvent('notification', 'Haritada Satın Alınabilen Evler Açıldı!', 2)
    else
        goster = false
        for k, v in pairs(blips) do
            RemoveBlip(v)
        end

        TriggerEvent('notification', 'Haritada Satın Alınabilen Evler Kapatıldı!', 2)
    end
end


RegisterNetEvent('umt-warehouse:spawnHouse')
AddEventHandler('umt-warehouse:spawnHouse', function(coords, furniture)
    local prop = Config.Houses[OwnedHouse.houseId]['prop']
    local house = EnterHouse(Config.Props[prop], coords)
    local player = PlayerPedId()
    local placed_furniture = {}
    for k, v in pairs(OwnedHouse['furniture']) do
        local model = GetHashKey(v['object'])
        while not HasModelLoaded(model) do RequestModel(model) Wait(0) end
        local object = CreateObject(model, GetOffsetFromEntityInWorldCoords(house, vector3(v['offset'][1], v['offset'][2], v['offset'][3])), false, false, false)
        SetEntityHeading(object, v['heading'])
        FreezeEntityPosition(object, true)
        SetEntityCoordsNoOffset(object, GetOffsetFromEntityInWorldCoords(house, vector3(v['offset'][1], v['offset'][2], v['offset'][3])))
        table.insert(placed_furniture, object)
    end
    SetEntityHeading(house, 0.0)
    local exit = GetOffsetFromEntityInWorldCoords(house, Config.Offsets[prop]['door'])
    local storage = GetOffsetFromEntityInWorldCoords(house, Config.Offsets[prop]['storage'])
    -- local tablet = GetOffsetFromEntityInWorldCoords(house, Config.Offsets[prop]['tablet'])
    TriggerServerEvent('umt-warehouse:setInstanceCoords', exit, coords, prop, OwnedHouse['furniture'])
    DoScreenFadeOut(300)
    while not IsScreenFadedOut() do Wait(0) end
    for i = 1, 25 do
        if IsPedInAnyVehicle(player, true) then 
        SetEntityCoords(GetVehiclePedIsUsing(player), exit)
        FreezeEntityPosition(PlayerPedId(), true)
        Wait(50)
        FreezeEntityPosition(PlayerPedId(), false)
        else
            SetEntityCoords(PlayerPedId(), exit)
            Wait(50)
        end
    end
    while IsEntityWaitingForWorldCollision(PlayerPedId()) do
        SetEntityCoords(PlayerPedId(), exit)
        Wait(50)
    end
    DoScreenFadeIn(300)
    local in_house = true
    ClearPedWetness(PlayerPedId())
    while in_house do
        NetworkOverrideClockTime(15, 0, 0)
        ClearOverrideWeather()
        ClearWeatherTypePersist()
        SetWeatherTypePersist('EXTRASUNNY')
        SetWeatherTypeNow('EXTRASUNNY')
        SetWeatherTypeNowPersist('EXTRASUNNY')

        -- DrawMarker(27, exit, vector3(0.0, 0.0, 0.0), vector3(0.0, 0.0, 0.0), vector3(1.0, 1.0, 1.0), 255, 0, 255, 150, false, false, 2, false, false, false)
        -- DrawText3D(vector3(0.0, 0.0, 0.0), vector3(0.0, 0.0, 0.0), vector3(1.0, 1.0, 1.0), "[E] Depo")

        if Vdist2(GetEntityCoords(PlayerPedId()), storage) <= 9.2 then
            -- DrawMarker(20, storage, vector3(0.0, 0.0, 0.0), vector3(0.0, 0.0, 0.0), vector3(1.0, 1.0, 1.0), 153, 2, 202, 150, false, false, 1, false, false, false)
            -- DrawMarker(2, storage,vector3(0.0, 0.0, 0.0), vector3(0.0, 0.0, 0.0), vector3(1.0, 1.0, 1.0), 0.0, 0.0, 110.0, 0.55, 0.75, 0.25, 202, 0, 0, 255, false, false, 1, false, false, false, false)
            DrawText3D(storage, "[E] Depo")

            HelpText('[E] Depo', storage)
            if IsControlJustReleased(0, 38) and Vdist2(GetEntityCoords(PlayerPedId()), storage) <= 9.2 then
                ESX.UI.Menu.CloseAll()

                TriggerEvent("disc-inventoryhud:stash", "Warehouse - "..tostring(OwnedHouse.houseId))
                

            end
        end
        if Vdist2(GetEntityCoords(PlayerPedId()), exit) <= 10 then
            HelpText('[E] - ÇIKIŞ', exit)
            -- DrawMarker(22, exit, vector3(0.0, 0.0, 0.0), vector3(0.0, 0.0, 0.0), vector3(1.0, 1.0, 1.0), 165, 40, 36, 150, false, false, 1, false, false, false)
            -- DrawMarker(2, exit,vector3(0.0, 0.0, 0.0), vector3(0.0, 0.0, 0.0), vector3(1.0, 1.0, 1.0), 0.0, 0.0, 110.0, 0.55, 0.75, 0.25, 202, 0, 0, 255, false, false, 1, false, false, false, false)


            if IsControlJustReleased(0, 38) then
                ESX.UI.Menu.CloseAll()

                local elements = {
                    {label = 'Emin misiniz?', value = 'exit'},
                }

                ESX.UI.Menu.Open(
                    'default', GetCurrentResourceName(), 'manage_door',
                {
                    title = 'Çıkış Yap',
                    align = 'right',
                    elements = elements,
                },
                function(data, menu)
                    if data.current.value == 'exit' then
                        -- ESX.TriggerServerCallback('umt-warehouse:hasGuests', function(has)
                            if not has then
                                ESX.UI.Menu.CloseAll()
                                TriggerServerEvent('umt-warehouse:deleteInstance')
                                Wait(500)
                                in_house = false
                                housespawn = false
                                return
                            else
                                ESX.ShowNotification(Strings['Guests'])
                            end
                        -- end)
                    end
                end, 
                    function(data, menu)
                    menu.close()
                end)
            end
        end
        Wait(0)
    end
    DeleteObject(house)
    for k, v in pairs(placed_furniture) do
        DeleteObject(v)
    end
end)



RegisterNetEvent('umt-warehouse:leaveHouse')
AddEventHandler('umt-warehouse:leaveHouse', function(house)
    local player = PlayerPedId()
    local vehicle = GetVehiclePedIsIn(playerPed, false)


    DoScreenFadeOut(300)
    while not IsScreenFadedOut() do Wait(0) end
        if IsPedInAnyVehicle(player, true) then 
        SetEntityCoords(GetVehiclePedIsUsing(PlayerPedId()), Config.Houses[house]['door'])
        else
        SetEntityCoords(PlayerPedId(), Config.Houses[house]['door'])
        while IsEntityWaitingForWorldCollision(PlayerPedId()) do   
        SetEntityCoords(PlayerPedId(), Config.Houses[house]['door'])
         Wait(50)
        end
    end
    -- DeleteObject(house)
    DoScreenFadeIn(300)
end)


RegisterNetEvent('umt-warehouse:reloadHouses')
AddEventHandler('umt-warehouse:reloadHouses', function()
    while ESX == nil do TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end) Wait(0) end
    while ESX.GetPlayerData().job == nil do Wait(0) end
    TriggerServerEvent('umt-warehouse:getOwned')
end)


RegisterNetEvent('umt-warehouse:setHouse')
AddEventHandler('umt-warehouse:setHouse', function(house, purchasedHouses)
    OwnedHouse = house

    for k, v in pairs(blips) do
        RemoveBlip(v)
    end

    for k, v in pairs(purchasedHouses) do
        if v.houseid ~= OwnedHouse.houseId then
            AvailableHouses[v.houseid] = v.houseid
        end
    end

    for k, v in pairs(Config.Houses) do
        if OwnedHouse.houseId == k then
            CreateBlip(v['door'], 40, 3, 0.75, Strings['Your_House'])
        else
            if not AvailableHouses[k] then
                if Config.AddHouseBlips then
                    CreateBlip(v['door'], 374, 0, 0.45, '')
                end
            else
                if Config.AddBoughtHouses then
                    CreateBlip(v['door'], 374, 2, 0.45, Strings['Player_House'])
                end
            end
        end
    end
end)

EnterHouse = function(prop, coords)
    local obj = CreateObject(prop, coords, false)
    FreezeEntityPosition(obj, true)
    return obj
end

HelpText = function(msg, coords)
    if not coords or not Config.Use3DText then
        AddTextEntry(GetCurrentResourceName(), msg)
        DisplayHelpTextThisFrame(GetCurrentResourceName(), false)
    else
        DrawText3D(coords, string.gsub(msg, "~INPUT_CONTEXT~", "~r~[~w~E~r~]~w~"), 0.35)
    end
end

CreateBlip = function(coords, sprite, colour, scale, text)
    local blip = AddBlipForCoord(coords)
    SetBlipSprite(blip, sprite)
    SetBlipColour(blip, colour)
    SetBlipAsShortRange(blip, true)
    SetBlipScale(blip, scale)
    BeginTextCommandSetBlipName("STRING")
    AddTextComponentString(text)
    EndTextCommandSetBlipName(blip)
    table.insert(blips, blip)
end



local enableField = false

function toggleField(enable)
  SetNuiFocus(enable, enable)
  enableField = enable
    SendNUIMessage({
        type = "enableui",
        enable = enable
    })
end

RegisterNUICallback('escape', function(data, cb)
    toggleField(false)
    SetNuiFocus(false, false)
    cb('ok')
end)


RegisterNUICallback('try', function(data, cb, evNo)
    toggleField(false)
    local code = tonumber(data.code)
    local playerCoords = GetEntityCoords(PlayerPedId())
    local evNo = Config.Houses


    for k, v in pairs(evNo) do

        if Vdist2(GetEntityCoords(PlayerPedId()), v['door']) <= 6.5 then
          ESX.TriggerServerCallback('umt-warehouse:getHousePassword', function(housepassword)

            if housepassword == code then
              v.locked = not v.locked

            --   if OwnedHouse.houseId == k then   -- EĞERKİ EV SAHİBİ HARİCİ GİRMESİNİ İSTEMİYORSAN KAPALI YERLERİ AÇABİLİRSİN
                  TriggerServerEvent('umt-warehouse:enterHouse', k)
                  housespawn = true
            --   else
                --   TriggerEvent('notification', 'Bu yer senin değil', 4)
            --   end
            end
          end,  OwnedHouse.houseId)
        end
    end
    
    cb('ok')
  end)





  ----- CONTRACT KISMI

----  if OwnedHouse.houseid == k then & diyip ev ayarlarını açtırabiliriz 
----  else attırıp 
  local selectedHouse = nil
  local evNo = Config.Houses
  local satinalindi = false
--   Citizen.CreateThread(function()
--     local satinalindi = false
--       while true do
--         -- print(satinalindi)
--           if not satinalindi  then
            
--               local pedCoords = GetEntityCoords(PlayerPedId())
  
--             --   for i = 1, #Config.Houses, 1 do
--                 for k, v in pairs(Config.Houses) do
--                   local dst = GetDistanceBetweenCoords(pedCoords, v['door'], true)
  
--                   if dst <= 2.5  then
--                       -- marker çizme ve help text
--                       HelpText('[E] - satın al',  v['door'])
--                       DrawMarker(22, v['door'], vector3(0.0, 0.0, 0.0), vector3(0.0, 0.0, 0.0), vector3(1.0, 1.0, 1.0), 165, 40, 36, 150, false, false, 1, false, false, false)
--                       if dst <= 1.0 and IsControlJustReleased(0, 38) then
--                         satinalindi = true
--                           OpenBuyMenu(evNo) -- buradaki i tablodaki pozisyon yani ev no
--                           TriggerEvent('umt-warehouse:client:viewHouse', evNo)
--                       end
--                   end                
--               end
--               Citizen.Wait(0)
--             else
--               Citizen.Wait(1000)
--           end
--       end
--   end)

    -- end

Citizen.CreateThread(function()
    local player = PlayerPedId()
    while true do
        local sleepthread = 1000
        for k, v in pairs(Config.Houses) do
            if Vdist2(GetEntityCoords(PlayerPedId()), v['door']) <= 3.5 then
                if Vdist2(GetEntityCoords(PlayerPedId()), v['door']) <= 2.5 then
                    sleepthread = 10
                end
                    while OwnedHouse == nil do
                    local sleepthread = 1000
                    sleepthread = 10
                    end
                    TriggerEvent('umt-warehouse:faraway')
            end
        end
        Citizen.Wait(sleepthread)
    end
end)


RegisterNetEvent('umt-warehouse:faraway')  -- deneme kısmı
AddEventHandler('umt-warehouse:faraway', function()
    for k, v in pairs(Config.Houses) do
        Wait(0)
        if OwnedHouse.houseId == k then
            local menuopen = false
                local pedCoords = GetEntityCoords(PlayerPedId())
                local dst = GetDistanceBetweenCoords(pedCoords, v['door'], true)

                if dst <= 5.5 then
                        DrawText3D(pedCoords, "[E] EV YONETIMI")

                        if IsControlJustReleased(0, 38) then
                            myHouse()
                            menuopen = true
                    end
                end
            else
                local pedCoords = GetEntityCoords(PlayerPedId())
                local dst = GetDistanceBetweenCoords(pedCoords, v['door'], true)

                if dst <= 2.5 then
                    -- DrawMarker(22, v['door'], vector3(0.0, 0.0, 0.0), vector3(0.0, 0.0, 0.0), vector3(1.0, 1.0, 1.0), 165, 40, 36, 150, false, false, 1, false, false, false)
                    DrawText3D(pedCoords, "[E] SATIN AL")
                    -- if dist <= 1.0 then
                    if IsControlJustReleased(0, 38) then
                        -- HelpText('[E] - satın al  (DENEME)',  v['door'])
                        OpenBuyMenu(evNo)
                        TriggerEvent('umt-warehouse:client:viewHouse', evNo)
                    end
                end
            end
        end
end)






function OpenBuyMenu(evNo)
    for k, v in pairs(evNo) do
        openContract(true)
    end
end
  
  
  RegisterNUICallback("buy", function(evNo)
    local evNo = Config.Houses

    for k, v in pairs(evNo) do

        if Vdist2(GetEntityCoords(PlayerPedId()), v['door']) <= 6.5 then
            
            TriggerServerEvent("umt-warehouse:buyHouse", k)
            Wait(200)
            exports['mythic_notify']:SendAlert('error', 'Ev Yönetiminden şifrenizi oluşturunuz')

             Wait(1200)
            -- SetNuiFocus(true, true)
            -- ChangePassword(k)
            satinalindi = true
            
            end
        end
    end)

  

-- purchased = false'yi evi almış olarak değerlendir
-- purchased == true ''
  
-- Citizen.CreateThread(function()
--     local player = PlayerPedId()
--     -- local prop = Config.Houses[OwnedHouse.houseId]['prop']

--     while true do
--         Citizen.Wait(1)
--         for k, v in pairs(Config.Houses) do
--             if Vdist2(GetEntityCoords(PlayerPedId()), v['door']) <= 10  then
--             HelpText('[E] - satın al', v['door'])
--             DrawMarker(22, v['door'], vector3(0.0, 0.0, 0.0), vector3(0.0, 0.0, 0.0), vector3(1.0, 1.0, 1.0), 165, 40, 36, 150, false, false, 1, false, false, false)
--             if IsControlJustReleased(0, 38) then
--                 TriggerEvent('umt-warehouse:client:viewHouse')

--                 end
--             end
--         end
--     end
-- end)



  function InstructionButton(ControlButton)
    N_0xe83a3e3557a56640(ControlButton)
end

function InstructionButtonMessage(text)
    BeginTextCommandScaleformString("STRING")
    AddTextComponentScaleform(text)
    EndTextCommandScaleformString()
end

function disableViewCam()
    if viewCam then
        RenderScriptCams(false, true, 500, true, true)
        SetCamActive(cam, false)
        DestroyCam(cam, true)
        viewCam = false
    end
end

function openContract(bool)
    SetNuiFocus(bool, bool)
    SendNUIMessage({
        type = "toggle",
        status = bool,
    })
    contractOpen = bool
end


RegisterNUICallback('exit', function()
    openContract(false)
    disableViewCam()
end)



function setViewCam(coords, h, yaw)
    cam = CreateCamWithParams("DEFAULT_SCRIPTED_CAMERA", 855.8841, -2120.14, 30.646, yaw, 0.00, h, 80.00, false, 0)
    SetCamActive(cam, true)
    RenderScriptCams(true, true, 500, true, true)
    viewCam = true
end

RegisterNetEvent('umt-warehouse:client:viewHouse')
AddEventHandler('umt-warehouse:client:viewHouse', function(houseprice, brokerfee, bankfee, taxes, firstname, lastname)
    -- setViewCam(Config.Houses[closesthouse].coords.cam, Config.Houses[closesthouse].coords.cam.h, Config.Houses[closesthouse].coords.yaw)
    local evNo = Config.Houses


    for k, v in pairs(evNo) do

        if Vdist2(GetEntityCoords(PlayerPedId()), v['door']) <= 6.5 then

    Citizen.Wait(500)
    openContract(true)
    SendNUIMessage({
        type = "setupContract",
        firstname = firstname,
        lastname = lastname,
        street = v['prop'],
        houseprice = v['price'],
        brokerfee = math.random(100, 100),
        bankfee = math.random(100, 1000),
        taxes = math.random(100, 4000),
        totalprice = (v['price'] + math.random(100, 100) + math.random(100, 1000) + math.random(100, 4000))
    })
        end
    end
end)


