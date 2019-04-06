require("time")

local Init = {}

local Handler = {}

local GUI = {}

local ticks_per_day = 25000

function Init:Players()
   for _, player in pairs(game.players) do
      Init:Player(player)
   end
end

function Init:Player(player)
   if player.connected then
      GUI:Create(player)
   end
end

function Init:All()
   Time:InitDay()
   Init:Players()
end

function GUI:Create(player)
   local t = Time.get_time()
   local widget = player.gui.top.time_widget
   if widget == nil then
      widget = player.gui.top.add({type="button", name="time_widget", caption=t})
   else
      widget.caption = t
   end
   return widget
end

function GUI:Update()
   for _, player in pairs(game.players) do
      if player.connected then
         local widget_label = GUI:Create(player)
      end
   end
end

script.on_init(function() Init:All() end)

script.on_event(defines.events.on_player_created, function(event)
   local player = game.players[event.player_index]
   Init:Player(player)
end)

script.on_event(defines.events.on_player_joined_game, function(event)
   local player = game.players[event.player_index]
   Init:Player(player)
end)

script.on_event(defines.events.on_tick, function(event)
   if event.tick % 30 == 0 then --common trick to reduce how often this runs, we don't want it running every tick, just 1/second
      GUI:Update()
   end
end)
