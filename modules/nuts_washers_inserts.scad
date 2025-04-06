//////////////////////////////////////////////////////////////
//    NUTS / WASHERS / INSERTS (Top View + Side View)      //
//////////////////////////////////////////////////////////////
module standard_Nut(width, height, vertical_offset = 2.5) {
    translate([-2.5, vertical_offset, height]) {
        // top view
        difference() {    
            cylinder(h=text_height, d=5, $fn=6);
            cylinder(h=text_height, d=3);
        }
        // side view
        translate([4, -2.5, 0])
            cube([2.8, 5, text_height]);
    }
}

module lock_Nut(width, height, vertical_offset = 2.5) {
    translate([-2.5, vertical_offset, height]) {
        // top view
        difference() {    
            cylinder(h=text_height, d=5, $fn=6);
            cylinder(h=text_height, d=3);
        }
        // side view
        translate([4, -2.5, 0])
            cube([2.8, 5, text_height]);

        translate([4, -2, 0])
            cube([3.5, 4, text_height]);
    }
}

module standard_washer(width, height, vertical_offset = 2.5) {
    translate([-1.5, vertical_offset, height]) {
        // top view
        difference() {
            cylinder(h=text_height, d=5);
            cylinder(h=text_height, d=3);
        }
        // side view
        translate([4, -2.5, 0])
            cube([1, 5, text_height]);
    }
}

module spring_washer(width, height, vertical_offset = 2.5) {
    translate([-1.5, vertical_offset, height]) {
        // top view (split ring)
        difference() {
            cylinder(h=text_height, d=5);
            cylinder(h=text_height, d=3);
            cube([5, 0.8, text_height]);
        }
        // side view
        translate([4, -2.5, 0])
            cube([1, 5, text_height]);
    }
}

module Heat_Set_Inserts(hardware_length, width, height, vertical_offset = 2.5) {
    translate([-4, vertical_offset, height]) {
        // top view
        difference() {
            union() {
                cylinder(h=text_height, r=2.5, $fn=5);
                rotate(36) cylinder(h=text_height, r=2.5, $fn=5);
            }
            cylinder(h=text_height, r=1.5, $fn=80);
        }
        // side pattern
        translate([4, -2, 0])    cube([1, 4, text_height]);
        translate([5, -2.5, 0])  cube([2, 5, text_height]);
        translate([7, -2, 0])    cube([1, 4, text_height]);
        translate([8, -2.5, 0])  cube([2, 5, text_height]);
    }
}

module Wall_Anchor(hardware_length, width, height, vertical_offset = 2.5) {
    translate([-4, vertical_offset, height]) {
        difference() {
            // 1) The main geometry, combined via union()
            union() {
                // The extruded polygons
                linear_extrude(height = text_height)
                    translate([-2,  0, 0])
                    polygon(points=[[0,2],[-2,1],[-2,-1],[0,-2]], paths=[[0,1,2,3]]);
                linear_extrude(height = text_height)
                    translate([-0.5, 0, 0])
                    polygon(points=[[0,2],[-1.5,1.5],[-1.5,-1.5],[0,-2]], paths=[[0,1,2,3]]);
                linear_extrude(height = text_height)
                    translate([1,    0, 0])
                    polygon(points=[[0,2],[-1.5,1.5],[-1.5,-1.5],[0,-2]], paths=[[0,1,2,3]]);
                linear_extrude(height = text_height)
                    translate([2.5,  0, 0])
                    polygon(points=[[0,2],[-1.5,1.5],[-1.5,-1.5],[0,-2]], paths=[[0,1,2,3]]);
                linear_extrude(height = text_height)
                    translate([4,    0, 0])
                    polygon(points=[[0,2],[-1.5,1.5],[-1.5,-1.5],[0,-2]], paths=[[0,1,2,3]]);

                // A couple more cubes for shape
                translate([4, -1.5, 0])
                    cube([7, 3, text_height]);
                translate([11, -2, 0])
                    cube([1, 4, text_height]);
            }

            // 2) The cutting object: this is subtracted (removed) from the union above
            translate([-4, -0.25, 0])
                cube([10, 0.5, 3]);
        }
    }
}
