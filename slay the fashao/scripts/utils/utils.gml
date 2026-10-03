function approach(value, to, by) {
	if (value < to) {
	    return min(value + by, to); 
    } else {
	    return max(value - by, to);
	}
}

function log(variable) {
	show_debug_message("{0}", variable)
}

function log_name(inst) {
	if (variable_instance_exists(inst, "object_index")) {
		log(object_get_name(inst.object_index))
	}
}