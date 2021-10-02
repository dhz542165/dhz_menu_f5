crouched, handsup = false, false


Citizen.CreateThread(function()
	while true do
		Citizen.Wait(0)
		DisableControlAction(1, cfg.Controls.Crouch.clavier, true)

		if IsDisabledControlJustReleased(1, cfg.Controls.Crouch.clavier) and GetLastInputMethod(2) then
			local plyPed = PlayerPedId()
			if (DoesEntityExist(plyPed)) and (not IsEntityDead(plyPed)) and (IsPedOnFoot(plyPed)) then
				crouched = not crouched
				if crouched then 
					RequestAnimSet('move_ped_crouched')
		
					while not HasAnimSetLoaded('move_ped_crouched') do
						Citizen.Wait(10)
					end
		
					SetPedMovementClipset(plyPed, 'move_ped_crouched', 0.25)
				else
					ResetPedMovementClipset(plyPed, 0)
				end
			end
		end

		if IsControlJustReleased(1, cfg.Controls.HandsUP.clavier) and GetLastInputMethod(2) then
			local plyPed = PlayerPedId()
			if (DoesEntityExist(plyPed)) and not (IsEntityDead(plyPed)) and (IsPedOnFoot(plyPed)) then
				if pointing then
					pointing = false
				end

				handsup = not handsup
				if handsup then
					RequestAnimDict('random@mugging3')

					while not HasAnimDictLoaded('random@mugging3') do
						Citizen.Wait(10)
					end

					TaskPlayAnim(plyPed, 'random@mugging3', 'handsup_standing_base', 8.0, -8, -1, 49, 0, 0, 0, 0)
				else
					ClearPedSecondaryTask(plyPed)
				end
			end
		end
	end
end)