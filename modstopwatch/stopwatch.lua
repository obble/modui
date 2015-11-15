

	local x, y = 0
	local visible = false
	local t0
	local saved_time = 0
	local orig = {}
	local pad = function(n) return strlen(n) == 2 and n or '0'..n end

	local sw = CreateFrame('Frame', 'modstopwatch', UIParent)
	sw:EnableMouse(true) sw:SetMovable(true)
	sw:SetWidth(132) sw:SetHeight(24)
	sw:RegisterForDrag'LeftButton'
	sw:SetPoint('TOP', x, y)
	sw:SetBackdrop({bgFile = [[Interface\Tooltips\UI-Tooltip-Background]],
							 insets = {left = -1, right = -1, top = -1, bottom = -1}})
	sw:SetBackdropColor(0, 0, 0, .8)
	sw:Hide()
	
	modSkin(sw, 18)
	modSkinPadding(sw, 5)
	modSkinColor(sw, .15, .15, .15)

	local t = sw:CreateFontString(nil, 'OVERLAY')
	t:SetFontObject'GameFontNormalLarge'
	t:SetPoint('LEFT', 5, 0)

	local reset = CreateFrame('Button', 'modstopwatch_reset', sw, 'UIPanelButtonTemplate')
	reset:SetWidth(40) reset:SetHeight(20)
	reset:SetPoint('RIGHT', -2, 0)
	reset:SetText'Reset'

	local play = CreateFrame('Button', 'modstopwatch_playpause', sw, 'UIPanelButtonTemplate')
	play:SetWidth(40) play:SetHeight(20)
	play:SetPoint('RIGHT', reset, 'LEFT')
	play:SetText'Start'

	local sw_OnUpdate = function()
		local time = GetTime()
		if time - 0 > 1 then
			local s = (t0 and floor(time - t0) or 0) + saved_time
			local h = floor(s/3600)
			s = s - h*3600
			local m = floor(s/60)
			s = s - m*60
			t:SetText(string.format('%d:%d:%d', pad(h), pad(m), pad(s)))
			sw:SetWidth(t:GetStringWidth() + play:GetWidth() + reset:GetWidth() + 10)
		end
	end

	local sw_show = function()
		if visible then
			sw:Hide()
			visible = false
			t0 = nil
		else
			sw:Show()
			t:SetText'0:0:0'
			visible = true
		end
	end

	local sw_start = function()
		if play.playing then return end
		play.playing = true
		play:SetText'Stop'
		t0 = GetTime()
		sw:SetScript('OnUpdate', sw_OnUpdate)
	end

	local sw_stop = function()
		if not play.playing then return end
		play.playing = false
		play:SetText'Start'
		saved_time = floor(saved_time + GetTime() - t0)
		t0 = nil
		sw:SetScript('OnUpdate', nil)
	end

	local sw_reset = function()
		t:SetText'0:0:0'
		sw:SetWidth(132)
		sw:SetScript('OnUpdate', nil)
		sw_stop()
		saved_time = 0
		t0 = nil
	end

	local sw_toggle = function()
		if this.playing then
			sw_stop()
			PlaySound'igMainMenuOptionCheckBoxOff'
		else
			sw_start()
			PlaySound'igMainMenuOptionCheckBoxOn'
		end
	end

	sw:SetScript('OnDragStart', function() sw:StartMoving() end)
	sw:SetScript('OnDragStop',  function() sw:StopMovingOrSizing() end)

	play:SetScript('OnClick', sw_toggle)
	reset:SetScript('OnClick', sw_reset)

	GameTimeFrame:SetScript('OnMouseDown', sw_show)
	function GameTimeFrame_UpdateTooltip(h, m)
		if TwentyFourHourTime then
			GameTooltip:SetText(format(TEXT(TIME_TWENTYFOURHOURS), h, m))
		else
			local pm = 0
			if h >= 12 then pm = 1 end
			if h >  12 then h = h - 12 end
			if h ==  0 then h = 12 end
			if pm == 0 then
				GameTooltip:SetText(format(TEXT(TIME_TWELVEHOURAM), h, m))
			else
				GameTooltip:SetText(format(TEXT(TIME_TWELVEHOURPM), h, m))
			end
		end
		GameTooltip:AddLine'Click to Toggle Stopwatch.'
		GameTooltip:Show()
	end

	SLASH_STOPWATCH1 = '/stopwatch'
	SlashCmdList['STOPWATCH'] = function(arg)
		if arg == '' then sw_show() end
	end

	--
