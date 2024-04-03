$fn = 128;
r = 95.50 / 2;
w = 0.4 * 2;

difference() {
    linear_extrude(10.4)
        circle(r + w);
    
    translate([0, 0, 0.4])
        linear_extrude(10.4)
            circle(r);
}

