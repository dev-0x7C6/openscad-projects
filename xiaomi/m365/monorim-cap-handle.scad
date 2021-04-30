outer_r = 8.60;
inner_r = 5.72;
hole_r = 3.20;

h = 16.00;

base_h = 2.00;

difference() {
    linear_extrude(h)
        difference() {
            circle(r = outer_r, $fn = 6);
            circle(r = hole_r, $fn = 64);
        }
    
    translate([0, 0, base_h])
        linear_extrude(h - base_h)
                circle(r = inner_r, $fn = 6);                
}