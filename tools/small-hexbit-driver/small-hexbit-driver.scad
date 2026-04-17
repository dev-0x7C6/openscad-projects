$fn = 128;

driver_r = 4;
driver_h = 9;
driver_l = 60.00;

head_r = 4.00; 

driver_rounding = 1.0;

socket_r_outer = 6.00;
socket_h = 10.00;
socket_r = 3.80;
socket_base_h = 3.40;


magnet_h = 3.00;
magnet_r = 3.00;
magnet_r_hole = 1.50;


difference() {
    union() {
        minkowski() {
            linear_extrude(driver_h - driver_rounding * 2)
                union() {
                    hull() {
                        circle(driver_r);
                        translate([driver_l, 0, 0])
                            circle(driver_r);
                    }
                    circle(driver_r + head_r);
                }
          sphere(r = driver_rounding);
        }
        minkowski() {
            linear_extrude(socket_h + socket_base_h - driver_rounding)
                circle(socket_r_outer - driver_rounding);
            sphere(r = driver_rounding);
        }
    }
    
    translate([0, 0, socket_base_h - magnet_h])
        linear_extrude(magnet_h)
            difference() {
                circle(r = magnet_r);
                circle(r = magnet_r_hole);
            }

    translate([0, 0, socket_base_h])
        linear_extrude(socket_h)
            circle($fn = 6, r = socket_r);
}