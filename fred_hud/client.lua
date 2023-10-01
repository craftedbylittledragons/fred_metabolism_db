money = 0
-- mystress = nil

 RegisterNetEvent("gui:getItems")
 AddEventHandler("gui:getItems", function(THEITEMS)
     SendNUIMessage({
        items = THEITEMS,
     })
 end)

-- RegisterNetEvent("gui:getStress") --[[ THIS FUNCTION SHIFTS THE STRESS VARIABLE FROM THE SERVER SIDE TO THE CLIENT SIDE ]]
-- AddEventHandler("gui:getStress", function(stress)
--     mystress = stress
--     print("This is your stress:", mystress)
-- end) 

-- RegisterNetEvent("gui:setstress") --[[ THIS FUNCTION RECORDS THE PLAYER'S STRESS ON A VARIABLE SERVER ]]
-- AddEventHandler("gui:setstress", function()
--     local _src = source
--     TriggerServerEvent("maliko:notstress")
-- end)

-- Citizen.CreateThread(function() --[[ THIS THREAD CHARGES PLAYER STRESS AT LOGIN]]
--     TriggerEvent("gui:setstress")
--     print("I activate the Server side")
-- end)

-- Citizen.CreateThread(function() --[[ THIS THREAD DECREASES PLAYER STRESS EVERY 30 SECONDS BY 3. ]]
-- while true do 
--     Wait(30000)
--     TriggerServerEvent("AbbassaStress", mystress)
--     mystress = nil
-- end
-- end)

local ClotheList = {
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



Citizen.CreateThread(function()
    while true do
        Citizen.Wait(0)
        local _source = source 
		--TriggerServerEvent("hud:checkmoney")
        Citizen.InvokeNative(0x50C803A4CD5932C5 , true)
        local myhunger = exports["fred_metabolism"]:getHunger()
        local mythirst = exports["fred_metabolism"]:getThirst()

        local player = PlayerPedId()
        local coords = GetEntityCoords(player)
        Citizen.InvokeNative(0xB98B78C3768AF6E0,true)
        local temp = GetTemperatureAtCoords(coords)
        local _src = source

        if Config["BodyTemp"] == true then
        
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
                    temp = temp + 1
                end

                if isWearingShirt then
                    temp = temp + 2
                end

                if isWearingPants then
                    temp = temp + 2
                end

                if isWearingBoots then
                    temp = temp + 2
                end

                if isWearingCoat then
                    temp = temp + 3
                end

                if isWearingClosedCoat then
                    temp = temp + 4
                end

                if isWearingGloves then
                    temp = temp + 1
                end

                if isWearingVest then
                    temp = temp + 1
                end

                if isWearingPonchoOne then
                    temp = temp + 5
                end

                if isWearingPonchoTwo then
                    temp = temp + 5
                end
    
                --[[local IsWearingClothes = Citizen.InvokeNative(0xFB4891BD7578CDC1, player, v)
                if IsWearingClothes then
                    temp = temp + 1
                end]]--
            --end
        end
        SendNUIMessage({
            action = "updateStatusHud",
                show = not IsRadarHidden(),
                hunger = myhunger,
                thirst = mythirst,
                --stress = mystress,
                --cash = money,
                --temp = math.floor(temp * 1.8 + 32.0).."°F",
				temp = math.floor(temp).."°C|"..math.floor(temp * 1.8 + 32.0).."°F", --°
		})
        Citizen.Wait(1000)
    end
end)

-- RegisterNetEvent("StressaPlayer")
-- AddEventHandler("StressaPlayer", function(qt)
--     stress = 0
--     mystress = nil
--     TriggerServerEvent("maliko:stressa",qt)
--     print("The player was stressed out of "..qt)
-- end)



-- RegisterCommand("malikomistressa", function()
--     TriggerEvent("StressaPlayer", 10)
-- end)


--  TriggerEvent("StressaPlayer", 100)  -- AGGIUNGE X STRESS 
