w=20.0;
l=40.0;
h=0.6;
border=3;
top_additional = 2;

module u_figure(l, w, h, border) {
    w2 = w - border*2;
    difference() {
        cube([l, w, h]);
        translate([-border, border, 0])
            cube([l, w2, h]);
    }
}

module bookmark(l, w, h, border) {
    difference() {
        cube([l+border*2+top_additional, w+border*2, h]);
        translate([border + top_additional, border, 0])
            u_figure(l, w, h, border);
    }
}

bookmark(l, w, h, 3);