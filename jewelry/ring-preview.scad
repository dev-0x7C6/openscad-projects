$fn = 128;


// ring size in poland
ring_size = 20;

// i.e.
// female size: 9
// male size: 20

// height in mm
ring_width = 4.00;

// width
ring_thickness = 1.20;

dia = (ring_size + 40.00) / PI;
echo("dia", dia);
echo("circumference", (dia / 2) * PI * 2)

linear_extrude(ring_width) {
    difference() {
        circle(r = ring_thickness + dia / 2);
        circle(r = dia / 2);
    }
}