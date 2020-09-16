// safety-1st-lever
// Version 4
//
// Opening lever for "Safety 1st" child barriers
//
// The original levers tend to break after a while of use, so it's a good idea to keep a few spares
// around.
//
// Copyright (c) 2019 regenschein71
// https://github.com/regenschein71/safety-1st-lever


// Set this to true to rotate the lever onto the long flat side with the knob
// for the spring pointing up. This needs supports, but will result in a much cleaner 
// knob print.
knob_side_up = true;


rotate([0,knob_side_up ? -90 : 0,0])
union() {
    intersection() {
        difference() {
            // Base Plate
            // translate ([0, 0, -2.1]) scale ([25,19,4.2]) cube(1,true);
            translate ([0, 0, -2.1]) roundedcube ([25,19,4.2], true, 1.5, "zmin");
            // Cutout
            translate ([(-12 - 4.3) / 2 , 0, 0]) scale ([12,5.53,1]) cube(1,true);
        }
        // translate ([0, 0, 20 - 4.2 - 1]) rotate ([0, 90, 90]) cylinder(30, 20,20, true, $fn=64);
    }
    
    // Bottom bottom, connected to plate
    translate ([0, 0, 31.3 / 2]) scale ([4.3, 5.53, 31.3]) cube(1, true);
    
    // Wider post part
    translate ([0, 0, 24.5 / 2 + 31.3 - 24.5]) scale ([4.3, 7.05, 24.5]) cube(1, true);
    
    // Top (widest) post part
    translate ([(6.75 - 4.3) / 2, 0, 19.3 / 2 + 31.3 - 19.3]) scale ([6.75, 7.05, 19.3]) cube(1, true);
    
    // Spring protrusion
    translate ([(7.05 - 4.3) / 2,0,6.75]) rotate ([0, 90, 0]) cylinder(7.05, 2, 2, true, $fn=16);
    
    // Bottom enforcer cylinder
    translate ([2.15, 0, 0])  rotate ([0, 90, 90]) cylinder(5.53, 2, 2, true, $fn=16);
}


// Higher definition curves
$fs = 0.01;

module roundedcube(size = [1, 1, 1], center = false, radius = 0.5, apply_to = "all") {
	// If single value, convert to [x, y, z] vector
	size = (size[0] == undef) ? [size, size, size] : size;

	translate_min = radius;
	translate_xmax = size[0] - radius;
	translate_ymax = size[1] - radius;
	translate_zmax = size[2] - radius;

	diameter = radius * 2;

	module build_point(type = "sphere", rotate = [0, 0, 0]) {
		if (type == "sphere") {
			sphere(r = radius);
		} else if (type == "cylinder") {
			rotate(a = rotate)
			cylinder(h = diameter, r = radius, center = true);
		}
	}

	obj_translate = (center == false) ?
		[0, 0, 0] : [
			-(size[0] / 2),
			-(size[1] / 2),
			-(size[2] / 2)
		];

	translate(v = obj_translate) {
		hull() {
			for (translate_x = [translate_min, translate_xmax]) {
				x_at = (translate_x == translate_min) ? "min" : "max";
				for (translate_y = [translate_min, translate_ymax]) {
					y_at = (translate_y == translate_min) ? "min" : "max";
					for (translate_z = [translate_min, translate_zmax]) {
						z_at = (translate_z == translate_min) ? "min" : "max";

						translate(v = [translate_x, translate_y, translate_z])
						if (
							(apply_to == "all") ||
							(apply_to == "xmin" && x_at == "min") || (apply_to == "xmax" && x_at == "max") ||
							(apply_to == "ymin" && y_at == "min") || (apply_to == "ymax" && y_at == "max") ||
							(apply_to == "zmin" && z_at == "min") || (apply_to == "zmax" && z_at == "max")
						) {
							build_point("sphere");
						} else {
							rotate = 
								(apply_to == "xmin" || apply_to == "xmax" || apply_to == "x") ? [0, 90, 0] : (
								(apply_to == "ymin" || apply_to == "ymax" || apply_to == "y") ? [90, 90, 0] :
								[0, 0, 0]
							);
							build_point("cylinder", rotate);
						}
					}
				}
			}
		}
	}
}