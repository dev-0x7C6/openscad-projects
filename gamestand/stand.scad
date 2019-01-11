// WORK IN PROGRESS

model_width = 160;

model_height = 25;


module prism(l, w, h) {
    polyhedron(
        points=[[0,0,0], [l,0,0], [l,w,0], [0,w,0], [0,w,h], [l,w,h]],
        faces=[[0,1,2,3],[5,4,3,2],[0,4,5,1],[0,3,4],[5,2,1]]
    );
}

module extended_prism(l, w, h, extended) {
    prism(l, w, h);
    translate([0, w, 0])
        cube([l, extended, h]);
}


//translate([0, 12, 0])
  //  cube([160, 72, 2]);

module logo_dxf(filename, height, size) {
    linear_extrude(height = height, convexity = 100, center = true)
        resize(newsize=[0, size * 0.70, 0], auto = true)
            import (file = filename);
}

//difference() {
    extended_prism(model_width, 9, model_height, 3);
    color([0,0,0])
       // translate([40, 2, 4])
        rotate([(180 * (model_height/9.0) / PI) - 90.0,0,0])
            logo_dxf("resources/wiiu.dxf", 2, model_height);
//}

//cube([91, 160, 1]);

base_width=100;
base_lenght=180;
base_height=2;

module prism(l, w, h) {
    polyhedron(
        points=[[0,0,0], [l,0,0], [l,w,0], [0,w,0], [0,w,h], [l,w,h]],
        faces=[[0,1,2,3],[5,4,3,2],[0,4,5,1],[0,3,4],[5,2,1]]
    );
}

module prism2(l, w, h, e) {
    union() {
        difference() {
            union() {
                prism(l, w, h);
                translate([0, w, 0])
                    cube([l, e, h]);
                translate([0, w*2 + e, 0])
                    mirror([0, 1, 0])
                        prism(l, w, h);
            }
            
            union() {
                translate([0, w /4, 0])
                    rotate([-header_angle, 0, 0])
                        cube([l, e, h* 4]);
               // translate([0, 100, 0])
                //    mirror([0, 1, 0])
                   //     prism(100, w, 100);
            }
        }
    }
}

module prism3(l, w, h, e) {
    union() {
        difference() {
            union() {
                prism(l, w, h);
                translate([0, w, 0])
                    cube([l, e, h]);
                translate([0, w*2 + e, 0])
                    mirror([0, 1, 0])
                        prism(l, w, h);
            }
            
            union() {
                translate([0, w /4, 0])
                    rotate([-header_angle, 0, 0])
                        cube([l, e, h* 4]);
               // translate([0, 100, 0])
                //    mirror([0, 1, 0])
                   //     prism(100, w, 100);
            }
        }
        prism(l, w, h);
    }
}

header_height = 10;
header_angle = 15;
header_extend = 10;
header_lenght = base_lenght;

color("red")
translate([0, tan(header_angle) * header_extend * 0.7, 0])
cube([base_lenght, base_width, base_height]);

difference() {
    o = header_angle;
    x = header_extend;
    y = header_height;
    a = abs(x * sin(o)) + abs(y * cos(o));
    b = abs(x * cos(o)) + abs(y * sin(o));
    header_width = tan(header_angle) * header_height;
    
    all_w = header_width*2 +  header_extend;
    
    prism2(header_lenght, header_width ,header_height, header_extend);
    //translate([0, (all_w / 2) - b/2, (header_height / 2) - (b/2)])
       // rotate([-header_angle, 0, 0])
        //    cube([header_lenght, header_extend, header_height]);
}