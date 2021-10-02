fx_version 'adamant'
games { 'gta5' };

shared_scripts {
    "sh/config.lua", 
}

server_scripts {
    '@async/async.lua',
    '@es_extended/locale.lua',
    '@mysql-async/lib/MySQL.lua',

    "sv/sv_main.lua", 
}

client_scripts {
    "src/client/RMenu.lua",
    "src/client/menu/RageUI.lua",
    "src/client/menu/Menu.lua",
    "src/client/menu/MenuController.lua",
    "src/client/components/*.lua",
    "src/client/menu/elements/*.lua",
    "src/client/menu/items/*.lua",
    "src/client/menu/panels/*.lua",
    "src/client/menu/windows/*.lua",
}

client_scripts {
    "cl/cl_main.lua",--f5
    "cl/handler.lua",--f5
    "cl/cl_utils.lua",--f5
    "cl/other.lua",--f5
}
