
    local _, class = UnitClass'Player'
    local colour   = RAID_CLASS_COLORS[class]
    local orig     = {}
    local q

    local link = function(i, w, qi)
        local click = CreateFrame('Button', 'modq'..i, QuestWatchFrame)
        click:SetAllPoints(w)
        local r, g, b = w:GetTextColor()
        click:SetScript('OnEnter', function() w:SetTextColor(colour.r, colour.g, colour.b) end)
        click:SetScript('OnLeave', function() w:SetTextColor(r, g, b) end)
        click:SetScript('OnClick', function()
            ShowUIPanel(QuestLogFrame)
            QuestLog_SetSelection(qi)
            QuestLog_Update()
        end)
    end

    orig.QuestWatch_Update = QuestWatch_Update
    function QuestWatch_Update()
        orig.QuestWatch_Update()
        q = {}
        local wi = 1
        if tonumber(GetCVar'modQuestWatch') == 1 then
            for i = 1, GetNumQuestWatches() do
                local qi  = GetQuestIndexForWatch(i)
                if  qi then
                    local t     = GetQuestLogTitle(qi)
                    local num   = GetNumQuestLeaderBoards(qi)
                    if  num > 0 then
                        local title = _G['QuestWatchLine'..wi]
                        if  q[t] then
                            print(t)
                            wi = wi + 1
                            --  title is already in our objective tracker and is being duplicated!!
                            title:Hide()
                            for j = 1, num do
                                local line = _G['QuestWatchLine'..wi]
                                line:Hide()
                                wi = wi + 1
                            end
                        else
                            if  title and title:GetText() == t then  -- double-check
                                link(i, title, qi)
                                tinsert(q, t)
                            end
                        end
                    end
                end
            end
        end
    end

    --
