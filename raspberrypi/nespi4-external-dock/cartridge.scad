base_size = [80.00, 103.00];

bottom_thickness = 1.60;
top_thickness = 0.00;

disk_width = 70.40;
disk_space = 9.40;

height = disk_space + bottom_thickness + top_thickness;

narrow = [3.00, 19.00];

wall = 1.60;

$fn = 64;

module allen_bolt_socket() {
    translate([0, 0, height])
    mirror([0, 0, 1]) {
        linear_extrude(1.80)
            circle(r = 1.90);
        translate([0, 0, 1.80])
            linear_extrude(2)
                circle(r = 1.30);
        translate([0, 0, 3.80])
            linear_extrude(4.00)
                circle(r = 1.00);
    }
}


module prism(l, w, h, center = true) {
    translate([center ? -l/2 : 0, 0, 0])
    polyhedron(
        points=[[0,0,0], [l,0,0], [l,w,0], [0,w,0], [0,w,h], [l,w,h]],
        faces=[[0,1,2,3],[5,4,3,2],[0,4,5,1],[0,3,4],[5,2,1]]
    );
}

module cartridge_rail(w, l, size = 1.5) {    
    module rail(size = size) {
        translate([-w / 2 + size, 0, 0])
            rotate([0, 0, 90])
                prism(l, size, size);
    }

    rail();
    mirror([1, 0, 0])
        rail();
}


module grid(x, y, width, height, center = true){
    x_space = width / (x - 1);
    y_space = height / (y - 1);
    translate(center ? [-(x_space * (x - 1))/2, -(y_space * (y - 1))/2, 0] : [0, 0, 0])
        for (i = [0:x_space:(x - 1) * x_space]) {
            for (j = [0:y_space:(y - 1) * y_space]) {
                translate([i, j, 0]) {
                    children();
                }
            }
        }
}


module base(size = base_size) {
    difference() {
        square(size, center = true);
        translate([size[0] / 2 - narrow[0] / 2, size[1] / 2 - narrow[1] / 2, 0])
            square(narrow, center = true);
        translate([-(size[0] / 2 - narrow[0] / 2), size[1] / 2 - narrow[1] / 2, 0])
            square(narrow, center = true);
    }
}

module lying_cylinder(w = 1.00, r = 5.00, center = true) {
    translate([0, 0, r])
        rotate([90, 0, 0])
            cylinder(w, r, r, center);
}


module disk_mounting_holes(width = disk_width, gap = 4.00, r_inner = 1.50, r_outter = 2.50) {
    translate([0, 0, bottom_thickness + 3.00])
    rotate([0, 0, 90])
        union() {            
            translate([0, 0, r_inner - r_outter])
            difference() {
                lying_cylinder(width * 2, r = r_outter);
                lying_cylinder(width + gap, r = r_outter);
            }
            
            lying_cylinder(width + gap, r = r_inner);
        }
}

difference() {
    linear_extrude(height)
        base(base_size);
    translate([0, wall/2, bottom_thickness])
        linear_extrude(disk_space)
            square([disk_width, base_size[1] - wall], center = true);
    
    cartridge_rail(base_size[0], base_size[1], 3.00);
    
    translate([0, base_size[1] / 2 - 14.00, 0])
        disk_mounting_holes(disk_width, gap = 2.00);
    
    translate([0, base_size[1] / 2 - 14.00 - 74.00, 0])
        disk_mounting_holes(disk_width, gap = 2.00);
    
    ///translate([0, -narrow[1]/2, 0])
     //   grid(2, 2, base_size[0] - 5, base_size[1] - narrow[1] - 5)
       //             allen_bolt_socket();
}