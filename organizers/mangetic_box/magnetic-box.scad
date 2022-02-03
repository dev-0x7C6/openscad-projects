nozzle = 0.4;

magnet_r = 1.00;
magnet_h = 1.00;
base_h = 0.40;

box = [20.00, 20.00, 2.00];

n = magnet_r * 3 + 1.6;

module alg_next_each_other_x(count = 2, w = 10.00, center = true) {
    translate([center ? -w * count / 2 + w/2 : 0, 0, 0])
        for (offset = [0:count - 1])
            translate([offset * w, 0, 0])
                children();
}

module alg_next_each_other_y(count = 2, w = 10.00, center = true) {
    translate([0, center ? -w * count / 2 + w/2 : 0, 0])
        for (offset = [0:count - 1])
            translate([0, offset * w, 0])
                children();
}

$fn = 64;

difference() {
    linear_extrude(box[2] + base_h)
        square(box[0] + n, box[1] + n, center = true);
    
    translate([0, 0, box[2] + base_h - magnet_h])
        alg_next_each_other_y(2, box[0])
            alg_next_each_other_x(2, box[1])
                linear_extrude(magnet_h)
                    circle(magnet_r);

    translate([0, 0, base_h])
        linear_extrude(box[2])
            square(box[0], box[1], center = true);
    
    
    
}


