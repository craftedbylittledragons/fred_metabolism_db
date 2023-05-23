
function syringe(index, PropName, Effect, EffectDuration )
	local ped = PlayerPedId()
	local coords = GetEntityCoords(ped) 
	RequestAnimDict("mech_inventory@item@stimulants@inject@quick")
	while not HasAnimDictLoaded("mech_inventory@item@stimulants@inject@quick") do
		Wait(100)
	end
	TaskPlayAnim(ped, "mech_inventory@item@stimulants@inject@quick", "quick_stimulant_inject_lhand", 8.0, -0.5, -1, 0, 0, true, 0, false, 0, false)
	Wait(5000)
	if (Effect ~= "") then
		ScreenEffect(Effect, EffectDuration)
	end
	DeleteEntity(syringe)
	ClearPedTasks(ped)
end 	

function berry(index, PropName, Effect, EffectDuration )
	local ped = PlayerPedId()
	local coords = GetEntityCoords(ped) 
	RequestAnimDict("mech_pickup@plant@berries")
	while not HasAnimDictLoaded("mech_pickup@plant@berries") do
		Wait(100)
	end
	TaskPlayAnim(ped, "mech_pickup@plant@berries", "exit_eat", 8.0, -0.5, -1, 0, 0, true, 0, false, 0, false)
	Wait(2500)
	if (Effect ~= "") then
		ScreenEffect(Effect, EffectDuration)
	end
	ClearPedTasks(ped)
end 	

function bowl(index, PropName, Effect, EffectDuration )
	local ped = PlayerPedId()
	local coords = GetEntityCoords(ped)
	Citizen.InvokeNative(0xFCCC886EDE3C63EC, ped, 2, 1) -- Removes Weapon from animation
	ExecuteCommand('close')
	local bowl = CreateObject("p_bowl04x_stew", GetEntityCoords(ped), true, true, true)
	local spoon = CreateObject("p_spoon01x", GetEntityCoords(ped), true, true, true)
	Citizen.InvokeNative(0x669655FFB29EF1A9, bowl, 0, "Stew_Fill", 1.0)
	Citizen.InvokeNative(0xCAAF2BCCFEF37F77, bowl, 20)
	Citizen.InvokeNative(0xCAAF2BCCFEF37F77, spoon, 82)
	TaskItemInteraction_2(ped, 599184882, bowl, GetHashKey("p_bowl04x_stew_ph_l_hand"), -583731576, 3, 0, -1.0)
	TaskItemInteraction_2(ped, 599184882, spoon, GetHashKey("p_spoon01x_ph_r_hand"), -583731576, 3, 0, -1.0)
	Citizen.InvokeNative(0xB35370D5353995CB, ped, -583731576, 1.0)
	Wait(20000)
	if (Effect ~= "") then
		ScreenEffect(Effect, EffectDuration)
	end
	DeleteEntity(bowl)
	DeleteEntity(spoon)
end 

function shortbottole(index, PropName, Effect, EffectDuration, DrinkCount, SoftAlcohol, HardAlcohol)
	local ped = PlayerPedId()
	local coords = GetEntityCoords(ped)
	local propEntity = CreateObject(GetHashKey(PropName), GetEntityCoords(PlayerPedId()), false, true, false, false, true)
	local anim = TaskItemInteraction_2(PlayerPedId(), -1199896558, propEntity, GetHashKey('p_bottleBeer01x_PH_R_HAND'), GetHashKey('DRINK_BOTTLE@Bottle_Cylinder_D1-55_H18_Neck_A8_B1-8_TABLE_HOLD'), 1, 0, -1.0)
	if (SoftAlcohol) then
		local drunky = true
		while drunky do
			Wait(1)
			local retval  = DoesEntityExist(propEntity)
			if not retval then
				drunky = false
				drunken = drunken + 1
				if drunken == DrinkCount and not crazydrunk then
					timer = EffectDuration
					crazydrunk = true
					Citizen.InvokeNative(0x406CCF555B04FAD3, PlayerPedId(), 1, 1.0)
					if (Effect ~= "") then
						ScreenEffect(Effect, EffectDuration)
					end
				end
			end
		end
	end
	if (HardAlcohol) then
		local drunky = true
		while drunky do
			Wait(1)
			local retval  = DoesEntityExist(propEntity)
			if not retval then
				drunky = false
				drunken = drunken + 1
				if drunken >= 1 and not crazydrunk then
					timer = EffectDuration
					crazydrunk = true
					Citizen.InvokeNative(0x406CCF555B04FAD3, PlayerPedId(), 1, 1.0)
					if (Effect ~= "") then
						ScreenEffect(Effect, EffectDuration)
						--PlayAnimation(PlayerPedId(), Vomits["vomit3"])
					end
				end
				if (Config["VomitMe"] == true) then
					vomitLogic()
				end
			end
		end
	end
end 	
	
function longbottle(index, PropName, Effect, EffectDuration, DrinkCount, SoftAlcohol, HardAlcohol)
	local ped = PlayerPedId()
	local coords = GetEntityCoords(ped)
	local propEntity = CreateObject(GetHashKey(PropName), GetEntityCoords(PlayerPedId()), false, true, false, false, true)
		local anim = TaskItemInteraction_2(PlayerPedId(), -1199896558, propEntity, GetHashKey('p_bottleJD01x_ph_r_hand'), GetHashKey('DRINK_BOTTLE@Bottle_Cylinder_D1-3_H30-5_Neck_A13_B2-5_TABLE_HOLD'), 1, 0, -1.0)
		if (ItemsToUse[index]["SoftAlcohol"]) then
			local drunky = true
			while drunky do
				Wait(1)
				local retval  = DoesEntityExist(propEntity)
				if not retval then
					drunky = false
					drunken = drunken + 1
					if drunken == DrinkCount and not crazydrunk then
						timer = EffectDuration
						crazydrunk = true
						Citizen.InvokeNative(0x406CCF555B04FAD3, PlayerPedId(), 1, 1.0)
						if (Effect ~= "") then
							ScreenEffect(Effect, EffectDuration )
						end
					end
				end
			end
		end
		if (HardAlcohol) then
			local drunky = true
			while drunky do
				Wait(1)
				local retval  = DoesEntityExist(propEntity)
				if not retval then
					drunky = false
					drunken = drunken + 1
					if drunken >= 1 and not crazydrunk then
						timer = EffectDuration
						crazydrunk = true
						Citizen.InvokeNative(0x406CCF555B04FAD3, PlayerPedId(), 1, 1.0)
						if (Effect ~= "") then
							ScreenEffect(Effect, EffectDuration)
						end
					end
					if (Config["VomitMe"] == true) then
						vomitLogic()
					end
				end
			end
		end
	end 	

function drink_cup(index, PropName, Effect, EffectDuration)
	local ped = PlayerPedId()
	local coords = GetEntityCoords(ped)
	Citizen.InvokeNative(0xFCCC886EDE3C63EC, ped, 2, 1) -- Remove Weapon for Animation
	ExecuteCommand('close')
	local propEntity = CreateObject(GetHashKey('p_mugCoffee01x'), GetEntityCoords(ped), true, true, true)
	local task = TaskItemInteraction_2(ped, -1199896558, propEntity, GetHashKey('p_mugCOFFEE01x_ph_r_hand'), GetHashKey('DRINK_COFFEE_HOLD'), 3, 0, -1.0)
	Citizen.Wait(20000)
	if (Effect ~= "") then
		ScreenEffect(Effect, EffectDuration)
	end
	ClearPedSecondaryTask(ped)
end 

function drink(index, PropName, Effect, EffectDuration)
	local ped = PlayerPedId()
	local coords = GetEntityCoords(ped)
	local prop = CreateObject(PropName, coords.x, coords.y, coords.z + 0.2, true, true, false, false, true)
	local boneIndex = GetEntityBoneIndexByName(ped, "SKEL_R_Finger12")
	Citizen.InvokeNative(0xFCCC886EDE3C63EC, ped, 2, 1) -- Removes Weapon from animation
	Citizen.Wait(0)
	PlayAnimation(ped, Anims["drink"])
	AttachEntityToEntity(prop, PlayerPedId(), boneIndex, 0.02, 0.028, 0.001, 15.0, 175.0, 0.0, true, true, false, true, 1, true)
	Wait(10000)
	-- EFFECT 
	if (Effect ~= "") then
		ScreenEffect(Effect, EffectDuration)
	end
	DeleteEntity(prop)
	ClearPedSecondaryTask(ped)
end 

function eat(index, PropName, Effect, EffectDuration)
	local ped = PlayerPedId()
	local coords = GetEntityCoords(ped)
	local prop = CreateObject(PropName, coords.x, coords.y, coords.z + 0.2, true, true, false, false, true)
	local boneIndex = GetEntityBoneIndexByName(ped, "SKEL_L_Finger12")
	Citizen.Wait(0)
	Citizen.InvokeNative(0xFCCC886EDE3C63EC, ped, 2, 1) -- Removes Weapon from animation
	PlayAnimation(ped, Anims["eat"])
	AttachEntityToEntity(prop, PlayerPedId(), boneIndex, 0.02, 0.028, 0.001, 15.0, 175.0, 0.0, true, true, false, true, 1, true)
	Wait(1000)
	-- EFFECT 
	if (Effect ~= "") then
		ScreenEffect(Effect, EffectDuration)
	end
	DeleteEntity(prop)
	ClearPedSecondaryTask(ped)
end 


RegisterNetEvent('prop:eat')
AddEventHandler('prop:eat', function(index, PropName, Effect, EffectDuration)  
	eat(index, PropName, Effect, EffectDuration)
end) 

RegisterNetEvent('prop:drink')
AddEventHandler('prop:drink', function(index, PropName, Effect, EffectDuration)   
	drink(index, PropName, Effect, EffectDuration)
end) 

RegisterNetEvent('prop:drink_cup')
AddEventHandler('prop:drink_cup', function(index, PropName, Effect, EffectDuration)   
	drink_cup(index, PropName, Effect, EffectDuration) 
end) 

RegisterNetEvent('prop:bowl')
AddEventHandler('prop:bowl', function(index, PropName, Effect, EffectDuration)   
	bowl(index, PropName, Effect, EffectDuration) 
end) 

RegisterNetEvent('prop:shortbottle')
AddEventHandler('prop:shortbottle', function(index, PropName, Effect, EffectDuration)   
	shortbottole(index, PropName, Effect, EffectDuration, DrinkCount, SoftAlcohol, HardAlcohol)
end) 

RegisterNetEvent('prop:longbottle')
AddEventHandler('prop:longbottle', function(index, PropName, Effect, EffectDuration)  	 
	longbottle(index, PropName, Effect, EffectDuration, DrinkCount, SoftAlcohol, HardAlcohol)
end) 

RegisterNetEvent('prop:syringe')
AddEventHandler('prop:syringe', function(index, PropName, Effect, EffectDuration)  	 
	syringe(index, PropName, Effect, EffectDuration) 
end) 

RegisterNetEvent('prop:berry')
AddEventHandler('prop:berry', function(index, PropName, Effect, EffectDuration)   
	berry(index, PropName, Effect, EffectDuration) 
end)  
 

function PlayAnimation(ped, anim)
	--print("fredmeta:PlayAnimation - active")
	if not DoesAnimDictExist(anim.dict) then
		return
	end

	RequestAnimDict(anim.dict)

	while not HasAnimDictLoaded(anim.dict) do
		Wait(0)
	end
	TaskPlayAnim(ped, anim.dict, anim.name, 1.0, 1.0, -1, anim.flag, 0, false, false, false, '', false)
	RemoveAnimDict(anim.dict)
end

function ScreenEffect(effect, time)
	--print("fredmeta:ScreenEffect - active")
	--Citizen.InvokeNative(0x4102732DF6B4005F, effect)
	AnimpostfxPlay(effect)
	Citizen.Wait(time)
	--Citizen.InvokeNative(0xB4FD7446BAB2F394, effect)
	AnimpostfxStop(effect)
end