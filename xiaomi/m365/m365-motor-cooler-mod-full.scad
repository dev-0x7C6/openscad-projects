// Bartlomiej Burdukiewicz, 11 August 2020
//
// Some parts based on
// Denise Lee, 12 March 2017


$fn = 64;

nozzle = 0.4;

blade_radius = 78;
pitch_angle = 45; //Converting pitch to twist angle for linear extrud
blade_arch = blade_radius/8; // Curvature of blades, selected straight edge or use ARC module 

fan_base = 1.20;
fan_base_blade = 2.00;
fan_height = 9.00;

m365_plate_sockets = 60.00;

m365_motor_plate_height = 8.00;
m365_motor_plate_size = 150.00;

m365_motor_shaft_space_radius = 20.0;

socket_radius = 6.00;

turbine_inner_reinforcement = 5.00;
turbine_outer_reinforcement = 12.00;

turbine_remove_blades = 0; // remove blades to make dent

turbine_height = fan_height;

printer_layer_height = 0.1; //for preview (F5) x20, set this to 0.1 for rendering for export STL(F6)!!!
blade_thickness = 4 * nozzle; //thickness of blade
num_blades = 36;
rotation_dir = 1; //CCW = -1, CW = 1

pi = 3.14159265359;
blade_cirf = 2*pi*blade_radius;
twist_angle = 360*turbine_height/(blade_cirf*tan(pitch_angle));

slicing = turbine_height / printer_layer_height; //equal printing slicing height

module m365_motor_plate() {    
    resize(newsize=[m365_motor_plate_size, m365_motor_plate_size, m365_motor_plate_height]) {
        difference() {
            sphere(r = 10);
            translate([0, 0, 0])
            linear_extrude(10)
                square([20, 20], center = true);
            
            translate([0, 0, -10])
            linear_extrude(1)
                square([20, 20], center = true);
        }
    }
}

module fan_blade() {
    translate([0,-blade_thickness/2])
        mirror([0, rotation_dir == -1 ? 1 : 0, 0])
            arc(blade_radius, blade_thickness, blade_arch); 
}

module fan() {
    linear_extrude(height=turbine_height, center = false, convexity = 10, twist = twist_angle*rotation_dir, slices = slicing)

    for(i=[turbine_remove_blades:num_blades-1])
        rotate((360*i)/num_blades)
            fan_blade();
}


module ring(r = 10, hole = 8) {
    difference() {
        circle(r + hole);
        circle(r);
    }
}

module ring_centred(r = 10, hole = 8) {
    difference() {
        circle(r + hole);
        circle(r - hole);
    }
}

module turbine_base(fan_base = fan_base) {
    linear_extrude(fan_base) {
        ring(m365_motor_shaft_space_radius, turbine_inner_reinforcement);
        ring_centred(m365_plate_sockets, socket_radius);
        ring(m365_motor_plate_size / 2.00 - turbine_outer_reinforcement / 2, turbine_outer_reinforcement / 2);
        ring(m365_motor_plate_size / 2.00 - turbine_outer_reinforcement / 2, turbine_outer_reinforcement / 2);
    }
}


{
    difference() {
        union() {
            fan();
            turbine_base(fan_base);
        }
        
        linear_extrude(fan_height)
            circle(r = m365_motor_shaft_space_radius);
        
        make_socket_holes();
        
        translate([0, 0, fan_height + fan_base_blade])
            m365_motor_plate();
        /*
        linear_extrude(height=turbine_height, center = false, convexity = 10, twist = twist_angle*rotation_dir, slices = slicing)
        for(i=[-15:15])
       // for(i=[-16:312])
            rotate(i)
                fan_blade();
        */
    }
     

    //cylinder(h=10, r1=30.0, r2=75.0);

    difference() {
        make_sockets();
        translate([0, 0, fan_height + fan_base_blade])
                m365_motor_plate();
    }
}

socket_count = 6;

module make_sockets() {
    for(i=[0:socket_count-1])
        rotate((360*i)/socket_count)
            translate([0, m365_plate_sockets])
                socket();
}

module make_socket_holes() {
    for(i=[0:socket_count-1])
        rotate((360*i)/socket_count)
            translate([0, 60])
                linear_extrude(11.0)
                    circle(socket_radius, center = true);
}


module socket(center = true) {
    color([0, 0, 1])
        difference() {
            union() {
                linear_extrude(7.0)
                    circle(socket_radius, center = center);
                
                translate([0, 0, 5.0])
                    linear_extrude(1.0)
                        circle(3.0, center = center);
            }
            
            linear_extrude(4.0)
                circle(r= 4.1, center = center);
            
            linear_extrude(12.0)
                circle(r= 2.1, center = center);
        }
}

//length and breath of inner arc
module arc(length, width, arch_height){
    //r = (l^2 + 4*b^2)/8*b 
    radius = (pow(length,2) + 4*pow(arch_height,2))/(8*arch_height);
    translate([length/2,0,0])
    difference() {
    difference() {
        translate([0,-radius+arch_height,0])
            difference() {
                circle(r=radius+width,$fn=100);
                circle(r=(radius),$fn=100);
            }
        
        translate([-(radius+width),-(radius+width)*2,0,])
            square([(radius+width)*2,(radius+width)*2]);
    }
    union() {
        translate([-length,-arch_height]) 
            square([length/2,arch_height*2]);
        translate([length/2,-arch_height])     
            square([length/2,arch_height*2]);
    }}    
}

