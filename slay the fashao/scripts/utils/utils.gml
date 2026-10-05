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

/// draw_circular_bar(x ,y ,value, max, colour, radius, transparency, width)
function draw_circular_bar(xx, yy, value, _max, colour, radius, transparency, width) {
	if (argument2 > 0) { // no point even running if there is nothing to display (also stops /0
	    var i, len, tx, ty, val;
    
	    var numberofsections = 60 // there is no draw_get_circle_precision() else I would use that here
	    var sizeofsection = 360/numberofsections
    
	    val = (argument2/argument3) * numberofsections 
    
	    if (val > 1) { // HTML5 version doesnt like triangle with only 2 sides 
	        piesurface = surface_create(argument5*2,argument5*2)
            
	        draw_set_colour(argument4);
	        draw_set_alpha(argument6);
        
	        surface_set_target(piesurface)
        
	        draw_clear_alpha(c_blue,0.7)
	        draw_clear_alpha(c_black,0)
        
	        draw_primitive_begin(pr_trianglefan);
	        draw_vertex(argument5, argument5);
        
	        for(i=0; i<=val; i++) {
	            len = (i*sizeofsection)+90; // the 90 here is the starting angle
	            tx = lengthdir_x(argument5, len);
	            ty = lengthdir_y(argument5, len);
	            draw_vertex(argument5+tx, argument5+ty);
	        }
        
	        draw_primitive_end();
        
	        draw_set_alpha(1);
        
	        gpu_set_blendmode(bm_subtract)
	        draw_set_colour(c_black)
	        draw_circle(argument5-1, argument5-1,argument5-argument7,false)
	        gpu_set_blendmode(bm_normal)

	        surface_reset_target();
     
	        draw_surface(piesurface,argument0-argument5, argument1-argument5)
        
	        surface_free(piesurface)
	    }
	}
}

function array_choose(array) {
	var len = array_length(array)
	
	if (len == 0)
		return undefined
	
	if (len == 1)
		return array[0]
	
	return array[floor(irandom_range(0, len - 1))]
}

// Screenshot stuff
global.screenshot_path = "";

function screenshot_prompt() {
    var _path = get_save_filename("PNG image|*.png", "fashao-katana-run.png");
    if (_path == "") return false;           
    global.screenshot_path = _path;
    return true;
}