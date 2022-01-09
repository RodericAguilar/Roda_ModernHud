
fx_version 'cerulean'
game 'gta5'

author ''

description 'Modern Hud'

client_scripts {
    'Client/*.lua',
}

server_scripts {
    '@mysql-async/lib/MySQL.lua',  --If you use qbcore, just delete this.
    'Server/*.lua'
}

shared_scripts {
    'Config.lua'
}

ui_page {
    'html/index.html',
}

files {
	'html/index.html',
	'html/app.js', 
    'html/style.css',
    'html/fonts/*.otf',
    'html/weapons/*.png',
    'html/dist/*.css',
    'html/dist/*.min.css',
    'html/dist/*.min.js',
    'html/dist/*.js',
    'html/weapons/*.svg'
}