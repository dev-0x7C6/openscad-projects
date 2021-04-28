$fn = 32;

roundedcube(225 + 8, 102 + 8, 2, 3.5);

translate([0, 0, 2])
    roundedcube(225, 102, 4, 3.5);

module roundedcube(xdim, ydim, zdim, rdim, center = true) {
    translate(center ? [-xdim / 2, -ydim / 2, 0] : [0, 0, 0])
    hull() {
        translate([rdim,rdim,0])
            cylinder(h=zdim,r=rdim);
        translate([xdim-rdim,rdim,0])
            cylinder(h=zdim,r=rdim);
        translate([rdim,ydim-rdim,0])
            cylinder(h=zdim,r=rdim);
        translate([xdim-rdim,ydim-rdim,0])
            cylinder(h=zdim,r=rdim);
    }
}