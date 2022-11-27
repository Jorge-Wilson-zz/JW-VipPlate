local QBCore = exports['qb-core']:GetCoreObject()

QBCore.Functions.CreateUseableItem("vip-plate", function(source)
    TriggerClientEvent("JW-VipPlate:client:customplate", source) 
end)

QBCore.Functions.CreateCallback('JW-VipPlate:callback:vehicle', function(source, cb,plate)
    exports.oxmysql:fetch("SELECT * FROM player_vehicles",
		{}, function(result)
		if result[1] ~= nil then
			cb(result)
		else
			cb(nil)
		end
	end)
end)

RegisterNetEvent('JW-VipPlate:server:setPlate', function (oldPlate, newPlate)
    MySQL.Async.execute('UPDATE player_vehicles SET plate = @newPlate WHERE plate = @oldPlate', {
    ['@oldPlate'] = oldPlate,
    ['@newPlate'] = newPlate
    })
end)

RegisterNetEvent('JW-VipPlate:server:RemoveItem', function()
    local src = source
    local Player = QBCore.Functions.GetPlayer(src)

    Player.Functions.RemoveItem("vip-plate", 1)
    TriggerClientEvent("inventory:client:ItemBox", src, "vip-plate", "remove", amount)
end)
