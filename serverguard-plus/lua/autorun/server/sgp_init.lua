-- Included in every file.
SGPlus = SGPlus or {}

-- Display messages in console
SGPlus.WHITE = Color( 255, 255, 255 ) -- For information.
SGPlus.RED = Color( 255, 0, 0 ) -- For errors.
SGPlus.GREEN = Color( 0, 255, 0 ) -- For successfully done operations.
SGPlus.BLUE = Color( 0, 0, 255 )

SGPlus.PrintConsole = function( color, log )
    local time = os.date( "%H:%M" )
    MsgC( color, string.format( "[%s][SGuard+] %s", time, log ) )
end