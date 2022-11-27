local QBCore = exports['qb-core']:GetCoreObject()

local function platecustom()
	local random = exports['qb-input']:ShowInput({
        header = "Escolha sua Placa",
        submitText = "Numeros",
        inputs = {
            {
                text = "maximo 8 digitos",
                name = "plate",
                type = "text",
                isRequired = true
            }
        }
    })
    return random["plate"]
end

RegisterNetEvent("JW-VipPlate:client:customplate", function()
    local veh = QBCore.Functions.GetClosestVehicle()
    local vehID = NetworkGetNetworkIdFromEntity(veh)
    local playerpos = GetEntityCoords(PlayerPedId())
    local front = GetOffsetFromEntityInWorldCoords(veh, 0, -2.5, 0)
    local back = GetOffsetFromEntityInWorldCoords(veh, 0, 2.5, 0)
    local PlayerData = QBCore.Functions.GetPlayerData()
    local distFront = #(playerpos - front)
    local distBack = #(playerpos - back)
    local plate = GetVehicleNumberPlateText(veh)
    if veh ~= 0 and not IsPedInAnyVehicle(PlayerPedId()) then
        if distFront <= 2.0 or distBack <= 2.0 then
            QBCore.Functions.TriggerCallback('JW-VipPlate:callback:vehicle', function(result)
                for i, v in pairs(result) do
                    if PlayerData.citizenid == v.citizenid then
                        QBCore.Functions.Progressbar('change_plate', Lang:t("Progressbar.changingPlate"), 8000, false, true, { -- Name | Label | Time | useWhileDead | canCancel
                            disableMovement = true,
                            disableCarMovement = true,
                            disableMouse = false,
                            disableCombat = true,
                        }, {
                            animDict = '"anim@amb@clubhouse@tutorial@bkr_tut_ig3@"@',
                            anim = 'machinic_loop_mechandplayer',
                            flags = 1,
                        }, {}, {}, function()
                            TriggerEvent('JW-VipPlate:client:setPlate', vehID)
                            ClearPedTasks(PlayerPedId())
                        end, function()
                            ClearPedTasks(PlayerPedId())
                        end)
                    else
                        QBCore.Functions.Notify(Lang:t("error.owner"), "error")
                    end
                end
            end)
        else
            QBCore.Functions.Notify(Lang:t("error.notvehicledist"), "error")
        end
    end
end)

RegisterNetEvent('JW-VipPlate:client:setPlate', function (vehID)
    local veh = NetworkGetEntityFromNetworkId(vehID)
    if veh and veh ~= 0 then
        local plate = QBCore.Functions.GetPlate(veh)
        local newPlate = platecustom()
        local tPlate = string.len(newPlate)
        if tPlate <= 8 then
            SetVehicleNumberPlateText(veh, newPlate)
            TriggerServerEvent('JW-VipPlate:server:setPlate', plate, newPlate)
            QBCore.Functions.Notify(Lang:t("success.plate"), "success")
            TriggerEvent('vehiclekeys:client:SetOwner', newPlate)
            TriggerServerEvent("JW-VipPlate:server:RemoveItem")
        else
            QBCore.Functions.Notify(Lang:t("error.platelen"), "error")
        end        
    end
end)
