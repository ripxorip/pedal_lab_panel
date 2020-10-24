$fa = 1;
$fs = 0.4;
$fn = 100;

jack_diameter = 10.50;
jack_margin = 10.00;

potentiometer_diameter = 12;
potentiometer_margin = 10;

switch_diameter = 6;
switch_margin = 8;
switch_right_margin = 15;

num_potentiometers = 3;
num_switches = 2;
num_jacks = 2;

breadboard_width = 175;
breadboard_overlap = 10;
breadboard_feet_height = 3.00; // Shall match the rubber feet

panel_depth = 5.00;
panel_height = 35;
hole_height = 23;
panel_diameter = 15.00;

panel_sides_margin = 10.00;

footswitch_diameter = 13;

socket_height = 12;
socket_depth = 15;
socket_width = 20;

screw_thickness = 6.0;
screw_cap_width = 9.0;
screw_length = 2.00;

module sub_wall()
{
    rotate([90, 0,0 ])
        union()
        {
            translate([-breadboard_width/2 + panel_diameter/2, panel_height-panel_diameter/2, 0])
                cylinder(d=panel_diameter, h=panel_depth, center=true);
            translate([-breadboard_width/2 + panel_diameter/2, panel_diameter/2, 0])
                cube([panel_diameter, panel_diameter, panel_depth], center=true);
        }
}

module wall()
{
    hull () {
        sub_wall();
        mirror([1, 0, 0]) sub_wall();
    }
}

module switch_slots()
{
    for (i = [0:num_switches-1])
    {
        rotate([90, 0, 0])
            translate([-footswitch_diameter/2-switch_diameter/2-switch_right_margin-i*(switch_diameter+switch_margin), hole_height, 0])
                cylinder(d=switch_diameter, h=panel_depth*2, center=true);
    }
}

module jack_slots()
{
    for (i = [0:num_jacks-1])
    {
        rotate([90, 0, 0])
            translate([-breadboard_width/2+panel_sides_margin+i*(jack_diameter+jack_margin), hole_height, 0])
                cylinder(d=jack_diameter, h=panel_depth*2, center=true);
    }
}

module potentiometer_slots()
{
    for (i = [0:num_potentiometers-1])
    {
        rotate([90, 0, 0])
            translate([breadboard_width/2-panel_sides_margin-i*(potentiometer_diameter+potentiometer_margin), hole_height, 0])
                cylinder(d=potentiometer_diameter, h=panel_depth*2, center=true);
    }
}

module footswitch_slot()
{
    rotate([90, 0, 0])
            translate([0, hole_height, 0])
                cylinder(d=footswitch_diameter, h=panel_depth*2, center=true);
}

module socket_bulk()
{
    rotate([0, 90, 0])
        translate([-socket_height, 0, 0])
            linear_extrude(height=socket_width, center=true)
                polygon([[0,0], [socket_height,0], [socket_height,socket_depth]]);
}

module screw_socket()
{
    difference()
    {
        socket_bulk();
        translate([0, socket_depth/2, 0])
            cylinder(d=screw_thickness, h=panel_height*2, center=true);
        translate([0, socket_depth/2, screw_length])
            cylinder(d=screw_cap_width, h=panel_height);
    }
}

/* Main constructions */
union()
{
    difference()
    {
        wall();
        jack_slots();
        potentiometer_slots();
        footswitch_slot();
        switch_slots();
    }
    for (i = [0:2])
    {
        translate([-breadboard_width/2+socket_width/2+ i*((breadboard_width/2)-(socket_width/2)), panel_depth/2])
            screw_socket();
    }
}
