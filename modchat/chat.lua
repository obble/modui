

    local _G = getfenv(0)
    local type, gsub, time, floor,  _ = type, _G.string.gsub, time, math.floor, _
    local tostring = tostring
    local _AddMessage = ChatFrame1.AddMessage
    local buttons = {"UpButton", "DownButton", "BottomButton"}
    local dummy = function() end
    local ts = "|cffffffff%s|||r %s"

    ChatFontNormal:SetFont(STANDARD_TEXT_FONT, 14)
    ChatFontNormal:SetShadowOffset(1, -1)
    ChatFontNormal:SetShadowColor(0, 0, 0, 1)

    SLASH_RELOADUI1 = '/rl'
    SlashCmdList.RELOADUI = ReloadUI

        -- more font sizes
    CHAT_FONT_HEIGHTS = {
        [1] = 8, [2] = 9, [3] = 10, [4] = 11, [5] = 12, [6] = 13,
        [7] = 14, [8] = 15, [9] = 16, [10] = 17, [11] = 18, [12] = 19, [13] = 20, }

     local TL, TC, TR = 'TOPLEFT', 'TOP', 'TOPRIGHT'
     local ML, MC, MR = 'LEFT', 'CENTER', 'RIGHT'
     local BL, BC, BR = 'BOTTOMLEFT', 'BOTTOM', 'BOTTOMRIGHT'

     local hooks = {}
     local replaces = {
     	['Guild'] = 'G',
     	['Party'] = 'P',
     	['Raid'] = 'R',
     	['Raid Leader'] = 'RL',
     	['Raid Warning'] = 'RW',
     	['Officer'] = 'O',
     	['Battleground'] = 'B',
     	['Battleground Leader'] = 'BL',
     	['(%d )%. .-'] = '%1',
     }

     local function showFrameForever (f)
     	f:SetScript('OnShow', nil)
     	f:Show()
     end

     local function hideFrameForever (f)
     	f:SetScript('OnShow', function() f:Hide() end)
     	f:Hide()
     end

     --[[local function AddMessage(frame, text, red, green, blue, id)
     	text = tostring(text) or ''

     	-- channels
     	for k,v in pairs(replaces) do
     		text = text:gsub('|h%['..k..'%]|h', '|h'..v..'|h')
     	end

     	-- players
     	text = text:gsub('(|Hplayer.-|h)%[(.-)%]|h', '%1%2|h')

    	-- normal messages
    	text = text:gsub(' says:', ':')

    	-- whispers
    	text = text:gsub(' whispers:', ' <')
    	text = text:gsub('To (|Hplayer.+|h):', '%1 >')

    	-- achievements
    	text = text:gsub('(|Hplayer.+|h) has earned the achievement (.+)!', '%1 ! %2')

     	-- timestamp
     	text = '|cff999999' .. date('%H%M') .. '|r ' .. text

     	return hooks[frame](frame, text, red, green, blue, id)
    end ]]

     local function scrollChat(frame, delta)
     	if arg2 > 0 then
     		if IsShiftKeyDown() then
     			frame:ScrollToTop()
     		else
     			frame:ScrollUp()
     		end
     	elseif arg2 < 0 then
     		if IsShiftKeyDown() then
     			frame:ScrollToBottom()
     		else
     			frame:ScrollDown()
     		end
     	end
     end

     local modScroll = function()
         if not arg1 then print'nope' return end
         local f = this:GetParent()
         if arg1 > 0 then
             if IsShiftKeyDown() then f:ScrollToTop()
             else f:ScrollUp() end
         elseif arg1 < 0 then
             if IsShiftKeyDown() then f:ScrollToBottom()
      		else f:ScrollDown() end
         end
     end


      for i = 1, 7 do
      	local chat = _G['ChatFrame'..i]

      	-- buttons
      	hideFrameForever(_G['ChatFrame'..i..'UpButton'])
      	hideFrameForever(_G['ChatFrame'..i..'DownButton'])
      	hideFrameForever(_G['ChatFrame'..i..'BottomButton'])

        local f = CreateFrame('Frame', nil, chat)
        f:EnableMouse(false)
        f:SetPoint('TOPLEFT', chat)
        f:SetPoint('BOTTOMRIGHT', chat)
        f:EnableMouseWheel(true)
        f:SetScript('OnMouseWheel', modScroll)

         _G['ChatFrame'..i..'UpButton']:GetNormalTexture():SetVertexColor(.5, .5, .5)
         _G['ChatFrame'..i..'DownButton']:GetNormalTexture():SetVertexColor(.5, .5, .5)
         _G['ChatFrame'..i..'BottomButton']:GetNormalTexture():SetVertexColor(.5, .5, .5)

      	-- text subs
      	hooks[chat] = chat.AddMessage
      	chat.AddMessage = AddMessage
      end

     -- buttons
    ChatFrameMenuButton:GetNormalTexture():SetVertexColor(.5, .5, .5)
    ChatFrameMenuButton:ClearAllPoints() ChatFrameMenuButton:SetPoint('BOTTOMRIGHT', ChatFrame1, 'BOTTOMLEFT', -3, -10)

     -- editbox background
     local x = ({ChatFrameEditBox:GetRegions()})
     x[6]:SetAlpha(0)
     x[7]:SetAlpha(0)
     x[8]:SetAlpha(0)

     -- editbox position
     ChatFrameEditBox:ClearAllPoints()
     ChatFrameEditBox:SetPoint(BL, _G.ChatFrame1, TL, -5, 0)
     ChatFrameEditBox:SetPoint(BR, _G.ChatFrame1, TR,  5, 0)

     -- editbox noalt
     ChatFrameEditBox:SetAltArrowKeyMode(nil)

     -- sticky channels
     ChatTypeInfo.SAY.sticky = 1
     ChatTypeInfo.EMOTE.sticky = 1
     ChatTypeInfo.YELL.sticky = 1
     ChatTypeInfo.PARTY.sticky = 1
     ChatTypeInfo.GUILD.sticky = 1
     ChatTypeInfo.OFFICER.sticky = 1
     ChatTypeInfo.RAID.sticky = 1
     ChatTypeInfo.RAID_WARNING.sticky = 1
     ChatTypeInfo.BATTLEGROUND.sticky = 1
     ChatTypeInfo.WHISPER.sticky = 1
     ChatTypeInfo.CHANNEL.sticky = 1

     --
