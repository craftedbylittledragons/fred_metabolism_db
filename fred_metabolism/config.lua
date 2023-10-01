 
Config = {

    -- ##### SELECT YOUR FRAMEWORK #####
    -- IMPORTANT: ONLY ONE MUST BE TRUE, OTHERS SHOULD BE FALSE.
    ["VORP"] = true,
    ["RedEM"] = false,
    -- #################################
    
    -- NOTIFICATIONS
    ["MSG"] = "You consumed ", -- Message to display when consumed 
    ["LowFoodNotification"] = "You are hungry!", -- When your food is low it displays this notification
    ["LowWaterNotification"] = "You are thirsty!", -- When your water is low it displays this notification
    ["FoodNotification"] = 10, -- Determines when the ["LowFoodNotification"] notifications displays
    ["WaterNotification"] = 20, -- Determines when the ["LowWaterNotification"] notifications displays 
     
    -- INITIAL VALUES
    ["InitialFood"] = 100, -- INITIAL FOOD -- MAX VALUE 100%
    ["InitialWater"] = 100, -- INITIAL FOOD -- MAX VALUE 100%
    
    -- AFTER DEATH VALUES
    ["AfterDeathFood"] = 25, -- After you die your food is set to this value
    ["AfterDeathWater"] = 25, -- After you die your water is set to this value
    
    -- METABOLISM
    -- **IMPORTANT: REMEMBER FEMALE PLAYERS MAY NOT UPDATE ITS BODY**
    ["MetabolismFiesta"] = false, -- This will disable visual body changes
    
    ["InitialMetabolism"] = 10000, -- Initial metabolism where 0 is super skinny and 20000 is super fat, 10000 would be normal
    ["MetabolismLossIdle"] = 1, -- Metabolism drop rate while on stand by
    ["MetabolismLossWalking"] = 1.5, -- Metabolism drop rate per tick while walking
    ["MetabolismLossRunning"] = 2, -- Metabolism drop rate per tick while running. Go do some exercise!
    
    -- TICK: This is the time (rate) it takes to excecute every check 
    -- For e.g: 2 food is drain per tick
    -- 1000 = 1 second; 20000 = 20 seconds; 3600 = 3,5 seconds
    -- **WARNING: ONLY TOUCH THIS VARIABLES IF YOU NEED, MAY HIGHLY AFFECT OPERATION**
    ["NeedsTick"] = 50000, -- Checks your needs over time
    ["MetabolismTick"] = 30000, -- Checks your metabolism over time
    
    -- DRAINS PER TICK ("NeedsTick")
    ["FoodDrainIdle"] = 0.2, -- Food drop rate on stand by
    ["FoodDrainRunning"] = 0.5, -- Food drop rate while running
    ["FoodDrainWalking"] = 0.3, -- Food drop rate while walking
    ["WaterDrainIdle"] = 0.4, -- Water drop rate on stand by
    ["WaterDrainRunning"] = 1, -- Water drop rate while running
    ["WaterDrainWalking"] = 0.6, -- Water drop rate while walking
    
    -- HEALTH LOSS STRIPE
    ["HealthLoss"] = 5, -- Health you lose per tick
    ["FoodStripe"] = 0, -- Food stripe that determines when you start to lose health
    ["WaterStripe"] = 0, -- Water stripe that determines when you start to lose health
    
    -- TEMPERATURE DEBUFF STRIPE
    ["TooCold!"] = true, -- Enables/disables Temperature System
    ["MinTemperature"] = -19, -- -20°C From this temperature below, you'll lose more food and water
    ["MaxTemperature"] = 36, -- 20°C From this temperature above, you'll lose more food and water
    ["TempNotify1"] = "You are feeling very cold, you should cover yourself more!!",
    ["TempNotify2"] = "You're cold, you should cover yourself",
    ["TempNotify3"] = "You're freezing cover yourself up, otherwise you will die!",
    
    -- FOOD AND WATER DROP RATE FROM TEMPERATURE
    ["WaterHotLoss"] = 1.5, -- Water drop rate increment for higher temperatures
    ["FoodColdLoss"] = 1.5, -- Food drop rate increment for lower temperatures
    
    -- DRUNK SYSTEM
    ["VomitMe"] = true, -- Enables/disables Vomit system.
    
    -- CLOTHES TEMPERATURE
    -- Temperature increment each clothes gives.
    ["HatTemp"] = 1, -- Hats
    ["ShirtTemp"] = 2, -- Shirts
    ["PantsTemp"] = 2, -- Pants
    ["BootsTemp"] = 2, -- Boots
    ["CoatTemp"] = 3, -- Coats
    ["ClosedCoatTemp"] = 4, -- Closed Coats
    ["GlovesTemp"] = 1, -- Gloves
    ["VestTemp"] = 1, -- Vest
    ["PonchoTemp"] = 5, -- Poncho
    }
     
-- ANIMATION LIST
    -- Thanks to @Chico for helping me get all this cool animations. 
    -- 'eat' = You will make a simple eat animation with any prop you select to it ("PropName" variable)
    -- 'drink' = You will make a simple drink animation with any prop you select to it ("PropName" variable)
    -- 'drink_cup' = Drink from a coffee cup
    -- 'bowl' = Animation where you eat from a bowl
    -- 'shortbottle' = Animation where you drink from a short bottle
    -- 'longbottle' = Animation where you drink from a long bottle
    -- 'syringe' = Animation to inject yourself with a syringe
    -- 'berry' = Animation where you eat berries
    
    -- SOME PROPS
    -- p_bottlejd01x = Whyskey bottle
    -- p_bottlebeer01a = Beer bottle
    -- p_bottlewine01x = Wine bottle
    -- You can find more props in http://rdr2.mooshe.tv/
    
    -- SOME EFFECTS
    -- PlayerDrunk01
    -- PlayerDrunkAberdeen
    -- PlayerDrugsPoisonWell
    -- You can find more effects in https://github.com/femga/rdr3_discoveries/blob/master/graphics/animpostfx/animpostfx.lua
    
    -- JUST ADD YOUR ITEMS HERE WITH THE VALUES YOU WANT
    -- CHECK YOUR COMMAS AND TYPING!!!
    -- MAKE SURE YOU CHANGE THE DEFAULT VALUES. THE ONES DISPLAYED HERE ARE TEST VALUES!-
 

    Config.ItemsToUse = {  -- do not change this array, it's just the initializer for the automated db
		{	
        ["Name"] = "water",	
        ["TYPE"] = "Drink",
        ["DisplayName"] = "Water",			 
        ["Animation"] = "",		
        ["PropName"] = "",		
        ["Metabolism"] = 0,	 	
		["Hunger"] = 0,		
        ["Thirst"] = 11,		

        ["InnerCoreStamina"] = 0,		
        ["InnerCoreStaminaGold"] = 0,	

        ["InnerCoreHealth"] = 0, 
        ["InnerCoreHealthGold"] = 0,		

        ["OuterCoreStaminaGold"] = 0,	 		
        ["OuterCoreHealthGold"] = 0,		

        ["HardAlcohol"] = false,		
        ["SoftAlcohol"] = false,		

        ["DrinkCount"] = 0,		
        ["Effect"] = "",		
        ["EffectDuration"] = 0,		
       	},    
    }
    
    Config.SPECIAL_ITEMS = {  -- Add special items here. 
    -- These are items you want full control over the settings. 
    -- These are loaded last, so that the settings over ride the database entries. 
        {	
            ["Name"] = "holywater",	
            ["TYPE"] = "Special", -- do not change this flag.
            ["DisplayName"] = "Holy Water",			 
            ["Animation"] = "longbottle",		
            ["PropName"] = "",		
            ["Metabolism"] = 0,	 	
            ["Hunger"] = 0,		
            ["Thirst"] = 11,		
            ["InnerCoreStamina"] = 0,		
            ["InnerCoreStaminaGold"] = 0,		
            ["OuterCoreStaminaGold"] = 0,		
            ["InnerCoreHealth"] = 0,			
            ["InnerCoreHealthGold"] = 0,		
            ["OuterCoreHealthGold"] = 0,		
            ["HardAlcohol"] = false,		
            ["SoftAlcohol"] = false,		
            ["DrinkCount"] = 0,		
            ["Effect"] = "",		
            ["EffectDuration"] = 0,		
        },    
    }
 
    Config.ScriptName = GetCurrentResourceName()