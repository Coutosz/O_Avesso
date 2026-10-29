if (variable_global_exists("next_room_x")) {
    x = global.next_room_x;
    y = global.next_room_y;
}

// Sala nova: zera o rastro (os seguidores nascem em cima dela)
trail = [];
last_x = x;
last_y = y;
cs_moving = false;

// Onde ela entrou na sala (se o calor zerar no escuro, volta pra cá)
global.room_entry_x = x;
global.room_entry_y = y;
