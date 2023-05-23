VorpCore = {}

if Config["VORP"] == true then
    TriggerEvent("getCore",function(core)
        VorpCore = core
    end)
    --VORP = exports.vorp_core:vorpAPI()
    VorpInv = exports.vorp_inventory:vorp_inventoryApi()
    print("^4["..Config.ScriptName.."]^0 ^2Framework: VORP Core^0")
end
   
 
-- APPLIES CHANGES TO DB
RegisterServerEvent(Config.ScriptName..":setChanges")
AddEventHandler(Config.ScriptName..":setChanges", function(abodytype, awaist)

    if Config["VORP"] == true then
        --print(Config.ScriptName..":setChanges Event")
        local User = VorpCore.getUser(source)
        local _source = source
        local Character = User.getUsedCharacter
        local u_identifier = Character.identifier
        local u_charid = Character.charIdentifier
        local BodyType = abodytype
        local Waist = awaist

        exports.ghmattimysql:execute('SELECT skinPlayer FROM characters WHERE identifier=@identifier AND charidentifier = @charidentifier', {['identifier'] = u_identifier, ['charidentifier'] = u_charid}, function(result)

            if result[1] ~= nil then 
                for i = 1, #result do
                local skinPlayer = json.decode(result[i].skinPlayer)
                skinPlayer.BodyType = abodytype
                skinPlayer.Waist = awaist
                skinPlayer = json.encode(skinPlayer)
                local Parameters = { ['identifier'] = u_identifier, ['charidentifier'] = u_charid , ['skinPlayer'] = skinPlayer}
                exports.ghmattimysql:execute("UPDATE characters SET skinPlayer=@skinPlayer WHERE identifier=@identifier AND charidentifier = @charidentifier", Parameters)
                end    
            end
        end)
    end 
end)

-- APPLIES CHANGES TO DB.
RegisterServerEvent(Config.ScriptName..":setStatus")
AddEventHandler(Config.ScriptName..":setStatus", function(hunger, thirst, metabolism)
        
    if Config["VORP"] == true then
        --print(Config.ScriptName..":setStatus Event")
        local User = VorpCore.getUser(source)
        local _source = source
        local Character = User.getUsedCharacter
        local u_identifier = Character.identifier
        local u_charid = Character.charIdentifier
        local Hunger = hunger
        local Thirst = thirst
        local Metabolism = metabolism

        exports.ghmattimysql:execute('SELECT meta FROM characters WHERE identifier=@identifier AND charidentifier = @charidentifier', {['identifier'] = u_identifier, ['charidentifier'] = u_charid}, function(result)

            if result[1] ~= nil then 
                for i = 1, #result do
                    local meta = json.decode(result[i].meta)
                    meta.Hunger = hunger
                    meta.Thirst = thirst
                    meta.Metabolism = metabolism
                    meta = json.encode(meta)
                    local Parameters = { ['identifier'] = u_identifier, ['charidentifier'] = u_charid , ['meta'] = meta}
                    exports.ghmattimysql:execute("UPDATE characters SET meta=@meta WHERE identifier=@identifier AND charidentifier = @charidentifier", Parameters)
                end 
            end
        end)
    end 
end)

-- Checks player status.
RegisterServerEvent(Config.ScriptName..":checkStatus")
AddEventHandler(Config.ScriptName..":checkStatus", function()
    --print(Config.ScriptName..":checkStatus Event")

    if Config["VORP"] == true then    
        local _source = source
        local User = VorpCore.getUser(source) 
        local Character = VorpCore.getUser(source).getUsedCharacter
        local identifier= Character.identifier
        local charidentifier= Character.charIdentifier
        exports.ghmattimysql:execute('SELECT meta FROM characters WHERE identifier=@identifier AND charidentifier = @charidentifier', {['identifier'] = identifier, ['charidentifier'] = charidentifier}, function(result)

            if result[1] ~= nil then 
                for i = 1, #result do
                    local meta = json.decode(result[i].meta)    
                    hunger = meta.Hunger
                    thirst = meta.Thirst
                    metabolism = meta.Metabolism
                    TriggerClientEvent(Config.ScriptName..":applyChanges", _source, meta, hunger, thirst, metabolism)
                end
            end
        end)
    end 
end) 
 