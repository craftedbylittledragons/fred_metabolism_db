
    Loaded_Items_LiquidDrink = false
    Loaded_Items_LiquidAlcoholDrink = false
    Loaded_Items_SolidFood = false
    Loaded_Items_Special = false
    Loaded_Items_Total = 0  

Citizen.CreateThread(function()
    Citizen.Wait(20000)
    ItemsToUse = Config.ItemsToUse
    
    --print(Config.ScriptName..": Calling server for checking for ready.")

    --print(Config.ScriptName..":ReadyCheck - Food",Loaded_Items_SolidFood)  
    while Loaded_Items_SolidFood == false do 
        Citizen.Wait(1000)
        TriggerServerEvent(Config.ScriptName..":SendReady", "Food")	          
    end 

    --print(Config.ScriptName..":ReadyCheck - Drink",Loaded_Items_LiquidDrink)  
    while Loaded_Items_LiquidDrink == false do 
        Citizen.Wait(1000)    
        TriggerServerEvent(Config.ScriptName..":SendReady", "Drink")	 
    end      
    
    --print(Config.ScriptName..":ReadyCheck - Alcohol",Loaded_Items_LiquidAlcoholDrink)  
    while Loaded_Items_LiquidAlcoholDrink == false do 
        Citizen.Wait(1000)
        TriggerServerEvent(Config.ScriptName..":SendReady", "Alcohol")	 
    end  

    --print(Config.ScriptName..":ReadyCheck - Alcohol",Loaded_Items_Special)  
    while Loaded_Items_Special == false do 
        Citizen.Wait(1000)
        TriggerServerEvent(Config.ScriptName..":SendReady", "Special")	 
    end  	

    -------------------------------------------------------------------------------

    -------------------------------------------------------------------------------

    --print(Config.ScriptName..": Calling server for consumable item database.")
	
    if Loaded_Items_SolidFood == true then  
	    TriggerServerEvent(Config.ScriptName..":sendItemsRequested", "Food")	
    end 
    if Loaded_Items_LiquidDrink == true then  
	    TriggerServerEvent(Config.ScriptName..":sendItemsRequested", "Drink")	
    end  
    if Loaded_Items_LiquidAlcoholDrink == true then  	    
	    TriggerServerEvent(Config.ScriptName..":sendItemsRequested", "Alcohol")	
    end  
    if Loaded_Items_Special == true then  	    
	    TriggerServerEvent(Config.ScriptName..":sendItemsRequested", "Special")	
    end 	

    -------------------------------------------------------------------------------
	
    -------------------------------------------------------------------------------

	META_READY = false 
    user_feedback_message = "Metabolism has loaded."
	 -- The server side (Loaded_Items_Total) has water twice, the client side only has it once.
    while META_READY == false do         
        Citizen.Wait(1000)
		if #ItemsToUse >= Loaded_Items_Total then 
			META_READY = true 
			TriggerEvent("vorp:TipBottom", user_feedback_message, 5000)  
		end 
		--print(#ItemsToUse, Loaded_Items_Total, META_READY )
    end  
end) 

 
local clientside_ReadyCheckFood = "catch:ReadyCheck:Food"
local new_event_clientside_ReadyCheckFood = Config.ScriptName..":"..clientside_ReadyCheckFood 
print("Registered Event:", new_event_clientside_ReadyCheckFood)
RegisterNetEvent(new_event_clientside_ReadyCheckFood)
AddEventHandler(new_event_clientside_ReadyCheckFood, function(check, max)  		
	--print(Config.ScriptName..": Caught item: ",check)
    Loaded_Items_SolidFood = check
    Loaded_Items_Total = max -1
end)

local clientside_ReadyCheckDrink = "catch:ReadyCheck:Drink"
local new_event_clientside_ReadyCheckDrink = Config.ScriptName..":"..clientside_ReadyCheckDrink 
print("Registered Event:", new_event_clientside_ReadyCheckDrink)
RegisterNetEvent(new_event_clientside_ReadyCheckDrink)
AddEventHandler(new_event_clientside_ReadyCheckDrink, function(check, max)  		
	--print(Config.ScriptName..": Caught item: ",check, max)
    Loaded_Items_LiquidDrink = check 
    Loaded_Items_Total = max -1
end)

local clientside_ReadyCheckAlcohol = "catch:ReadyCheck:Alcohol"
local new_event_clientside_ReadyCheckAlcohol = Config.ScriptName..":"..clientside_ReadyCheckAlcohol 
print("Registered Event:", new_event_clientside_ReadyCheckAlcohol)
RegisterNetEvent(new_event_clientside_ReadyCheckAlcohol)
AddEventHandler(new_event_clientside_ReadyCheckAlcohol, function(check, max)  		
	--print(Config.ScriptName..": Caught item: ",check, max)
    Loaded_Items_LiquidAlcoholDrink = check 
    Loaded_Items_Total = max -1
end) 

local clientside_ReadyCheckSpecial = "catch:ReadyCheck:Special"
local new_event_clientside_ReadyCheckSpecial = Config.ScriptName..":"..clientside_ReadyCheckSpecial 
print("Registered Event:", new_event_clientside_ReadyCheckSpecial)
RegisterNetEvent(new_event_clientside_ReadyCheckSpecial)
AddEventHandler(new_event_clientside_ReadyCheckSpecial, function(check, max)  		
	--print(Config.ScriptName..": Caught item: ",check, max)
    Loaded_Items_Special = check 
    Loaded_Items_Total = max -1
end) 


local clientside_detailedItem = "catch:detailedItem:Drink"
local new_event_clientside_detailedItem = Config.ScriptName..":"..clientside_detailedItem 
print("Registered Event:", new_event_clientside_detailedItem)
RegisterNetEvent(new_event_clientside_detailedItem)
AddEventHandler(new_event_clientside_detailedItem, function(ItemName, DisplayName, MetabolismRank, PropName)  
	local TYPE = "Drink"
	--print(Config.ScriptName..": Caught item: ",ItemName, DisplayName, MetabolismRank, PropName) 
	local Animation = "drink"	
	local Metabolism = 0	 	
	local Hunger = 0		
	local Thirst = 11		
	local InnerCoreStamina = 0		
	local InnerCoreStaminaGold = 0		
	local OuterCoreStaminaGold = 0		
	local InnerCoreHealth = 0		        
	local InnerCoreHealthGold = 0		
	local OuterCoreHealthGold = 0		
	local HardAlcohol = false		
	local SoftAlcohol = false		
	local DrinkCount = 0			
	local Effect = ""		
	local EffectDuration = 0 
	if PropName == "" or PropName == 0 or PropName == nil then 
		PropName = "p_mugcoffee01x" 
	end 

	flag_item_found = false
	for n,m in pairs(ItemsToUse) do   
		if ItemsToUse[n]["Name"] == ItemName then 
			-- item found moving on. 
			flag_item_found = true  
			-- update existing values 
			SetItemsToUseTable(n, ItemName, TYPE, DisplayName, MetabolismRank, PropName, Animation, Metabolism, Hunger, Thirst, InnerCoreStamina, InnerCoreStaminaGold, OuterCoreStaminaGold, InnerCoreHealth, InnerCoreHealthGold, OuterCoreHealthGold, HardAlcohol, SoftAlcohol, DrinkCount, Effect, EffectDuration) 
		end 
	end
	if flag_item_found == false then 
		-- Add item to the database 
		local r = #ItemsToUse+1
		table.insert(ItemsToUse, r)   
		ItemsToUse[r] = {}                
		BuildItemsToUseTable(r, ItemName, TYPE, DisplayName, MetabolismRank, PropName, Animation, Metabolism, Hunger, Thirst, InnerCoreStamina, InnerCoreStaminaGold, OuterCoreStaminaGold, InnerCoreHealth, InnerCoreHealthGold, OuterCoreHealthGold, HardAlcohol, SoftAlcohol, DrinkCount, Effect, EffectDuration)
    end 
end)

local clientside_detailedItemFood = "catch:detailedItem:Food"
new_event_clientside_detailedItemFood = Config.ScriptName..":"..clientside_detailedItemFood 
print("Registered Event:", new_event_clientside_detailedItemFood)
RegisterNetEvent(new_event_clientside_detailedItemFood)
AddEventHandler(new_event_clientside_detailedItemFood, function(ItemName, DisplayName, MetabolismRank, PropName)  
	local TYPE = "Food"
	--print(Config.ScriptName..": Caught item: ",ItemName, DisplayName, MetabolismRank, PropName)		 		 
	local Animation = "eat"	 
	local Metabolism = 0	 	
	local Hunger = 11		
	local Thirst = 0		
	local InnerCoreStamina = 0		
	local InnerCoreStaminaGold = 0		
	local OuterCoreStaminaGold = 0		
	local InnerCoreHealth = 0		        
	local InnerCoreHealthGold = 0		
	local OuterCoreHealthGold = 0		
	local HardAlcohol = false		
	local SoftAlcohol = false		
	local DrinkCount = 0			
	local Effect = ""		
	local EffectDuration = 0 
	if PropName == "" or PropName == 0 or PropName == nil then 
		PropName = "p_bread05x" 
	end  

	flag_item_found = false
	for n,m in pairs(ItemsToUse) do   
		if ItemsToUse[n]["Name"] == ItemName then 
			-- item found moving on. 
			flag_item_found = true  
			-- update existing values 
			SetItemsToUseTable(n, ItemName, TYPE, DisplayName, MetabolismRank, PropName, Animation, Metabolism, Hunger, Thirst, InnerCoreStamina, InnerCoreStaminaGold, OuterCoreStaminaGold, InnerCoreHealth, InnerCoreHealthGold, OuterCoreHealthGold, HardAlcohol, SoftAlcohol, DrinkCount, Effect, EffectDuration) 
		end 
	end
	if flag_item_found == false then 
		-- Add item to the database 
		local r = #ItemsToUse+1
		table.insert(ItemsToUse, r)   
		ItemsToUse[r] = {}                
		BuildItemsToUseTable(r, ItemName, TYPE, DisplayName, MetabolismRank, PropName, Animation, Metabolism, Hunger, Thirst, InnerCoreStamina, InnerCoreStaminaGold, OuterCoreStaminaGold, InnerCoreHealth, InnerCoreHealthGold, OuterCoreHealthGold, HardAlcohol, SoftAlcohol, DrinkCount, Effect, EffectDuration)
    end 
end)


local clientside_detailedItemAlcohol = "catch:detailedItem:Alcohol"
local new_event_clientside_detailedItemAlcohol = Config.ScriptName..":"..clientside_detailedItemAlcohol 
print("Registered Event:", new_event_clientside_detailedItemAlcohol)
RegisterNetEvent(new_event_clientside_detailedItemAlcohol)
AddEventHandler(new_event_clientside_detailedItemAlcohol, function(ItemName, DisplayName, MetabolismRank, PropName)  	
	local TYPE = "Alcohol"
	--print(Config.ScriptName..": Caught item: ",ItemName, DisplayName, MetabolismRank, PropName) 
	local Animation = "longbottle" 	
	local Metabolism = 500	 	
	local Hunger = 0	
	local Thirst = 11		
	local InnerCoreStamina = 0		
	local InnerCoreStaminaGold = 0		
	local OuterCoreStaminaGold = 100		
	local InnerCoreHealth = -10		        
	local InnerCoreHealthGold = 0		
	local OuterCoreHealthGold = 0		
	local HardAlcohol = false		
	local SoftAlcohol = true		
	local DrinkCount = 12		
	local Effect = "PlayerDrunkSaloon1"		
	local EffectDuration = 5000 
	if PropName == "" or PropName == 0 or PropName == nil then 
		PropName = "p_bottlebeer01a" 
	end   

	flag_item_found = false
	for n,m in pairs(ItemsToUse) do   
		if ItemsToUse[n]["Name"] == ItemName then 
			-- item found moving on. 
			flag_item_found = true  
			-- update existing values 
			SetItemsToUseTable(n, ItemName, TYPE,  DisplayName, MetabolismRank, PropName, Animation, Metabolism, Hunger, Thirst, InnerCoreStamina, InnerCoreStaminaGold, OuterCoreStaminaGold, InnerCoreHealth, InnerCoreHealthGold, OuterCoreHealthGold, HardAlcohol, SoftAlcohol, DrinkCount, Effect, EffectDuration) 
		end 
	end
	if flag_item_found == false then 
		-- Add item to the database 
		local r = #ItemsToUse+1
		table.insert(ItemsToUse, r)   
		ItemsToUse[r] = {}                
		BuildItemsToUseTable(r, ItemName, TYPE, DisplayName, MetabolismRank, PropName, Animation, Metabolism, Hunger, Thirst, InnerCoreStamina, InnerCoreStaminaGold, OuterCoreStaminaGold, InnerCoreHealth, InnerCoreHealthGold, OuterCoreHealthGold, HardAlcohol, SoftAlcohol, DrinkCount, Effect, EffectDuration)
    end 
end)
 


function BuildItemsToUseTable(KEY, ItemName, TYPE, DisplayName, MetabolismRank, PropName, Animation, Metabolism, Hunger, Thirst, InnerCoreStamina, InnerCoreStaminaGold, OuterCoreStaminaGold, InnerCoreHealth, InnerCoreHealthGold, OuterCoreHealthGold, HardAlcohol, SoftAlcohol, DrinkCount, Effect, EffectDuration) 
	--print("BuildItemsToUseTable:",KEY, ItemName, DisplayName, MetabolismRank, PropName, Animation)
	r = KEY
	table.insert(ItemsToUse[r], "Name") 
	ItemsToUse[r]["Name"] = ItemName 
	table.insert(ItemsToUse[r], "TYPE") 
	ItemsToUse[r]["TYPE"] = TYPE 
	table.insert(ItemsToUse[r], "DisplayName") 
	ItemsToUse[r]["DisplayName"] = DisplayName  
	table.insert(ItemsToUse[r], "Animation") 
	ItemsToUse[r]["Animation"] = Animation  
	table.insert(ItemsToUse[r], "PropName") 
	ItemsToUse[r]["PropName"] = PropName   

	if Metabolism == nil then Metabolism = 0 end 
	if MetabolismRank == nil then MetabolismRank = 0 end 
	table.insert(ItemsToUse[r], "Metabolism") 
	ItemsToUse[r]["Metabolism"] = Metabolism * MetabolismRank 
	
	if Hunger == nil then Hunger = 0 end 
	table.insert(ItemsToUse[r], "Hunger") 
	ItemsToUse[r]["Hunger"] = Hunger * MetabolismRank
	
	if Thirst == nil then Thirst = 0 end 
	table.insert(ItemsToUse[r], "Thirst") 
	ItemsToUse[r]["Thirst"] = Thirst * MetabolismRank                      

	if InnerCoreStamina == nil then InnerCoreStamina = 0 end 
	table.insert(ItemsToUse[r], "InnerCoreStamina") 
	ItemsToUse[r]["InnerCoreStamina"] = InnerCoreStamina 
	
	if InnerCoreStaminaGold == nil then InnerCoreStaminaGold = 0 end 
	table.insert(ItemsToUse[r], "InnerCoreStaminaGold") 
	ItemsToUse[r]["InnerCoreStaminaGold"] = InnerCoreStaminaGold 
	
	if OuterCoreStaminaGold == nil then OuterCoreStaminaGold = 0 end 
	table.insert(ItemsToUse[r], "OuterCoreStaminaGold") 
	ItemsToUse[r]["OuterCoreStaminaGold"] = OuterCoreStaminaGold        

	if InnerCoreHealth == nil then InnerCoreHealth = 0 end 
	table.insert(ItemsToUse[r], "InnerCoreHealth") 
	ItemsToUse[r]["InnerCoreHealth"] = InnerCoreHealth 
	
	if InnerCoreHealthGold == nil then InnerCoreHealthGold = 0 end 
	table.insert(ItemsToUse[r], "InnerCoreHealthGold") 
	ItemsToUse[r]["InnerCoreHealthGold"] = InnerCoreHealthGold 
	
	if OuterCoreHealthGold == nil then OuterCoreHealthGold = 0 end 
	table.insert(ItemsToUse[r], "OuterCoreHealthGold") 
	ItemsToUse[r]["OuterCoreHealthGold"] = OuterCoreHealthGold              

	if HardAlcohol == nil then HardAlcohol = 0 end 
	table.insert(ItemsToUse[r], "HardAlcohol") 
	ItemsToUse[r]["HardAlcohol"] = HardAlcohol 
	
	if SoftAlcohol == nil then SoftAlcohol = 0 end 
	table.insert(ItemsToUse[r], "SoftAlcohol") 
	ItemsToUse[r]["SoftAlcohol"] = SoftAlcohol 
	
	if DrinkCount == nil then DrinkCount = 0 end 
	table.insert(ItemsToUse[r], "DrinkCount") 
	ItemsToUse[r]["DrinkCount"] = DrinkCount          

	table.insert(ItemsToUse[r], "Effect") 
	ItemsToUse[r]["Effect"] = Effect 

	if EffectDuration == nil then EffectDuration = 0 end 
	table.insert(ItemsToUse[r], "EffectDuration") 
	ItemsToUse[r]["EffectDuration"] = EffectDuration 
end 

function SetItemsToUseTable(KEY, ItemName, TYPE,  DisplayName, MetabolismRank, PropName, Animation, Metabolism, Hunger, Thirst, InnerCoreStamina, InnerCoreStaminaGold, OuterCoreStaminaGold, InnerCoreHealth, InnerCoreHealthGold, OuterCoreHealthGold, HardAlcohol, SoftAlcohol, DrinkCount, Effect, EffectDuration) 
	--print("SetItemsToUseTable:",KEY, ItemName, DisplayName, MetabolismRank, PropName, Animation)
	r = KEY 
	ItemsToUse[r]["Name"] = ItemName   
	ItemsToUse[r]["TYPE"] = TYPE  
	ItemsToUse[r]["DisplayName"] = DisplayName  
	ItemsToUse[r]["Animation"] = Animation   
	ItemsToUse[r]["PropName"] = PropName    
	if MetabolismRank == nil then MetabolismRank = 0 end 
	if Metabolism == nil then Metabolism = 0 end 
	ItemsToUse[r]["Metabolism"] = Metabolism * MetabolismRank  
	if Hunger == nil then Hunger = 0 end 
	ItemsToUse[r]["Hunger"] = Hunger * MetabolismRank 
	if Thirst == nil then Thirst = 0 end 
	ItemsToUse[r]["Thirst"] = Thirst * MetabolismRank  
	if InnerCoreStamina == nil then InnerCoreStamina = 0 end    
	ItemsToUse[r]["InnerCoreStamina"] = InnerCoreStamina  
	if InnerCoreStaminaGold == nil then InnerCoreStaminaGold = 0 end
	ItemsToUse[r]["InnerCoreStaminaGold"] = InnerCoreStaminaGold  
	if OuterCoreStaminaGold == nil then OuterCoreStaminaGold = 0 end
	ItemsToUse[r]["OuterCoreStaminaGold"] = OuterCoreStaminaGold   
	if InnerCoreHealth == nil then InnerCoreHealth = 0 end 
	ItemsToUse[r]["InnerCoreHealth"] = InnerCoreHealth  
	if InnerCoreHealthGold == nil then InnerCoreHealthGold = 0 end 
	ItemsToUse[r]["InnerCoreHealthGold"] = InnerCoreHealthGold  
	if OuterCoreHealthGold == nil then OuterCoreHealthGold = 0 end 
	ItemsToUse[r]["OuterCoreHealthGold"] = OuterCoreHealthGold    
	if HardAlcohol == nil then HardAlcohol = 0 end 
	ItemsToUse[r]["HardAlcohol"] = HardAlcohol  
	if SoftAlcohol == nil then SoftAlcohol = 0 end 
	ItemsToUse[r]["SoftAlcohol"] = SoftAlcohol  
	if DrinkCount == nil then DrinkCount = 0 end 
	ItemsToUse[r]["DrinkCount"] = DrinkCount   
	ItemsToUse[r]["Effect"] = Effect  
	if EffectDuration == nil then EffectDuration = 0 end 
	ItemsToUse[r]["EffectDuration"] = EffectDuration 
end 



local clientside_specialItems = "catch:detailedItem:Special"
local new_event_clientside_specialItems = Config.ScriptName..":"..clientside_specialItems 
print("Registered Event:", new_event_clientside_specialItems)
RegisterNetEvent(new_event_clientside_specialItems)
AddEventHandler(new_event_clientside_specialItems, function()  	
	local TYPE = "Special"
	flag_item_found = false
	
	for a,b in pairs(Config.SPECIAL_ITEMS) do  
		for n,m in pairs(ItemsToUse) do   			
			if ItemsToUse[n]["Name"] == Config.SPECIAL_ITEMS[a]["Name"] then   
				--print( Config.SPECIAL_ITEMS[a]["Name"], Config.SPECIAL_ITEMS[a]["TYPE"] )  
				flag_item_found = true   
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
			
			--print( Config.SPECIAL_ITEMS[a]["Name"], Config.SPECIAL_ITEMS[a]["TYPE"] )  
		end 
	end
end)