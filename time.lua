require('notification')

function addNewItem(keyTable, myTable, key, value)
    table.insert(keyTable, key)
    myTable[key] = value 
end 

Time = {}

Time.ticks_per_day = 25000
Time.Phase = {
    day = {duration = 12500, name = "day", isActive = false},
    sunset = {duration = 5000, name = "sunset", isActive = false},
    night = {duration = 2500, name = "night", isActive = false},
    sunrise = {duration = 5000, name = "sunrise", isActive = false}
}
Time.PhaseIndex = {
    "day",
    "sunset",
    "night",
    "sunrise"
}

function Time:SetCurrentPhase(name)
    Time.Phase[name].isActive = true
end

function Time:ResetPhase(name)
    Time.Phase[name].isActive = false
end

function Time:ResetPhases()
    for key in pairs(Time.Phase) do
        Time:ResetPhase(key)
    end
end

function Time:Day()
    return math.floor((game.tick + (Time.ticks_per_day / 2)) / Time.ticks_per_day) + 1
end

function Time:InitDay()
    global.day = Time:Day()
end

function Time:GetNextPhaseName(ticks)
    next_phase = ""

    if (ticks >= 12000 and ticks <= 12500)
    then
        next_phase = Time.Phase.sunset.name
    elseif (ticks >= 17000 and ticks <= 17500)
    then
        next_phase = Time.Phase.night.name
    elseif (ticks >= 19500 and ticks <= 20000)
    then
        next_phase = Time.Phase.sunrise.name
    elseif (ticks >= 24500 and ticks <= 25000)
    then
        next_phase = Time.Phase.day.name
    else
        return nil
    end

    if Time.Phase[next_phase].isActive == false then
        Notification:SendPublicMessage(next_phase .. " is coming")
        Time:ResetPhases()
        Time:SetCurrentPhase(next_phase)
    end

    return next_phase
end

function Time:FormatHour(h)
    if h < 10 then return "0" .. h else return h end
end

function Time:FormatMinutes(m)
    if m < 10 then return "0" .. m else return m end
end

function Time:get_time()
    local daytime = game.tick / Time.ticks_per_day
    Time:GetNextPhaseName(daytime)
    daytime = daytime - math.floor(daytime)
    daytime = (daytime * 24 + 12) % 24
    h = math.floor(daytime)
    m = math.floor((daytime- h) * 60)
    Time:Day()

    return "" .. Time:FormatHour(h) .. ":" .. Time:FormatMinutes(m)
end