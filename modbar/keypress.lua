

	local bongos = IsAddOnLoaded'Bongos_ActionBar'

	local update = function(time)
		local nutime = GetTime()
		if modSkinned(this) then
			local i = nutime - time
			modSkinColor(this, .025/i, .075/i, .05/i)
		end
		if nutime > (time + .4) then
			modSkinColor(this, .2, .2, .2)
			this:SetScript('OnUpdate', nil)
		end
	end

	function ActionButtonDown(i)
		local time = GetTime()
		if not bongos then
			if BonusActionBarFrame:IsShown() then
				local bu = _G['BonusActionButton'..i]
				if  bu:GetButtonState() == 'NORMAL' then
					bu:SetButtonState'PUSHED'
					UseAction(ActionButton_GetPagedID(bu), 0)
					bu:SetScript('OnUpdate', function() update(time) end)
				end
				return
			end
			local bu = _G['ActionButton'..i]
			if  bu:GetButtonState() == 'NORMAL' then
				bu:SetButtonState'PUSHED'
				UseAction(ActionButton_GetPagedID(bu), 0)
				bu:SetScript('OnUpdate', function() update(time) end)
			end
		else
			local bu = _G['BActionButton'..i]
			local id = BActionButton.GetPagedID(i)
			if bu and bu:GetButtonState() == 'NORMAL' then bu:SetButtonState'PUSHED' end
			UseAction(id, 0)
			id:SetScript('OnUpdate', function() update(time) end)
		end
	end

	function ActionButtonUp(i, onSelf)
		if not bongos then
			if BonusActionBarFrame:IsShown() then
				local bu = _G['BonusActionButton'..i]
				if  bu:GetButtonState() == 'PUSHED' then
					bu:SetButtonState'NORMAL'
					if MacroFrame_SaveMacro then MacroFrame_SaveMacro() end
					if IsCurrentAction(ActionButton_GetPagedID(bu)) then bu:SetChecked(1)
					else bu:SetChecked(0) end
				end
				return
			end

			local bu = _G['ActionButton'..i]
			if bu and bu:GetButtonState() == 'PUSHED' then
				bu:SetButtonState'NORMAL'
				if MacroFrame_SaveMacro then MacroFrame_SaveMacro() end
				if IsCurrentAction(ActionButton_GetPagedID(bu)) then bu:SetChecked(1)
				else bu:SetChecked(0)
				end
			end
		else
			local bu = _G['BActionButton'..i]
			if bu and bu:GetButtonState() == 'PUSHED' then
				bu:SetButtonState'NORMAL'
				if MacroFrame_SaveMacro then MacroFrame_SaveMacro() end
				bu:SetChecked(IsCurrentAction(BActionButton.GetPagedID(i)))
			end
		end
	end

	function MultiActionButtonDown(bar, i)
		local time = GetTime()
		local bu = _G[bar..'Button'..i]
		if  bu:GetButtonState() == 'NORMAL' then
			bu:SetButtonState'PUSHED'
			UseAction(ActionButton_GetPagedID(bu), 0)
			bu:SetScript('OnUpdate', function() update(time) end)
		end
	end

	function MultiActionButtonUp(bar, i, onSelf)
		local bu = _G[bar..'Button'..i]
		if  bu:GetButtonState() == 'PUSHED' then
			bu:SetButtonState'NORMAL'
			if MacroFrame_SaveMacro then MacroFrame_SaveMacro() end
			if IsCurrentAction(ActionButton_GetPagedID(bu)) then bu:SetChecked(1)
			else bu:SetChecked(0)
			end
		end
	end

	--
