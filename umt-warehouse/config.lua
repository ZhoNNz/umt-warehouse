Config = {
    SellPercentage = 75, 
    AddHouseBlips = true,
    AddBoughtHouses = false, 
    EnableGarage = false, 
    Use3DText = false, 
    
    Props = { 
        ['warehouse1'] = `shell_warehouse1`,
        ['warehouse2'] = `shell_warehouse2`,
        ['warehouse3'] = `shell_warehouse3`,
        ['warehouse4'] = `shell_weed`,
        ['warehouse5'] = `shell_weed2`,
        ['warehouse6'] = `shell_coke1`
    },


    Offsets = { 
        ['warehouse1'] = {['door'] = vector3(5.50, 0.99, -1.39), ['storage'] = vector3(0.17, -3.51, -1.39) , ['spawn_furniture'] = vector3(1.046143, 0.06665039, -1.398043)},
        ['warehouse2'] = {['door'] = vector3(8.0, 0.11, -1.36), ['storage'] = vector3(-0.19, 2.23, -1.69), ['spawn_furniture'] = vector3(3.002892, 0.9969482, -1.359673)},
        ['warehouse3'] = {['door'] = vector3(-0.6, 0.0, -2.41), ['storage'] = vector3(1.60, 0.0, -1.41), ['spawn_furniture'] = vector3(7.177441, 0.05088806, -2.416786)},
        ['warehouse4'] = {['door'] = vector3(6.35, -1.80, -1.47), ['storage'] = vector3(-6.50, 2.0, -1.490), ['spawn_furniture'] = vector3(1.285862, 0.1700745, -1.462135)},
        ['warehouse5'] = {['door'] = vector3(5.35, 2.80, -1.47), ['storage'] = vector3(-6.50, 2.0, -1.490), ['spawn_furniture'] = vector3(-0.4546165, 2.853912, -0.6442719)},-- buradaki map illeegaller için yapılmıştır
        ['warehouse6'] = {['door'] = vector3(3.65, 0.8, -1.482468), ['storage'] = vector3(-5.65, 6.87549, -1.482468), ['spawn_furniture'] = vector3(-3.95883, 1.823792, -1.475471)}
    },
    Houses = { 
        {['prop'] = 'warehouse2', ['door'] = vector3(925.8994, -2308.06, 30.509), ['price'] = 1},
        {['prop'] = 'warehouse2', ['door'] = vector3(751.3571, -1849.84, 29.291), ['price'] = 1},
        {['prop'] = 'warehouse1', ['door'] = vector3(790.4193, -2191.24, 29.551), ['price'] = 1},
        {['prop'] = 'warehouse3', ['door'] = vector3(820.7659, -2116.80, 29.357), ['price'] = 1},
        {['prop'] = 'warehouse4', ['door'] = vector3(943.0275, -1493.64, 30.093), ['price'] = 1},
        {['prop'] = 'warehouse5', ['door'] = vector3(933.6350, -1804.26, 30.722), ['price'] = 1}, 
        {['prop'] = 'warehouse6', ['door'] = vector3(855.5836, -2120.39, 30.636), ['price'] = 1},
        {['prop'] = 'warehouse3', ['door'] = vector3(995.4709, -1857.17, 30.889), ['price'] = 1},
        {['prop'] = 'warehouse4', ['door'] = vector3(947.0319, -1697.73, 29.691), ['price'] = 1},
        {['prop'] = 'warehouse6', ['door'] = vector3(943.3812, -1456.41, 31.334), ['price'] = 1},
        {['prop'] = 'warehouse6', ['door'] = vector3(752.7078, -1900.92, 29.217), ['price'] = 1},
        {['prop'] = 'warehouse6', ['door'] = vector3(880.6254, -1572.12, 30.787), ['price'] = 1},
        
    },

    lesterCoords = {
        lesterNPC = {
            coords = vector3(-1443.14, -535.599, 33.740)
        }
    },

    challengeCoords = {
        weaponChallenge = {
            coords = vector3(1740.497, 3326.664, 41.223)
        },
        
        weaponbuyingChallenge = {
            coords = vector3(2531.919, 4988.352, 43.940)
        },
    
        vehiclechallengecar = {
            coords = vector3(-361.344, 6098.013, 30.705)
        },
    
        vehiclesellingChallenge = {
            coords = vector3(851.4471, 2131.864, 52.10)
        },
    
        itemchallenge = {
            coords = vector3(-2079.13, -1019.08, 5.8817)
        },
    
        itembuyingChallenge = {
            coords = vector3(714.1986, 2525.800, 72.648)
        }
    },
    weaponchallangeMoney = {
        -- Alış;
        PistolBuying = 500,
        MicroSMGBuying = 1500,
        SMGBuying = 2500,
    
        -- Teslimat;
        PistolReward = 2500,
        MicroSMGReward = 4000,
        SMGReward = 7500
    },

    vehiclechallengeMoney = {
        vehiclesellingMoney = 5000
    },

    vehicle = {
        "seven70"
    },

    
    Houses = { 
        [1] = {name = 'warehouse2', coords = vector3(925.8994, -2308.06, 30.509), price = 1},
        [2] = {name = 'warehouse2', coords = vector3(751.3571, -1849.84, 29.291), price = 1},
        [3] = {name = 'warehouse1', coords = vector3(790.4193, -2191.24, 29.551), price = 1},
        [4] = {name = 'warehouse3', coords = vector3(820.7659, -2116.80, 29.357), price = 1},
        [5] = {name = 'warehouse4', coords = vector3(943.0275, -1493.64, 30.093), price = 1},
        [6] = {name = 'warehouse5', coords = vector3(933.6350, -1804.26, 30.722), price = 1}, -- buradaki map illeegaller için yapılmıştır
        [7] = {name = 'warehouse6', coords = vector3(855.5836, -2120.39, 30.636), price = 1},
        [8] = {name = 'warehouse3', coords = vector3(995.4709, -1857.17, 30.889), price = 1},
        [9] = {name = 'warehouse4', coords = vector3(947.0319, -1697.73, 29.691), price = 1},
        [10] = {name = 'warehouse6', coords = vector3(752.7078, -1900.92, 29.217), price = 1},
        [11] = {name = 'warehouse6', coords = vector3(880.6254, -1572.12, 30.787), price = 1},
        
    },

    HouseSpawns = { 
        {['taken'] = false, ['coords'] = vector3(1020.0, 2000.0, -100.0)}, -- spawn #1
        {['taken'] = false, ['coords'] = vector3(1080.0, 2000.0, -100.0)}, -- spawn #2
        {['taken'] = false, ['coords'] = vector3(1140.0, 2000.0, -100.0)}, -- spawn #3
        {['taken'] = false, ['coords'] = vector3(1200.0, 2000.0, -100.0)}, -- spawn #4
        {['taken'] = false, ['coords'] = vector3(1260.0, 2000.0, -100.0)}, -- spawn #5
        {['taken'] = false, ['coords'] = vector3(1320.0, 2000.0, -100.0)}, -- spawn #6
        {['taken'] = false, ['coords'] = vector3(1380.0, 2000.0, -100.0)}, -- spawn #7
        {['taken'] = false, ['coords'] = vector3(1440.0, 2000.0, -100.0)}, -- spawn #8
        {['taken'] = false, ['coords'] = vector3(1500.0, 2000.0, -100.0)}, -- spawn #9
        {['taken'] = false, ['coords'] = vector3(1560.0, 2000.0, -100.0)}, -- spawn #10
        {['taken'] = false, ['coords'] = vector3(1620.0, 2000.0, -100.0)}, -- spawn #11
        {['taken'] = false, ['coords'] = vector3(1680.0, 2000.0, -100.0)}, -- spawn #12
        {['taken'] = false, ['coords'] = vector3(1740.0, 2000.0, -100.0)}, -- spawn #13
        {['taken'] = false, ['coords'] = vector3(1800.0, 2000.0, -100.0)}, -- spawn #14
        {['taken'] = false, ['coords'] = vector3(1860.0, 2000.0, -100.0)}, -- spawn #15
        {['taken'] = false, ['coords'] = vector3(1920.0, 2000.0, -100.0)}, -- spawn #16
        {['taken'] = false, ['coords'] = vector3(1980.0, 2000.0, -100.0)}, -- spawn #17
        {['taken'] = false, ['coords'] = vector3(2040.0, 2000.0, -100.0)}, -- spawn #18
        {['taken'] = false, ['coords'] = vector3(2100.0, 2000.0, -100.0)}, -- spawn #19
        {['taken'] = false, ['coords'] = vector3(2160.0, 2000.0, -100.0)}, -- spawn #20
        {['taken'] = false, ['coords'] = vector3(2220.0, 2000.0, -100.0)}, -- spawn #21
        {['taken'] = false, ['coords'] = vector3(2280.0, 2000.0, -100.0)}, -- spawn #22
        {['taken'] = false, ['coords'] = vector3(2340.0, 2000.0, -100.0)}, -- spawn #23
        {['taken'] = false, ['coords'] = vector3(2400.0, 2000.0, -100.0)}, -- spawn #24
        {['taken'] = false, ['coords'] = vector3(2460.0, 2000.0, -100.0)}, -- spawn #25
        {['taken'] = false, ['coords'] = vector3(2520.0, 2000.0, -100.0)}, -- spawn #26
        {['taken'] = false, ['coords'] = vector3(2580.0, 2000.0, -100.0)}, -- spawn #27
        {['taken'] = false, ['coords'] = vector3(2640.0, 2000.0, -100.0)}, -- spawn #28
        {['taken'] = false, ['coords'] = vector3(2700.0, 2000.0, -100.0)}, -- spawn #29
        {['taken'] = false, ['coords'] = vector3(2760.0, 2000.0, -100.0)}, -- spawn #30
        {['taken'] = false, ['coords'] = vector3(2820.0, 2000.0, -100.0)}, -- spawn #31
        {['taken'] = false, ['coords'] = vector3(2880.0, 2000.0, -100.0)}, -- spawn #32
        {['taken'] = false, ['coords'] = vector3(2940.0, 2000.0, -100.0)}, -- spawn #33

        {['taken'] = false, ['coords'] = vector3(1020.0, 2100.0, -100.0)}, -- spawn #34
        {['taken'] = false, ['coords'] = vector3(1080.0, 2100.0, -100.0)}, -- spawn #35
        {['taken'] = false, ['coords'] = vector3(1140.0, 2100.0, -100.0)}, -- spawn #36
        {['taken'] = false, ['coords'] = vector3(1200.0, 2100.0, -100.0)}, -- spawn #37
        {['taken'] = false, ['coords'] = vector3(1260.0, 2100.0, -100.0)}, -- spawn #38
        {['taken'] = false, ['coords'] = vector3(1320.0, 2100.0, -100.0)}, -- spawn #39
        {['taken'] = false, ['coords'] = vector3(1380.0, 2100.0, -100.0)}, -- spawn #40
        {['taken'] = false, ['coords'] = vector3(1440.0, 2100.0, -100.0)}, -- spawn #41
        {['taken'] = false, ['coords'] = vector3(1500.0, 2100.0, -100.0)}, -- spawn #42
        {['taken'] = false, ['coords'] = vector3(1560.0, 2100.0, -100.0)}, -- spawn #43
        {['taken'] = false, ['coords'] = vector3(1620.0, 2100.0, -100.0)}, -- spawn #44
        {['taken'] = false, ['coords'] = vector3(1680.0, 2100.0, -100.0)}, -- spawn #45
        {['taken'] = false, ['coords'] = vector3(1740.0, 2100.0, -100.0)}, -- spawn #46
        {['taken'] = false, ['coords'] = vector3(1800.0, 2100.0, -100.0)}, -- spawn #47
        {['taken'] = false, ['coords'] = vector3(1860.0, 2100.0, -100.0)}, -- spawn #48
        {['taken'] = false, ['coords'] = vector3(1920.0, 2100.0, -100.0)}, -- spawn #49
        {['taken'] = false, ['coords'] = vector3(1980.0, 2100.0, -100.0)}, -- spawn #50
        {['taken'] = false, ['coords'] = vector3(2040.0, 2100.0, -100.0)}, -- spawn #51
        {['taken'] = false, ['coords'] = vector3(2100.0, 2100.0, -100.0)}, -- spawn #52
        {['taken'] = false, ['coords'] = vector3(2160.0, 2100.0, -100.0)}, -- spawn #53
        {['taken'] = false, ['coords'] = vector3(2220.0, 2100.0, -100.0)}, -- spawn #54
        {['taken'] = false, ['coords'] = vector3(2280.0, 2100.0, -100.0)}, -- spawn #55
        {['taken'] = false, ['coords'] = vector3(2340.0, 2100.0, -100.0)}, -- spawn #56
        {['taken'] = false, ['coords'] = vector3(2400.0, 2100.0, -100.0)}, -- spawn #57
        {['taken'] = false, ['coords'] = vector3(2460.0, 2100.0, -100.0)}, -- spawn #58
        {['taken'] = false, ['coords'] = vector3(2520.0, 2100.0, -100.0)}, -- spawn #59
        {['taken'] = false, ['coords'] = vector3(2580.0, 2100.0, -100.0)}, -- spawn #60
        {['taken'] = false, ['coords'] = vector3(2640.0, 2100.0, -100.0)}, -- spawn #61
        {['taken'] = false, ['coords'] = vector3(2700.0, 2100.0, -100.0)}, -- spawn #62
        {['taken'] = false, ['coords'] = vector3(2760.0, 2100.0, -100.0)}, -- spawn #63
        {['taken'] = false, ['coords'] = vector3(2820.0, 2100.0, -100.0)}, -- spawn #64
        {['taken'] = false, ['coords'] = vector3(2880.0, 2100.0, -100.0)}, -- spawn #65
        {['taken'] = false, ['coords'] = vector3(2940.0, 2100.0, -100.0)}, -- spawn #66
    }
}
lesterCoords = {
    lesterNPC = {
        coords = vector3(-1443.14, -535.599, 33.740)
    }
}

Strings = {
    ['Press_E'] = 'Press ~INPUT_CONTEXT~ to %s',
    ['Furniture_Categories'] = 'Categories',
    ['Manage_House'] = 'manage your house',
    ['Buy_House'] = 'buy house #%s',
    ['Knock_House'] = 'knock on the door',
    ['Your_House'] = 'Warehouse',
    ['Buyable_House'] = 'Buyable house',
    ['Player_House'] = 'Satın alınmış Warehouse',
    ['Storage'] = 'access your storage',
    ['Sell_House'] = 'Sell for $%s',
    ['Enter_House'] = 'Enter house',
    ['Sell_Confirm'] = 'Sell house for $%s?',
    ['yes'] = 'Yes',
    ['no'] = 'No',
    ['Sold_House'] = 'You sold your house for $%s',
    ['Must_Sell'] = 'You can only own one house. Sell your house to buy this one.',
    ['Buy_House_Confirm'] = 'Buy house #%s for $%s?',
    ['Manage_Door'] = 'Evini Yönet',
    ['Accept'] = 'Accept someone to enter',
    ['Exit'] = 'Leave the house',
    ['Noone_Home'] = 'Noone seems to be home!',
    ['Someone_Knocked'] = 'Someone knocked. Go to the door to let them in!',
    ['Let_In'] = 'Kapıyı Çalan Kişiyi İçeri Al',
    ['Accept_Player'] = 'Let %s in?',
    ['Waiting_Owner'] = 'Waiting for the house owner to let you in.',
    ['Buying_Furniture'] = '~INPUT_FRONTEND_LEFT~ ~INPUT_FRONTEND_RIGHT~ browse\n~INPUT_CELLPHONE_DOWN~ ~INPUT_CELLPHONE_UP~ change category (%s)\n~INPUT_FRONTEND_RDOWN~ buy %s for $%s\n~INPUT_MOVE_UP_ONLY~ ~INPUT_MOVE_DOWN_ONLY~ ~INPUT_VEH_CINEMATIC_UP_ONLY~ ~INPUT_VEH_CINEMATIC_DOWN_ONLY~ adjust camera\n~INPUT_MOVE_LEFT_ONLY~ ~INPUT_MOVE_RIGHT_ONLY~ rotate\n\n~INPUT_FRONTEND_RRIGHT~ exit',
    ['Confirm_Purchase'] = 'Buy %s for $%s?',
    ['no_money'] = "You don't have enough money.",
    ['Bought_Furniture'] = 'Bought 1x %s for $%s',
    ['Furnish'] = 'Furnish your house',
    ['Store_Garage'] = 'Press ~INPUT_CONTEXT~ to store the vehicle', 
    ['Re_Furnish'] = 'Remove placed furniture',
    ['Remove'] = 'Remove %s (#%s)',
    ['Amount'] = 'How many?',
    ['Player_Inventory'] = 'Your inventory',
    ['House_Inventory'] = 'Inventory',
    ['Invalid_Amount'] = 'Invalid amount. Please put a number.',
    ['Store'] = 'Store',
    ['Withdraw'] = 'Withdraw',
    ['Storage_Title'] = 'Storage',
    ['You_Stored'] = 'You stored %sx %s',
    ['You_Withdrew'] = 'You withdrew %sx %s',
    ['Not_Enough'] = 'You don\'t have that many!',
    ['Not_Enough_House'] = 'There\'s not that many in the storage!',
    ['Weapons'] = 'Weapons',
    ['Items'] = 'Items',
    ['No_Weapon'] = 'You don\'t have that weapon on you!',
    ['bullets'] = 'bullets', 
    ['Rotation'] = 'rotation',
    ['Guests'] = 'Your guests need to leave the house before you may do this.',
    ['Garage'] = 'Enter garage',
    ['No_Spawn'] = 'Couldn\'t find a spawnpoint for your house.',
    ['Host_Left'] = 'The house owner left the server, you were kicked out of their house.',
    ['No_Money'] = 'You don\'t have enough money!',
    ['Furnishing'] = '~INPUT_CELLPHONE_LEFT~ ~INPUT_CELLPHONE_RIGHT~ ~INPUT_CELLPHONE_DOWN~ ~INPUT_CELLPHONE_UP~ move\n~INPUT_VEH_CINEMATIC_UP_ONLY~ ~INPUT_VEH_CINEMATIC_DOWN_ONLY~ height\n~INPUT_ATTACK~ ~INPUT_AIM~ rotate\n~INPUT_DETONATE~ place on ground\n~INPUT_FRONTEND_ENDSCREEN_ACCEPT~ place\n~INPUT_FRONTEND_CANCEL~ cancel'
}