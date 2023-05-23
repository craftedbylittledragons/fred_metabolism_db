Loaded_Items_LiquidDrink = false
Loaded_Items_LiquidAlcoholDrink = false
Loaded_Items_SolidFood = false
Loaded_Items_Special = false


Citizen.CreateThread(function()  
    Citizen.Wait(20000)   
    ItemsToUse = Config.ItemsToUse -- Initialize changeable variable 
    --print("Server Item Count:", #ItemsToUse)
       
    trigger_breakout = 0
    before_databasecalls = #ItemsToUse
    Loaded_Items_SolidFood = GetItems_SolidFood(ItemsToUse)    
    while Loaded_Items_SolidFood == false do 
        Citizen.Wait(1000) 
        if trigger_breakout >= 10 then 
            break 
        else 
            trigger_breakout = trigger_breakout +1
        end 	
    end  
 
    before_databasecalls = #ItemsToUse
    Loaded_Items_LiquidDrink = GetItems_LiquidDrink(ItemsToUse)     
    while Loaded_Items_LiquidDrink == false do 
        Citizen.Wait(1000) 
        if trigger_breakout >= 10 then 
            break 
        else 
            trigger_breakout = trigger_breakout +1
        end 	
    end  
 
    before_databasecalls = #ItemsToUse
    Loaded_Items_LiquidAlcoholDrink = GetItems_LiquidAlcoholDrink(ItemsToUse)   
    while Loaded_Items_LiquidAlcoholDrink == false do 
        Citizen.Wait(1000) 
        if trigger_breakout >= 10 then 
            break 
        else 
            trigger_breakout = trigger_breakout +1
        end 	
    end   
 
    before_databasecalls = #ItemsToUse
    Loaded_Items_Special = GetItems_Special()   
    while Loaded_Items_Special == false do 
        Citizen.Wait(1000) 
        if trigger_breakout >= 10 then 
            break 
        else 
            trigger_breakout = trigger_breakout +1
        end 	
    end  
    -- no count check, because these items will already exist.
    -- we are just forcing them to hardcoded values after everything has finished loading
    -- on the client side.

    --print("Server Item Count:", #ItemsToUse)
---------------------
--
--REGISTER USABLES--   
--
---------------------
    --print("Loop RegisterUsableItem: ",#ItemsToUse)
    for i,m in pairs(ItemsToUse) do          
    --for i = 1, #ItemsToUse do            
        local index = i        
        if Config["VORP"] == true then
            -- print("VorpInv.RegisterUsableItem: ",ItemsToUse[i]["Name"])
            VorpInv.RegisterUsableItem(ItemsToUse[i]["Name"], function(data)       
                TriggerClientEvent(Config.ScriptName..":useItem", data.source, ItemsToUse[i]["Name"])
                VorpInv.subItem(data.source, ItemsToUse[index]["Name"], 1)
                -- TriggerClientEvent("vorp:TipBottom", data.source, Config["MSG"]..ItemsToUse[index]["DisplayName"], 5000)    
                -- print("vorp:TipBottom TriggerClientEvent",ItemsToUse[i]["Name"])
            end)
        end 
    end    

end)

function GetItems_SolidFood(ItemsToUse)

    local trigger_getitems = false 
    local malformed_entry = false 
    local rowtoupdate = 0
	SQL_READ_QUERY_ITEM  = "SELECT * FROM `items` WHERE `consumable` = 1 and `solidorliquid` = 1 and `medical` = 0 and `alcohol` = 0;"  
    -- call the database
    exports.ghmattimysql:execute(SQL_READ_QUERY_ITEM, function(result)     	

        local ItemName = ""	
        local DisplayName = ""			 
        local Animation = "eat"		
        local PropName = ""		
        local Metabolism = 0	 
        local MetabolismRank = 0	 	 

        --print ("GetItems_SolidFood", #result)
        if result[1] ~= nil then 
            for n,m in pairs(result) do   
                if type(m) == "table" then 
                    for s,t in pairs(m) do 
                        --code goes here                    
                        if(s == "item") then                if t ~= nil then    ItemName = t            end end   
                        if(s == "label") then               if t ~= nil then    DisplayName = t         end end   
                        if(s == "metabolismrank") then      if t ~= nil then    MetabolismRank = t      end end    
                        if(s == "propname") then            if t ~= nil then    PropName = t            end end                         
                    end                     
                end   
                local r = #ItemsToUse+1
                table.insert(ItemsToUse, r)   
                ItemsToUse[r] = {}                 
                BuildItemsToUseTable(r, ItemName,"Food", DisplayName, MetabolismRank, PropName, Animation)        
                
            end        
        end
        trigger_getitems = true
    end) -- exports.ghmattimysql:execute   
    while trigger_getitems == false do 
        Citizen.Wait(100)
    end 
    return(true) 
end --- end the function to load items 


function GetItems_LiquidDrink(ItemsToUse)

    local trigger_getitems = false 
    local malformed_entry = false 
    local rowtoupdate = 0
	SQL_READ_QUERY_ITEM  = "SELECT * FROM `items` WHERE `consumable` = 1 and `solidorliquid` = 0 and `medical` = 0 and `alcohol` = 0;"  
    -- call the database
    exports.ghmattimysql:execute(SQL_READ_QUERY_ITEM, function(result)     	

        local ItemName = ""	
        local DisplayName = ""			 
        local Animation = "drink"		
        local PropName = ""		
        local Metabolism = 0	 	 
        local MetabolismRank = 0	
 
        --print ("GetItems_LiquidDrink", #result)
        if result[1] ~= nil then 
            for n,m in pairs(result) do   
                if type(m) == "table" then 
                    for s,t in pairs(m) do 
                        --code goes here                    
                        if(s == "item") then                if t ~= nil then    ItemName = t            end end   
                        if(s == "label") then               if t ~= nil then    DisplayName = t         end end   
                        if(s == "metabolismrank") then      if t ~= nil then    MetabolismRank = t      end end    
                        if(s == "propname") then            if t ~= nil then    PropName = t            end end                         
                    end                     
                end   
                local r = #ItemsToUse+1
                table.insert(ItemsToUse, r)   
                ItemsToUse[r] = {}                 
                BuildItemsToUseTable(r,  ItemName, "Drink",  DisplayName, MetabolismRank, PropName, Animation)                          

            end        
        end
        trigger_getitems = true
    end) -- exports.ghmattimysql:execute  
    while trigger_getitems == false do 
        Citizen.Wait(100)
    end  
    return(true) 
end --- end the function to load items 


function GetItems_LiquidAlcoholDrink(ItemsToUse)

    local trigger_getitems = false 
    local malformed_entry = false 
    local rowtoupdate = 0
	SQL_READ_QUERY_ITEM  = "SELECT * FROM `items` WHERE `consumable` = 1 and `solidorliquid` = 0 and `medical` = 0 and `alcohol` = 1;"  
    -- call the database
    exports.ghmattimysql:execute(SQL_READ_QUERY_ITEM, function(result)     	

        local ItemName = ""	
        local DisplayName = ""			 
        local Animation = "longbottle"		
        local PropName = ""		
        local Metabolism = 500	 	 
        local MetabolismRank = 0	 
  
        --print ("GetItems_LiquidAlcoholDrink", #result)
        if result[1] ~= nil then 
            for n,m in pairs(result) do    
                if type(m) == "table" then 
                    for s,t in pairs(m) do 
                        --code goes here                    
                        if(s == "item") then                if t ~= nil then    ItemName = t            end end   
                        if(s == "label") then               if t ~= nil then    DisplayName = t         end end   
                        if(s == "metabolismrank") then      if t ~= nil then    MetabolismRank = t      end end    
                        if(s == "propname") then            if t ~= nil then    PropName = t            end end                         
                    end                     
                end       
                local r = #ItemsToUse+1
                table.insert(ItemsToUse, r) 
                ItemsToUse[r] = {}             
                BuildItemsToUseTable(r,   ItemName, "Alcohol",DisplayName, MetabolismRank, PropName, Animation)                         

            end        
        end
        trigger_getitems = true
    end) -- exports.ghmattimysql:execute   
    while trigger_getitems == false do 
        Citizen.Wait(100)
    end   
    return(true) 
end --- end the function to load items 

function GetItems_Special() 

	flag_item_found = false
	for a,b in pairs(Config.SPECIAL_ITEMS) do 
		for n,m in pairs(ItemsToUse) do   
			if ItemsToUse[n]["Name"] == Config.SPECIAL_ITEMS[a]["Name"] then 
				-- item found moving on. 
				flag_item_found = true  
				-- update existing values 
				SetItemsToUseTable(n, 
					Config.SPECIAL_ITEMS[a]["Name"], 
					Config.SPECIAL_ITEMS[a]["TYPE"], 
					Config.SPECIAL_ITEMS[a]["DisplayName"], 
					Config.SPECIAL_ITEMS[a]["MetabolismRank"], 
					Config.SPECIAL_ITEMS[a]["PropName"], 
					Config.SPECIAL_ITEMS[a]["Animation"], 
					Config.SPECIAL_ITEMS[a]["Metabolism"], 
					Config.SPECIAL_ITEMS[a]["Hunger"], 
					Config.SPECIAL_ITEMS[a]["Thirst"], 
					Config.SPECIAL_ITEMS[a]["InnerCoreStamina"], 
					Config.SPECIAL_ITEMS[a]["InnerCoreStaminaGold"], 
					Config.SPECIAL_ITEMS[a]["OuterCoreStaminaGold"], 
					Config.SPECIAL_ITEMS[a]["InnerCoreHealth"], 
					Config.SPECIAL_ITEMS[a]["InnerCoreHealthGold"], 
					Config.SPECIAL_ITEMS[a]["OuterCoreHealthGold"], 
					Config.SPECIAL_ITEMS[a]["HardAlcohol"], 
					Config.SPECIAL_ITEMS[a]["SoftAlcohol"], 
					Config.SPECIAL_ITEMS[a]["DrinkCount"], 
					Config.SPECIAL_ITEMS[a]["Effect"], 
					Config.SPECIAL_ITEMS[a]["EffectDuration"]
				) 
			end 
		end
		if flag_item_found == false then 
			-- Add item to the database 
			local r = #ItemsToUse+1
			table.insert(ItemsToUse, r)   
			ItemsToUse[r] = {}                
			BuildItemsToUseTable(r, 
                Config.SPECIAL_ITEMS[a]["Name"], 
                Config.SPECIAL_ITEMS[a]["TYPE"], 
                Config.SPECIAL_ITEMS[a]["DisplayName"], 
                Config.SPECIAL_ITEMS[a]["MetabolismRank"], 
                Config.SPECIAL_ITEMS[a]["PropName"], 
                Config.SPECIAL_ITEMS[a]["Animation"], 
                Config.SPECIAL_ITEMS[a]["Metabolism"], 
                Config.SPECIAL_ITEMS[a]["Hunger"], 
                Config.SPECIAL_ITEMS[a]["Thirst"], 
                Config.SPECIAL_ITEMS[a]["InnerCoreStamina"], 
                Config.SPECIAL_ITEMS[a]["InnerCoreStaminaGold"], 
                Config.SPECIAL_ITEMS[a]["OuterCoreStaminaGold"], 
                Config.SPECIAL_ITEMS[a]["InnerCoreHealth"], 
                Config.SPECIAL_ITEMS[a]["InnerCoreHealthGold"], 
                Config.SPECIAL_ITEMS[a]["OuterCoreHealthGold"], 
                Config.SPECIAL_ITEMS[a]["HardAlcohol"], 
                Config.SPECIAL_ITEMS[a]["SoftAlcohol"], 
                Config.SPECIAL_ITEMS[a]["DrinkCount"], 
                Config.SPECIAL_ITEMS[a]["Effect"], 
                Config.SPECIAL_ITEMS[a]["EffectDuration"]
			)
		end 
	end    
    --- no work needed, just call the client once to load into the client db. 
    --print("Server side: Specials loaded.")    
    return(true) 
end 


function BuildItemsToUseTable(KEY, ItemName, TYPE, DisplayName, MetabolismRank, PropName, Animation) 
	r = KEY     
	table.insert(ItemsToUse[r], "Name") 
	ItemsToUse[r]["Name"] = ItemName     
	table.insert(ItemsToUse[r], "TYPE")
	ItemsToUse[r]["TYPE"] = TYPE 
	table.insert(ItemsToUse[r], "MetabolismRank")
	ItemsToUse[r]["MetabolismRank"] = MetabolismRank 
	table.insert(ItemsToUse[r], "DisplayName") 
	ItemsToUse[r]["DisplayName"] = DisplayName  
	table.insert(ItemsToUse[r], "Animation") 
	ItemsToUse[r]["Animation"] = Animation  
	table.insert(ItemsToUse[r], "PropName") 
	ItemsToUse[r]["PropName"] = PropName    
end 

function SetItemsToUseTable(KEY, ItemName, TYPE, DisplayName, MetabolismRank, PropName, Animation) 
	r = KEY 
	ItemsToUse[r]["Name"] = ItemName   
	ItemsToUse[r]["TYPE"] = TYPE   
	ItemsToUse[r]["DisplayName"] = DisplayName  
	ItemsToUse[r]["Animation"] = Animation   
	ItemsToUse[r]["PropName"] = PropName     
	ItemsToUse[r]["MetabolismRank"] = MetabolismRank     
end 



-- Sends item contents to clien in response to client request for data. 
print("Register Event: ",Config.ScriptName..":sendItemsRequested")
RegisterServerEvent(Config.ScriptName..":sendItemsRequested")
AddEventHandler(Config.ScriptName..":sendItemsRequested", function(--[[source,]] TYPE) 
    local _source = source 
	for n,m in pairs(ItemsToUse) do   
		if ItemsToUse[n]["TYPE"] == TYPE then 
			if TYPE == "Food" then 
                TriggerClientEvent(Config.ScriptName..":catch:detailedItem:Food",_source, ItemsToUse[n]["Name"], ItemsToUse[n]["DisplayName"], ItemsToUse[n]["MetabolismRank"], ItemsToUse[n]["PropName"])
            end 
			if TYPE == "Drink" then 
                TriggerClientEvent(Config.ScriptName..":catch:detailedItem:Drink",_source, ItemsToUse[n]["Name"], ItemsToUse[n]["DisplayName"], ItemsToUse[n]["MetabolismRank"], ItemsToUse[n]["PropName"])
            end
			if TYPE == "Alcohol" then 
                TriggerClientEvent(Config.ScriptName..":catch:detailedItem:Alcohol",_source, ItemsToUse[n]["Name"], ItemsToUse[n]["DisplayName"], ItemsToUse[n]["MetabolismRank"], ItemsToUse[n]["PropName"])
            end 
			if TYPE == "Special" then             
                TriggerClientEvent(Config.ScriptName..":catch:detailedItem:Special",_source)
            end             
		end 
	end 
end)


print("Register Event: ",Config.ScriptName..":SendReady")
RegisterServerEvent(Config.ScriptName..":SendReady")
AddEventHandler(Config.ScriptName..":SendReady", function(--[[source,]] TYPE) 
    local _source = source 
    if TYPE == "Food" then 
        TriggerClientEvent(Config.ScriptName..":catch:ReadyCheck:Food",_source, Loaded_Items_SolidFood, #ItemsToUse)
    end   
    if TYPE == "Drink" then 
        TriggerClientEvent(Config.ScriptName..":catch:ReadyCheck:Drink",_source, Loaded_Items_LiquidDrink, #ItemsToUse)
    end
    if TYPE == "Alcohol" then 
        TriggerClientEvent(Config.ScriptName..":catch:ReadyCheck:Alcohol",_source, Loaded_Items_LiquidAlcoholDrink, #ItemsToUse)
    end 
    if TYPE == "Special" then 
        TriggerClientEvent(Config.ScriptName..":catch:ReadyCheck:Special",_source, Loaded_Items_Special, #ItemsToUse)
    end 
end)