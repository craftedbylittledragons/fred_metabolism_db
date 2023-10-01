next = next 
checked = false
playerstatus = {}

water = Config["InitialWater"]
food = Config["InitialFood"]
metabolism = Config["InitialMetabolism"]

drunken = 0
timer = 0
timer2 = 0
hard = 0

IsPlayerLoaded = false
FirstCheck = false


Anims = {
    ["eat"] = {
            dict = "mech_inventory@eating@multi_bite@sphere_d8-2_sandwich",
            name = "quick_left_hand", 
            flag = 24
        },
    ["drink"] = {
            dict = "amb_rest_drunk@world_human_drinking@male_a@idle_a",
            name = "idle_a", 
            flag = 24
	},  
}

local Vomits = {
	["vomit1"] = {
			dict = "amb_misc@world_human_vomit@male_a@idle_a",
			name = "idle_a" ,
			flag = 0,
	},
	["vomit2"] = {
		dict = "amb_misc@world_human_vomit@male_a@idle_c",
		name = "idle_g" ,
		flag = 0,
	},
	["vomit3"] = {
		dict = "amb_misc@world_human_vomit@male_a@idle_c",
		name = "idle_h" ,
		flag = 0,
	},    
}

local BodyCustomization = {

    BodySizes = {
        61606861,
        -1241887289,
        -369348190,
        32611963,
        -20262001
    },
    WaistSizes = {
        -2045421226,
        -1745814259,
        -325933489,
        -1065791927,
        -844699484,
        -1273449080,
        927185840,
        149872391,
        399015098,
        -644349862,
        1745919061,
        1004225511,
        1278600348,
        502499352,
        -2093198664,
        -1837436619,
        1736416063,
        2040610690,
        -1173634986,
        -867801909,
        1960266524
    }
}

local ClotheList ={
    0x9925C067, -- Hat
    0x2026C46D, -- Shirt
    0x1D4C528A, -- Pants
    0x777EC6EF, -- Boots
    0xE06D30CE, -- Coats
    0x662AC34, -- Closed Coats
    0xEABE0032, -- Gloves
    0x485EE834, -- Vest
    0xAF14310B, -- Ponchos 1
    0x3C1A74CD -- Ponchos 2
}


function getThirst()
	--print("fredmeta:getThirst - active")
	return water
end

function getHunger()
	--print("fredmeta:getHunger - active")
	return food
end


Citizen.CreateThread(function() 

    while true do
		Citizen.Wait(0)
		local player = PlayerPedId()
        local coords = GetEntityCoords(player)
        Citizen.InvokeNative(0xB98B78C3768AF6E0,true)
		temp = math.floor(GetTemperatureAtCoords(coords))
		local hot = 0
		local cold = 0

		-- Checks if the player is wearing clothes
		--for k,v in pairs(ClotheList) do
		local isWearingHat = Citizen.InvokeNative(0xFB4891BD7578CDC1, player, ClotheList[1])
        local isWearingShirt = Citizen.InvokeNative(0xFB4891BD7578CDC1, player, ClotheList[2])
        local isWearingPants = Citizen.InvokeNative(0xFB4891BD7578CDC1, player, ClotheList[3])
        local isWearingBoots = Citizen.InvokeNative(0xFB4891BD7578CDC1, player, ClotheList[4])
        local isWearingCoat = Citizen.InvokeNative(0xFB4891BD7578CDC1, player, ClotheList[5])
        local isWearingClosedCoat = Citizen.InvokeNative(0xFB4891BD7578CDC1, player, ClotheList[6])
        local isWearingGloves = Citizen.InvokeNative(0xFB4891BD7578CDC1, player, ClotheList[7])
        local isWearingVest = Citizen.InvokeNative(0xFB4891BD7578CDC1, player, ClotheList[8])
        local isWearingPonchoOne = Citizen.InvokeNative(0xFB4891BD7578CDC1, player, ClotheList[9])
        local isWearingPonchoTwo = Citizen.InvokeNative(0xFB4891BD7578CDC1, player, ClotheList[10])
    
        if isWearingHat then
            temp = temp + Config["HatTemp"]--1
        end

        if isWearingShirt then
            temp = temp + Config["ShirtTemp"] --2
        end

        if isWearingPants then
            temp = temp + Config["PantsTemp"] --2
        end

        if isWearingBoots then
            temp = temp + Config["BootsTemp"] --2
        end

        if isWearingCoat then
            temp = temp + Config["CoatTemp"] --3
        end

        if isWearingClosedCoat then
            temp = temp + Config["ClosedCoatTemp"] --4
        end

        if isWearingGloves then
            temp = temp + Config["GlovesTemp"] --1
        end

        if isWearingVest then
            temp = temp + Config["VestTemp"] --1
        end

        if isWearingPonchoOne then
            temp = temp + Config["PonchoTemp"] --5
        end

        if isWearingPonchoTwo then
            temp = temp + Config["PonchoTemp"] --5
        end

            --[[local IsWearingClothes = Citizen.InvokeNative(0xFB4891BD7578CDC1, player, v)
            if IsWearingClothes then
                temp = temp + 1
            end
		end]]--

		if (food < 0) 	then		food = 0		end
		if (food > 100) then		food = 100		end
		if (water < 0) then			water = 0		end
		if (water > 100) then		water = 100		end

		if temp > Config["MaxTemperature"] then 
			hot = Config["WaterHotLoss"]
		else 
			hot = 0
		end

		if temp < Config["MinTemperature"] then
			cold = Config["FoodColdLoss"]
		else 
			cold = 0
		end

		if IsPedRunning(PlayerPedId()) then
			if Config["TooCold!"] then
				food = food - (Config["FoodDrainRunning"] + cold)
				water = water - (Config["WaterDrainRunning"] + hot)
			else
				food = food - (Config["FoodDrainRunning"])
				water = water - (Config["WaterDrainRunning"])
			end
		elseif IsPedWalking(PlayerPedId()) then
			if Config["TooCold!"] then
            	food = food - (Config["FoodDrainWalking"] + cold)
				water = water - (Config["WaterDrainWalking"] + hot)
			else
				food = food - (Config["FoodDrainWalking"])
				water = water - (Config["WaterDrainWalking"])
			end
		else
			if Config["TooCold!"] then
				food = food - (Config["FoodDrainIdle"] + cold)
				water = water - (Config["WaterDrainIdle"] + hot)
			else
				food = food - (Config["FoodDrainIdle"])
				water = water - (Config["WaterDrainIdle"])
			end
		end
		Citizen.Wait(Config["NeedsTick"])
	end
end)

-- TEMPERATURE CHECK
Citizen.CreateThread(function()
    while true do
		Citizen.Wait(60000)
		if Config["TooCold!"] then
			-- Temperature Checks
			if Config["VORP"] then
				if tonumber(temp) <= -8 then
					TriggerEvent("vorp:NotifyLeft", "~t7~Temperature", Config["TempNotify3"], "rpg_textures", "rpg_cold", 4000)
				elseif tonumber(temp) <= -6 then
					TriggerEvent("vorp:NotifyLeft", "~pa~Temperature", Config["TempNotify2"], "rpg_textures", "rpg_cold", 4000)
				elseif tonumber(temp) <= -4 then 
					TriggerEvent("vorp:NotifyLeft", "~t3~Temperature", Config["TempNotify1"], "rpg_textures", "rpg_cold", 4000)
			--	elseif tonumber(roundtemp) <= 20 then 
			--		TriggerEvent("vorp:NotifyLeft", "~o~Temperature", "Feeling hot, quench your thirst often!", "rpg_textures", "rpg_hot", 3000)
			--	elseif tonumber(roundtemp) <= 25 then 
				--	TriggerEvent("vorp:NotifyLeft", "~d~Temperature", "You are hot, seek shelter and quench your thirst often!", "rpg_textures", "rpg_hot", 3000)
				--elseif tonumber(roundtemp) <= 30 then 
					--TriggerEvent("vorp:NotifyLeft", "~t2 ~Temperature", "You're too hot, look for shelter, otherwise it's the end!", "rpg_textures", "rpg_hot", 3000)
				end
			end
			if Config["RedEM"] then
				if tonumber(temp) <= -8 then
					TriggerEvent("redem_roleplay:NotifyLeft", "~t7~Temperature", Config["TempNotify3"], "rpg_textures", "rpg_cold", 4000)
				elseif tonumber(temp) <= -6 then
					TriggerEvent("redem_roleplay:NotifyLeft", "~pa~Temperature", Config["TempNotify2"], "rpg_textures", "rpg_cold", 4000)
				elseif tonumber(temp) <= -4 then 
					TriggerEvent("redem_roleplay:NotifyLeft", "~t3~Temperature", Config["TempNotify1"], "rpg_textures", "rpg_cold", 4000)
			--	elseif tonumber(roundtemp) <= 20 then 
			--		TriggerEvent("redem_roleplay:NotifyLeft", "~o~Temperature", "Feeling hot, quench your thirst often!", "rpg_textures", "rpg_hot", 3000)
			--	elseif tonumber(roundtemp) <= 25 then 
				--	TriggerEvent("redem_roleplay:NotifyLeft", "~d~Temperature", "You are hot, seek shelter and quench your thirst often!", "rpg_textures", "rpg_hot", 3000)
				--elseif tonumber(roundtemp) <= 30 then 
					--TriggerEvent("redem_roleplay:NotifyLeft", "~t2 ~Temperature", "You're too hot, look for shelter, otherwise it's the end!", "rpg_textures", "rpg_hot", 3000)
				end
			end
		end
    end
end)
 
-- TEMPERATURE DAMAGE EFFECT
Citizen.CreateThread(function()
	while true do
		Wait(5000)
		if Config["TooCold!"] then
			ped = PlayerPedId()
			health = GetEntityHealth(ped)
			coords = GetEntityCoords(ped)
			if tonumber(temp) <= -8 then
				SetEntityHealth(ped,health  - 5)
			elseif tonumber(temp) <= -6 then
				SetEntityHealth(ped,health  - 2)
			elseif tonumber(temp) <= -4 then
				SetEntityHealth(ped,health  - 1)
			end
			if health > 0 and health < 50 then -- and tonumber(temp) > 0 then -- COULD THIS BE THE ISSUE?
				SetEntityHealth(ped, health-1)
				Citizen.InvokeNative(0xa4d3a1c008f250df, 6)  ---hp bleed core
				PlayPain(ped, 9, 1, true, true)
				Citizen.InvokeNative(0x4102732DF6B4005F,"MP_Downed", 0, true) --play
			else
				if Citizen.InvokeNative(0x4A123E85D7C4CA0B,"MP_Downed") then --ifrunning
					Citizen.InvokeNative(0xB4FD7446BAB2F394,"MP_Downed") --- stop
				end
			end
		end
	end
end)

Citizen.CreateThread(function()
    while true do
		Citizen.Wait(1000)

		local showNotification1 = false
		local showNorification2 = false
		
		--print("fredmeta:Notifications - active")
		if food <= Config["FoodNotification"] and not shownotifiaction2 then
			shownotifiaction1 = true 
			if Config["VORP"] then
				TriggerEvent("vorp:TipBottom", Config["LowFoodNotification"], 3000)
			end
		end

		if water <= Config["WaterNotification"] and not shownotifiaction1 then
			shownotifiaction2 = true 
			if Config["VORP"] then
				TriggerEvent("vorp:TipBottom", Config["LowWaterNotification"], 3000)
			end
		end

		shownotifiaction2 = not shownotifiaction2
		shownotifiaction1 = not shownotifiaction1

		if food < Config["FoodStripe"] or water < Config["WaterStripe"] then
			local health2 = GetEntityHealth(PlayerPedId())
			local remove = health2 - Config["HealthLoss"]
			PlayPain(PlayerPedId(), 9, 1, true, true)
			if remove <= 0 then
				remove = 0
				Citizen.InvokeNative(0x697157CED63F18D4, PlayerPedId(), 500000, false, true, true) -- ApplyDamageToPed
				food = 100
				water = 100
			end
			SetEntityHealth(PlayerPedId(), remove) 
        end
    end
end)

function updatePlayerBody(ped, bodyPart1, bodypart2)
	--print("fredmeta:updatePlayerBody - active")
	Citizen.InvokeNative(0x1902C4CFCC5BE57C, ped, bodyPart1) -- Changes bodysize
	Citizen.InvokeNative(0x1902C4CFCC5BE57C, ped, bodypart2) -- Changes waist
	Citizen.InvokeNative(0xCC8CA3E88256E58F, ped, false, true, true, true, false) --updates bodycomponents	
end


Citizen.CreateThread(function()
	while true do

		local ped = PlayerPedId()
		Citizen.Wait(0)			
		if (metabolism < 1) 	then	metabolism = 0	end
		if (metabolism > 20000) then	metabolism = 20000	end

		if IsPedRunning(ped) then
			metabolism = metabolism - Config["MetabolismLossRunning"]
		elseif IsPedWalking(ped) then
			metabolism = metabolism - Config["MetabolismLossRunning"]
		else
			metabolism = metabolism - Config["MetabolismLossIdle"]
		end
		
		--print("fredmeta:MetabolismFiesta - active")
		if Config["MetabolismFiesta"] then
			if (metabolism > 0) and (metabolism <= 2500) then
				updatePlayerBody(ped, BodyCustomization.BodySizes[2], BodyCustomization.WaistSizes[1])	
			end
		
			if (metabolism > 2500) and (metabolism <= 5000) then
				updatePlayerBody(ped, BodyCustomization.BodySizes[2], BodyCustomization.WaistSizes[21])	
			end
		
			if (metabolism > 5000) and (metabolism <= 7500) then
				updatePlayerBody(ped, BodyCustomization.BodySizes[3], BodyCustomization.WaistSizes[1])		
			end
		
			if (metabolism > 7500) and (metabolism <= 12500) then
				updatePlayerBody(ped, BodyCustomization.BodySizes[3], BodyCustomization.WaistSizes[21])	
			end
		
			if (metabolism > 12500) and (metabolism <= 15000) then
				updatePlayerBody(ped, BodyCustomization.BodySizes[5], BodyCustomization.WaistSizes[1])
			end
		
			if (metabolism > 15000) and (metabolism <= 17500) then
				updatePlayerBody(ped, BodyCustomization.BodySizes[5], BodyCustomization.WaistSizes[21])
			end

			if (metabolism > 17500) and (metabolism <= 20000) then
				updatePlayerBody(ped, BodyCustomization.BodySizes[4], BodyCustomization.WaistSizes[21])	
			end		
		end
		if Config["VORP"] then
			--local statusx = {food = food, water = water, metabolism = metabolism}      
            --print(Config.ScriptName..":setStatus Trigger")
			TriggerServerEvent(Config.ScriptName..":setStatus", food, water, metabolism)
			--TriggerServerEvent(Config.ScriptName..":savedtodb", statusx)
		end 
		Citizen.Wait(Config["MetabolismTick"])
	end
end)



function vomitLogic()
	--print("fredmeta:vomitLogic - active")
	hard = hard + 1
	timer2 = 60000
	if hard == 1 then
		local vomitchance = math.random(1,10) -- 10% chance
		if vomitchance == 1 then
			local vom = math.random(1,3)
			PlayAnimation(PlayerPedId(), Vomits["vomit"..vom])
		end
	elseif hard == 2 then
		local vomitchance = math.random(1, 4) -- 25% chance
		if vomitchance == 1 then
			local vom = math.random(1,3)
			PlayAnimation(PlayerPedId(), Vomits["vomit"..vom])
		end
	elseif hard == 3 then
		local vomitchance = math.random(1, 2) -- 50% chance
		if vomitchance == 1 then
			local vom = math.random(1,3)
			PlayAnimation(PlayerPedId(), Vomits["vomit"..vom])
		end
	elseif hard == 4 then
		local vomitchance = math.random(1, 1) -- 100% chance
		if vomitchance == 1 then
			local vom = math.random(1,3)
			PlayAnimation(PlayerPedId(), Vomits["vomit"..vom])
		end
	elseif hard == 5 then
		SetPedToRagdoll(PlayerPedId(-1), 60000, 60000, 0, 0, 0, 0)
		ScreenEffect("PlayerDrunk01", 5000)
		ScreenEffect("PlayerDrunk01_PassOut", 30000)
		hard = 0
	end
end


RegisterNetEvent(Config.ScriptName..":useItem")
AddEventHandler(Config.ScriptName..":useItem", function(itemname)
	
	index = 0
    --print(Config.ScriptName..":useItem Event","itemname:", itemname)
	for choosenitem,ItemArray in pairs(ItemsToUse) do  
		if (ItemsToUse[choosenitem]["Name"] == itemname) then 
			--print(Config.ScriptName..":useItem Found","itemname:", itemname)
			index = choosenitem
		end
	end 
	local ped = PlayerPedId()
	local coords = GetEntityCoords(ped)
	
	print(Config.ScriptName..":useItem Event","itemname:", itemname ,"food:", food, "live:", ItemsToUse[index]["Hunger"], "water:", water, "live:", ItemsToUse[index]["Thirst"])
	food = food + tonumber(ItemsToUse[index]["Hunger"])	 
	water = water + tonumber(ItemsToUse[index]["Thirst"])

	--print("metabolism:", metabolism, "live:", ItemsToUse[index]["Metabolism"])
	metabolism = metabolism + tonumber(ItemsToUse[index]["Metabolism"])
	
	TriggerServerEvent(Config.ScriptName..":setStatus", food, water, metabolism)
	--print(Config.ScriptName..":setStatus Trigger")
	--print("meta: hunger",hunger,"food",food,"thirst",thirst,"water",water)

	if (food < 0) 		then		food = 0		end
	if (food > 100) 	then		food = 100		end
	if (water < 0)	 	then		water = 0		end
	if (water > 100) 	then		water = 100		end
	
	--
	--ANIMATIONS
	--
	
	--print("Animations Start")

	if (ItemsToUse[index]["Animation"] == "eat") then
		eat(index, ItemsToUse[index]["PropName"], ItemsToUse[index]["Effect"], ItemsToUse[index]["EffectDuration"])
 	
	elseif (ItemsToUse[index]["Animation"] == "drink") then
		drink(index, ItemsToUse[index]["PropName"], ItemsToUse[index]["Effect"], ItemsToUse[index]["EffectDuration"])

	elseif (ItemsToUse[index]["Animation"] == "drink_cup") then
		drink_cup(index, ItemsToUse[index]["PropName"], ItemsToUse[index]["Effect"], ItemsToUse[index]["EffectDuration"])

	elseif (ItemsToUse[index]["Animation"] == "bowl") then
		bowl(index, ItemsToUse[index]["PropName"], ItemsToUse[index]["Effect"], ItemsToUse[index]["EffectDuration"])

	elseif (ItemsToUse[index]["Animation"] == "shortbottle") then
		shortbottle(index, ItemsToUse[index]["PropName"], ItemsToUse[index]["Effect"], ItemsToUse[index]["EffectDuration"], ItemsToUse[index]["DrinkCount"], ItemsToUse[index]["SoftAlcohol"],ItemsToUse[index]["HardAlcohol"])
		
	elseif (ItemsToUse[index]["Animation"] == "longbottle") then
		longbottle(index, ItemsToUse[index]["PropName"], ItemsToUse[index]["Effect"], ItemsToUse[index]["EffectDuration"], ItemsToUse[index]["DrinkCount"], ItemsToUse[index]["SoftAlcohol"],ItemsToUse[index]["HardAlcohol"])
		
	elseif (ItemsToUse[index]["Animation"] == "syringe") then
		syringe(index, ItemsToUse[index]["PropName"], ItemsToUse[index]["Effect"], ItemsToUse[index]["EffectDuration"])
		
	elseif (ItemsToUse[index]["Animation"] == "bandage") then
		bandage(index, ItemsToUse[index]["PropName"], ItemsToUse[index]["Effect"], ItemsToUse[index]["EffectDuration"])

	elseif (ItemsToUse[index]["Animation"] == "berry") then
		berry(index, ItemsToUse[index]["PropName"], ItemsToUse[index]["Effect"], ItemsToUse[index]["EffectDuration"])

	end

	-- CORES
	if (ItemsToUse[index]["InnerCoreStamina"] ~= 0) then
		-- GetAttributeCoreValue
		local stamina = Citizen.InvokeNative(0x36731AC041289BB1, PlayerPedId(), 1)
		if stamina == false then
			newStamina = tonumber(ItemsToUse[index]["InnerCoreStamina"])
			-- SetAttributeCoreValue
			Citizen.InvokeNative(0xC6258F41D86676E0, PlayerPedId(), 1, newStamina)
		else
			-- GetAttributeCoreValue
			stamina = Citizen.InvokeNative(0x36731AC041289BB1, PlayerPedId(), 1) --ACTUAL STAMINA CORE GETTER
			newStamina = stamina + tonumber(ItemsToUse[index]["InnerCoreStamina"])
			if (newStamina > 100) then	newStamina = 100	end
			-- SetAttributeCoreValue
			Citizen.InvokeNative(0xC6258F41D86676E0, PlayerPedId(), 1, newStamina)
		end
	end	
	--GOLDS
	if (ItemsToUse[index]["InnerCoreStaminaGold"] ~= 0.0) then
		-- EnableAttributeCoreOverpower
		Citizen.InvokeNative(0x4AF5A4C7B9157D14, PlayerPedId(), 1, ItemsToUse[index]["InnerCoreStaminaGold"], true)
	end
	if (ItemsToUse[index]["OuterCoreStaminaGold"] ~= 0.0) then
		-- EnableAttributeOverpower
		Citizen.InvokeNative(0xF6A7C08DF2E28B28, PlayerPedId(), 1, ItemsToUse[index]["OuterCoreStaminaGold"], true)
	end

	-- CORES
	if (ItemsToUse[index]["InnerCoreHealth"] ~= 0)then
		-- GetAttributeCoreValue
		local health = Citizen.InvokeNative(0x36731AC041289BB1, PlayerPedId(), 0) --ACTUAL HEALTH CORE GETTER
		if health == false then
			newHealth = tonumber(ItemsToUse[index]["InnerCoreHealth"])
			Citizen.InvokeNative(0xC6258F41D86676E0, PlayerPedId(), 0, newHealth)	
		else
			-- GetAttributeCoreValue
			health = Citizen.InvokeNative(0x36731AC041289BB1, PlayerPedId(), 0)	
			newHealth = health + tonumber(ItemsToUse[index]["InnerCoreHealth"])
			if (newHealth > 100) then	newHealth = 100		end			
			-- SetAttributeCoreValue
			Citizen.InvokeNative(0xC6258F41D86676E0, PlayerPedId(), 0, newHealth)
		end
	end 
	--GOLDS 
	if (ItemsToUse[index]["InnerCoreHealthGold"] ~= 0.0) then
		-- EnableAttributeCoreOverpower
		Citizen.InvokeNative(0x4AF5A4C7B9157D14, PlayerPedId(), 0, ItemsToUse[index]["InnerCoreHealthGold"], true)
	end
	if	(ItemsToUse[index]["OuterCoreHealthGold"] ~= 0.0) then
		-- EnableAttributeOverpower
		Citizen.InvokeNative(0xF6A7C08DF2E28B28, PlayerPedId(), 0, ItemsToUse[index]["OuterCoreHealthGold"], true)
	end

end)

-- DRUNK EFFECT
Citizen.CreateThread(function() 
    while true do
        Wait(1000)
        if crazydrunk then
			--print("Drunken Behavior Start")
            if timer > 0 then
				timer = timer - 1000
            else
                Citizen.InvokeNative(0x406CCF555B04FAD3 , PlayerPedId(), 1, 0.0)
                crazydrunk = false
				drunken = 0
				--hard = 0
                --[[if Citizen.InvokeNative(0x4A123E85D7C4CA0B,"PlayerDrunk01") then 
                    Citizen.InvokeNative(0xB4FD7446BAB2F394,"PlayerDrunk01")
                end]]--
            end
		end
		-- If in 1 minute you don't drink, hard restart
		if timer2 > 0 then
			timer2 = timer2 - 1000
		else
			hard = 0
			Citizen.InvokeNative(0x406CCF555B04FAD3 , PlayerPedId(), 1, 0.0)
		end
		if hard ~= 0 then
			Citizen.InvokeNative(0x406CCF555B04FAD3 , PlayerPedId(), 1, 1.0)
		end
    end
end)

if Config["VORP"] then
    --print("vorp:SelectedCharacter Event")
	RegisterNetEvent("vorp:SelectedCharacter")
	AddEventHandler("vorp:SelectedCharacter", function(charid)
		TriggerServerEvent(Config.ScriptName..":checkStatus")
		--print(Config.ScriptName..":checkStatus TriggerServerEvent")
		TriggerEvent("vorpcharacter:refreshPlayerSkin")
		--print("vorpcharacter:refreshPlayerSkin TriggerEvent")
	end)
end
  

Citizen.CreateThread(function()
	local sleep = true 
	while true do
	Citizen.Wait(0)
		if checked then
			sleep = false
			if next(playerstatus) ~= nil then
				for k,v in pairs(playerstatus) do 
					food = playerHunger
					water = playerThirst
					metabolism = playerMetabolism
				end
			end
			sleep = true
			checked = false
		end
		if sleep then 
			Wait(500)
		end
	end
end)


 