fx_version 'adamant'
games { 'gta5' }

this_is_a_map 'yes'

client_scripts {
    -- Polyzones
    '@PolyZone/client.lua',
	'@PolyZone/BoxZone.lua',
	'@PolyZone/EntityZone.lua',
	'@PolyZone/CircleZone.lua',
	'@PolyZone/ComboZone.lua',
    
    'client.lua',
}

server_script "server.lua"