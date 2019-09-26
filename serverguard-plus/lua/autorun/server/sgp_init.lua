-- Included in every file.
SGPlus = SGPlus or {}

-- Display messages in console
SGPlus.WHITE = Color( 255, 255, 255 )
SGPlus.RED = Color( 255, 0, 0 )
SGPlus.GREEN = Color( 0, 255, 0 )
SGPlus.BLUE = Color( 0, 0, 255 )

SGPlus.PrintConsole = function( color, log )
    local time = os.date( "%H:%M" )
    MsgC( color or SGPlus.WHITE, string.format( "[%s][SGuard+] %s\n", time, log ) )
end