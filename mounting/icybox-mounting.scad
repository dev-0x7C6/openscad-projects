$fn = 64;

//box = [160.00 , 52.00];
//bh = 6.00;
//side = 6.00;
//hole_r = 2.00;


box = [96.00, 17.00];

bh = 2.00;
side = 2.00;
hole_r = 1.00;

wh = 8.00;

bottom = [box[0] + side * 2, wh];

/*
support = 6.00;
mount = 16.00;

difference() {
    square([box[0] + support * 2, box[1] + support], center = true);
    translate([0, support / 2, 0])
        square(box, center = true);
    //translate([-box[0] / 2 - mount / 2 - support, -support / 2, 0])
    //    square([mount, box[1]], center = true);
    //translate([box[0] / 2 + mount / 2 + support, -support / 2, 0])
    //    square([mount, box[1]], center = true);
}

*/

module bottom_support(h, area) {
    linear_extrude(h)
        square(area, center = true);
}

module square_with_hole(h, area, r) {
    translate([0, 0, h])
        rotate([0, 180, 0])
            difference() {
                linear_extrude(h)
                    square(area, center = true);
                linear_extrude(h, scale = 2)
                    circle(r);
            }
}

union() {
    bottom_support(bh, bottom);

    translate([-bottom[0] / 2 + side / 2, 0, bh])
        linear_extrude(box[1])
            square([side, bottom[1]], center = true);

    translate([bottom[0] / 2 - side / 2, 0, bh])
        linear_extrude(box[1])
            square([side, bottom[1]], center = true);

    translate([-bottom[0] / 2 - wh / 2, 0, box[1]])
        square_with_hole(bh, [wh, bottom[1]], hole_r);

    translate([bottom[0] / 2 + wh / 2, 0, box[1]])
        square_with_hole(bh, [wh, bottom[1]], hole_r);
}
