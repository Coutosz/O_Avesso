menu_options = ["Continue", "New Game"];
menu_enabled = [file_exists("save1.sav"), true]; 
menu_index = 1; 
global.inventory = array_create(8, ""); 
menu_state = "select"; 
player_name_input = "";

// a tela inicial entra devagar do preto de novo
global.title_t = 0;

// Saindo do Avesso pro menu: o barulho de fundo some
scr_som_update("rm_menu");
