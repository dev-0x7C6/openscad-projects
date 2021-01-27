$fn = 64;

font_size = 24.00;
font_space = font_size + 4.00;
font_h = 2.00;

ring_r = 70.00;
mount_hole = 4.00;

base_h = 5.00;

module centred_txt(value, font_size = font_size) {
    text(value, font = "Liberation Sans", size = font_size, halign = "center", valign = "center");
}


module message() {
    translate([0, font_space, 0])
        centred_txt("Baron");
    centred_txt("Jakości");
    translate([0, -font_space, 0])
        centred_txt("Sonel®");
}


module base(r = ring_r, h = base_h) {
    linear_extrude(h)
        circle(r);
}

module circle_with_hole(r = ring_r, size = 2.00) {
    difference() {
        circle(r);
        circle(r - size / 2);
    }
}

difference() {
    union() {
        base(ring_r);
        linear_extrude(base_h + font_h) {
            circle_with_hole(ring_r);
            message();
        }
    }
    translate([0, ring_r * 0.90, 0])
    linear_extrude(base_h)
        circle(mount_hole);
}

