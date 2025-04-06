/////////////////////////////////////////////
// Custom label generator by Laurens Guijt //
/////////////////////////////////////////////

include <modules/label_base_shape.scad> // label base shape
include <modules/bolts_screws.scad> // bolts, screws, nuts, washers, etc.
include <modules/label_text.scad> // text generation


//////////////////////////////////////////////////////////////
//                   BATCH LABEL DATA                      //
//////////////////////////////////////////////////////////////

batch_label_data = [
    ["Dome head bolt", "M2", 8],
    ["Dome head bolt", "M2", 12],
    ["Dome head bolt", "M2", 16],
    ["Dome head bolt", "M2", 20],
    ["Dome head bolt", "M3", 8],
    ["Dome head bolt", "M3", 12],
    ["Dome head bolt", "M3", 16],
    ["Dome head bolt", "M3", 20],
    ["Dome head bolt", "M4", 8],
    ["Dome head bolt", "M4", 12],
    ["Dome head bolt", "M4", 16],
    ["Dome head bolt", "M4", 20],
    ["Dome head bolt", "M5", 8],
    ["Dome head bolt", "M5", 12],
    ["Dome head bolt", "M5", 16],
    ["Dome head bolt", "M5", 20],
    ["Standard nut", "M2", 0],
    ["Standard nut", "M3", 0],
    ["Standard nut", "M4", 0],
    ["Standard nut", "M5", 0],
    ["Standard washer", "M2", 0],
    ["Standard washer", "M3", 0],
    ["Standard washer", "M4", 0],
    ["Standard washer", "M5", 0],
];


/* [Part customization] */
Type = "Bolt"; // [Nut, Washer, Insert, Bolt, Wood Screw]
Head_Shape = "Hex"; // [Hex, Round, Pan, Dome, Flat, Socket, Flat, Lock]
Driver = "None" ; // [Phillips, Flathead, Hex, Allen, Torx]

Hardware_Units = "Metric"; // [Metric, SAE, Fractional]
Hardware_Diameter = "4";  // free text, e.g. "1/4-20", "#8-32"
Hardware_Length = 24;

/* [Label customization] */
Y_Units       = 1;          // [1,2,3]
Label_Color   = "#000000";  // color
Content_Color = "#FFFFFF";  // color

/* [Text customization] */

// Font type
TEXT_FONT = "Noto Sans SC:Noto Sans China"; // [HarmonyOS Sans, Inter, Inter Tight, Lora, Merriweather Sans, Montserrat, Noto Sans, Noto Sans SC:Noto Sans China, Noto Sans KR, Noto Emoji, Nunito, Nunito Sans, Open Sans, Open Sans Condensed, Oswald, Playfair Display, Plus Jakarta Sans, Raleway, Roboto, Roboto Condensed, Roboto Flex, Roboto Mono, Roboto Serif, Roboto Slab, Rubik, Source Sans 3, Ubuntu Sans, Ubuntu Sans Mono, Work Sans]
// Font Style
FONT_STYLE = "Bold"; // [Regular,Black,Bold,ExtraBol,ExtraLight,Light,Medium,SemiBold,Thin,Italic,Black Italic,Bold Italic,ExtraBold Italic,ExtraLight Italic,Light Italic,Medium Italic,SemiBold Italic,Thin Italic]
// Flush text requires an AMS
TEXT_TYPE  = "Raised Text";                  // [Raised Text, Flush Text]
//Font size
TEXT_SIZE  = 4.2;

/* [Batch exporter] */
// Enable this feature if you want generate a lot of different labels at once.
// In the code editor on the left side edit the batch_label_data to the parts desired.
// Make sure to type the names the same as the dropdowns above
Batch_Export = false; // false

/* [Settings for nerds] */
width    = 11.5;
height   = 0.8;
radius   = 0.9;
champfer = 0.2;
$fs      = 0.1;
$fa      = 5;

/* [Hidden] */
Font        = str(TEXT_FONT, ":style=", FONT_STYLE);
length      = getDimensions(Y_Units);
text_height = (TEXT_TYPE == "Raised Text") ? 0.2 : 0.01;


//////////////////////////////////////////////////////////////
//               MAIN SWITCH: Single vs. Batch             //
//////////////////////////////////////////////////////////////
if (batch_export) {
    generate_multiple_labels();
} else {
    label(
        length          = length, 
        width           = width, 
        height          = height,
        radius          = radius,
        champfer        = champfer,
        Component       = Component,
        diameter        = diameter,
        hardware_length = hardware_length
    );
}

//////////////////////////////////////////////////////////////
//               Dimension Helper Function                 //
//////////////////////////////////////////////////////////////
function getDimensions(Y_Units) =
    (Y_Units == 1) ? 35.8 :
    (Y_Units == 2) ? 77.8 :
    (Y_Units == 3) ? 119.8 :
    0;


//////////////////////////////////////////////////////////////
//            BATCH LABEL GENERATION (Multiple)            //
//////////////////////////////////////////////////////////////
module generate_multiple_labels() {
    columns           = 3;              
    horizontal_offset = length + 3;     
    vertical_offset   = 12;            

    for (i = [0 : len(batch_label_data) - 1]) {
        label_parameters = batch_label_data[i];
        
        row = i / columns;
        col = i % columns;
        
        translate([col * horizontal_offset, row * -vertical_offset, 0]) {
            label(
                length          = length, 
                width           = width, 
                height          = height,
                radius          = radius,
                champfer        = champfer,
                Component       = label_parameters[0],
                diameter        = label_parameters[1],
                hardware_length = label_parameters[2]
            );
        }
    }
}


//////////////////////////////////////////////////////////////
//         MAIN LABEL MODULE (base + icons/text)           //
//////////////////////////////////////////////////////////////
module label(length, width, height, radius, champfer, Component, diameter, hardware_length) {
    color(Label_Color) {
        difference() {
            labelbase(length, width, height, radius, champfer);

            // holes at each side
            translate([(length - 1)/2, 0, 0])
                cylinder(h=height+1, d=1.5, center=true);

            translate([(-length + 1)/2, 0, 0])
                cylinder(h=height+1, d=1.5, center=true);
        }
    }
    color(Content_Color) {
        choose_Part_version(Component, hardware_length, width, height, diameter);
    }
}


//////////////////////////////////////////////////////////////
//           DISPATCH: Which Part Icon to Draw?            //
//////////////////////////////////////////////////////////////
module choose_Part_version(Part_version, hardware_length, width, height, diameter) {
    if (Part_version == "Socket head bolt") {
        Socket_head(hardware_length, width, height);
        bolt_text(diameter, hardware_length, height);

    } else if (Part_version == "Torx head bolt") {
        Torx_head(hardware_length, width, height);
        bolt_text(diameter, hardware_length, height);

    } else if (Part_version == "Countersunk Torx head bolt") {
        Countersunk_Torx_head(hardware_length, width, height);
        bolt_text(diameter, hardware_length, height);

    } else if (Part_version == "Hex head bolt") {
        Hex_head(hardware_length, width, height);
        bolt_text(diameter, hardware_length, height);

    } else if (Part_version == "Flat Head countersunk") {
        Countersunk_socket_head(hardware_length, width, height);
        bolt_text(diameter, hardware_length, height);

    } else if (Part_version == "Dome head bolt") {
        Dome_head(hardware_length, width, height);
        bolt_text(diameter, hardware_length, height);

    } else if (Part_version == "phillips head bolt") {
        Phillips_head(hardware_length, width, height);
        bolt_text(diameter, hardware_length, height);

    } else if (Part_version == "Phillips head countersunk") {
        Phillips_head_countersunk(hardware_length, width, height);
        bolt_text(diameter, hardware_length, height);

    } else if (Part_version == "Standard washer") {
        standard_washer(width, height);
        washer_text(diameter, height);

    } else if (Part_version == "Spring washer") {
        spring_washer(width, height);
        washer_text(diameter, height);

    } else if (Part_version == "Standard nut") {
        standard_Nut(width, height);
        nut_text(diameter, height);

    } else if (Part_version == "Lock nut") {
        lock_Nut(width, height);
        nut_text(diameter, height);

    } else if (Part_version == "Heat set inserts") {
        Heat_Set_Inserts(hardware_length, width, height);
        bolt_text(diameter, hardware_length, height);
    } else if (Part_version == "Wall Anchor") {
        Wall_Anchor(hardware_length, width, height);
        bolt_text(diameter, hardware_length, height);

    } else if (Part_version == "phillips wood screw") {
        Phillips_Wood_Screw(hardware_length, width, height);
        bolt_text(diameter, hardware_length, height);

    } else if (Part_version == "Torx wood screw") {
        Torx_Wood_Screw(hardware_length, width, height);
        bolt_text(diameter, hardware_length, height);
    }
}
