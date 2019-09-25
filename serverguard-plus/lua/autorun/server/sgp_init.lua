-- Included in every file.
SGPlus = SGPlus or {}

-- Display messages in console
SGPlus.PrintConsole = function( log )
    local time = os.date( "%H:%M" )
    print( string.format( "[%s][SGuard+] %s", time, log ) )
end