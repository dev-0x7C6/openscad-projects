$fn = 64;

module wltoys_hex_mount(h = 4.00, diameter = 13.70, axle_d = 4.20, spacer_h = 0.60) {
    optical_axis_mount_l = 10.00;
    optical_axis_mount_w = 1.80;
    optical_axis_mount_h = 2.00;
    
    difference() {
        union() {
            linear_extrude(h)
                difference() {
                    circle($fn = 6, r = diameter / 2);
                    circle(r = axle_d / 2);
                }
            translate([0, 0, h])
                linear_extrude(spacer_h, scale = 0.85)
                    circle(r = axle_d / 1.28);
        }
            
        translate([0, 0, h - optical_axis_mount_h])
            linear_extrude(h)
                rotate([0, 0, 30])
                square([optical_axis_mount_w, optical_axis_mount_l], center = true);
        
        linear_extrude(h + spacer_h + 0.1)
            circle(r = axle_d / 2);
    }
}


translate([00, 0, 0]) wltoys_hex_mount(h = 5.40);
translate([20, 0, 0]) wltoys_hex_mount(h = 4.00);
