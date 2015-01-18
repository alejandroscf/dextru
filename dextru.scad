include <MCAD/math.scad>
use <MCAD/motors.scad>

fary_largo=70; //FIXME!

//Extrusor
bolt_hole_distance = 1.220*mm_per_inch;
bolt_diameter=4;
shaft_diameter=1.725*mm_per_inch/2+1;
extruder_bolt_margen=3.5*2;
extruder_largo=bolt_hole_distance+2*extruder_bolt_margen;
extruder_alto=extruder_largo;
extruder_ancho=8;

//Apoyo hotend
base_largo=fary_largo*1.1;
base_alto=15;
base_ancho=40;
  //Tornillos fary
  t_fary_d=4+1;
  t_fary_separacion=50;
  //Tornillos anclaje
  t_anclaje_d=3+1;
  t_anclaje_separacion=50;
  t_anclaje_desfase=8;
  

//Motor virtual
#translate([(base_largo-extruder_largo)/2,base_ancho,base_alto-0.01]) translate([extruder_largo/2,0,extruder_largo/2]) rotate([90,0,0]) stepper_motor_mount(17);

union() {
//Extrusor
  color("red") translate([(base_largo-extruder_largo)/2,base_ancho-extruder_ancho,base_alto-0.01]){
    difference(){
      cube([extruder_largo,extruder_ancho,extruder_alto]);

      //Tornillos motor
      translate([extruder_bolt_margen,0,extruder_bolt_margen]) rotate([90,0,0]) cylinder(d=bolt_diameter, h=1000, center=true);

      translate([extruder_bolt_margen+bolt_hole_distance,0,extruder_bolt_margen]) rotate([90,0,0]) cylinder(d=bolt_diameter, h=1000, center=true);

      translate([extruder_bolt_margen,0,extruder_bolt_margen+bolt_hole_distance]) rotate([90,0,0]) cylinder(d=bolt_diameter, h=1000, center=true);

      translate([extruder_bolt_margen+bolt_hole_distance,0,extruder_bolt_margen+bolt_hole_distance]) rotate([90,0,0]) cylinder(d=bolt_diameter, h=1000, center=true);


      //Agujero shaft
      translate([extruder_largo/2,0,extruder_largo/2]) rotate([90,0,0]) cylinder(d=shaft_diameter, h=1000, center=true);

    }
  }

//Apoyo hotend
  difference() {
    cube([base_largo,base_ancho,base_alto]);

  //Tornillos fary
    translate([base_largo/2-t_fary_separacion/2,base_ancho/2,base_alto/2]) cylinder(d=t_fary_d, h=1000, center=true);

    translate([base_largo/2+t_fary_separacion/2,base_ancho/2,base_alto/2]) cylinder(d=t_fary_d, h=1000, center=true);

    
  //Tornillos ancalaje
    translate([base_largo/2-t_anclaje_separacion/2+t_anclaje_desfase,0,base_alto/2]) rotate([90,0,0]) cylinder(d=t_anclaje_d, h=1000, center=true);

    translate([base_largo/2+t_anclaje_separacion/2+t_anclaje_desfase,0,base_alto/2]) rotate([90,0,0]) cylinder(d=t_anclaje_d, h=1000, center=true);    
  }
}