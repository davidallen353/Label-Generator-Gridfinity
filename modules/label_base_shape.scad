//////////////////////////////////////////////////////////////
//                LABEL BASE SHAPE + CHAMFER               //
//////////////////////////////////////////////////////////////
module labelbase(length, width, height, radius, champfer) {
    // Extra perimeter shape
    translate([(-length - 2)/2, -5.7/2, 0]) {
        __shapeWithChampfer(
            length+2, 
            5.7, 
            height, 
            0.2, 
            champfer
        );
    }
    // Main label shape
    translate([(-length)/2, -width/2, 0]) {
        __shapeWithChampfer(
            length, 
            width, 
            height, 
            radius, 
            champfer
        );
    }
}

// shape with top/bottom chamfer
module __shapeWithChampfer(length, width, height, radius, champfer) {
    // bottom chamfer
    translate([0, 0, 0])
        __champfer(length, width, champfer, radius, flip=false);

    // main shape
    translate([0, 0, champfer])
        __shape(length, width, height - 2*champfer, radius);

    // top chamfer
    translate([0, 0, height - champfer])
        __champfer(length, width, champfer, radius, flip=true);
}

// side chamfer
module __champfer(length, width, size, radius, flip=false) {
    r1 = flip ? radius : radius - size;
    r2 = flip ? radius - size : radius;
    hull() {
        translate([radius, radius, 0])
            cylinder(h=size, r1=r1, r2=r2);
        translate([radius, width-radius, 0])
            cylinder(h=size, r1=r1, r2=r2);
        translate([length-radius, width-radius, 0])
            cylinder(h=size, r1=r1, r2=r2);
        translate([length-radius, radius, 0])
            cylinder(h=size, r1=r1, r2=r2);
    }
}

// main shape with rounded corners
module __shape(length, width, height, radius) {
    hull() {
        translate([radius, radius, 0])
            cylinder(h=height, r=radius);
        translate([radius, width-radius, 0])
            cylinder(h=height, r=radius);
        translate([length-radius, width-radius, 0])
            cylinder(h=height, r=radius);
        translate([length-radius, radius, 0])
            cylinder(h=height, r=radius);
    }
}
