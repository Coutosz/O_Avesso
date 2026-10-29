// Um por sala da história. Roda a preparação da sala (quem aparece, cutscene de entrada...),
// a luz/escuro e os extras — tudo em scr_room_setup / scr_room_style / scr_room_lights no scr_ato1.
// O cenário de verdade é feito com tiles (tileset ts_casa, grade de 16px) nas camadas
// Tiles_Chao, Tiles_Parede, Tiles_Tapete e Tiles_Decor da sala.
// Sala sem tiles ainda: o chão e as paredes provisórios são desenhados por código.
depth = 10000;
room_name = room_get_name(room);
style = scr_room_style(room_name);
bg_sprite = asset_get_index("spr_bg_" + string_delete(room_name, 1, 3));
if (bg_sprite != -1 && asset_get_type("spr_bg_" + string_delete(room_name, 1, 3)) != asset_sprite) bg_sprite = -1;
light_surf = -1;
has_tiles = layer_exists("Tiles_Chao");
if (has_tiles) depth = 250;   // entre os tiles da parede (300) e os tapetes/decoração (200/100)

// A nova arte da sala é desenhada em pixels pelo scr_visual.
has_tiles = false;
depth = 10000;
var _art_layers = ["Background", "Tiles_Chao", "Tiles_Parede", "Tiles_Tapete", "Tiles_Decor"];
for (var i = 0; i < array_length(_art_layers); i++) {
    if (layer_exists(_art_layers[i])) layer_set_visible(_art_layers[i], false);
}
