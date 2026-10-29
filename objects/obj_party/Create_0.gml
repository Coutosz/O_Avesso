// Controla o grupo que anda atrás da protagonista. Fica na rm_menu, persistente.
// A lista de quem está no grupo fica em global.party (salva junto com o jogo).
if (!variable_global_exists("party")) global.party = [];
