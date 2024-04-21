$fn = 128;

optical_disc_size = 120.00;
optical_disc_hole = 15.0;

tolerance = 0.50;
base_h = 4.00;
h = 80;

linear_extrude(base_h)
    circle(optical_disc_size / 2  + tolerance);

linear_extrude(base_h + h)
    circle(optical_disc_hole / 2  - tolerance);