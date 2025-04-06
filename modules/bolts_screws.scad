//////////////////////////////////////////////////////////////
//            BOLT ICONS (Top View + Side View)            //
//////////////////////////////////////////////////////////////

module machineScrew(hardware_length, width, height, head_type, driver, vertical_offset = 2.5) {
    display_length = (hardware_length > 20) ? 20 : hardware_length;
    translate([-display_length/2 - 2, vertical_offset, height]) {
        // top view
        difference() {
            cylinder(h=text_height, d=5);
            cylinder(h=text_height, r=1.6, $fn=6);
        }
        // side view
        translate([3, -2.5, 0])
            cube([4, 5, text_height]);

        // stem
        drawBoltStem(hardware_length, text_height, [7, -1.25, 0]);
    }
}


///////////////////////////////////////////////////////////////////////
//                  TOP VIEW + SIDE VIEW BOLT ICONS                  //
///////////////////////////////////////////////////////////////////////

module _topView(head_shape, driver, vertical_offset = 2.5) {

    if (head_shape == "Hex") {
        difference() {
            cylinder(h=text_height, d=5);
            translate([-0.5, -2, 0])
                cube([1, 4, text_height]);
            translate([-2, -0.5, 0])
                cube([4, 1, text_height]);
        }
    } else if (head_shape == "Round") {
        
    } else if (head_shape == "Pan") {
        
    } else if (head_shape == "Dome") {
        
    } else if (head_shape == "Flat") {
        
    } else if (head_shape == "Socket") {
        
    } else if (head_shape == "Lock") {
        
    } 
}










// "drawBoltStem" for typical bolts/screws
module drawBoltStem(hardware_length, text_height, start=[7, -1.25, 0], thickness=2.5) {
    // The max length scales with Y_Units; e.g. Y_Units=1 => 20, Y_Units=2 => 40, etc.
    maxLen = 20 * Y_Units;

    // Final length is either the actual hardware_length or the scaled maxLen
    finalLen = (hardware_length > maxLen) ? maxLen : hardware_length;

    if (hardware_length > maxLen) {
        // For bolts exceeding maxLen, show a "split" icon
        gapBetween    = 2;  // small gap to indicate it's a longer bolt
        segmentLength = (finalLen - gapBetween) / 2;  // split finalLen into two segments

        // First partial segment
        translate(start)
            cube([segmentLength, thickness, text_height]);

        // Second partial segment
        translate([
            start[0] + segmentLength + gapBetween, 
            start[1], 
            start[2]
        ])
            cube([segmentLength, thickness, text_height]);

    } else {
        // If the bolt length is <= maxLen, draw one solid stem
        translate(start)
            cube([finalLen, thickness, text_height]);
    }
}

// Torx star shape for top view
module Torx_star(points, point_len, height=2, rnd=0.1) {
    fn=25;
    point_deg = 360 / points;
    point_deg_adjusted = point_deg + (-point_deg / 2);

    for (i = [0 : points - 1]) {
        rotate([0, 0, i * point_deg])
        translate([0, -point_len, 0])
            point(point_deg_adjusted, point_len, rnd, height, fn);
    }  
    
    module point(deg, leng, rnd, height, fn=25) {
    hull() {
        cylinder(height, d=rnd, $fn=fn); // Base cylinder at the center
        rotate([0, 0, -deg / 2])
            translate([0, leng, 0]) cylinder(height, d=rnd); // Left edge
        rotate([0, 0, deg / 2])
            translate([0, leng, 0]) cylinder(height, d=rnd); // Right edge
    }
}
}


// Torx head bolt
module Torx_head(hardware_length, width, height, vertical_offset = 2.5) {
    display_length = (hardware_length > 20) ? 20 : hardware_length;
    translate([-display_length/2 - 2, vertical_offset, height]) {
        // top view
        difference() {
            cylinder(h=text_height, d=5);
            Torx_star(6, 2, height=2, rnd=0.1);
        }
        // side view
        translate([3, -2.5, 0])
            cube([4, 5, text_height]);

        // stem
        drawBoltStem(hardware_length, text_height, [7, -1.25, 0]);
    }
}

// Countersunk Torx
module Countersunk_Torx_head(hardware_length, width, height, vertical_offset = 2.5) {
    display_length = (hardware_length > 20) ? 20 : hardware_length;
    translate([-display_length/2 - 2, vertical_offset, height]) {
        // top view
        difference() {
            cylinder(h=text_height, d=5);
            Torx_star(6, 2, height=2, rnd=0.1);
        }
        // countersunk side
        translate([6.6, 0, 0])
            cylinder(r=3, h=text_height, $fn=3);

        // stem
        drawBoltStem(hardware_length, text_height, [7, -1.25, 0]);
    }
}

// Socket head
module Socket_head(hardware_length, width, height, vertical_offset = 2.5) {
    display_length = (hardware_length > 20) ? 20 : hardware_length;
    translate([-display_length/2 - 2, vertical_offset, height]) {
        // top view
        difference() {
            cylinder(h=text_height, d=5);
            cylinder(h=text_height, r=1.6, $fn=6);
        }
        // side view
        translate([3, -2.5, 0])
            cube([4, 5, text_height]);

        // stem
        drawBoltStem(hardware_length, text_height, [7, -1.25, 0]);
    }
}

// Hex head
module Hex_head(hardware_length, width, height, vertical_offset = 2.5) {
    display_length = (hardware_length > 20) ? 20 : hardware_length;
    translate([-display_length/2 - 2, vertical_offset, height]) {
        // top view
        cylinder(h=text_height, d=5, $fn=6);
        // side view
        translate([3, -2.5, 0])
            cube([3, 5, text_height]);

        // stem
        drawBoltStem(hardware_length, text_height, [6, -1.25, 0]);
    }
}

// Countersunk socket head
module Countersunk_socket_head(hardware_length, width, height, vertical_offset = 2.5) {
    display_length = (hardware_length > 20) ? 20 : hardware_length;
    translate([-display_length/2 - 2, vertical_offset, height]) {
        // top view
        difference() {
            cylinder(h=text_height, d=5);
            cylinder(h=text_height, r=1.6, $fn=6);
        }
        // countersunk side
        translate([5, 0, 0])
            cylinder(r=3, h=text_height, $fn=3);

        // stem
        drawBoltStem(hardware_length, text_height, [5, -1.25, 0]);
    }
}

// Dome head
module Dome_head(hardware_length, width, height, vertical_offset = 2.5) {
    display_length = (hardware_length > 20) ? 20 : hardware_length;
    translate([-display_length/2 - 2, vertical_offset, height]) {
        // top view
        difference() {
            cylinder(h=text_height, d=5);
            cylinder(h=text_height, r=1.6, $fn=6);
        }
        // side view
        translate([6, 0, 0]) {
            difference() {
                cylinder(h=text_height, d=5);
                translate([0, -2.5, 0])
                    cube([4, 5, text_height]);
            }
        }
        // stem
        drawBoltStem(hardware_length, text_height, [6, -1.25, 0]);
    }
}

// Phillips head
module Phillips_head(hardware_length, width, height, vertical_offset = 2.5) {
    display_length = (hardware_length > 20) ? 20 : hardware_length;
    translate([-display_length/2 - 2, vertical_offset, height]) {
        // top view
        difference() {
            cylinder(h=text_height, d=5);
            translate([-0.5, -2, 0])
                cube([1, 4, text_height]);
            translate([-2, -0.5, 0])
                cube([4, 1, text_height]);
        }
        // side view
        translate([6, 0, 0]) {
            difference() {
                cylinder(h=text_height, d=5);
                translate([0, -2.5, 0])
                    cube([4, 5, text_height]);
            }
        }
        // stem
        drawBoltStem(hardware_length, text_height, [6, -1.25, 0]);
    }
}

// Phillips countersunk
module Phillips_head_countersunk(hardware_length, width, height, vertical_offset = 2.5) {
    display_length = (hardware_length > 20) ? 20 : hardware_length;
    translate([-display_length/2 - 2, vertical_offset, height]) {
        // top view
        difference() {
            cylinder(h=text_height, d=5);
            translate([-0.5, -2, 0])
                cube([1, 4, text_height]);
            translate([-2, -0.5, 0])
                cube([4, 1, text_height]);
        }
        // countersunk side
        translate([5, 0, 0])
            cylinder(r=3, h=text_height, $fn=3);

        // stem
        drawBoltStem(hardware_length, text_height, [5, -1.25, 0]);
    }
}


//Philips wood screw 
module Phillips_Wood_Screw(hardware_length, width, height, vertical_offset = 2.5) {
    // We'll place everything in "real" X after we clamp a final stem length
    display_length = (hardware_length > 20) ? 20 : hardware_length;
    
    // The start of the main stem
    stemStart = [5, -1.25, 0];

    // We want to shorten the actual stem by 1.5 for the tip
    // Then clamp it to the same maxLen logic used in drawBoltStem
    maxLen    = 20 * Y_Units;
    rawStem   = hardware_length - 1.5;  
    finalStem = (rawStem > maxLen) ? maxLen : rawStem;
    
    translate([-display_length/2 - 2, vertical_offset, height]) {
        // Head (top view)
        difference() {
            cylinder(h=text_height, d=5);
            // Phillips "plus"
            translate([-0.5, -2, 0]) cube([1, 4, text_height]);
            translate([-2, -0.5, 0]) cube([4, 1, text_height]);
        }

        // Countersunk side
        translate([5, 0, 0])
            cylinder(r=3, h=text_height, $fn=3);

        // Draw the stem with the same logic as drawBoltStem,
        // but using finalStem (the "shortened" length).
        // That means if rawStem is still bigger than maxLen,
        // it will be split within the function as well.
        drawBoltStem(rawStem, text_height, stemStart);

        // Place the tip exactly at the end of the final stem, not the full hardware_length
        translate([stemStart[0] + finalStem, 0, 0]) {
            linear_extrude(height=text_height)
                polygon(
                    points = [[0, 1.25],[2, 0],[0, -1.25]],
                    paths  = [[0, 1, 2]]
                );
        }
    }
}

//Torx wood screw 
module Torx_Wood_Screw(hardware_length, width, height, vertical_offset = 2.5) {
    // We'll place everything in "real" X after we clamp a final stem length
    display_length = (hardware_length > 20) ? 20 : hardware_length;
    
    // The start of the main stem
    stemStart = [5, -1.25, 0];

    // We want to shorten the actual stem by 1.5 for the tip
    // Then clamp it to the same maxLen logic used in drawBoltStem
    maxLen    = 20 * Y_Units;
    rawStem   = hardware_length - 1.5;  
    finalStem = (rawStem > maxLen) ? maxLen : rawStem;
    
    translate([-display_length/2 - 2, vertical_offset, height]) {
        // top view (torx head)
        difference() {
            cylinder(h=text_height, d=5);
            Torx_star(6, 2, height=2, rnd=0.1);
        }

        // Countersunk side
        translate([5, 0, 0])
            cylinder(r=3, h=text_height, $fn=3);

        // Main stem (shortened by 1.5). We pass 'rawStem' so drawBoltStem can do the split if needed.
        drawBoltStem(rawStem, text_height, stemStart);

        // Place tip exactly at the end of that final stem
        translate([stemStart[0] + finalStem, 0, 0]) {
            linear_extrude(height=text_height)
                polygon(
                    points = [[0,  1.25],[2, 0],[0, -1.25]],
                    paths  = [[0, 1, 2]]
                );
        }
    }
}

