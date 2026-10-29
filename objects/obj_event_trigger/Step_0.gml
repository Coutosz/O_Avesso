if (event == "" || !instance_exists(obj_player)) exit;

var _touch = place_meeting(x, y, obj_player);

if (_touch && !inside && !scr_is_blocking()) {
    var _flag = "trig_" + event;
    if (!once || !scr_flag_get(_flag)) {
        var _cmds = scr_event_cmds(event, id);
        if (is_array(_cmds) && array_length(_cmds) > 0) {
            if (once) scr_flag_set(_flag, true);
            cs_start(_cmds);
        }
    }
}

// só conta como "entrou" quando não tem nada bloqueando
if (!scr_is_blocking()) inside = _touch;
