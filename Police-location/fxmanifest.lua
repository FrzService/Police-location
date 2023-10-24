fx_version 'adamant'

game 'gta5'

author 'Frz Service'

description 'Police location script by Frz Service | https://discord.gg/6F96YdpJ8H'

version '1.1.0'

server_scripts {
    '@mysql-async/lib/MySQL.lua',
    '@es_extended/locale.lua',
    'config.lua',
    'server/main.lua'
}

client_scripts {
    '@es_extended/locale.lua',
    'config.lua',
    'client/main.lua'
}

shared_script '@es_extended/imports.lua'