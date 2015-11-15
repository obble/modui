

    function SecondsToTimeAbbrev(time)  -- AURA DURATION SUB
        local h, m, s, text
        if time <= 0 then
            text = ''
        elseif time < 3600 and time > 60 then
            h = floor(time/3600)
            m = floor(mod(time, 3600)/60 + 1)
            text = format('%dm', m)
        elseif time < 60 then
            m = floor(time/60)
            s = mod(time, 60)
            text = m == 0 and format('%ds', s)
        else
            h = floor(time/3600 + 1)
            text = format('%dh', h)
        end
        return text
     end

    --
