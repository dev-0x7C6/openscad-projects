pcb = [200.00, 57.00];
pcb_half = [pcb[0] / 2, pcb[1] / 2];

hole_3mm = 3.50;
hole_3mm_r = hole_3mm / 2;

hole_nr1_3mm_offset = [5.00, 16.65];
hole_nr2_3mm_offset = [11.80, 36.50];
hole_nr3_3mm_offset = [50.00, 36.50];
hole_nr4_3mm_offset = [29.65, 36.50];
hole_nr5_3mm_offset = hole_nr1_3mm_offset;

wall_height = 3.00;
feet_size = 10.00;

$fn = 64;

module prism(l, w, h, center = false) {
    translate([center ? -l / 2 : 0, center ? -w / 2 : 0, 0])
    polyhedron(
        points=[[0,0,0], [l,0,0], [l,w,0], [0,w,0], [0,w,h], [l,w,h]],
        faces=[[0,1,2,3],[5,4,3,2],[0,4,5,1],[0,3,4],[5,2,1]]
    );
}
  
module pcb_hole_offset(offset = [0, 0], r = hole_3mm_r) {
    r_half = 0;
    x_offset = pcb_half[0] - offset[0] - r_half;
    y_offset = pcb_half[1] - offset[1] - r_half;
    
    translate([x_offset, y_offset, 0])
        circle(r);
}

module wall(h) {
    linear_extrude(h) {
        difference() {
            square(pcb, center = true);
            
            pcb_hole_offset(hole_nr1_3mm_offset);        
            pcb_hole_offset(hole_nr2_3mm_offset);
            pcb_hole_offset(hole_nr3_3mm_offset);
            
            mirror([1, 0, 0]) {
                pcb_hole_offset(hole_nr4_3mm_offset);
                pcb_hole_offset(hole_nr5_3mm_offset);
            }
        }
    }
}

module side(f = feet_size) {
    union() {
        wall(wall_height);
        translate([-pcb_half[0], pcb_half[1] - f, wall_height])
            difference() {
                prism(pcb[0], f, f);
                translate([0, 0, f - 1])
                    cube(pcb[0], 10, 1);
            }
    }
}

mirror([1, 0, 0])
    side();

translate([0, pcb[1] * 1.1, 0])
mirror([0, 0, 0])
    side();