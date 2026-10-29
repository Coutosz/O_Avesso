// ---- Efeitos de tela ----
if (shake > 0) {
    shake -= 1;
    view_set_xport(0, irandom_range(-3, 3));
    view_set_yport(0, irandom_range(-2, 2));
} else {
    view_set_xport(0, 0);
    view_set_yport(0, 0);
}

flash_alpha = max(0, flash_alpha - 0.04);

if (tint_alpha < tint_target) tint_alpha = min(tint_target, tint_alpha + 0.02);
if (tint_alpha > tint_target) tint_alpha = max(tint_target, tint_alpha - 0.02);

switch (title_state) {
    case "in":
        title_alpha += 0.03;
        if (title_alpha >= 1) { title_alpha = 1; title_state = "hold"; title_timer = title_hold; }
        break;
    case "hold":
        title_timer -= 1;
        if (title_timer <= 0) title_state = "out";
        break;
    case "out":
        title_alpha -= 0.03;
        if (title_alpha <= 0) { title_alpha = 0; title_state = ""; }
        break;
}

// ---- Fila de comandos ----
if (!global.cutscene_active) exit;

var _guard = 0;
while (_guard < 100) {
    _guard++;

    if (waiting != "") {
        if (!cs_wait_done()) break;
        waiting = "";
    }

    if (array_length(queue) == 0) {
        global.cutscene_active = false;
        with (obj_player) interact_cooldown = 10;
        break;
    }

    var _cmd = queue[0];
    array_delete(queue, 0, 1);
    cs_exec(_cmd);
}
