


    local barstosmooth = {    -- SMOOTH ANIM ON PLAYER, TARGET, XP, REP, SKILL STATUSBARS
                              -- ALSO NAMEPLATES
        PlayerFrameHealthBar, PlayerFrameManaBar,
        TargetFrameHealthBar, TargetFrameManaBar,
        MainMenuExpBar, ReputationWatchStatusBar,
        PartyMemberFrame1HealthBar, PartyMemberFrame1ManaBar,
        PartyMemberFrame2HealthBar, PartyMemberFrame2ManaBar,
        PartyMemberFrame3HealthBar, PartyMemberFrame3ManaBar,
        PartyMemberFrame4HealthBar, PartyMemberFrame4ManaBar,
        ReputationBar1, ReputationBar2, ReputationBar3, ReputationBar4, ReputationBar5,
        ReputationBar6, ReputationBar7, ReputationBar8, ReputationBar9, ReputationBar10,
        ReputationBar11, ReputationBar12, ReputationBar13, ReputationBar14, ReputationBar15,
        SkillRankFrame1, SkillRankFrame2, SkillRankFrame3, SkillRankFrame4,
        SkillRankFrame5, SkillRankFrame6, SkillRankFrame7, SkillRankFrame8,
        SkillRankFrame9, SkillRankFrame10, SkillRankFrame11, SkillRankFrame12,
    }

    local raidbarstosmooth = {
        RaidPullout1Button1HealthBar, RaidPullout1Button2HealthBar, RaidPullout1Button3HealthBar, RaidPullout1Button4HealthBar, RaidPullout1Button5HealthBar,
        RaidPullout2Button1HealthBar, RaidPullout2Button2HealthBar, RaidPullout2Button3HealthBar, RaidPullout2Button4HealthBar, RaidPullout5Button5HealthBar,
        RaidPullout3Button1HealthBar, RaidPullout3Button2HealthBar, RaidPullout3Button3HealthBar, RaidPullout3Button4HealthBar, RaidPullout3Button5HealthBar,
        RaidPullout4Button1HealthBar, RaidPullout4Button2HealthBar, RaidPullout4Button3HealthBar, RaidPullout4Button4HealthBar, RaidPullout4Button5HealthBar,
        RaidPullout5Button1HealthBar, RaidPullout5Button2HealthBar, RaidPullout5Button3HealthBar, RaidPullout5Button4HealthBar, RaidPullout5Button5HealthBar,
        RaidPullout1Button1ManaBar, RaidPullout1Button2ManaBar, RaidPullout1Button3ManaBar, RaidPullout1Button4ManaBar, RaidPullout1Button5ManaBar,
        RaidPullout2Button1ManaBar, RaidPullout2Button2ManaBar, RaidPullout2Button3ManaBar, RaidPullout2Button4ManaBar, RaidPullout5Button5ManaBar,
        RaidPullout3Button1ManaBar, RaidPullout3Button2ManaBar, RaidPullout3Button3ManaBar, RaidPullout3Button4ManaBar, RaidPullout3Button5ManaBar,
        RaidPullout4Button1ManaBar, RaidPullout4Button2ManaBar, RaidPullout4Button3ManaBar, RaidPullout4Button4ManaBar, RaidPullout4Button5ManaBar,
        RaidPullout5Button1ManaBar, RaidPullout5Button2ManaBar, RaidPullout5Button3ManaBar, RaidPullout5Button4ManaBar, RaidPullout5Button5ManaBar,
    }

	local smoothframe = CreateFrame'Frame'
	smoothing = {}

    local isPlate = function(frame)
        local overlayRegion = frame:GetRegions()
        if not overlayRegion or overlayRegion:GetObjectType() ~= 'Texture'
        or overlayRegion:GetTexture() ~= [[Interface\Tooltips\Nameplate-Border]] then
            return false
        end
        return true
    end

	local min, max = math.min, math.max
	local function AnimationTick()
		local limit = 30/GetFramerate()
		for bar, value in pairs(smoothing) do
			local cur = bar:GetValue()
			local new = cur + min((value - cur)/3, max(value - cur, limit))
			if new ~= new then new = value end
			if cur == value or abs(new - value) < 2 then
				bar:SetValue_(value)
				smoothing[bar] = nil
			else
				bar:SetValue_(new)
			end
		end
	end

	local function SmoothSetValue(self, value)
		local _, max = self:GetMinMaxValues()
		if value == self:GetValue() or self._max and self._max ~= max then
			smoothing[self] = nil
			self:SetValue_(value)
		else
			smoothing[self] = value
		end
		self._max = max
	end

	for bar, value in pairs(smoothing) do
		if bar.SetValue_ then bar.SetValue = SmoothSetValue end
	end

	local function SmoothBar(bar)
		if not bar.SetValue_ then
			bar.SetValue_ = bar.SetValue bar.SetValue = SmoothSetValue
		end
	end

	local function ResetBar(bar)
		if bar.SetValue_ then
			bar.SetValue = bar.SetValue_ bar.SetValue_ = nil
		end
	end

    smoothframe:SetScript('OnUpdate', function()
        local frames = {WorldFrame:GetChildren()}
        for _, plate in ipairs(frames) do
            if isPlate(plate) and plate:IsVisible() then
                local v = plate:GetChildren()
                SmoothBar(v)
            end
        end
        AnimationTick()
    end)

	for _, v in pairs (barstosmooth) do if v then SmoothBar(v) end end
    smoothframe:RegisterEvent'ADDON_LOADED'
    smoothframe:SetScript('OnEvent', function()
        if arg1 == 'Blizzard_RaidUI' then
            for _, v in pairs (raidbarstosmooth) do if v then SmoothBar(v) end end
        end
    end)

    --
