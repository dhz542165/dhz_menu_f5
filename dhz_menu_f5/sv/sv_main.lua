ESX = nil

TriggerEvent(cfg.DefBase.ESX, function(obj) ESX = obj end)


ESX.RegisterServerCallback('DHZ:VerifStaff', function(source, cb)
	local xPlayer = ESX.GetPlayerFromId(source)
	local group = xPlayer.getGroup()
	cb(group)
end)

RegisterServerEvent('DHZ:Weapon_addAmmoToPedS')
AddEventHandler('DHZ:Weapon_addAmmoToPedS', function(plyId, value, quantity)
	if #(GetEntityCoords(source, false) - GetEntityCoords(plyId, false)) <= 3.0 then
		TriggerClientEvent('DHZ:Weapon_addAmmoToPedC', plyId, value, quantity)
	end
end)

ESX.RegisterServerCallback('dhz_personalmenu:Bill_getBills', function(source, cb)
	local xPlayer = ESX.GetPlayerFromId(source)
	local bills = {}

	MySQL.Async.fetchAll('SELECT * FROM billing WHERE identifier = @identifier', {
		['@identifier'] = xPlayer.identifier
	}, function(result)
		for i = 1, #result, 1 do
			table.insert(bills, {
				id = result[i].id,
				label = result[i].label,
				amount = result[i].amount
			})
		end

		cb(bills)
	end)
end)

RegisterServerEvent('job:set')
AddEventHandler('job:set', function(job, grade)
	local _source = source
	local xPlayer = ESX.GetPlayerFromId(_source)
	
	xPlayer.setJob("unemployed", 0)		
end)
