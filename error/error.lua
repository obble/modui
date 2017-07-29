

    UIErrorsFrame:SetTimeVisible(.2)
    UIErrorsFrame:SetFadeDuration(.3)

    local SYSMSG = function(e, msg)
        if  e == 'UI_INFO_MESSAGE' then
            ChatFrame1:AddMessage(msg, 1, 1, 0, 1)
        else
            this:AddMessage(
                msg,
                e == 'SYSMSG' and arg1 or  1,
                e == 'SYSMSG' and arg2 or .1,
                e == 'SYSMSG' and arg3 or .1,
                1
            )
        end
    end

    UIErrorsFrame_OnEvent = SYSMSG


    --
