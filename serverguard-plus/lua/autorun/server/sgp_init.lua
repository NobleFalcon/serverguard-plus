include( "../sgp_config.lua" )

-- Display messages in console
SGPlus.WHITE = Color( 255, 255, 255 )
SGPlus.RED = Color( 255, 0, 0 )
SGPlus.DARKRED = Color( 220, 0, 0 )
SGPlus.GREEN = Color( 0, 255, 0 )
SGPlus.BLUE = Color( 50, 194, 219 )

SGPlus.PrintConsole = function( color, log )
    local time = os.date( "%H:%M" )
    MsgC( SGPlus.BLUE, string.format( "[%s][SGuard+] ", time ),
     color or SGPlus.WHITE, log .. "\n" )
end
