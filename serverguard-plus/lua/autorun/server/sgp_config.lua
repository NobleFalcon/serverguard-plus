-- Included in every file.
SGPlus = SGPlus or {};

SGPlus.Version = "1.0";

SGPlus.AdminSitDataDir = "sgplus/adminsitdata/"
SGPlus.AdminSitData = SGPlus.AdminSitDataDir .. "adminsitdata.txt";

file.CreateDir( SGPlus.AdminSitDataDir );

-- Prevent value error.
if not file.Exists( SGPlus.AdminSitData, "DATA" ) then
    file.Write( SGPlus.AdminSitData, "0 0 0" );
end;