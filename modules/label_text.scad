//////////////////////////////////////////////////////////////
//                       TEXT MODULES                      //
//////////////////////////////////////////////////////////////
module bolt_text(diameter, Length, height) {
    translate([0, -3, height])
        linear_extrude(height=text_height)
            text(str(diameter, "x", Length),
                 size   = TEXT_SIZE,
                 font   = Font,
                 valign = "center",
                 halign = "center");
}

module nut_text(diameter, height) {
    translate([0, -3, height])
        linear_extrude(height=text_height)
            text(diameter, 
                 size   = TEXT_SIZE,
                 font   = Font,
                 valign = "center",
                 halign = "center");
}

module washer_text(diameter, height) {
    translate([0, -3, height])
        linear_extrude(height=text_height)
            text(diameter,
                 size   = TEXT_SIZE,
                 font   = Font,
                 valign = "center",
                 halign = "center");
}


