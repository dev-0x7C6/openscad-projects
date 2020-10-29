pcb_sata_board = [72.20, 15.20, 1.20];

pcb_sata_bottom_space = 2.00;
pcb_sata_top_space = 6.20;

pcb_mounting_corner_width = 6.20;
pcb_extra_corner_width = 1.20;

$fn = 64;

pcb_bottom_lift = 3.40;
pcb_top_lift = 8.00;

pcb_hole_size = 2.90;
pcb_hole_shift = 1.50 + (3.0/2 - pcb_hole_size/2);


module pcb_holder(height, gap) {
    difference() {
        linear_extrude(height)
            square([pcb_sata_board[0] + pcb_extra_corner_width * 2, pcb_sata_board[1]], center = true);
        translate([0, 0, height - gap])
            linear_extrude(gap)
                square([pcb_sata_board[0] - pcb_mounting_corner_width*2, pcb_sata_board[1]], center = true);
        
        translate([pcb_sata_board[0] / 2 - pcb_hole_size / 2 - pcb_hole_shift, 0, 0])
            linear_extrude(height)
                circle(pcb_hole_size / 2);
        
        translate([-(pcb_sata_board[0] / 2 - pcb_hole_size / 2 - pcb_hole_shift), 0, 0])
            linear_extrude(height)
                circle(pcb_hole_size / 2);
    }
}

//pcb_holder(pcb_bottom_lift, pcb_sata_bottom_space);

//translate([0, 20, 0])
 //   pcb_holder(pcb_top_lift, pcb_sata_top_space);


cartridge_top = 2.00;
cartridge_bot = 2.00;
cartridge_rail_width = 81.00;
cartridge_dock = [96.00, 110.00, 12.00 + cartridge_top + cartridge_bot];





cartridge_rail = [81.00, 90.00, 1.00];

module prism(l, w, h, center = true) {
    translate([center ? -l/2 : 0, 0, 0])
    polyhedron(
        points=[[0,0,0], [l,0,0], [l,w,0], [0,w,0], [0,w,h], [l,w,h]],
        faces=[[0,1,2,3],[5,4,3,2],[0,4,5,1],[0,3,4],[5,2,1]]
    );
}

module cartridge_rail(w = cartridge_rail_width, l = cartridge_dock[1]) {
    h = cartridge_rail[2];
    linear_extrude(h)
        square([w, l], center = true);
    
    module rail(size = 1.5) {
        translate([-w / 2 + size, 0, h])
            rotate([0, 0, 90])
                prism(l, size, size);
    }

    rail();

    mirror([1, 0, 0])
        rail();
}

module allen_bolt_socket() {
    translate([0, 0, 13.20])
    mirror([0, 0, 1]) {
        linear_extrude(3.20)
            circle(r = 2.80);
        translate([0, 0, 3.20])
            linear_extrude(2)
                circle(r = 1.70);
        translate([0, 0, 5.20])
            linear_extrude(8.00)
                circle(r = 1.40);
    }
}


module cartridge_dock() {
    h = cartridge_dock[2];
    difference() {

        minkowski() {
            linear_extrude(h)
                square([cartridge_dock[0] - 4, cartridge_dock[1] - 4], center = true);
            cylinder(r = 2,h = 1);
        }
    
        translate([0, 0, cartridge_bot])
        linear_extrude(h - cartridge_top - cartridge_bot)
            square([81.00, cartridge_dock[1]], center = true);
    }
}

module grid(x, y, width, height, center = true)
{
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

module dock() {
    difference() {
        cartridge_dock();
        
        translate([0, 0, 3.81])
            grid(2, 2, cartridge_dock[0] - 8, cartridge_dock[1] - 8)
                allen_bolt_socket();
    }
    
    translate([0, cartridge_dock[1]/2 - pcb_sata_board[1]/2, 2])
        pcb_holder(pcb_bottom_lift, pcb_sata_bottom_space);
    
    translate([0, 0, 1])
    cartridge_rail();
}

dock();
