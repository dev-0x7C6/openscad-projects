$fn=64;

// holes
hole_size = 5;
hole_tolerance = 0.2;

// holder size
holder_height = 4.5;
holder_lenght = 5;
holder_wall = 1.2;

//sizes
base_lenght = 30;
base_width = hole_size * 2.0;
base_height = 0.8;

module make_holes(h, shift_x, size) {
    union() {
        translate([size, size, 0]) cylinder(h, size, size, false);
        translate([size + shift_x, size, 0]) cylinder(h, size, size, false);
    }
}

module make_cliper(l, w, h, hole_s, holder_l, holder_h, holder_t) {
    hole_r = hole_s / 2.0;
    difference() {
        union() {
            difference() {
                cube([l, w, h]);
                translate([hole_r, w / 2.0 - hole_r, 0]) make_holes(h, l - (hole_s * 2.0), hole_r);
            }
            translate([l / 2.0 - (holder_l + holder_t * 2.0) / 2.0, 0, 0]) cube([holder_l + holder_t * 2.0, w, holder_h + holder_t]);
        }
        translate([l / 2.0 - holder_l / 2.0, 0, 0]) cube([holder_l, w, holder_h]);
    }
}

make_cliper(base_lenght, base_width, base_height, hole_size + hole_tolerance, holder_lenght, holder_height, holder_wall);