ESX = nil

DHZ = {
    Menu = false,
    bank = nil,
    sale = nil,
    map = true,
    hud = true,
    visual = false,
    visual2 = false,
    visual3 = false,
    visual4 = false,
    visual5 = false,
    visual6 = false,
    visual7 = false,
    visual8 = false,
    visual9 = false,
    visual10 = false,
    isDead = false,
    noclip = false,
    godmode = false,
	ghostmode = false,
    ItemSelected = {},
    BillData = {},
    GPSIndex = 1,
	GPSList = {},
}

local plyPed = PlayerPedId()

object = {}

DHZ.V = {
    agauche = false,
    argauche = false,
    adroite = false,
    ardroite = false,
    capot = false
}


Citizen.CreateThread(function()
    while ESX == nil do
        TriggerEvent(cfg.DefBase.ESX, function(obj) ESX = obj end)
        Citizen.Wait(0)
    end

	while ESX.GetPlayerData().job == nil do
		Citizen.Wait(10)
	end

    if cfg.DoubleJob then
        while ESX.GetPlayerData().job2 == nil do
            Citizen.Wait(10)
        end
    end

	ESX.PlayerData = ESX.GetPlayerData()

    RefreshMoney()

    if cfg.DoubleJob then
        RefreshMoney2()
    end

    DHZ.WeaponData = ESX.GetWeaponList()

	for i = 1, #DHZ.WeaponData, 1 do
		if DHZ.WeaponData[i].name == 'WEAPON_UNARMED' then
			DHZ.WeaponData[i] = nil
		else
			DHZ.WeaponData[i].hash = GetHashKey(DHZ.WeaponData[i].name)
		end
    end

    for i = 1, #cfg.GPS, 1 do
		table.insert(DHZ.GPSList, cfg.GPS[i].Nom)
	end

    RMenu.Add('inventory', 'main', RageUI.CreateMenu("Inventaire", "", 0,0))
    RMenu.Add('inventory', 'inventory', RageUI.CreateSubMenu(RMenu:Get('inventory', 'main'), "Choix", "~b~Type"))
    RMenu.Add('inventory', 'weapon', RageUI.CreateSubMenu(RMenu:Get('inventory', 'main'), "Inventaire", "~b~Inventaire du joueur"))
    RMenu.Add('inventory', 'inventaire', RageUI.CreateSubMenu(RMenu:Get('inventory', 'main'), "Inventaire", "~b~Inventaire du joueur"))
    RMenu.Add('inventory', 'inventaire_use', RageUI.CreateSubMenu(RMenu:Get('inventory', 'main'), "Inventaire", "~b~Inventaire du joueur"))
    RMenu.Add('inventory', 'weapondddd_use', RageUI.CreateSubMenu(RMenu:Get('inventory', 'main'), "Inventaire", "~b~Inventaire du joueur"))
    RMenu.Add('inventory', 'portefeuille', RageUI.CreateSubMenu(RMenu:Get('inventory', 'main'), "Portefeuille", "~b~Portefeuille"))
    RMenu.Add('inventory', 'portefeuille_use', RageUI.CreateSubMenu(RMenu:Get('inventory', 'main'), "Portefeuille", "~b~Portefeuille"))
    RMenu.Add('inventory', 'portefeuille_money', RageUI.CreateSubMenu(RMenu:Get('inventory', 'main'), "Portefeuille", "~b~Actions sur votre portefeuille"))
    RMenu.Add('inventory', 'portefeuille_work', RageUI.CreateSubMenu(RMenu:Get('inventory', 'main'), "Emplois", "~b~Gestions de votre emplois"))
    RMenu.Add('inventory', 'portefeuille_work2', RageUI.CreateSubMenu(RMenu:Get('inventory', 'main'), "Emplois secondaire", "~b~Gestions de votre emplois"))
    RMenu.Add('inventory', 'portefeuille_billing', RageUI.CreateSubMenu(RMenu:Get('inventory', 'main'), "Factures", "~b~Gestions de vos factures"))

    RMenu.Add('inventory', 'demarches', RageUI.CreateSubMenu(RMenu:Get('inventory', 'main'), "Démarches", "~b~Liste des démarches"))
    RMenu.Add('inventory', 'anim', RageUI.CreateSubMenu(RMenu:Get('inventory', 'main'), "Animations", "~b~Liste des animations"))
    RMenu.Add('inventory', 'dances', RageUI.CreateSubMenu(RMenu:Get('inventory', 'anim'), "Animations", "~b~Animations de dances"))
    RMenu.Add('inventory', 'festives', RageUI.CreateSubMenu(RMenu:Get('inventory', 'anim'), "Animations", "~b~Animations festives"))
    RMenu.Add('inventory', 'salutations', RageUI.CreateSubMenu(RMenu:Get('inventory', 'anim'), "Animations", "~b~Animations de salutations"))
    RMenu.Add('inventory', 'travail', RageUI.CreateSubMenu(RMenu:Get('inventory', 'anim'), "Animations", "~b~Animations de travail"))
    RMenu.Add('inventory', 'humeurs', RageUI.CreateSubMenu(RMenu:Get('inventory', 'anim'), "Animations", "~b~ Humeurs"))
    RMenu.Add('inventory', 'sports', RageUI.CreateSubMenu(RMenu:Get('inventory', 'anim'), "Animations", "~b~Animations de sports"))
    RMenu.Add('inventory', 'animdivers', RageUI.CreateSubMenu(RMenu:Get('inventory', 'anim'), "Animations", "~b~Divers"))
    RMenu.Add('inventory', 'pegi18', RageUI.CreateSubMenu(RMenu:Get('inventory', 'anim'), "Animations", "~b~Animations -18"))

    RMenu.Add('inventory', 'objectmain', RageUI.CreateSubMenu(RMenu:Get('inventory', 'main'), "Menu Props", "Catégories :"))

    RMenu.Add('inventory', 'object', RageUI.CreateSubMenu(RMenu:Get('inventory', 'main'), "Props", "Appuyer sur [~b~E~w~] pour poser les objet"))
    RMenu.Add('inventory', 'object2', RageUI.CreateSubMenu(RMenu:Get('inventory', 'main'), "Props", "Appuyer sur [~b~E~w~] pour poser les objet"))
    RMenu.Add('inventory', 'object3', RageUI.CreateSubMenu(RMenu:Get('inventory', 'main'), "Props", "Appuyer sur [~b~E~w~] pour poser les objet"))
    RMenu.Add('inventory', 'object4', RageUI.CreateSubMenu(RMenu:Get('inventory', 'main'), "Props", "Appuyer sur [~b~E~w~] pour poser les objet"))
    RMenu.Add('inventory', 'object5', RageUI.CreateSubMenu(RMenu:Get('inventory', 'main'), "Props", "Appuyer sur [~b~E~w~] pour poser les objet"))
    RMenu.Add('inventory', 'object6', RageUI.CreateSubMenu(RMenu:Get('inventory', 'main'), "Props", "Appuyer sur [~b~E~w~] pour poser les objet"))
    RMenu.Add('inventory', 'object7', RageUI.CreateSubMenu(RMenu:Get('inventory', 'main'), "Props", "Appuyer sur [~b~E~w~] pour poser les objet"))
    RMenu.Add('inventory', 'objectlist', RageUI.CreateSubMenu(RMenu:Get('inventory', 'object'), "Suppression d'objets", "~b~Suppression d'objets"))

    RMenu.Add('inventory', 'divers', RageUI.CreateSubMenu(RMenu:Get('inventory', 'main'), "Divers", "~b~Divers"))
    RMenu.Add('inventory', 'visual', RageUI.CreateSubMenu(RMenu:Get('inventory', 'main'), "Visuel", "~b~Menu visuel"))
    RMenu.Add('inventory', 'touches', RageUI.CreateSubMenu(RMenu:Get('inventory', 'main'), "Touches", "~b~Menu touches"))
    RMenu.Add('inventory', 'utils', RageUI.CreateSubMenu(RMenu:Get('inventory', 'main'), "utils", "~r~Serveur"))
    RMenu.Add('inventory', 'boos', RageUI.CreateSubMenu(RMenu:Get('inventory', 'main'), "Gestion d'entreprise", "~r~Gestion d'entreprise"))
    RMenu.Add('inventory', 'boos2', RageUI.CreateSubMenu(RMenu:Get('inventory', 'main'), "Gestion d'entreprise", "~r~Gestion d'entreprise"))
    RMenu.Add('inventory', 'personnage', RageUI.CreateSubMenu(RMenu:Get('inventory', 'main'), "Personnage", "~b~Personnage"))
    RMenu.Add('inventory', 'clothes1', RageUI.CreateSubMenu(RMenu:Get('inventory', 'main'), "Personnage", "~b~Personnage"))
    RMenu.Add('inventory', 'accessoires1', RageUI.CreateSubMenu(RMenu:Get('inventory', 'main'), "Personnage", "~b~Personnage"))
    RMenu:Get('inventory', 'main'):SetSubtitle("Votre ~b~ID~s~ est : ~b~".. GetPlayerServerId(PlayerId()) .. '')
    RMenu:Get('inventory', 'main').EnableMouse = false
    RMenu:Get('inventory', 'main').Closed = function()
        DHZ.Menu = false
    end
end) 

societymoney = nil
societymoney2 = nil

AddEventHandler('esx:onPlayerDeath', function()
	DHZ.isDead = true
	RageUI.CloseAll()
	ESX.UI.Menu.CloseAll()
    DHZ.Menu = false
end)

AddEventHandler('playerSpawned', function()
	DHZ.isDead = false
end)


function RefreshMoney()
	if ESX.PlayerData.job ~= nil and ESX.PlayerData.job.grade_name == 'boss' then
		ESX.TriggerServerCallback(cfg.DefBase.ArgentSociete, function(money)
			societymoney = ESX.Math.GroupDigits(money)
		end, ESX.PlayerData.job.name)
	end
end

function startAttitude(lib, anim)
	ESX.Streaming.RequestAnimSet(lib, function()
		SetPedMovementClipset(PlayerPedId(), anim, true)
	end)
end

function startAnim(lib, anim)
	ESX.Streaming.RequestAnimDict(lib, function()
		TaskPlayAnim(PlayerPedId(), lib, anim, 8.0, -8.0, -1, 0, 0.0, false, false, false)
	end)
end

function startScenario(anim)
	TaskStartScenarioInPlace(PlayerPedId(), anim, 0, false)
end

function EmoteCancel()
    if ChosenDict == "MaleScenario" then
        ClearPedTasksImmediately(PlayerPedId())
    elseif ChosenDict == "Scenario" then
        ClearPedTasksImmediately(PlayerPedId())
    end
    PtfxNotif = false
    PtfxPrompt = false
    ClearPedTasks(PlayerPedId())
    ClearPedTasksImmediately(PlayerPedId())
  end

function PtfxStop()
    for a,b in pairs(PlayerParticles) do
        StopParticleFxLooped(b, false)
        table.remove(PlayerParticles, a)
    end
end

if cfg.DoubleJob then
    function RefreshMoney2()
        if ESX.PlayerData.job2 ~= nil and ESX.PlayerData.job2.grade_name == 'boss' then
            ESX.TriggerServerCallback(cfg.DefBase.ArgentSociete, function(money)
                societymoney2 = ESX.Math.GroupDigits(money)
            end, ESX.PlayerData.job2.name)
        end
    end
end

function setUniform(value, plyPed)
	ESX.TriggerServerCallback('esx_skin:getPlayerSkin', function(skin)
		TriggerEvent('skinchanger:getSkin', function(skina)
			if value == 'torso' then
				startAnim('clothingtie', 'try_tie_neutral_a')
				Citizen.Wait(1000)
				ClearPedTasks(PlayerPedId())

				if skin.torso_1 ~= skina.torso_1 then
					TriggerEvent('skinchanger:loadClothes', skina, {['torso_1'] = skin.torso_1, ['torso_2'] = skin.torso_2, ['tshirt_1'] = skin.tshirt_1, ['tshirt_2'] = skin.tshirt_2, ['arms'] = skin.arms})
				else
					TriggerEvent('skinchanger:loadClothes', skina, {['torso_1'] = 15, ['torso_2'] = 0, ['tshirt_1'] = 15, ['tshirt_2'] = 0, ['arms'] = 15})
				end
            elseif value == 'pants' then
                startAnim('re@construction', 'out_of_breath')
                Citizen.Wait(1000)
				ClearPedTasks(PlayerPedId())
				if skin.pants_1 ~= skina.pants_1 then
					TriggerEvent('skinchanger:loadClothes', skina, {['pants_1'] = skin.pants_1, ['pants_2'] = skin.pants_2})
				else
					if skin.sex == 0 then
						TriggerEvent('skinchanger:loadClothes', skina, {['pants_1'] = 55, ['pants_2'] = 0})
					else
						TriggerEvent('skinchanger:loadClothes', skina, {['pants_1'] = 15, ['pants_2'] = 0})
					end
				end
            elseif value == 'shoes' then
                startAnim('random@domestic', 'pickup_low')
                Citizen.Wait(1000)
				ClearPedTasks(PlayerPedId())
				if skin.shoes_1 ~= skina.shoes_1 then
					TriggerEvent('skinchanger:loadClothes', skina, {['shoes_1'] = skin.shoes_1, ['shoes_2'] = skin.shoes_2})
				else
					if skin.sex == 0 then
						TriggerEvent('skinchanger:loadClothes', skina, {['shoes_1'] = 49, ['shoes_2'] = 0})
					else
						TriggerEvent('skinchanger:loadClothes', skina, {['shoes_1'] = 35, ['shoes_2'] = 0})
					end
				end
            elseif value == 'bag' then
                startAnim('clothingtie', 'try_tie_neutral_a')
                Citizen.Wait(1000)
				ClearPedTasks(PlayerPedId())
				if skin.bags_1 ~= skina.bags_1 then
					TriggerEvent('skinchanger:loadClothes', skina, {['bags_1'] = skin.bags_1, ['bags_2'] = skin.bags_2})
				else
					TriggerEvent('skinchanger:loadClothes', skina, {['bags_1'] = 0, ['bags_2'] = 0})
				end
			elseif value == 'bproof' then
				startAnim('clothingtie', 'try_tie_neutral_a')
				Citizen.Wait(1000)
				
				ClearPedTasks(PlayerPedId())

				if skin.bproof_1 ~= skina.bproof_1 then
					TriggerEvent('skinchanger:loadClothes', skina, {['bproof_1'] = skin.bproof_1, ['bproof_2'] = skin.bproof_2})
				else
					TriggerEvent('skinchanger:loadClothes', skina, {['bproof_1'] = 0, ['bproof_2'] = 0})
				end
			end
		end)
	end)
end

function setAccessory(accessory)
	ESX.TriggerServerCallback('esx_accessories:get', function(hasAccessory, accessorySkin)
		local _accessory = (accessory):lower()

		if hasAccessory then
			TriggerEvent('skinchanger:getSkin', function(skin)
				local mAccessory = -1
				local mColor = 0

				if _accessory == 'ears' then
					startAnim('mini@ears_defenders', 'takeoff_earsdefenders_idle')
					Citizen.Wait(250)
					
					ClearPedTasks(PlayerPedId())
				elseif _accessory == 'glasses' then
					mAccessory = 5
					startAnim('clothingspecs', 'try_glasses_positive_a')
					Citizen.Wait(1000)
					
					ClearPedTasks(PlayerPedId())
				elseif _accessory == 'helmet' then
					startAnim('missfbi4', 'takeoff_mask')
					Citizen.Wait(1000)
					
					ClearPedTasks(PlayerPedId())
				elseif _accessory == 'mask' then
					mAccessory = 0
					startAnim('missfbi4', 'takeoff_mask')
					Citizen.Wait(850)
					
					ClearPedTasks(PlayerPedId())
				end

				if skin[_accessory .. '_1'] == mAccessory then
					mAccessory = accessorySkin[_accessory .. '_1']
					mColor = accessorySkin[_accessory .. '_2']
				end

				local accessorySkin = {}
				accessorySkin[_accessory .. '_1'] = mAccessory
				accessorySkin[_accessory .. '_2'] = mColor
				TriggerEvent('skinchanger:loadClothes', skin, accessorySkin)
			end)
		else
			if _accessory == 'ears' then
                ESX.ShowNotification("Vous n'en avez pas")
			elseif _accessory == 'glasses' then
				ESX.ShowNotification("Vous n'en avez pas")
			elseif _accessory == 'helmet' then
				ESX.ShowNotification("Vous n'en avez pas")
			elseif _accessory == 'mask' then
				ESX.ShowNotification("Vous n'en avez pas")
			end
		end
	end, accessory)
end

RegisterNetEvent('esx_addonaccount:setMoney')
AddEventHandler('esx_addonaccount:setMoney', function(society, money)
	if ESX.PlayerData.job ~= nil and ESX.PlayerData.job.grade_name == 'boss' and 'society_' .. ESX.PlayerData.job.name == society then
		societymoney = ESX.Math.GroupDigits(money)
	end

	if ESX.PlayerData.job2 ~= nil and ESX.PlayerData.job2.grade_name == 'boss' and 'society_' .. ESX.PlayerData.job2.name == society then
		societymoney2 = ESX.Math.GroupDigits(money)
	end
end)

function FonctionMenuF5Ouvert()
    if DHZ.Menu then
        DHZ.Menu = false
    else
        DHZ.Menu = true
        RageUI.Visible(RMenu:Get('inventory', 'main'), true)

        Citizen.CreateThread(function()
            while DHZ.Menu do
                Wait(0)
                RageUI.IsVisible(RMenu:Get('inventory', 'main'), true, true, true, function() 

                    RageUI.ButtonWithStyle("Inventaire", nil, {RightLabel = "→"}, true, function(Hovered,Active,Selected)
                        if Selected then
                        end
                    end, RMenu:Get('inventory', 'inventory'))

                    RageUI.ButtonWithStyle("Portefeuille", nil, {RightLabel = "→"}, true, function(Hovered,Active,Selected)
                        if Selected then
                        end
                    end, RMenu:Get('inventory', 'portefeuille'))

                    RageUI.ButtonWithStyle("Mon personnage", nil, {RightLabel = "→"}, true, function(Hovered,Active,Selected)
                        if Selected then
                        end
                    end, RMenu:Get('inventory', 'personnage'))
                        
                    RageUI.ButtonWithStyle("Animations", nil, {RightLabel = "→"}, true, function(Hovered,Active,Selected)
                        if Selected then
                        end
                    end, RMenu:Get('inventory', 'anim'))


                    RageUI.ButtonWithStyle("Divers", nil, {RightLabel = "→"}, true, function(Hovered,Active,Selected)
                        if Selected then
                        end
                    end, RMenu:Get('inventory', 'divers'))   
                    
                    RageUI.ButtonWithStyle("Démarches", nil, {RightLabel = "→"}, true, function(Hovered,Active,Selected)
                        if Selected then
                        end
                    end, RMenu:Get('inventory', 'demarches'))

                    RageUI.List('GPS rapide', DHZ.GPSList, DHZ.GPSIndex, nil, {}, true, function(Hovered, Active, Selected, Index)
                        if (Selected) then
                            if cfg.GPS[Index].Coo ~= nil then
                                SetNewWaypoint(cfg.GPS[Index].Coo)
                            else
                                DeleteWaypoint()
                            end
                        end
                        DHZ.GPSIndex = Index
                    end)

                    if cfg.Props.UtiliserMenuProps then
                        RageUI.ButtonWithStyle("Menu props", nil, {RightLabel = "→"}, true, function(Hovered,Active,Selected)
                            if Selected then
                            end
                        end, RMenu:Get('inventory', 'objectmain'))
                    end
                end)    

                RageUI.IsVisible(RMenu:Get('inventory', 'inventory'), true, true, true, function() 

                    RageUI.ButtonWithStyle("Items", nil, {RightLabel = "→"}, true, function(Hovered, Actice, Selected)
                        if (Selected) then
                        end
                    end, RMenu:Get('inventory', 'inventaire'))

                    RageUI.ButtonWithStyle("Armes", nil, {RightLabel = "→"}, true, function(Hovered, Actice, Selected)
                        if (Selected) then
                        end
                    end, RMenu:Get('inventory', 'weapon'))
                end, function() 
                end)

                RageUI.IsVisible(RMenu:Get('inventory', 'inventaire'), true, true, true, function()
                    if cfg.UtiliserSystemeDePoids then
                        RageUI.Separator('~b~Sac à dos')
                        ESX.PlayerData = ESX.GetPlayerData()
                        RageUI.Separator('Poids > '.. GetCurrentWeight() + 0.0 .. '/' .. ESX.PlayerData.maxWeight + 0.0)
                        for i = 1, #ESX.PlayerData.inventory do
                            if ESX.PlayerData.inventory[i].count > 0 then
                                RageUI.ButtonWithStyle('[~r~' ..ESX.PlayerData.inventory[i].count.. '~s~] ~b~- ~s~' ..ESX.PlayerData.inventory[i].label, nil, {RightLabel = "→"}, true, function(Hovered, Active, Selected) 
                                    if (Selected) then 
                                        DHZ.ItemSelected = ESX.PlayerData.inventory[i]
                                    end 
                                end, RMenu:Get('inventory', 'inventaire_use'))
                            end
                        end
                    else
                        RageUI.Separator('~b~Sac à dos')
                        ESX.PlayerData = ESX.GetPlayerData()
                        for i = 1, #ESX.PlayerData.inventory do
                            if ESX.PlayerData.inventory[i].count > 0 then
                                RageUI.ButtonWithStyle('[~r~' ..ESX.PlayerData.inventory[i].count.. '~s~] ~b~- ~s~' ..ESX.PlayerData.inventory[i].label, nil, {RightLabel = "→"}, true, function(Hovered, Active, Selected) 
                                    if (Selected) then 
                                        DHZ.ItemSelected = ESX.PlayerData.inventory[i]
                                    end 
                                end, RMenu:Get('inventory', 'inventaire_use'))
                            end
                        end
                    end
                end)

                function GetCurrentWeight()
                    local currentWeight = 0
                    
                    for i = 1, #ESX.PlayerData.inventory do
                        if ESX.PlayerData.inventory[i].count > 0 then
                            currentWeight = currentWeight + (ESX.PlayerData.inventory[i].weight * ESX.PlayerData.inventory[i].count)
                        end
                    end
                    
                    return currentWeight
                end

                RageUI.IsVisible(RMenu:Get('inventory', 'weapon'), true, true, true, function() 
                    ESX.PlayerData = ESX.GetPlayerData()
                    for i = 1, #DHZ.WeaponData, 1 do
                        if HasPedGotWeapon(PlayerPedId(), DHZ.WeaponData[i].hash, false) then
                            local ammo = GetAmmoInPedWeapon(PlayerPedId(), DHZ.WeaponData[i].hash)
                            RageUI.ButtonWithStyle(DHZ.WeaponData[i].label .. ' [' .. ammo .. ']', nil, {RightLabel = "→→→"}, true, function(Hovered, Active, Selected)
                                if (Selected) then
                                    DHZ.ItemSelected = DHZ.WeaponData[i]
                                end
                            end, RMenu:Get('inventory', 'weapondddd_use'))
                        end
                    end
                end)

                RageUI.IsVisible(RMenu:Get('inventory', 'weapondddd_use'), true, true, true, function() 
                    RageUI.ButtonWithStyle('Donner des ~r~munitions', nil, {RightBadge = RageUI.BadgeStyle.Ammo}, false, function(Hovered, Active, Selected)
                        if (Selected) then
                            local post, quantity = CheckQuantity(KeyboardInput('Nombre de munitions', '180'), '', 8)
                            if post then
                                local closestPlayer, closestDistance = ESX.Game.GetClosestPlayer()
                                if closestDistance ~= -1 and closestDistance <= 3 then
                                    local closestPed = GetPlayerPed(closestPlayer)
                                    local pPed = PlayerPedId()
                                    local coords = GetEntityCoords(pPed)
                                    local x,y,z = table.unpack(coords)
                                    DrawMarker(2, x, y, z+1.5, 0, 0, 0, 180.0,nil,nil, 0.5, 0.5, 0.5, 0, 0, 255, 120, true, true, p19, true)
                                    if IsPedOnFoot(closestPed) then
                                        local ammo = GetAmmoInPedWeapon(plyPed, DHZ.ItemSelected.hash)
                                        if ammo > 0 then
                                            if quantity <= ammo and quantity >= 0 then
                                                local finalAmmo = math.floor(ammo - quantity)
                                                SetPedAmmo(plyPed, DHZ.ItemSelected.name, finalAmmo)
                                                TriggerServerEvent('DHZ:Weapon_addAmmoToPedS', GetPlayerServerId(closestPlayer), DHZ.ItemSelected.name, quantity)
                                                ESX.ShowNotification('Vous avez donné x '..quantity..' munitions à '..GetPlayerName(closestPlayer))
                                            else
                                                ESX.ShowNotification('Vous n\'avez pas assez de munitions')
                                            end
                                        else
                                            ESX.ShowNotification("Vous n'avez pas de munitions")
                                        end
                                    else
                                        ESX.ShowNotification('Vous ne pouvez pas donner des munitions dans un véhicule')
                                    end
                                else
                                    ESX.ShowNotification("Aucun joueur proche")
                                end
                            else
                                ESX.ShowNotification("Nombre de munitions invalide")
                            end
                        end
                    end)
                    
                    RageUI.ButtonWithStyle("Jeter ~g~l'arme", nil, {RightBadge = RageUI.BadgeStyle.Gun}, false, function(Hovered, Active, Selected)
                        if Selected then
                            if IsPedOnFoot(PlayerPedId()) then
                                TriggerServerEvent('esx:removeInventoryItem', 'item_weapon', DHZ.ItemSelected.name)
                            else
                                ESX.ShowNotification("Impossible de jeter l'arme dans un véhicule")
                                
                            end
                        end
                    end)

                    if HasPedGotWeapon(plyPed, DHZ.ItemSelected.hash, false) then
                        RageUI.ButtonWithStyle("Donner ~g~l'arme", nil, {RightBadge = RageUI.BadgeStyle.Gun}, false, function(Hovered, Active, Selected)
                            if Selected then
                                local closestPlayer, closestDistance = ESX.Game.GetClosestPlayer()
    
                                if closestDistance ~= -1 and closestDistance <= 3 then
                                    local closestPed = GetPlayerPed(closestPlayer)
                                    local pPed = PlayerPedId()
                                    local coords = GetEntityCoords(pPed)
                                    local x,y,z = table.unpack(coords)
                                    DrawMarker(2, x, y, z+1.5, 0, 0, 0, 180.0,nil,nil, 0.5, 0.5, 0.5, 0, 0, 255, 120, true, true, p19, true)
        
                                    if IsPedOnFoot(closestPed) then
                                        local ammo = GetAmmoInPedWeapon(plyPed, DHZ.ItemSelected.hash)
                                        TriggerServerEvent('esx:giveInventoryItem', GetPlayerServerId(closestPlayer), 'item_weapon', DHZ.ItemSelected.name, ammo)
                                    else
                                        ESX.ShowNotification("Impossible de donner une arme dans un véhicule")
                                    end
                                else
                                    ESX.ShowNotification("Aucun joueur proche")
                                end
                            end
                        end)  
                    end      
                end,function()
                end)



                RageUI.IsVisible(RMenu:Get('inventory', 'demarches'), true, true, true, function()

                    for _, v in pairs (cfg.demarches) do
                        RageUI.ButtonWithStyle(v.Nom, nil, {RightLabel = "→→→"}, true, function(Hovered, Active, Selected)
                            if Selected then
                                startAttitude(v.Arg1, v.Arg2)
                            end
                        end)
                    end

                end,function()
                end)




                RageUI.IsVisible(RMenu:Get('inventory', 'anim'), true, true, true, function()

                    RageUI.ButtonWithStyle("~r~Annuler l'animations", nil, {RightLabel = "~r~→→→"}, true, function(Hovered, Active, Selected)
                        if Selected then
                            EmoteCancel()
                        end
                    end)
                
                    RageUI.Separator("Liste des ~b~Animations~s~")

                    RageUI.ButtonWithStyle("Dances", nil, { RightLabel = "→→→" },true, function()
                    end, RMenu:Get('inventory', 'dances'))
                    RageUI.ButtonWithStyle("Festives", nil, { RightLabel = "→→→" },true, function()
                    end, RMenu:Get('inventory', 'festives'))
                    RageUI.ButtonWithStyle("Salutations", nil, { RightLabel = "→→→" },true, function()
                    end, RMenu:Get('inventory', 'salutations'))
                    RageUI.ButtonWithStyle("Travail", nil, { RightLabel = "→→→" },true, function()
                    end, RMenu:Get('inventory', 'travail'))
                    RageUI.ButtonWithStyle("Humeurs", nil, { RightLabel = "→→→" },true, function()
                    end, RMenu:Get('inventory', 'humeurs'))
                    RageUI.ButtonWithStyle("Sports", nil, { RightLabel = "→→→" },true, function()
                    end, RMenu:Get('inventory', 'sports'))
                    RageUI.ButtonWithStyle("Divers", nil, { RightLabel = "→→→" },true, function()
                    end, RMenu:Get('inventory', 'animdivers'))
                    RageUI.ButtonWithStyle("Adulte +18", nil, { RightLabel = "→→→" },true, function()
                    end, RMenu:Get('inventory', 'pegi18'))
                end, function()
                end)

                RageUI.IsVisible(RMenu:Get('inventory', 'objectmain'), true, true, true, function()

                    RageUI.ButtonWithStyle("Mode suppression", "Supprimer des objets", { RightLabel = "→→→" }, true, function(Hovered, Active, Selected)
                    end, RMenu:Get('inventory', 'objectlist'))

                    RageUI.Separator("↓ Liste des props ↓")

                    RageUI.ButtonWithStyle("Civil", nil, { RightLabel = "→→→" }, true, function(Hovered, Active, Selected)
                    end, RMenu:Get('inventory', 'object'))
        
                    if cfg.Props.UtiliserGang then
                        if cfg.Props.UtiliserJob2 then
                            if ESX.PlayerData.job2 ~= nil and ESX.PlayerData.job2.name ~= 'unemployed' then
                                RageUI.ButtonWithStyle("Gang", nil, { RightLabel = "→→→" }, true, function(Hovered, Active, Selected)
                                end, RMenu:Get('inventory', 'object3'))
                            end
                        else
                            RageUI.ButtonWithStyle("Gang", nil, { RightLabel = "→→→" }, true, function(Hovered, Active, Selected)
                            end, RMenu:Get('inventory', 'object3'))
                        end
                    end
        
                    if cfg.Props.UtiliserEMS then
                        if ESX.PlayerData.job ~= nil and ESX.PlayerData.job.name == cfg.Props.NomJobEMS then
                            RageUI.ButtonWithStyle("EMS", nil, { RightLabel = "→→→" }, true, function(Hovered, Active, Selected)
                            end, RMenu:Get('inventory', 'object2'))
                        end
                    end
        
                    if cfg.Props.UtiliserMecano then
                        if ESX.PlayerData.job ~= nil and ESX.PlayerData.job.name == cfg.Props.NomJobMecano then
                            RageUI.ButtonWithStyle("Mecano", nil, { RightLabel = "→→→" }, true, function(Hovered, Active, Selected)
                            end, RMenu:Get('inventory', 'object7'))
                        end
                    end
        
                    RageUI.ButtonWithStyle("Armes", nil, { RightLabel = "→→→" }, true, function(Hovered, Active, Selected)
                    end, RMenu:Get('inventory', 'object5'))
        
                    RageUI.ButtonWithStyle("Drogue", nil, { RightLabel = "→→→" }, true, function(Hovered, Active, Selected)
                    end, RMenu:Get('inventory', 'object6'))
        

                end, function()
                end)

                RageUI.IsVisible(RMenu:Get('inventory', 'objectlist'), true, true, true, function()

                    for k,v in pairs(object) do
                        if GoodName(GetEntityModel(NetworkGetEntityFromNetworkId(v))) == 0 then table.remove(object, k) end
                        RageUI.ButtonWithStyle("Object: "..GoodName(GetEntityModel(NetworkGetEntityFromNetworkId(v))).." ["..v.."]", nil, {}, true, function(Hovered, Active, Selected)
                            if Active then
                                local entity = NetworkGetEntityFromNetworkId(v)
                                local ObjCoords = GetEntityCoords(entity)
                                DrawMarker(0, ObjCoords.x, ObjCoords.y, ObjCoords.z+1.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.3, 0.3, 0.3, 0, 255, 0, 170, 1, 0, 2, 1, nil, nil, 0)
                            end
                            if Selected then
                                RemoveObj(v, k)
                            end
                        end)
                    end

                end, function()
                end)

                RageUI.IsVisible(RMenu:Get('inventory', 'object'), true, true, true, function()
                    RageUI.ButtonWithStyle("Chaise", nil, {}, true, function(Hovered, Active, Selected)
                        if Selected then
                            SpawnObj("apa_mp_h_din_chair_12")
                        end
                    end)
                    
                    RageUI.ButtonWithStyle("Carton", nil, {}, true, function(Hovered, Active, Selected)
                        if Selected then
                            SpawnObj("prop_cardbordbox_04a")
                        end
                    end)
        
                    RageUI.ButtonWithStyle("Sac", nil, {}, true, function(Hovered, Active, Selected)
                        if Selected then
                            SpawnObj("prop_cs_heist_bag_02")
                        end
                    end)
        
                    RageUI.ButtonWithStyle("Table 1", nil, {}, true, function(Hovered, Active, Selected)
                        if Selected then
                            SpawnObj("prop_rub_table_02")
                        end
                    end)
        
                    RageUI.ButtonWithStyle("Table 2", nil, {}, true, function(Hovered, Active, Selected)
                        if Selected then
                            SpawnObj("prop_table_04")
                        end
                    end)
        
                    RageUI.ButtonWithStyle("Table 3", nil, {}, true, function(Hovered, Active, Selected)
                        if Selected then
                            SpawnObj("bkr_prop_weed_table_01b")
                        end
                    end)
        
                    RageUI.ButtonWithStyle("Petite Chaise", nil, {}, true, function(Hovered, Active, Selected)
                        if Selected then
                            SpawnObj("bkr_prop_clubhouse_chair_01")
                        end
                    end)
        
                    RageUI.ButtonWithStyle("Ordinateur", nil, {}, true, function(Hovered, Active, Selected)
                        if Selected then
                            SpawnObj("bkr_prop_clubhouse_laptop_01a")
                        end
                    end)
        
                    RageUI.ButtonWithStyle("Chaise Bureau", nil, {}, true, function(Hovered, Active, Selected)
                        if Selected then
                            SpawnObj("bkr_prop_clubhouse_offchair_01a")
                        end
                    end)
        
                    RageUI.ButtonWithStyle("Lit Bunker", nil, {}, true, function(Hovered, Active, Selected)
                        if Selected then
                            SpawnObj("gr_prop_bunker_bed_01")
                        end
                    end)
        
                    RageUI.ButtonWithStyle("Lit Biker", nil, {}, true, function(Hovered, Active, Selected)
                        if Selected then
                            SpawnObj("gr_prop_gr_campbed_01")
                        end
                    end)
        
                    RageUI.ButtonWithStyle("Chaise Peche", nil, {}, true, function(Hovered, Active, Selected)
                        if Selected then
                            SpawnObj("hei_prop_hei_skid_chair")
                        end
                    end)
                end, function()
                end)

                RageUI.IsVisible(RMenu:Get('inventory', 'object3'), true, true, true, function()
                    RageUI.ButtonWithStyle("Chaise", nil, {}, true, function(Hovered, Active, Selected)
                        if Selected then
                            SpawnObj("bkr_prop_weed_chair_01a")
                        end
                    end)
        
                    RageUI.ButtonWithStyle("Sac pour arme", nil, {}, true, function(Hovered, Active, Selected)
                        if Selected then
                            SpawnObj("prop_gun_case_01")
                        end
                    end)
        
                    RageUI.ButtonWithStyle("Cash", nil, {}, true, function(Hovered, Active, Selected)
                        if Selected then
                            SpawnObj("hei_prop_cash_crate_half_full")
                        end
                    end)
        
                    RageUI.ButtonWithStyle("Valise de cash", nil, {}, true, function(Hovered, Active, Selected)
                        if Selected then
                            SpawnObj("prop_cash_case_02")
                        end
                    end)
        
                    RageUI.ButtonWithStyle("Petite pile de cash", nil, {}, true, function(Hovered, Active, Selected)
                        if Selected then
                            SpawnObj("prop_cash_crate_01")
                        end
                    end)
        
                    RageUI.ButtonWithStyle("Poubelle", nil, {}, true, function(Hovered, Active, Selected)
                        if Selected then
                            SpawnObj("prop_cs_dumpster_01a")
                        end
                    end)
        
                    RageUI.ButtonWithStyle("Canapé", nil, {}, true, function(Hovered, Active, Selected)
                        if Selected then
                            SpawnObj("v_tre_sofa_mess_c_s")
                        end
                    end)
        
                    RageUI.ButtonWithStyle("Canapé 2", nil, {}, true, function(Hovered, Active, Selected)
                        if Selected then
                            SpawnObj("v_res_tre_sofa_mess_a")
                        end
                    end)
        
                    RageUI.ButtonWithStyle("Pile de cash", nil, {}, true, function(Hovered, Active, Selected)
                        if Selected then
                            SpawnObj("bkr_prop_bkr_cashpile_04")
                        end
                    end)
        
                    RageUI.ButtonWithStyle("Pile de cash 2", nil, {}, true, function(Hovered, Active, Selected)
                        if Selected then
                            SpawnObj("bkr_prop_bkr_cashpile_05")
                        end
                    end)
                end, function()
                end)

                RageUI.IsVisible(RMenu:Get('inventory', 'object2'), true, true, true, function()
                    RageUI.ButtonWithStyle("Sac mortuaire", nil, {}, true, function(Hovered, Active, Selected)
                        if Selected then
                            SpawnObj("xm_prop_body_bag")
                        end
                    end)
        
                    RageUI.ButtonWithStyle("Trousse médical 1", nil, {}, true, function(Hovered, Active, Selected)
                        if Selected then
                            SpawnObj("xm_prop_smug_crate_s_medical")
                        end
                    end)
        
                    RageUI.ButtonWithStyle("Trousse médical 2", nil, {}, true, function(Hovered, Active, Selected)
                        if Selected then
                            SpawnObj("xm_prop_x17_bag_med_01a")
                        end
                    end)
                end, function()
                end)

                RageUI.IsVisible(RMenu:Get('inventory', 'object7'), true, true, true, function()
                    RageUI.ButtonWithStyle("Outils", nil, {}, true, function(Hovered, Active, Selected)
                        if Selected then
                            SpawnObj("prop_cs_trolley_01")
                        end
                    end)
                    
                    RageUI.ButtonWithStyle("Outils mecano", nil, {}, true, function(Hovered, Active, Selected)
                        if Selected then
                            SpawnObj("prop_carcreeper")
                        end
                    end)
            
                    RageUI.ButtonWithStyle("Sac à outils", nil, {}, true, function(Hovered, Active, Selected)
                        if Selected then
                            SpawnObj("prop_cs_heist_bag_02")
                        end
                    end)
                end, function()
                end)

                RageUI.IsVisible(RMenu:Get('inventory', 'object5'), true, true, true, function()
                    RageUI.ButtonWithStyle("Malette Armes", nil, {}, true, function(Hovered, Active, Selected)
                        if Selected then
                            SpawnObj("bkr_prop_biker_gcase_s")
                        end
                    end)
        
                    RageUI.ButtonWithStyle("Caisse Armes", nil, {}, true, function(Hovered, Active, Selected)
                        if Selected then
                            SpawnObj("ex_prop_crate_ammo_bc")
                        end
                    end)
        
                    RageUI.ButtonWithStyle("Caisse Batteuses 2", nil, {}, true, function(Hovered, Active, Selected)
                        if Selected then
                            SpawnObj("ex_prop_crate_ammo_sc")
                        end
                    end)
        
                    RageUI.ButtonWithStyle("Caisse Fermé", nil, {}, true, function(Hovered, Active, Selected)
                        if Selected then
                            SpawnObj("ex_prop_adv_case_sm_03")
                        end
                    end)
        
                    RageUI.ButtonWithStyle("Petite Caisse", nil, {}, true, function(Hovered, Active, Selected)
                        if Selected then
                            SpawnObj("ex_prop_adv_case_sm_flash")
                        end
                    end)
        
                    RageUI.ButtonWithStyle("Caisse Explosif", nil, {}, true, function(Hovered, Active, Selected)
                        if Selected then
                            SpawnObj("ex_prop_crate_expl_bc")
                        end
                    end)
        
                    RageUI.ButtonWithStyle("Caisse Vetements", nil, {}, true, function(Hovered, Active, Selected)
                        if Selected then
                            SpawnObj("ex_prop_crate_expl_sc")
                        end
                    end)
        
                    RageUI.ButtonWithStyle("Caisse Chargeurs", nil, {}, true, function(Hovered, Active, Selected)
                        if Selected then
                            SpawnObj("gr_prop_gr_crate_mag_01a")
                        end
                    end)
        
                    RageUI.ButtonWithStyle("Grosse Caisse Armes", nil, {}, true, function(Hovered, Active, Selected)
                        if Selected then
                            SpawnObj("gr_prop_gr_crates_rifles_01a")
                        end
                    end)
        
                    RageUI.ButtonWithStyle("Grosse Caisse Armes 2", nil, {}, true, function(Hovered, Active, Selected)
                        if Selected then
                            SpawnObj("gr_prop_gr_crates_weapon_mix_01a")
                        end
                    end)
                end, function()
                end)

                RageUI.IsVisible(RMenu:Get('inventory', 'object6'), true, true, true, function()
                    RageUI.ButtonWithStyle("Cocaine Block", nil, {}, true, function(Hovered, Active, Selected)
                        if Selected then
                            SpawnObj("bkr_prop_coke_block_01a")
                        end
                    end)
        
                    RageUI.ButtonWithStyle("Cocaine Pallet", nil, {}, true, function(Hovered, Active, Selected)
                        if Selected then
                            SpawnObj("bkr_prop_coke_pallet_01a")
                        end
                    end)
        
                    RageUI.ButtonWithStyle("Balance Cocaine", nil, {}, true, function(Hovered, Active, Selected)
                        if Selected then
                            SpawnObj("bkr_prop_coke_scale_01")
                        end
                    end)
        
                    RageUI.ButtonWithStyle("Spatule Cocaine", nil, {}, true, function(Hovered, Active, Selected)
                        if Selected then
                            SpawnObj("bkr_prop_coke_spatula_04")
                        end
                    end)
        
                    RageUI.ButtonWithStyle("Table Cocaine", nil, {}, true, function(Hovered, Active, Selected)
                        if Selected then
                            SpawnObj("bkr_prop_coke_table01a")
                        end
                    end)
        
                    RageUI.ButtonWithStyle("Caisse", nil, {}, true, function(Hovered, Active, Selected)
                        if Selected then
                            SpawnObj("bkr_prop_crate_set_01a")
                        end
                    end)
        
                    RageUI.ButtonWithStyle("Palette Weed", nil, {}, true, function(Hovered, Active, Selected)
                        if Selected then
                            SpawnObj("bkr_prop_fertiliser_pallet_01a")
                        end
                    end)
        
                    RageUI.ButtonWithStyle("Palette 1", nil, {}, true, function(Hovered, Active, Selected)
                        if Selected then
                            SpawnObj("bkr_prop_fertiliser_pallet_01b")
                        end
                    end)
        
                    RageUI.ButtonWithStyle("Palette 2", nil, {}, true, function(Hovered, Active, Selected)
                        if Selected then
                            SpawnObj("bkr_prop_fertiliser_pallet_01c")
                        end
                    end)
        
                    RageUI.ButtonWithStyle("Palette 3", nil, {}, true, function(Hovered, Active, Selected)
                        if Selected then
                            SpawnObj("bkr_prop_fertiliser_pallet_01d")
                        end
                    end)
        
                    RageUI.ButtonWithStyle("Acetone Meth", nil, {}, true, function(Hovered, Active, Selected)
                        if Selected then
                            SpawnObj("bkr_prop_meth_acetone")
                        end
                    end)
        
                    RageUI.ButtonWithStyle("Bidon Meth", nil, {}, true, function(Hovered, Active, Selected)
                        if Selected then
                            SpawnObj("bkr_prop_meth_ammonia")
                        end
                    end)
        
                    RageUI.ButtonWithStyle("Bac Meth", nil, {}, true, function(Hovered, Active, Selected)
                        if Selected then
                            SpawnObj("bkr_prop_meth_bigbag_01a")
                        end
                    end)
        
                    RageUI.ButtonWithStyle("Bac Meth 2", nil, {}, true, function(Hovered, Active, Selected)
                        if Selected then
                            SpawnObj("bkr_prop_meth_bigbag_02a")
                        end
                    end)
        
                    RageUI.ButtonWithStyle("Bac Meth 3", nil, {}, true, function(Hovered, Active, Selected)
                        if Selected then
                            SpawnObj("bkr_prop_meth_bigbag_03a")
                        end
                    end)
        
                    RageUI.ButtonWithStyle("Lithium Meth", nil, {}, true, function(Hovered, Active, Selected)
                        if Selected then
                            SpawnObj("bkr_prop_meth_lithium")
                        end
                    end)
        
                    RageUI.ButtonWithStyle("Phosphorus Meth", nil, {}, true, function(Hovered, Active, Selected)
                        if Selected then
                            SpawnObj("bkr_prop_meth_phosphorus")
                        end
                    end)
        
                    RageUI.ButtonWithStyle("Pseudoephedrine", nil, {}, true, function(Hovered, Active, Selected)
                        if Selected then
                            SpawnObj("bkr_prop_meth_pseudoephedrine")
                        end
                    end)
        
                    RageUI.ButtonWithStyle("Meth Smash", nil, {}, true, function(Hovered, Active, Selected)
                        if Selected then
                            SpawnObj("bkr_prop_meth_smashedtray_01")
                        end
                    end)
        
                    RageUI.ButtonWithStyle("Machine a sous", nil, {}, true, function(Hovered, Active, Selected)
                        if Selected then
                            SpawnObj("bkr_prop_money_counter")
                        end
                    end)
        
                    RageUI.ButtonWithStyle("Acetone Meth", nil, {}, true, function(Hovered, Active, Selected)
                        if Selected then
                            SpawnObj("bkr_prop_meth_acetone")
                        end
                    end)
        
                    RageUI.ButtonWithStyle("Pot Weed", nil, {}, true, function(Hovered, Active, Selected)
                        if Selected then
                            SpawnObj("bkr_prop_weed_01_small_01b")
                        end
                    end)
        
                    RageUI.ButtonWithStyle("Packet Weed", nil, {}, true, function(Hovered, Active, Selected)
                        if Selected then
                            SpawnObj("bkr_prop_weed_bigbag_03a")
                        end
                    end)
        
                    RageUI.ButtonWithStyle("Packet Weed Ouvert", nil, {}, true, function(Hovered, Active, Selected)
                        if Selected then
                            SpawnObj("bkr_prop_weed_bigbag_open_01a")
                        end
                    end)
        
                    RageUI.ButtonWithStyle("Pot Weed 2", nil, {}, true, function(Hovered, Active, Selected)
                        if Selected then
                            SpawnObj("bkr_prop_weed_bucket_01d")
                        end
                    end)
        
                    RageUI.ButtonWithStyle("Weed", nil, {}, true, function(Hovered, Active, Selected)
                        if Selected then
                            SpawnObj("bkr_prop_weed_drying_01a")
                        end
                    end)
        
                    RageUI.ButtonWithStyle("Weed Plante", nil, {}, true, function(Hovered, Active, Selected)
                        if Selected then
                            SpawnObj("bkr_prop_weed_lrg_01b")
                        end
                    end)
        
                    RageUI.ButtonWithStyle("Weed Plante 2", nil, {}, true, function(Hovered, Active, Selected)
                        if Selected then
                            SpawnObj("bkr_prop_weed_med_01b")
                        end
                    end)
        
                    RageUI.ButtonWithStyle("Table Weed", nil, {}, true, function(Hovered, Active, Selected)
                        if Selected then
                            SpawnObj("bkr_prop_weed_drying_01a")
                        end
                    end)
        
                    RageUI.ButtonWithStyle("Weed Pallet", nil, {}, true, function(Hovered, Active, Selected)
                        if Selected then
                            SpawnObj("hei_prop_heist_weed_pallet")
                        end
                    end)
        
                    RageUI.ButtonWithStyle("Coke", nil, {}, true, function(Hovered, Active, Selected)
                        if Selected then
                            SpawnObj("imp_prop_impexp_boxcoke_01")
                        end
                    end)
        
                    RageUI.ButtonWithStyle("Coke en bouteille", nil, {}, true, function(Hovered, Active, Selected)
                        if Selected then
                            SpawnObj("bkr_prop_coke_bottle_01a")
                        end
                    end)
        
                    RageUI.ButtonWithStyle("Coke coupé", nil, {}, true, function(Hovered, Active, Selected)
                        if Selected then
                            SpawnObj("bkr_prop_coke_cut_01")
                        end
                    end)
        
                    RageUI.ButtonWithStyle("Bol de coke", nil, {}, true, function(Hovered, Active, Selected)
                        if Selected then
                            SpawnObj("bkr_prop_coke_fullmetalbowl_02")
                        end
                    end)
        
                    RageUI.ButtonWithStyle("Prop meth", nil, {}, true, function(Hovered, Active, Selected)
                        if Selected then
                            SpawnObj("bkr_prop_meth_pseudoephedrine")
                        end
                    end)
        
                    RageUI.ButtonWithStyle("Sac de meth ouvert", nil, {}, true, function(Hovered, Active, Selected)
                        if Selected then
                            SpawnObj("bkr_prop_meth_openbag_01a")
                        end
                    end)
        
                    RageUI.ButtonWithStyle("Gros sac de meth", nil, {}, true, function(Hovered, Active, Selected)
                        if Selected then
                            SpawnObj("bkr_prop_meth_bigbag_04a")
                        end
                    end)
        
                    RageUI.ButtonWithStyle("Gros sac de weed", nil, {}, true, function(Hovered, Active, Selected)
                        if Selected then
                            SpawnObj("bkr_prop_weed_bigbag_03a")
                        end
                    end)
        
                    RageUI.ButtonWithStyle("Weed plante", nil, {}, true, function(Hovered, Active, Selected)
                        if Selected then
                            SpawnObj("bkr_prop_weed_01_small_01a")
                        end
                    end)
        
                    RageUI.ButtonWithStyle("Weed", nil, {}, true, function(Hovered, Active, Selected)
                        if Selected then
                            SpawnObj("bkr_prop_weed_dry_02b")
                        end
                    end)
        
                    RageUI.ButtonWithStyle("Table de weed", nil, {}, true, function(Hovered, Active, Selected)
                        if Selected then
                            SpawnObj("bkr_prop_weed_table_01a")
                        end
                    end)
        
                    RageUI.ButtonWithStyle("Block de coke", nil, {}, true, function(Hovered, Active, Selected)
                        if Selected then
                            SpawnObj("bkr_prop_coke_block_01a")
                        end
                    end)
                end, function()
                end)
                
                RageUI.IsVisible(RMenu:Get('inventory', 'festives'), true, true, true, function()
                
                    RageUI.ButtonWithStyle("Fumer une cigarette", nil, {}, true, function(Hovered, Active, Selected)
                        if (Selected) then
                            startScenario('WORLD_HUMAN_SMOKING')
                        end
                    end)
                    RageUI.ButtonWithStyle("Jouer de la musique", nil, {}, true, function(Hovered, Active, Selected)
                        if (Selected) then
                            startScenario('WORLD_HUMAN_MUSICIAN')
                        end
                    end)
                    RageUI.ButtonWithStyle("Dj", nil, {}, true, function(Hovered, Active, Selected)
                        if (Selected) then
                            startAnim('anim@mp_player_intcelebrationmale@dj', 'dj')
                        end
                    end)
                    RageUI.ButtonWithStyle("Boire une biere", nil, {}, true, function(Hovered, Active, Selected)
                        if (Selected) then
                            startScenario('WORLD_HUMAN_DRINKING')
                        end
                    end)
                    RageUI.ButtonWithStyle("Bière en zik", nil, {}, true, function(Hovered, Active, Selected)
                        if (Selected) then
                            startScenario('WORLD_HUMAN_PARTYING')
                        end
                    end)
                    RageUI.ButtonWithStyle("Air Guitar", nil, {}, true, function(Hovered, Active, Selected)
                        if (Selected) then
                            startAnim('anim@mp_player_intcelebrationmale@air_guitar', 'air_guitar')
                        end
                    end)
                    RageUI.ButtonWithStyle("Air Shagging", nil, {}, true, function(Hovered, Active, Selected)
                        if (Selected) then
                            startAnim('anim@mp_player_intcelebrationfemale@air_shagging', 'air_shagging')
                        end
                    end)
                    RageUI.ButtonWithStyle("Rock'n'roll", nil, {}, true, function(Hovered, Active, Selected)
                        if (Selected) then
                            startAnim('mp_player_int_upperrock', 'mp_player_int_rock')
                        end
                    end)
                    RageUI.ButtonWithStyle("Fumer un joint", nil, {}, true, function(Hovered, Active, Selected)
                        if (Selected) then
                            startScenario('WORLD_HUMAN_SMOKING_POT')
                        end
                    end)
                    RageUI.ButtonWithStyle("Bourré sur place", nil, {}, true, function(Hovered, Active, Selected)
                        if (Selected) then
                            startAnim('amb@world_human_bum_standing@drunk@idle_a', 'idle_a')
                        end
                    end)
                    RageUI.ButtonWithStyle("Vomir en voiture", nil, {}, true, function(Hovered, Active, Selected)
                        if (Selected) then
                            startAnim('oddjobs@taxi@tie', 'vomit_outside')
                        end
                    end)
                end, function()
                end)         

                RageUI.IsVisible(RMenu:Get('inventory', 'dances'), true, true, true, function()
                
                    RageUI.ButtonWithStyle("Dance F1", nil, {}, true, function(Hovered, Active, Selected)
                        if (Selected) then
                            startAnim('anim@amb@nightclub@dancers@solomun_entourage@', 'mi_dance_facedj_17_v1_female^1')
                        end
                    end)
                    RageUI.ButtonWithStyle("Dance F2", nil, {}, true, function(Hovered, Active, Selected)
                        if (Selected) then
                            startAnim('anim@amb@nightclub@mini@dance@dance_solo@female@var_a@', 'high_center')
                        end
                    end)
                    RageUI.ButtonWithStyle("Dance F3", nil, {}, true, function(Hovered, Active, Selected)
                        if (Selected) then
                            startAnim('anim@amb@nightclub@mini@dance@dance_solo@female@var_a@', 'high_center_up')
                        end
                    end)
                    RageUI.ButtonWithStyle("Dance F4", nil, {}, true, function(Hovered, Active, Selected)
                        if (Selected) then
                            startAnim('anim@amb@nightclub@dancers@crowddance_facedj@hi_intensity', 'hi_dance_facedj_09_v2_female^1')
                        end
                    end)
                    RageUI.ButtonWithStyle("Dance F5", nil, {}, true, function(Hovered, Active, Selected)
                        if (Selected) then
                            startAnim('anim@amb@nightclub@dancers@crowddance_facedj@hi_intensity', 'hi_dance_facedj_09_v2_female^3')
                        end
                    end)
                    RageUI.ButtonWithStyle("Dance F6", nil, {}, true, function(Hovered, Active, Selected)
                        if (Selected) then
                            startAnim('anim@amb@nightclub@mini@dance@dance_solo@female@var_a@', 'high_center_up')
                        end
                    end)
                    RageUI.ButtonWithStyle("Dance Lente 1", nil, {}, true, function(Hovered, Active, Selected)
                        if (Selected) then
                            startAnim('anim@amb@nightclub@mini@dance@dance_solo@female@var_a@', 'low_center')
                        end
                    end)
                    RageUI.ButtonWithStyle("Dance Lente 2", nil, {}, true, function(Hovered, Active, Selected)
                        if (Selected) then
                            startAnim('anim@amb@nightclub@mini@dance@dance_solo@female@var_a@', 'low_center_down')
                        end
                    end)
                    RageUI.ButtonWithStyle("Dance Lente 3", nil, {}, true, function(Hovered, Active, Selected)
                        if (Selected) then
                            startAnim('anim@amb@nightclub@mini@dance@dance_solo@female@var_b@', 'high_center')
                        end
                    end)
                    RageUI.ButtonWithStyle("Dance lente 4", nil, {}, true, function(Hovered, Active, Selected)
                        if (Selected) then
                            startAnim('anim@amb@nightclub@mini@dance@dance_solo@male@var_b@', 'low_center')
                        end
                    end)
                    RageUI.ButtonWithStyle("Dance stimulante", nil, {}, true, function(Hovered, Active, Selected)
                        if (Selected) then
                            startAnim('anim@amb@nightclub@mini@dance@dance_solo@female@var_a@', 'high_center')
                        end
                    end)
                    RageUI.ButtonWithStyle("Dance stimulante 2", nil, {}, true, function(Hovered, Active, Selected)
                        if (Selected) then
                            startAnim('anim@amb@nightclub@mini@dance@dance_solo@female@var_b@', 'high_center_up')
                        end
                    end)
                    RageUI.ButtonWithStyle("Dance timide", nil, {}, true, function(Hovered, Active, Selected)
                        if (Selected) then
                            startAnim('anim@amb@nightclub@mini@dance@dance_solo@male@var_a@', 'low_center')
                        end
                    end)
                    RageUI.ButtonWithStyle("Dance timide 2", nil, {}, true, function(Hovered, Active, Selected)
                        if (Selected) then
                            startAnim('anim@amb@nightclub@mini@dance@dance_solo@female@var_b@', 'low_center_down')
                        end
                    end)
                    RageUI.ButtonWithStyle("Dance 1", nil, {}, true, function(Hovered, Active, Selected)
                        if (Selected) then
                            startAnim('anim@amb@nightclub@dancers@podium_dancers@', 'hi_dance_facedj_17_v2_male^5')
                        end
                    end)
                    RageUI.ButtonWithStyle("Dance 2", nil, {}, true, function(Hovered, Active, Selected)
                        if (Selected) then
                            startAnim('anim@amb@nightclub@mini@dance@dance_solo@male@var_b@', 'high_center_down')
                        end
                    end)
                    RageUI.ButtonWithStyle("Dance 3", nil, {}, true, function(Hovered, Active, Selected)
                        if (Selected) then
                            startAnim('anim@amb@nightclub@mini@dance@dance_solo@male@var_a@', 'high_center')
                        end
                    end)
                    RageUI.ButtonWithStyle("Dance 4", nil, {}, true, function(Hovered, Active, Selected)
                        if (Selected) then
                            startAnim('anim@amb@nightclub@mini@dance@dance_solo@male@var_b@', 'high_center_up')
                        end
                    end)
                    RageUI.ButtonWithStyle("Dance 5", nil, {}, true, function(Hovered, Active, Selected)
                        if (Selected) then
                            startAnim('anim@amb@casino@mini@dance@dance_solo@female@var_a@', 'med_center')
                        end
                    end)
                    RageUI.ButtonWithStyle("Dance 6", nil, {}, true, function(Hovered, Active, Selected)
                        if (Selected) then
                            startAnim('misschinese2_crystalmazemcs1_cs', 'dance_loop_tao')
                        end
                    end)
                    RageUI.ButtonWithStyle("Dance 7", nil, {}, true, function(Hovered, Active, Selected)
                        if (Selected) then
                            startAnim('misschinese2_crystalmazemcs1_ig', 'dance_loop_tao')
                        end
                    end)
                    RageUI.ButtonWithStyle("Dance 8", nil, {}, true, function(Hovered, Active, Selected)
                        if (Selected) then
                            startAnim('missfbi3_sniping', 'dance_m_default')
                        end
                    end)
                    RageUI.ButtonWithStyle("Dance 9", nil, {}, true, function(Hovered, Active, Selected)
                        if (Selected) then
                            startAnim('anim@amb@nightclub@mini@dance@dance_solo@female@var_a@', 'med_center_up')
                        end
                    end)
                    RageUI.ButtonWithStyle("Dance idiote", nil, {}, true, function(Hovered, Active, Selected)
                        if (Selected) then
                            startAnim('special_ped@mountain_dancer@monologue_3@monologue_3a', 'mnt_dnc_buttwag')
                        end
                    end)
                    RageUI.ButtonWithStyle("Dance idiote 2", nil, {}, true, function(Hovered, Active, Selected)
                        if (Selected) then
                            startAnim('move_clown@p_m_zero_idles@', 'fidget_short_dance')
                        end
                    end)
                    RageUI.ButtonWithStyle("Dance idiote 3", nil, {}, true, function(Hovered, Active, Selected)
                        if (Selected) then
                            startAnim('move_clown@p_m_two_idles@', 'fidget_short_dance')
                        end
                    end)
                    RageUI.ButtonWithStyle("Dance idiote 4", nil, {}, true, function(Hovered, Active, Selected)
                        if (Selected) then
                            startAnim('anim@amb@nightclub@lazlow@hi_podium@', 'danceidle_hi_11_buttwiggle_b_laz')
                        end
                    end)
                    RageUI.ButtonWithStyle("Dance idiote 5", nil, {}, true, function(Hovered, Active, Selected)
                        if (Selected) then
                            startAnim('timetable@tracy@ig_5@idle_a', 'idle_a')
                        end
                    end)
                    RageUI.ButtonWithStyle("Dance idiote 6", nil, {}, true, function(Hovered, Active, Selected)
                        if (Selected) then
                            startAnim('timetable@tracy@ig_8@idle_b', 'idle_d')
                        end
                    end)
                    RageUI.ButtonWithStyle("Dance idiote 7", nil, {}, true, function(Hovered, Active, Selected)
                        if (Selected) then
                            startAnim('anim@amb@casino@mini@dance@dance_solo@female@var_b@', 'high_center')
                        end
                    end)
                    RageUI.ButtonWithStyle("Dance idiote 8", nil, {}, true, function(Hovered, Active, Selected)
                        if (Selected) then
                            startAnim('anim@mp_player_intcelebrationfemale@the_woogie', 'the_woogie')
                        end
                    end)
                    RageUI.ButtonWithStyle("Dance idiote 9", nil, {}, true, function(Hovered, Active, Selected)
                        if (Selected) then
                            startAnim('rcmnigel1bnmt_1b', 'dance_loop_tyler')
                        end
                    end)
                end, function()
                end)

                RageUI.IsVisible(RMenu:Get('inventory', 'salutations'), true, true, true, function()
                
                    RageUI.ButtonWithStyle("Saluer", nil, {}, true, function(Hovered, Active, Selected)
                        if (Selected) then
                            startAnim('gestures@m@standing@casual', 'gesture_hello')
                        end
                    end)
                    RageUI.ButtonWithStyle("Serrer la main", nil, {}, true, function(Hovered, Active, Selected)
                        if (Selected) then
                            startAnim('mp_common', 'givetake1_a')
                        end
                    end)
                    RageUI.ButtonWithStyle("Tchek", nil, {}, true, function(Hovered, Active, Selected)
                        if (Selected) then
                            startAnim('mp_ped_interaction', 'handshake_guy_a')
                        end
                    end)
                    RageUI.ButtonWithStyle("Salut bandit", nil, {}, true, function(Hovered, Active, Selected)
                        if (Selected) then
                            startAnim('mp_ped_interaction', 'hugs_guy_a')
                        end
                    end)
                    RageUI.ButtonWithStyle("Salut Militaire", nil, {}, true, function(Hovered, Active, Selected)
                        if (Selected) then
                            startAnim('mp_player_int_uppersalute', 'mp_player_int_salute')
                        end
                    end)
                end, function()
                end)

                RageUI.IsVisible(RMenu:Get('inventory', 'travail'), true, true, true, function()
                
                    RageUI.ButtonWithStyle("Suspect : se rendre à la police", nil, {}, true, function(Hovered, Active, Selected)
                        if (Selected) then
                            startAnim('random@arrests@busted','idle_c')
                        end
                    end)
                    RageUI.ButtonWithStyle("Pêcheur", nil, {}, true, function(Hovered, Active, Selected)
                        if (Selected) then
                            startScenario('world_human_stand_fishing')
                        end
                    end)
                    RageUI.ButtonWithStyle("Police : enquêter", nil, {}, true, function(Hovered, Active, Selected)
                        if (Selected) then
                            startAnim('amb@code_human_police_investigate@idle_b','idle_f')
                        end
                    end)
                    RageUI.ButtonWithStyle("Police : parler à la radio", nil, {}, true, function(Hovered, Active, Selected)
                        if (Selected) then
                            startAnim('random@arrests','generic_radio_chatter')
                        end
                    end)
                    RageUI.ButtonWithStyle("Police : circulation", nil, {}, true, function(Hovered, Active, Selected)
                        if (Selected) then
                            startScenario('WORLD_HUMAN_CAR_PARK_ATTENDANT')
                        end
                    end)
                    RageUI.ButtonWithStyle("Police : jumelles", nil, {}, true, function(Hovered, Active, Selected)
                        if (Selected) then
                            startScenario('WORLD_HUMAN_BINOCULARS')
                        end
                    end)
                    RageUI.ButtonWithStyle("Agriculture : récolter", nil, {}, true, function(Hovered, Active, Selected)
                        if (Selected) then
                            startScenario('world_human_gardener_plant')
                        end
                    end)
                    RageUI.ButtonWithStyle("Dépanneur : réparer le moteur", nil, {}, true, function(Hovered, Active, Selected)
                        if (Selected) then
                            startAnim('mini@repair', 'fixing_a_ped')
                        end
                    end)
                    RageUI.ButtonWithStyle("Médecin : observer", nil, {}, true, function(Hovered, Active, Selected)
                        if (Selected) then
                            startScenario('CODE_HUMAN_MEDIC_KNEEL')
                        end
                    end)
                    RageUI.ButtonWithStyle("Taxi : parler au client", nil, {}, true, function(Hovered, Active, Selected)
                        if (Selected) then
                            startAnim('oddjobs@taxi@driver', 'leanover_idle')
                        end
                    end)
                    RageUI.ButtonWithStyle("Taxi : donner la facture", nil, {}, true, function(Hovered, Active, Selected)
                        if (Selected) then
                            startAnim('oddjobs@taxi@cyi', 'std_hand_off_ps_passenger')
                        end
                    end)
                    RageUI.ButtonWithStyle("Epicier : donner les courses", nil, {}, true, function(Hovered, Active, Selected)
                        if (Selected) then
                            startAnim('mp_am_hold_up', 'purchase_beerbox_shopkeeper')
                        end
                    end)
                    RageUI.ButtonWithStyle("Barman : servir un shot", nil, {}, true, function(Hovered, Active, Selected)
                        if (Selected) then
                            startAnim('mini@drinking', 'shots_barman_b')
                        end
                    end)
                    RageUI.ButtonWithStyle("Journaliste : Prendre une photo", nil, {}, true, function(Hovered, Active, Selected)
                        if (Selected) then
                            startScenario('WORLD_HUMAN_PAPARAZZI')
                        end
                    end)
                    RageUI.ButtonWithStyle("Tout métiers : Prendre des notes", nil, {}, true, function(Hovered, Active, Selected)
                        if (Selected) then
                            startScenario('WORLD_HUMAN_CLIPBOARD')
                        end
                    end)
                    RageUI.ButtonWithStyle("Tout métiers : Coup de marteau", nil, {}, true, function(Hovered, Active, Selected)
                        if (Selected) then
                            startScenario('WORLD_HUMAN_HAMMERING')
                        end
                    end)
                    RageUI.ButtonWithStyle("Clochard : Faire la manche", nil, {}, true, function(Hovered, Active, Selected)
                        if (Selected) then
                            startScenario('WORLD_HUMAN_BUM_FREEWAY')
                        end
                    end)
                    RageUI.ButtonWithStyle("Clochard : Faire la statue", nil, {}, true, function(Hovered, Active, Selected)
                        if (Selected) then
                            startScenario('WORLD_HUMAN_HUMAN_STATUE')
                        end
                    end)
                end, function()
                end)

                RageUI.IsVisible(RMenu:Get('inventory', 'humeurs'), true, true, true, function()
                    RageUI.ButtonWithStyle("Féliciter", nil, {}, true, function(Hovered, Active, Selected)
                        if (Selected) then
                            startScenario('WORLD_HUMAN_CHEERING')
                        end
                    end)
                    RageUI.ButtonWithStyle("Super", nil, {}, true, function(Hovered, Active, Selected)
                        if (Selected) then
                            startAnim('mp_action', 'thanks_male_06')
                        end
                    end)
                    RageUI.ButtonWithStyle("Toi", nil, {}, true, function(Hovered, Active, Selected)
                        if (Selected) then
                            startAnim('gestures@m@standing@casual', 'gesture_point')
                        end
                    end)
                    RageUI.ButtonWithStyle("Viens", nil, {}, true, function(Hovered, Active, Selected)
                        if (Selected) then
                            startAnim('gestures@m@standing@casual', 'gesture_come_here_soft')
                        end
                    end)
                    RageUI.ButtonWithStyle("Keskya ?", nil, {}, true, function(Hovered, Active, Selected)
                        if (Selected) then
                            startAnim('gestures@m@standing@casual', 'gesture_bring_it_on')
                        end
                    end)
                    RageUI.ButtonWithStyle("A moi", nil, {}, true, function(Hovered, Active, Selected)
                        if (Selected) then
                            startAnim('gestures@m@standing@casual', 'gesture_me')
                        end
                    end)
                    RageUI.ButtonWithStyle("Je le savais", nil, {}, true, function(Hovered, Active, Selected)
                        if (Selected) then
                            startAnim('anim@am_hold_up@male', 'shoplift_high')
                        end
                    end)
                    RageUI.ButtonWithStyle("Etre épuisé", nil, {}, true, function(Hovered, Active, Selected)
                        if (Selected) then
                            startAnim('amb@world_human_jog_standing@male@idle_b', 'idle_d')
                        end
                    end)
                    RageUI.ButtonWithStyle("Je suis dans la merde", nil, {}, true, function(Hovered, Active, Selected)
                        if (Selected) then
                            startAnim('amb@world_human_bum_standing@depressed@idle_a', 'idle_a')
                        end
                    end)
                    RageUI.ButtonWithStyle("Facepalm", nil, {}, true, function(Hovered, Active, Selected)
                        if (Selected) then
                            startAnim('anim@mp_player_intcelebrationmale@face_palm', 'face_palm')
                        end
                    end)
                    RageUI.ButtonWithStyle("Calme-toi", nil, {}, true, function(Hovered, Active, Selected)
                        if (Selected) then
                            startAnim('gestures@m@standing@casual', 'gesture_easy_now')
                        end
                    end)
                    RageUI.ButtonWithStyle("Qu'est ce que j'ai fait", nil, {}, true, function(Hovered, Active, Selected)
                        if (Selected) then
                            startAnim('oddjobs@assassinate@multi@', 'react_big_variations_a')
                        end
                    end)
                    RageUI.ButtonWithStyle("Avoir peur", nil, {}, true, function(Hovered, Active, Selected)
                        if (Selected) then
                            startAnim('amb@code_human_cower_stand@male@react_cowering', 'base_right')
                        end
                    end)
                    RageUI.ButtonWithStyle("Fight ?", nil, {}, true, function(Hovered, Active, Selected)
                        if (Selected) then
                            startAnim('anim@deathmatch_intros@unarmed', 'intro_male_unarmed_e')
                        end
                    end)
                    RageUI.ButtonWithStyle("C'est pas Possible", nil, {}, true, function(Hovered, Active, Selected)
                        if (Selected) then
                            startAnim('gestures@m@standing@casual', 'gesture_damn')
                        end
                    end)
                    RageUI.ButtonWithStyle("Enlacer", nil, {}, true, function(Hovered, Active, Selected)
                        if (Selected) then
                            startAnim('mp_ped_interaction', 'kisses_guy_a')
                        end
                    end)
                    RageUI.ButtonWithStyle("Doigt d'honneur", nil, {}, true, function(Hovered, Active, Selected)
                        if (Selected) then
                            startAnim('mp_player_int_upperfinger', 'mp_player_int_finger_01_enter')
                        end
                    end)
                    RageUI.ButtonWithStyle("Branleur", nil, {}, true, function(Hovered, Active, Selected)
                        if (Selected) then
                            startAnim('mp_player_int_upperwank', 'mp_player_int_wank_01')
                        end
                    end)
                    RageUI.ButtonWithStyle("Balle dans la tete", nil, {}, true, function(Hovered, Active, Selected)
                        if (Selected) then
                            startAnim('mp_suicide', 'pistol')
                        end
                    end)
                end, function()
                end)
                
                RageUI.IsVisible(RMenu:Get('inventory', 'sports'), true, true, true, function()
                    RageUI.ButtonWithStyle("Montrer ses muscles", nil, {}, true, function(Hovered, Active, Selected)
                        if (Selected) then
                            startAnim('amb@world_human_muscle_flex@arms_at_side@base', 'base')
                        end
                    end)
                    RageUI.ButtonWithStyle("Barre de musculation", nil, {}, true, function(Hovered, Active, Selected)
                        if (Selected) then
                            startAnim('amb@world_human_muscle_free_weights@male@barbell@base', 'base')
                        end
                    end)
                    RageUI.ButtonWithStyle("Faire des pompes", nil, {}, true, function(Hovered, Active, Selected)
                        if (Selected) then
                            startAnim('amb@world_human_push_ups@male@base', 'base')
                        end
                    end)
                    RageUI.ButtonWithStyle("Faire des abdos", nil, {}, true, function(Hovered, Active, Selected)
                        if (Selected) then
                            startAnim('amb@world_human_sit_ups@male@base', 'base')
                        end
                    end)
                    RageUI.ButtonWithStyle("Faire du yoga", nil, {}, true, function(Hovered, Active, Selected)
                        if (Selected) then
                            startAnim('amb@world_human_yoga@male@base', 'base_a')
                        end
                    end)
                end, function()
                end)

                RageUI.IsVisible(RMenu:Get('inventory', 'animdivers'), true, true, true, function()
                    RageUI.ButtonWithStyle("Boire un café", nil, {}, true, function(Hovered, Active, Selected)
                        if (Selected) then
                            startAnim('amb@world_human_aa_coffee@idle_a', 'idle_a')
                        end
                    end)
                    RageUI.ButtonWithStyle("S'asseoir", nil, {}, true, function(Hovered, Active, Selected)
                        if (Selected) then
                            startAnim('anim@heists@prison_heistunfinished_biztarget_idle', 'target_idle')
                        end
                    end)
                    RageUI.ButtonWithStyle("Attendre contre un mur", nil, {}, true, function(Hovered, Active, Selected)
                        if (Selected) then
                            startScenario('world_human_leaning')
                        end
                    end)
                    RageUI.ButtonWithStyle("Couché sur le dos", nil, {}, true, function(Hovered, Active, Selected)
                        if (Selected) then
                            startScenario('WORLD_HUMAN_SUNBATHE_BACK')
                        end
                    end)
                    RageUI.ButtonWithStyle("Couché sur le ventre", nil, {}, true, function(Hovered, Active, Selected)
                        if (Selected) then
                            startScenario('WORLD_HUMAN_SUNBATHE')
                        end
                    end)
                    RageUI.ButtonWithStyle("Nettoyer quelque chose", nil, {}, true, function(Hovered, Active, Selected)
                        if (Selected) then
                            startScenario('world_human_maid_clean')
                        end
                    end)
                    RageUI.ButtonWithStyle("Préparer à manger", nil, {}, true, function(Hovered, Active, Selected)
                        if (Selected) then
                            startScenario('PROP_HUMAN_BBQ')
                        end
                    end)
                    RageUI.ButtonWithStyle("Position de Fouille", nil, {}, true, function(Hovered, Active, Selected)
                        if (Selected) then
                            startAnim('mini@prostitutes@sexlow_veh', 'low_car_bj_to_prop_female')
                        end
                    end)
                    RageUI.ButtonWithStyle("Prendre un selfie", nil, {}, true, function(Hovered, Active, Selected)
                        if (Selected) then
                            startScenario('world_human_tourist_mobile')
                        end
                    end)
                    RageUI.ButtonWithStyle("Ecouter à une porte", nil, {}, true, function(Hovered, Active, Selected)
                        if (Selected) then
                            startAnim('mini@safe_cracking', 'idle_base')
                        end
                    end)                       
                end, function()
                end)

                RageUI.IsVisible(RMenu:Get('inventory', 'pegi18'), true, true, true, function()
                    RageUI.ButtonWithStyle("Homme se faire su*** en voiture", nil, {}, true, function(Hovered, Active, Selected)
                        if (Selected) then
                            startAnim('oddjobs@towing', 'm_blow_job_loop')
                        end
                    end)
                    RageUI.ButtonWithStyle("Femme faire une gaterie en voiture", nil, {}, true, function(Hovered, Active, Selected)
                        if (Selected) then
                            startAnim('oddjobs@towing', 'f_blow_job_loop')
                        end
                    end)
                    RageUI.ButtonWithStyle("Homme bais** en voiture", nil, {}, true, function(Hovered, Active, Selected)
                        if (Selected) then
                            startAnim('mini@prostitutes@sexlow_veh', 'low_car_sex_loop_player')
                        end
                    end)
                    RageUI.ButtonWithStyle("Femme bais** en voiture", nil, {}, true, function(Hovered, Active, Selected)
                        if (Selected) then
                            startAnim('mini@prostitutes@sexlow_veh', 'low_car_sex_loop_female')
                        end
                    end)
                    RageUI.ButtonWithStyle("Se gratter les couilles", nil, {}, true, function(Hovered, Active, Selected)
                        if (Selected) then
                            startAnim('mp_player_int_uppergrab_crotch', 'mp_player_int_grab_crotch')
                        end
                    end)
                    RageUI.ButtonWithStyle("Faire du charme", nil, {}, true, function(Hovered, Active, Selected)
                        if (Selected) then
                            startAnim('mini@strip_club@idles@stripper', 'stripper_idle_02')
                        end
                    end)
                    RageUI.ButtonWithStyle("Pose michto", nil, {}, true, function(Hovered, Active, Selected)
                        if (Selected) then
                            startScenario('WORLD_HUMAN_PROSTITUTE_HIGH_CLASS')
                        end
                    end)
                    RageUI.ButtonWithStyle("Montrer sa poitrine", nil, {}, true, function(Hovered, Active, Selected)
                        if (Selected) then
                            startAnim('mini@strip_club@backroom@', 'stripper_b_backroom_idle_b')
                        end
                    end)
                    RageUI.ButtonWithStyle("Strip Tease 1", nil, {}, true, function(Hovered, Active, Selected)
                        if (Selected) then
                            startAnim('mini@strip_club@lap_dance@ld_girl_a_song_a_p1', 'ld_girl_a_song_a_p1_f')
                        end
                    end)
                    RageUI.ButtonWithStyle("Strip Tease 2", nil, {}, true, function(Hovered, Active, Selected)
                        if (Selected) then
                            startAnim('mini@strip_club@private_dance@part2', 'priv_dance_p2')
                        end
                    end)
                    RageUI.ButtonWithStyle("Stip Tease au sol", nil, {}, true, function(Hovered, Active, Selected)
                        if (Selected) then
                            startAnim('mini@strip_club@private_dance@part3', 'priv_dance_p3')
                        end
                    end)  
                end, function()
                end)

                RageUI.IsVisible(RMenu:Get('inventory', 'inventaire_use'), true, true, true, function()
                    
                    RageUI.ButtonWithStyle("Utiliser ~g~l'item", nil, {RightBadge = RageUI.BadgeStyle.Heart}, true, function(Hovered, Active, Selected)
                        if (Selected) then
                            if DHZ.ItemSelected.usable then
                                TriggerServerEvent('esx:useItem', DHZ.ItemSelected.name)
                            else
                                ESX.ShowNotification("Ceci n'est pas utilisable")
                            end
                        end
                    end) 

                    RageUI.ButtonWithStyle("Jeter ~r~l'item", nil, {RightBadge = RageUI.BadgeStyle.Alert}, true, function(Hovered, Active, Selected)
                        if (Selected) then
                            if DHZ.ItemSelected.canRemove then
                                local post,quantity = CheckQuantity(KeyboardInput("Nombres d'items que vous voulez jeter", '', '', 100))
                                if post then
                                    if not IsPedSittingInAnyVehicle(PlayerPed) then
                                        TriggerServerEvent('esx:removeInventoryItem', 'item_standard', DHZ.ItemSelected.name, quantity)
                                    end
                                end
                            end
                        end
                    end)

                    RageUI.ButtonWithStyle("Donner ~g~l'items", nil, {RightBadge = RageUI.BadgeStyle.Tick}, true, function(Hovered, Active, Selected)
                        if (Selected) then
                            local sonner,quantity = CheckQuantity(KeyboardInput("Nombres d'items que vous voulez donner", '', '', 100))
                            local closestPlayer, closestDistance = ESX.Game.GetClosestPlayer()
                            local pPed = PlayerPedId()
                            local coords = GetEntityCoords(pPed)
                            local x,y,z = table.unpack(coords)
                            DrawMarker(2, x, y, z+1.5, 0, 0, 0, 180.0,nil,nil, 0.5, 0.5, 0.5, 0, 0, 255, 120, true, true, p19, true)
        
                            if sonner then
                                if closestDistance ~= -1 and closestDistance <= 3 then
                                    local closestPed = GetPlayerPed(closestPlayer)
                                    if IsPedOnFoot(closestPed) then
                                        TriggerServerEvent('esx:giveInventoryItem', GetPlayerServerId(closestPlayer), 'item_standard', DHZ.ItemSelected.name, quantity)
                                    else
                                        ESX.ShowNotification("Nombre d'items invalide")
                                    end
                                else
                                    ESX.ShowNotification("Aucun joueur proche")
                                end
                            end
                        end
                    end)
                        
                end,function()
                end)

                RageUI.IsVisible(RMenu:Get('inventory', 'portefeuille_billing'), true, true, true, function()        
                    ESX.TriggerServerCallback('dhz_personalmenu:Bill_getBills', function(bills)
                        DHZ.BillData = bills	
                    end) 
                    
                    for i = 1, #DHZ.BillData, 1 do
                        RageUI.ButtonWithStyle(DHZ.BillData[i].label, nil, {RightLabel = '[~y~$' .. ESX.Math.GroupDigits(DHZ.BillData[i].amount.."~s~] →")}, true, function(Hovered, Active, Selected)
                            if (Selected) then
                                ESX.TriggerServerCallback('esx_billing:payBill', function()
                                    ESX.TriggerServerCallback('dhz_personalmenu:Bill_getBills', function(bills) DHZ.BillData = bills end)
                                end, DHZ.BillData[i].id)
                            end
                        end)
                    end
                end,function()
                end)


                RageUI.IsVisible(RMenu:Get('inventory', 'portefeuille'), true, true, true, function()

                    RageUI.ButtonWithStyle("Emplois", nil, {RightLabel = "~b~"..ESX.PlayerData.job.label .."~s~ →"}, true, function(Hovered, Active, Selected)
                        if Selected then
                        end
                    end, RMenu:Get('inventory', 'portefeuille_work'))

                    if cfg.DoubleJob then
                        RageUI.ButtonWithStyle("Emplois secondaire", nil, {RightLabel = "~b~"..ESX.PlayerData.job2.label .."~s~ →"}, true, function(Hovered, Active, Selected)
                            if Selected then
                            end
                        end, RMenu:Get('inventory', 'portefeuille_work2'))
                    end

                    RageUI.ButtonWithStyle('Liquide', nil, {RightLabel = "~g~$"..ESX.Math.GroupDigits(ESX.PlayerData.money.."~s~ →")}, true, function(Hovered, Active, Selected) 
                        if (Selected) then 
                            end 
                        end, RMenu:Get('inventory', 'portefeuille_money'))

                    RageUI.ButtonWithStyle('Facture', nil, {RightLabel = "→"}, true, function(Hovered, Active, Selected) 
                        if (Selected) then 
                            end 
                        end, RMenu:Get('inventory', 'portefeuille_billing'))
            
                    for i = 1, #ESX.PlayerData.accounts, 1 do
                        if ESX.PlayerData.accounts[i].name == 'bank'  then
                            DHZ.bank = RageUI.ButtonWithStyle('Banque', nil, {RightLabel = "~b~$"..ESX.Math.GroupDigits(ESX.PlayerData.accounts[i].money.."~s~")}, true, function(Hovered, Active, Selected) 
                                if (Selected) then 
                                end 
                            end)
                        end
                    end

                    for i = 1, #ESX.PlayerData.accounts, 1 do
                        if ESX.PlayerData.accounts[i].name == 'black_money'  then
                            DHZ.sale = RageUI.ButtonWithStyle('Non déclaré', nil, {RightLabel = "~r~$"..ESX.Math.GroupDigits(ESX.PlayerData.accounts[i].money.."~s~ →")}, true, function(Hovered, Active, Selected) 
                                if (Selected) then 
                                end 
                            end, RMenu:Get('inventory', 'portefeuille_use'))
                        end
                    end

                    RageUI.ButtonWithStyle(('~b~Montrer ~s~sa carte d\'identité'), nil, {}, true, function(Hovered, Active, Selected)
                        if (Selected) then
                            local closestPlayer, closestDistance = ESX.Game.GetClosestPlayer()
        
                            if closestDistance ~= -1 and closestDistance <= 3.0 then
                                TriggerServerEvent('jsfour-idcard:open', GetPlayerServerId(PlayerId()), GetPlayerServerId(closestPlayer))
                            else
                                ESX.ShowNotification("Aucun joueur proche")
                            end
                        end
                    end)

                    RageUI.ButtonWithStyle(('~g~Regarder ~s~sa carte d\'identité'), nil, {}, true, function(Hovered, Active, Selected)
                        if (Selected) then
                            TriggerServerEvent('jsfour-idcard:open', GetPlayerServerId(PlayerId()), GetPlayerServerId(PlayerId()))
                        end
                    end)

                    RageUI.ButtonWithStyle(('~b~Montrer ~s~son permis de conduire'), nil, {}, true, function(Hovered, Active, Selected)
                        if (Selected) then
                            local closestPlayer, closestDistance = ESX.Game.GetClosestPlayer()
        
                            if closestDistance ~= -1 and closestDistance <= 3.0 then
                                TriggerServerEvent('jsfour-idcard:open', GetPlayerServerId(PlayerId()), GetPlayerServerId(closestPlayer), 'driver')
                            else
                                ESX.ShowNotification("Aucun joueur proche")
                            end
                        end
                    end)
        
                    RageUI.ButtonWithStyle(('~g~Regarder ~s~son permis de conduire'), nil, {}, true, function(Hovered, Active, Selected)
                        if (Selected) then
                            TriggerServerEvent('jsfour-idcard:open', GetPlayerServerId(PlayerId()), GetPlayerServerId(PlayerId()), 'driver')
                        end
                    end)
        
                    RageUI.ButtonWithStyle(('~b~Montrer ~s~son PPA'), nil, {}, true, function(Hovered, Active, Selected)
                        if (Selected) then
                            local closestPlayer, closestDistance = ESX.Game.GetClosestPlayer()
        
                            if closestDistance ~= -1 and closestDistance <= 3.0 then
                                TriggerServerEvent('jsfour-idcard:open', GetPlayerServerId(PlayerId()), GetPlayerServerId(closestPlayer), 'weapon')
                            else
                                ESX.ShowNotification("Aucun joueur proche")
                            end
                        end
                    end)

                    RageUI.ButtonWithStyle(('~g~Regarder ~s~son PPA'), nil, {}, true, function(Hovered, Active, Selected)
                        if (Selected) then
                            local closestPlayer, closestDistance = ESX.Game.GetClosestPlayer()
                            if closestDistance ~= -1 and closestDistance <= 3.0 then
                                TriggerServerEvent('jsfour-idcard:open', GetPlayerServerId(PlayerId()), GetPlayerServerId(PlayerId()), 'weapon')
                            end
                        end
                    end)
                end)
                
                RageUI.IsVisible(RMenu:Get('inventory', 'personnage'), true, true, true, function()

                    RageUI.ButtonWithStyle('Mes vêtements', nil, {RightLabel = "→"}, true, function(Hovered, Active, Selected) 
                        if (Selected) then 
                        end 
                    end, RMenu:Get('inventory', 'clothes1'))

                    RageUI.ButtonWithStyle('Mes accessoires', nil, {RightLabel = "→"}, true, function(Hovered, Active, Selected) 
                        if (Selected) then 
                        end 
                    end, RMenu:Get('inventory', 'accessoires1'))
                end)

                RageUI.IsVisible(RMenu:Get('inventory', 'clothes1'), true, true, true, function()
                    RageUI.ButtonWithStyle(('T-Shirt'), nil, {}, true, function(Hovered, Active, Selected)
                        if (Selected) then
                            setUniform('torso', plyPed)
                        end
                    end)

                    RageUI.ButtonWithStyle(('Pantalon'), nil, {}, true, function(Hovered, Active, Selected)
                        if (Selected) then
                            setUniform('pants', plyPed)
                        end
                    end)

                    RageUI.ButtonWithStyle(('Chaussures'), nil, {}, true, function(Hovered, Active, Selected)
                        if (Selected) then
                            setUniform('shoes', plyPed)
                        end
                    end)

                    RageUI.ButtonWithStyle(('Sac'), nil, {}, true, function(Hovered, Active, Selected)
                        if (Selected) then
                            setUniform('bag', plyPed)
                        end
                    end)

                    RageUI.ButtonWithStyle(('Kevlar'), nil, {}, true, function(Hovered, Active, Selected)
                        if (Selected) then
                            setUniform('bproof', plyPed)
                        end
                    end)
                end)

                RageUI.IsVisible(RMenu:Get('inventory', 'accessoires1'), true, true, true, function()
                    RageUI.ButtonWithStyle(('Oreilles'), nil, {}, true, function(Hovered, Active, Selected)
                        if (Selected) then
                            setAccessory('Ears', plyPed)
                        end
                    end)

                    RageUI.ButtonWithStyle(('Lunettes'), nil, {}, true, function(Hovered, Active, Selected)
                        if (Selected) then
                            setAccessory('Glasses', plyPed)
                        end
                    end)

                    RageUI.ButtonWithStyle(('Chapeau'), nil, {}, true, function(Hovered, Active, Selected)
                        if (Selected) then
                            setAccessory('Helmet', plyPed)
                        end
                    end)

                    RageUI.ButtonWithStyle(('Masque'), nil, {}, true, function(Hovered, Active, Selected)
                        if (Selected) then
                            setAccessory('Mask', plyPed)
                        end
                    end)
                end)

                RageUI.IsVisible(RMenu:Get('inventory', 'portefeuille_use'), true, true, true, function() 
                    for i = 1, #ESX.PlayerData.accounts, 1 do
                        if ESX.PlayerData.accounts[i].name == 'black_money' then
                            RageUI.ButtonWithStyle("~r~Donner~s~ de l'argent non-déclaré", nil, {RightBadge = RageUI.BadgeStyle.Lock}, true, function(Hovered,Active,Selected)
                                if Selected then
                                    local black, quantity = CheckQuantity(KeyboardInput("Somme d'argent que vous voulez donner", '', '', 1000))
                                    if black then
                                        local closestPlayer, closestDistance = ESX.Game.GetClosestPlayer()
                                        if closestDistance ~= -1 and closestDistance <= 3 then
                                            local closestPed = GetPlayerPed(closestPlayer)
                                            if not IsPedSittingInAnyVehicle(closestPed) then
                                                TriggerServerEvent('esx:giveInventoryItem', GetPlayerServerId(closestPlayer), 'item_account', ESX.PlayerData.accounts[i].name, quantity)
                                            else
                                                ESX.ShowNotification("Vous ne pouvez pas donner de l'argent dans un véhicule")
                                            end
                                        else
                                            ESX.ShowNotification("Aucun joueur proche")
                                        end
                                    else
                                        ESX.ShowNotification("Somme invalide")
                                    end
                                end
                            end)
                        end
                    end
                    RageUI.ButtonWithStyle("~r~Jeter~s~ de l'argent non declaré", nil, {RightBadge = RageUI.BadgeStyle.Tick}, true, function(Hovered, Active, Selected)
                        if Selected then
                            local black, quantity = CheckQuantity(KeyboardInput("Somme d'argent que vous voulez jeter", '', '', 1000))
                            if black then
                                if not IsPedSittingInAnyVehicle(PlayerPed) then
                                    TriggerServerEvent('esx:removeInventoryItem', 'item_account', ESX.PlayerData.accounts[i].name, quantity)
                                else
                                    ESX.ShowNotification("Vous ne pouvez pas jetter de l'argent dans un véhicule")
                                end
                            else
                                ESX.ShowNotification("Somme invalide")
                            end
                        end
                    end)
                end)

                RageUI.IsVisible(RMenu:Get('inventory', 'portefeuille_work'), true, true, true, function()
                    RageUI.ButtonWithStyle("Grade", nil, {RightLabel = "~b~"..ESX.PlayerData.job.grade_label .."~s~"}, true, function(Hovered, Active, Selected)
                        if Selected then
                        end
                    end)


                    if ESX.PlayerData.job ~= nil and ESX.PlayerData.job.grade_name == 'boss' then
                        if societymoney ~= nil then
                            RageUI.Separator("[~b~"..ESX.PlayerData.job.label.."~s~] - [~g~"..societymoney.."$~s~]")
                        end
                    end 
                end, function()
                end)

                if cfg.DoubleJob then
                    RageUI.IsVisible(RMenu:Get('inventory', 'portefeuille_work2'), true, true, true, function()
                        RageUI.ButtonWithStyle("Grade", nil, {RightLabel = "~b~"..ESX.PlayerData.job2.grade_label .."~s~"}, true, function(Hovered, Active, Selected)
                            if Selected then
                            end
                        end)

                        if ESX.PlayerData.job2 ~= nil and ESX.PlayerData.job2.grade_name == 'boss' then
                            if societymoney2 ~= nil then
                                RageUI.Separator("[~r~"..ESX.PlayerData.job2.label.."~s~] - [~g~"..societymoney2.."$~s~]")
                            end
                        end 
                    end, function()
                    end)
                end

                RageUI.IsVisible(RMenu:Get('inventory', 'portefeuille_money'), true, true, true, function()

                    RageUI.ButtonWithStyle("~b~Donner~s~ de l'argent liquide", nil, {RightBadge = RageUI.BadgeStyle.Tick}, true, function(Hovered,Active,Selected)
                        if Selected then
                            local black, quantity = CheckQuantity(KeyboardInput("Somme d'argent que vous voulez donner", '', '', 1000))
                            if black then
                                local closestPlayer, closestDistance = ESX.Game.GetClosestPlayer()
                                if closestDistance ~= -1 and closestDistance <= 3 then
                                    local closestPed = GetPlayerPed(closestPlayer)
                                    if not IsPedSittingInAnyVehicle(closestPed) then
                                        TriggerServerEvent('esx:giveInventoryItem', GetPlayerServerId(closestPlayer), 'item_money', ESX.PlayerData.money, quantity)
                                    else
                                        ESX.ShowNotification("Vous ne pouvez pas donner de l'argent dans un véhicule")
                                    end
                                else
                                    ESX.ShowNotification("Aucun joueur proche")
                                end
                            else
                                ESX.ShowNotification("Somme invalide")
                            end
                        end
                    end)

                    RageUI.ButtonWithStyle("~b~Jeter~s~ de l'argent liquide", nil, {RightBadge = RageUI.BadgeStyle.Tick}, true, function(Hovered, Active, Selected)
                        if Selected then
                            local black, quantity = CheckQuantity(KeyboardInput("Somme d'argent que vous voulez jeter", '', '', 1000))
                            if black then
                                if not IsPedSittingInAnyVehicle(PlayerPed) then
                                    TriggerServerEvent('esx:removeInventoryItem', 'item_money', ESX.PlayerData.money, quantity)
                                else
                                    ESX.ShowNotification("Vous ne pouvez pas jetter de l'argent dans un véhicule")
                                end
                            else
                                ESX.ShowNotification("Somme invalide")
                            end
                        end
                    end)
                end)

                RageUI.IsVisible(RMenu:Get('inventory', 'divers'), true, true, true, function()

                    RageUI.Checkbox("Afficher / Désactiver la map", nil, DHZ.map,{},function(Hovered,Ative,Selected,Checked)
                        if Selected then
                            DHZ.map = Checked
                            if Checked then
                                DisplayRadar(true)
                            else
                                DisplayRadar(false)
                            end
                        end
                    end)

                    RageUI.Checkbox("Afficher / Désactiver l'HUD", nil, DHZ.hud,{},function(Hovered,Ative,Selected,Checked)
                        if Selected then
                            DHZ.hud = Checked
                            if Checked then
                                if cfg.HUD.UtiliserTrigger then
                                    TriggerClientEvent(cfg.HUD.Trigger)
                                else
                                    ExecuteCommand(cfg.HUD.Commande)
                                end
                            else
                                if cfg.HUD.UtiliserTrigger then
                                    TriggerClientEvent(cfg.HUD.Trigger)
                                else
                                    ExecuteCommand(cfg.HUD.Commande)
                                end
                            end
                        end
                    end)

                    local ragdolling = false
                    RageUI.ButtonWithStyle('Dormir / Se Reveiller', nil, {RightLabel = "→"}, true, function(Hovered, Active, Selected) 
                        if (Selected) then
                            ragdolling = not ragdolling
                            while ragdolling do
                                Wait(0)
                                local myPed = PlayerPedId()
                                SetPedToRagdoll(myPed, 1000, 1000, 0, 0, 0, 0)
                                ResetPedRagdollTimer(myPed)
                                AddTextEntry(GetCurrentResourceName(), ('Appuyez sur ~INPUT_JUMP~ pour vous ~b~Réveillé'))
                                DisplayHelpTextThisFrame(GetCurrentResourceName(), false)
                                ResetPedRagdollTimer(myPed)
                                if IsControlJustPressed(0, 22) then 
                                    break
                                end
                            end
                        end
                    end)

                    RageUI.ButtonWithStyle("Menu visuel", nil, {RightLabel = "→"}, true, function(Hovered, Active,Selected)
                        if Selected then
                        end
                    end, RMenu:Get('inventory', 'visual'))

                    if cfg.UtiliserTouches then
                        RageUI.ButtonWithStyle("Menu touches", nil, {RightLabel = "→"}, true, function(Hovered, Active,Selected)
                            if Selected then
                            end
                        end, RMenu:Get('inventory', 'touches'))
                    end

                    RageUI.Separator("~b~Notre discord : discord.gg/ZKJcrDddYx")
                end)

                if cfg.UtiliserTouches then
                    RageUI.IsVisible(RMenu:Get('inventory', 'touches'), true, true, true, function()
                        for _, v in pairs (cfg.Touches) do
                            RageUI.ButtonWithStyle(v.Nom, nil, {RightLabel = "~g~"..v.Touche}, true, function(Hovered, Active, Selected) 
                                if (Selected) then
                                end
                            end)
                        end
                    end,function()
                    end)
                end
                    

                RageUI.IsVisible(RMenu:Get('inventory', 'visual'), true, true, true, function()

                    RageUI.Checkbox("Vue & lumières améliorées", nil, DHZ.Visual, {}, function(Hovered, Selected, Active, Checked) 
                        if Selected then 
                            DHZ.Visual = Checked
                            if Checked then
                                SetTimecycleModifier('tunnel')
                            else
                                SetTimecycleModifier('')
                            end
                        end 
                    end)

                    RageUI.Checkbox("Vue & lumières améliorées ~r~2", nil, DHZ.Visual4, {}, function(Hovered, Selected, Active, Checked) 
                        if Selected then 
                            DHZ.Visual4 = Checked
                            if Checked then
                                SetTimecycleModifier('CS3_rail_tunnel')
                            else
                                SetTimecycleModifier('')
                            end
                        end 
                    end)

                    
                    RageUI.Checkbox("Vue & lumières améliorées ~g~3", nil, DHZ.Visual9, {}, function(Hovered, Selected, Active, Checked) 
                        if Selected then 
                            DHZ.Visual9 = Checked
                            if Checked then
                                SetTimecycleModifier('MP_lowgarage')
                            else
                                SetTimecycleModifier('')
                            end
                        end 
                    end)

                    RageUI.Checkbox("Vue lumineux", nil, DHZ.Visual7, {}, function(Hovered, Selected, Active, Checked) 
                        if Selected then 
                            DHZ.Visual7 = Checked
                            if Checked then
                                SetTimecycleModifier('rply_vignette_neg')
                            else
                                SetTimecycleModifier('')
                            end
                        end 
                    end)

                    RageUI.Checkbox("Vue lumineux ~b~2", nil, DHZ.Visual10, {}, function(Hovered, Selected, Active, Checked) 
                        if Selected then 
                            DHZ.Visual10 = Checked
                            if Checked then
                                SetTimecycleModifier('rply_saturation_neg')
                            else
                                SetTimecycleModifier('')
                            end
                        end 
                    end)
        
                    RageUI.Checkbox("Couleurs amplifiées", nil, DHZ.Visual2, {}, function(Hovered, Selected, Active, Checked) 
                        if Selected then 
                            DHZ.Visual2 = Checked
                            if Checked then
                                SetTimecycleModifier('rply_saturation')
                            else
                                SetTimecycleModifier('')
                            end
                        end 
                    end)
        
                    RageUI.Checkbox("Noir & blancs", nil, DHZ.Visual3, {}, function(Hovered, Selected, Active, Checked) 
                        if Selected then 
                            DHZ.Visual3 = Checked
                            if Checked then
                                SetTimecycleModifier('rply_saturation_neg')
                            else
                                SetTimecycleModifier('')
                            end
                        end 
                    end)

                    RageUI.Checkbox("Visual 1", nil, DHZ.Visual5, {}, function(Hovered, Selected, Active, Checked) 
                        if Selected then 
                            DHZ.Visual5 = Checked
                            if Checked then
                                SetTimecycleModifier('yell_tunnel_nodirect')
                            else
                                SetTimecycleModifier('')
                            end
                        end 
                    end)

                    RageUI.Checkbox("Blanc", nil, DHZ.Visual6, {}, function(Hovered, Selected, Active, Checked) 
                        if Selected then 
                            DHZ.Visual6 = Checked
                            if Checked then
                                SetTimecycleModifier('rply_contrast_neg')
                            else
                                SetTimecycleModifier('')
                            end
                        end 
                    end)

                    RageUI.Checkbox("Dégats", nil, DHZ.Visual8, {}, function(Hovered, Selected, Active, Checked) 
                        if Selected then 
                            DHZ.Visual8 = Checked
                            if Checked then
                                SetTimecycleModifier('rply_vignette')
                            else
                                SetTimecycleModifier('')
                            end
                        end 
                    end)
                end,function()
                end)
            end
        end)
    end
end

RegisterCommand('menuf5perso', function()
    if DHZ.Menu == false then
        if not DHZ.isDead then
            ESX.TriggerServerCallback('DHZ:VerifStaff', function(group)
                playergroup = group
            end)
            FonctionMenuF5Ouvert()
        end
    end  
end, false)
RegisterKeyMapping('menuf5perso', 'Ouvrir le menu F5', 'keyboard', 'f5')

mp_pointing = false
keyPressed = false
animation_pointing = false
function startPointing()
    local ped = PlayerPedId()
    RequestAnimDict("anim@mp_point")
    while not HasAnimDictLoaded("anim@mp_point") do
        Wait(0)
    end
    SetPedCurrentWeaponVisible(ped, 0, 1, 1, 1)
    SetPedConfigFlag(ped, 36, 1)
    Citizen.InvokeNative(0x2D537BA194896636, ped, "task_mp_pointing", 0.5, 0, "anim@mp_point", 24)
    RemoveAnimDict("anim@mp_point")
end

function start_pointing()
    animation_pointing = true
    Citizen.CreateThread(function()
        while animation_pointing do
            Wait(0)
            if Citizen.InvokeNative(0x921CE12C489C4C41, PlayerPedId()) and not mp_pointing then
                stopPointing()
            end
            if Citizen.InvokeNative(0x921CE12C489C4C41, PlayerPedId()) then
                if not IsPedOnFoot(PlayerPedId()) then
                    stopPointing()
                else
                    local ped = PlayerPedId()
                    local camPitch = GetGameplayCamRelativePitch()
                    if camPitch < -70.0 then
                        camPitch = -70.0
                    elseif camPitch > 42.0 then
                        camPitch = 42.0
                    end
                    camPitch = (camPitch + 70.0) / 112.0
    
                    local camHeading = GetGameplayCamRelativeHeading()
                    local cosCamHeading = Cos(camHeading)
                    local sinCamHeading = Sin(camHeading)
                    if camHeading < -180.0 then
                        camHeading = -180.0
                    elseif camHeading > 180.0 then
                        camHeading = 180.0
                    end
                    camHeading = (camHeading + 180.0) / 360.0
    
                    local blocked = 0
                    local nn = 0
    
                    local coords = GetOffsetFromEntityInWorldCoords(ped, (cosCamHeading * -0.2) - (sinCamHeading * (0.4 * camHeading + 0.3)), (sinCamHeading * -0.2) + (cosCamHeading * (0.4 * camHeading + 0.3)), 0.6)
                    local ray = Cast_3dRayPointToPoint(coords.x, coords.y, coords.z - 0.2, coords.x, coords.y, coords.z + 0.2, 0.4, 95, ped, 7);
                    nn,blocked,coords,coords = GetRaycastResult(ray)
    
                    Citizen.InvokeNative(0xD5BB4025AE449A4E, ped, "Pitch", camPitch)
                    Citizen.InvokeNative(0xD5BB4025AE449A4E, ped, "Heading", camHeading * -1.0 + 1.0)
                    Citizen.InvokeNative(0xB0A6CFD2C69C1088, ped, "isBlocked", blocked)
                    Citizen.InvokeNative(0xB0A6CFD2C69C1088, ped, "isFirstPerson", Citizen.InvokeNative(0xEE778F8C7E1142E2, Citizen.InvokeNative(0x19CAFA3C87F7C2FF)) == 4)
    
                end
            end
        end
    end)
end
function stopPointing()
    local ped = PlayerPedId()
    Citizen.InvokeNative(0xD01015C7316AE176, ped, "Stop")
    if not IsPedInjured(ped) then
        ClearPedSecondaryTask(ped)
    end
    if not IsPedInAnyVehicle(ped, 1) then
        SetPedCurrentWeaponVisible(ped, 1, 1, 1, 1)
    end
    SetPedConfigFlag(ped, 36, 0)
    ClearPedSecondaryTask(PlayerPedId())
end
once = true
oldval = false
oldvalped = false

RegisterCommand('pointerdoigt', function()
    if not playerIsOnKeyBoard then
        if not IsPedInAnyVehicle(PlayerPedId(), true) then
            if not IsHandcuffed then
                if not keyPressed then
                    keyPressed = true
                    startPointing()
                    mp_pointing = true
                    start_pointing()
                else
                    stopPointing()
                    keyPressed = false
                    mp_pointing = false
                    animation_pointing = false
                end
            else
                ESX.ShowNotification("Vous ne pouvez pas faire cette animation en étant menotté")
            end
        else
            ESX.ShowNotification("Vous devez être en dehors du véhicule")
        end
    end
end, false)
RegisterKeyMapping('pointerdoigt', 'Pointer du doigt', 'keyboard', 'b')


isCanceling = false
RegisterCommand('arreteranim', function()
    if not playerIsOnKeyBoard then
        if not isCanceling then
            if not IsPedInAnyVehicle(PlayerPedId(), true) then
                if not IsHandcuffed then
                    if not playerIsInTIGAnim then
                        isCanceling = true
                        ClearPedTasks(PlayerPedId())
                        --DestroyAllProps()
                        if PtfxPrompt then
                            PtfxStop()
                            FreezeEntityPosition(PlayerPedId(), false)
                        end
                        Wait(5000)
                        isCanceling = false
                    end
                end
            end
        end
    end
end, false)
RegisterKeyMapping('arreteranim', 'Arreter l\'animatiom', 'keyboard', 'x')



