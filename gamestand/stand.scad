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