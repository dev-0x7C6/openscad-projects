$fn = 128;

nozzle = 0.4;

mount_r = 70.0 / 2;
mount_wall = nozzle * 8;
mount_h = 60.0;

base_h = 8.00;

module tube_mount_wall() {
    linear_extrude(mount_h)
    difference() {
        circle(mount_r);
        circle(mount_r - mount_wall);
    }
}

module tube_base() {
    difference() {
        linear_extrude(base_h) 
            circle(mount_r);
        cylinder(base_h, 1.5, 3.0);
    }
}

tube_mount_wall();
tube_base();

