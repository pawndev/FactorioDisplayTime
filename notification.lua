Notification = {}

function Notification:SendPublicMessage(message) 
    for _, player in pairs(game.players) do
       player.print(message)
    end
end