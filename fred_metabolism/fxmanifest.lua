description 'Databased Items for Metabolism, Hunger, Thirst, Temperature'
author 'FRED - forked and modded by Crafted By Little Dragons'
version '1.0'
lua54 'yes'

fx_version "adamant"
games {"rdr3"}
rdr3_warning 'I acknowledge that this is a prerelease build of RedM, and I am aware my resources *will* become incompatible once RedM ships.'

client_scripts {    
	'config.lua',
	'client/*.lua',    
}

shared_script 'config.lua'

server_scripts {
    'config.lua',
	'server/*.lua',
}

export 'getThirst'
export 'getHunger'