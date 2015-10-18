
    local _, class = UnitClass'Player'
    local colour   = RAID_CLASS_COLORS[class]
    local orig     = {}

    local link = function(j, w, qi)
        local click = CreateFrame('Button', 'modQClick', QuestWatchFrame)
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
        for i = 1, GetNumQuestWatches() do
            local qi = GetQuestIndexForWatch(i)
            if qi then
                for j = 1, MAX_QUESTWATCH_LINES do
                    local w = _G['QuestWatchLine'..j]
                    if w:GetText() == GetQuestLogTitle(qi) then link(j, w, qi) end
                end
            end
        end
    end

    --
