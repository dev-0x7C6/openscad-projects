module alg_next_each_other_x(count = 2, space = 10.00, center = true) {
    translate([center ? -space * count / 2 + space/2 : 0, 0, 0])
        for (offset = [0:count - 1])
            translate([offset * space, 0, 0])
                children();
}

module alg_next_each_other_y(count = 2, space = 10.00, center = true) {
    translate([0, center ? -space * count / 2 + space/2 : 0, 0])
        for (offset = [0:count - 1])
            translate([0, offset * space, 0])
                children();
}

module alg_next_each_other_x_squeze_in(count = 2, width = 10.00, size = 1.00, center = true) {
    alg_next_each_other_x(count, width / count / 2, center)
        children();
}

module grid(x = 1, y = 1) {
    alg_next_each_other_y(y)
        alg_next_each_other_x(x)
            children();
}


module window(size = [17.00, 23.60], h = 1.60, inner_t = 0.8, outer_t = 0.8, shutter_h = 0.60, shutter_right = 9.00, shutter_left = 9.00, shutter_top = 0.80, shutter_bottom = 0.40, with_segment = true, with_shutter = false) {
    
    linear_extrude(h + (with_shutter ? shutter_h : 0))
        union() {
            difference() {
                square(size, center = true);
                square([size[0] - outer_t * 2, size[1] - outer_t * 2], center = true);
            }
            
            if (with_segment)
                square([inner_t, size[1]], center = true);
        }
        
    linear_extrude(shutter_h) {
        if (shutter_left > 0)
            translate([size[0]/2 + shutter_left/2, 0, 0])
                square([shutter_left, size[1]], center = true);
        
        if (shutter_right > 0)
            translate([-size[0]/2 - shutter_right/2, 0, 0])
                square([shutter_right, size[1]], center = true);
        
        if (shutter_top)
            translate([(shutter_left - shutter_right) / 2, size[1]/2 + shutter_top/2 - 0.001, 0])
                square([size[0] + shutter_left + shutter_right, shutter_top], center = true);
        
        if (shutter_bottom)
            translate([(shutter_left - shutter_right) / 2, -size[1]/2 - shutter_bottom/2 - 0.001, 0])
                square([size[0] + shutter_left + shutter_right, shutter_bottom], center = true);
    }
}

translate([30, 30, 0])
    window([18.20, 24.60]);

translate([76, 30, 0])
    window([20.00, 25.00], with_shutter = false);

translate([70, 60, 0])
    window([9.20, 24.60], h = 2.20, shutter_left = 0, with_segment = false);

translate([30, 60, 0])
    window([16.00, 17.00], h = 2.20, shutter_right = 8.00, shutter_left = 8.00, with_segment = false);

translate([-30, -60, 0])
    window([18.20, 24.60], h = 2.20, shutter_right = 18.30, shutter_left = 0, with_segment = false);

translate([-30, -30, 0])
    window([20.00, 25.00], shutter_right = 0, shutter_left = 0, shutter_top = 0, shutter_bottom = 0, with_shutter = false);

translate([-20, 30, 0])
    window([20.00, 25.00], shutter_right = 0, shutter_left = 0, shutter_top = 0, shutter_bottom = 0, with_shutter = false);

translate([-60, -30, 0])
    window([8.00, 15.00], h = 2.20, shutter_right = 7.50, shutter_left = 0, with_segment = false);

translate([-80, -60, 0])
    window([9.00, 25.00], h = 2.40, shutter_right = 0, shutter_left = 9, with_segment = false);

translate([-10, -50, 0])
    window([6.70, 14.80], h = 2.40, shutter_right = 0, shutter_left = 6, with_segment = false, shutter_top = 0);

translate([-10, -30, 0])
    window([6.60, 13.40], h = 2.40, shutter_right = 0, shutter_left = 7, with_segment = false, shutter_top = 0);

window([7.80, 17.20], h = 2.40, shutter_right = 0, shutter_left = 7, with_segment = false);

//linear_extrude(0.8)
//    square([66, 29]);

// filar
//linear_extrude(29.20)
//    square([3, 3]);

/*
translate([18.00, 0, 0])
    window([15.10, 15.50]);

translate([18.00 + 15.50 + 4, 0, 0])
    window([19.30, 23.60]);
*/