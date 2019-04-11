$fn = 64;

module samsung_vesa_sleeve(base = 3, height = 32)
difference() {
    union() {
        linear_extrude(base)
            circle(r = 10.5);

        translate([0, 0, base])
            linear_extrude(height - base)
                circle(r = 6.25);
    }
    
    linear_extrude(height)
        circle(r = 4.0);
}

samsung_vesa_sleeve();