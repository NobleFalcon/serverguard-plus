net.Receive( "RollMessage", function()
    local roll = net.ReadString()
    chat.AddText( Color(232, 68, 68), roll )
end )