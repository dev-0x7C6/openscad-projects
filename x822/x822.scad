$fn = 64;


base_height = 3.00;
height = 46.00 + base_height;

wall = 1.80;

y_offset = 4.00;

workspace = [176.00, 110.00 + y_offset];
workspace_wall = [workspace[0] + wall * 2.00, workspace[1] + wall * 2.00];

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

module prism(l, w, h, center = true){
    translate([center ? -l / 2 : 0, center ? -w / 2 : 0, center ? -h / 2 : 0])
    polyhedron(
           points=[[0,0,0], [l,0,0], [l,w,0], [0,w,0], [0,w,h], [l,w,h]],
           faces=[[0,1,2,3],[5,4,3,2],[0,4,5,1],[0,3,4],[5,2,1]]
           );
}


module led_corner(w = 10.00, h = 12.00, thickness = wall) {
    translate([-w / 2.00, 0, 0]) {
        linear_extrude(h)
            square([w, thickness + 3.40]);
        
        translate([0.00, 0.00, h])
            linear_extrude(12.00)
                square([w, thickness]);
    }
}

module sdcard_slot(h = 40.00, center = true) {
    translate([0, 0, center ? -h / 2 : 0])
    union() {
        linear_extrude(1.00)
            difference() {
                square([8.00, 25.40], center = true);
                square([5.00, 22.00], center = true);
            }

        linear_extrude(h)
        difference() {
            square([7.30 + 2.00, 25.10 + 2.00], center = true);
            square([7.30, 25.10], center = true);
        }
    }
}

module lid(height = 2.00, wall_height = 14.00) {
    linear_extrude(height)
        difference() {
            square(workspace_wall, center = true);
            translate([workspace[0] / 2 - 36.25 + 1.25 , 5.00 + 1.25, 0])
                square(42.00, center = true);
        }
        
    tolerance = 0.30;

    translate([0.00, 0.00, height])
        difference() {
            linear_extrude(wall_height)
                difference() {
                    square([workspace[0] - tolerance, workspace[1] - tolerance], center = true);
                    square([workspace[0] - wall * 2.0 - tolerance, workspace[1] - wall * 2.0 - tolerance], center = true);
                }
                
            translate([workspace[0] / 2 - 33.0, -workspace[1] / 2, 2.00])
                linear_extrude(wall_height - 2.00)
                    square(56.00, center = true);
        }

}

module case() {
    linear_extrude(base_height)
        difference() {
            square(workspace, center = true);
            translate([0, y_offset / 2.00, 0])
                grid(3, 2, 157.50, 57.50)
                    circle(r = 1.65);
        }
        
    first_board_level = base_height + 15.00 + 1.60;
    second_board_level = first_board_level + 12.00 + 1.75;



    difference() {
        union() {
            linear_extrude(height + base_height) {
                difference() {
                    square(workspace_wall, center = true);
                    square(workspace, center = true);
                }
            }
            
            color("red")
                translate([0.00, -workspace_wall[1] / 2, 0])
                    mirror([0, 1, 0])
                        translate([0, -wall / 2.00  - 5.40, 0])
                            led_corner(w = workspace[0] - 20.00, h = first_board_level - 2.00);
            
            color("red")
                translate([workspace_wall[0] / 2, 0, 0])
                    mirror([-90, 90, 0])
                        translate([0, -wall / 2.00 - 5.40, 0])
                            led_corner(w = workspace[1] - 20.00, h = first_board_level - 2.00);
            
            color("red")
                translate([-workspace_wall[0] / 2, 0, 0])
                    mirror([90, 90, 0])
                        translate([0, -wall / 2.00 - 5.40, 0])
                            led_corner(w = workspace[1] - 20.00, h = first_board_level - 2.00);
        }
        
        translate([workspace_wall[0] / 2, y_offset / 2, second_board_level - 3.00])
            linear_extrude(10) {
                difference() {
                    square([wall * 2, 58.00], center = true);
                }
            }
            
        
        translate([54.80, workspace_wall[1] / 2, second_board_level])
            linear_extrude(16.20) {
                    square([54.00, wall * 2], center = true);
            }
        
        translate([56.70, workspace_wall[1] / 2, first_board_level])
            linear_extrude(8.40) {
                    square([16.50, wall * 2], center = true);
            }
        
        translate([36.00, workspace_wall[1] / 2, first_board_level])
            linear_extrude(8.40) {
                    square([16.50, wall * 2], center = true);
            }
            
        translate([-30.00, workspace_wall[1] / 2, first_board_level])
            linear_extrude(8.40) {
                    square([16.50, wall * 2], center = true);
            }
            
        translate([-56.00, workspace_wall[1] / 2, first_board_level])
            linear_extrude(11.60) {
                    square([9.00, wall * 2], center = true);
            }
    }
}

translate([workspace_wall[0] * 1.1, 0, 0])
    lid();

case();