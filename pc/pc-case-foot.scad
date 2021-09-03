$fn = 64;

union() {
    difference() {
        linear_extrude(16)
            circle(r = 14.00);
        
        translate([0, 0, 2])
            linear_extrude(16)
                circle(r = 12.00);
    }
    
    difference() {
        linear_extrude(19)
                circle(r = 6.10);
        translate([0, 0, 2])
            linear_extrude(24)
                circle(r = 4.00);
    }
}