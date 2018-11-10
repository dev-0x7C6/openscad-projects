l=680;
w=860;
h=610;

wall_thickness=10;
base_thickness=10;
enclosure_height=10;
enclosure_bump=10;

module box(w, l, h, wt, bt) {
    difference() {
        cube([w + wt * 2, l + wt * 2, h + bt]);
        translate([wt, wt, bt])
            cube([w, l, h]);
    }
}

module box_enclosure(w, l, h, wt, bt) {
    cube([w + wt * 2, l + wt * 2, h + bt]);
}

box(w, l, h, wall_thickness, base_thickness);
translate([w + 100, 0, 0])
    box_enclosure(w, l, enclosure_height, wall_thickness, base_thickness);



