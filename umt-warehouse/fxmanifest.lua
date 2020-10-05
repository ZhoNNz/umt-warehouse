fx_version 'adamant'

game 'gta5'

client_scripts {
	'config.lua',
    'client/client.lua',
    -- 'client/cl_tablet.lua',
	'client/functions.lua'
}

server_scripts {
    '@mysql-async/lib/MySQL.lua',
    'config.lua',
    'server/sv_laptop.lua',
	'server/server.lua'
}

ui_page(
    'html/index.html'
    )

files {
    'html/index.html',
    'html/reset.css',
	'html/style.css',
    'html/script.js',
    'html/init.js',
    'html/jqueryjquery.js',
    'html/materialize.js',
    'html/materialize.min.css',
	'html/numField.mp3',
    'html/numField.png',
    'html/img/dynasty8-logo.png',
    'html/img/background.png',
    'html/img/frame.png'
}
    