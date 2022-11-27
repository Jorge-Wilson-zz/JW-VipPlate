name "QBcore Vip Plate"
author "Jorge Wilson"
version "v1.0"
description "QB-VipPlate"

fx_version "cerulean"

game "gta5"

shared_scripts {
    '@qb-core/shared/locale.lua',
    'locales/pt-br.lua',
}

client_script {
	'client/client.lua'
}

server_script {
    '@oxmysql/lib/MySQL.lua',
	'server/server.lua'
}

lua54 'yes'
