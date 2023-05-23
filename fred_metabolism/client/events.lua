-- EVENT, USE THIS FOR OTHER RESOURCES
RegisterNetEvent(Config.ScriptName..":consume")
AddEventHandler(Config.ScriptName..":consume", function(hunger,thirst, metabolism, innercorestamina, innercorestaminagold, outercorestaminagold, innercorehealth, innercorehealthgold, outercorehealthgold)

	--print("meta: hunger",hunger,"food",food,"thirst",thirst,"water",water)
    --print(Config.ScriptName..":consume Event")
	local ped = PlayerPedId()
	local coords = GetEntityCoords(ped) 
	food = food + tonumber(hunger)
	water = water + tonumber(thirst)
	metabolism = metabolism + tonumber(metabolism)
	TriggerServerEvent(Config.ScriptName..":setStatus", food, water, metabolism)

	if (food < 0) 		then	food = 0		end
	if (food > 100) 	then	food = 100		end
	if (water < 0)		then	water = 0		end
	if (water > 100)	then	water = 100		end

	if (innercorestamina ~= 0) then
		stamina = Citizen.InvokeNative(0x36731AC041289BB1, ped, 1) --ACTUAL STAMINA CORE GETTER
		newStamina = stamina + tonumber(innercorestamina)
		if (newStamina > 100) then	newStamina = 100	end
		Citizen.InvokeNative(0xC6258F41D86676E0, ped, 1, newStamina)
	end

	if (innercorehealth ~= 0)then
		health = Citizen.InvokeNative(0x36731AC041289BB1, ped, 0) --ACTUAL HEALTH CORE GETTER
		newHealth = health + tonumber(innercorehealth)
		if (newHealth > 100) then	newHealth = 100		end
		Citizen.InvokeNative(0xC6258F41D86676E0, ped, 0, newHealth)
	end
		--TO DO OUTER CORE HEALTH parametro = outerCoreHealth
	--GOLDS
	if (innercorestaminagold ~= 0.0) then
		Citizen.InvokeNative(0x4AF5A4C7B9157D14, PlayerPedId(), 1, innercorestaminagold, true)
	end
	if (outercorestaminagold ~= 0.0) then
		Citizen.InvokeNative(0xF6A7C08DF2E28B28, PlayerPedId(), 1, outercorestaminagold, true)
	end
	if (innercorehealthgold ~= 0.0) then
		Citizen.InvokeNative(0x4AF5A4C7B9157D14, PlayerPedId(), 0, innercorehealthgold, true)
	end
	if	(outercorehealthgold ~= 0.0) then
		Citizen.InvokeNative(0xF6A7C08DF2E28B28, PlayerPedId(), 0, outercorehealthgold, true)
	end
end)


RegisterNetEvent(Config.ScriptName..":applyChanges")
AddEventHandler(Config.ScriptName..":applyChanges", function(meta, hunger, thirst, metabolism)
--print(Config.ScriptName..":applyChanges Event")
	checked = true
	playerstatus = meta
	playerHunger = hunger
	playerThirst = thirst
	playerMetabolism = metabolism
end)