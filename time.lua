Time = {}

Time.ticks_per_day = 25000

function Time:Day()
    return  math.floor((game.tick + (Time.ticks_per_day / 2)) / Time.ticks_per_day) + 1
end

function Time:InitDay()
    global.day = Time:Day()
end

function Time:FormatHour(h)
    if h < 10 then return "0" .. h else return h end
end

function Time:FormatMinutes(m)
    if m < 10 then return "0" .. m else return m end
end

function Time:get_time()
    local daytime = game.tick / Time.ticks_per_day
    daytime = daytime - math.floor(daytime)
    daytime = (daytime * 24 + 12) % 24
    h = math.floor(daytime)
    m = math.floor((daytime- h) * 60)
    Time:Day()

    return "" .. Time:FormatHour(h) .. ":" .. Time:FormatMinutes(m)
end