// Toda sala nova: recria os seguidores em cima da protagonista
if (room == rm_boot || room == rm_menu) exit;
if (!instance_exists(obj_player)) exit;

var _px = variable_global_exists("next_room_x") ? global.next_room_x : obj_player.x;
var _py = variable_global_exists("next_room_y") ? global.next_room_y : obj_player.y;

for (var i = 0; i < array_length(global.party); i++) {
    var _who = global.party[i];
    // Quem está no grupo não fica parado na sala: tira a versão parada, se tiver
    with (obj_char) if (who == _who) instance_destroy();

    var _f = instance_create_depth(_px, _py, -_py, obj_follower);
    _f.who = _who;
    _f.slot = i;
    _f.sprite_index = scr_char_sprite(_who);
}
