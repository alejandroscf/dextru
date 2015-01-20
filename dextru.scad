//include <MCAD/math.scad>
//use <MCAD/motors.scad>
//mm_per_inch=25.4;


fary_largo=70; //FIXME!
filamento_diametro=3;
filamento_margen=1;

//Hobbed mini-hyena
hobbed_fuer_d=12.4;
hobbed_surco_d=10;
hobbed_dentro_d=5;
hobbed_ancho=10;
hobbed_ancho_base=7.3;

rodamiento_int_d=8;
rodamiento_ext_d=7+8+7;
rodamiento_ancho=7;

//Extrusor
bolt_hole_distance = 31;
bolt_diameter=4;
shaft_diameter=23+1;
extruder_bolt_margen=7;
extruder_largo=bolt_hole_distance+2*extruder_bolt_margen;
extruder_alto=extruder_largo;
extruder_ancho=8;

//Idler
idler_margen=1;
idler_redondeo=3;

idler_ancho=22;
idler_alto=extruder_alto-idler_margen;
idler_largo=15;

	//Bisagra idler
	bisagra_largo=extruder_largo/2;
	bisagra_alto=(extruder_alto-shaft_diameter)/2;
	bisagra_ancho=idler_ancho/2+idler_margen+extruder_ancho;
	//bisagra_x_offset=extruder_largo/2;
	
	//Bloque guia (idler fijo)
	guia_margen=2;
	guia_largo=extruder_largo/2+hobbed_surco_d/2+filamento_diametro+guia_margen;
	guia_alto=extruder_alto;
	guia_ancho=idler_ancho+idler_margen+extruder_ancho;

idler_largo_exceso=5;

idler_max_largo_izquierda=extruder_largo/2-(hobbed_surco_d/2+filamento_diametro+guia_margen);
//idler_largo=extruder_largo/2-(hobbed_surco_d/2+filamento_diametro+guia_margen)-idler_margen+idler_largo_exceso;

idler_bolt_margen=5;



//Apoyo hotend
base_largo=80;
base_alto=15;
base_ancho=40;
  //Tornillos fary
  t_fary_d=4+1;
  t_fary_separacion=50;
  //Tornillos anclaje
  t_anclaje_d=3+1;
  t_anclaje_separacion=50;
  t_anclaje_desfase=0;
  

//Motor virtual
//translate([(base_largo-extruder_largo)/2,base_ancho,base_alto-0.01]) translate([extruder_largo/2,0,extruder_largo/2]) rotate([90,0,0]) stepper_motor_mount(17);

difference() {
union() {
//Extrusor
  translate([(base_largo-extruder_largo)/2,base_ancho,base_alto-0.01]){
    difference(){
      union(){
        //Ancalje motor
        color("red") translate([0,-extruder_ancho,0]) cube([extruder_largo,extruder_ancho,extruder_alto]);
        
        //Bloque guia (idler fijo)
        color("red") translate([0,-guia_ancho,0]) difference() {
          cube([guia_largo,guia_ancho,guia_alto]);
          //Rebaje hobbed-idler
          translate([extruder_largo/2,-500,extruder_alto/2-shaft_diameter/2]) cube([1000,1000,shaft_diameter]);
          //Rebaje tornillo abajo
          translate([-0.01,-500,0]) cube([extruder_bolt_margen+4,1000,extruder_bolt_margen+4]);

          //Rebaje tornillo arriba
          translate([-0.01,-500,extruder_alto-(extruder_bolt_margen+4)+0.01]) cube([extruder_bolt_margen+4,1000,extruder_bolt_margen+4]);
        }

        //Bisagra idler
        *color("red") translate([extruder_largo-bisagra_largo,-bisagra_ancho,0]) union() {
          cube([bisagra_largo,bisagra_ancho,bisagra_alto]);
          translate([bisagra_largo,0,0]) rotate([90,0,0]) cylinder(r=bisagra_alto-extruder_bolt_margen, h=1000, center=true);
        }

        //Idler
        color("blue") translate(
          [ extruder_largo-idler_max_largo_izquierda+idler_margen,
            -idler_ancho-extruder_ancho-idler_margen,
            idler_margen
          ]) difference() {
          union() {
             //Prisma
	          translate([0,0,idler_largo/2]) cube([idler_largo,idler_ancho,idler_alto-idler_largo/2]);
             //Cilindro
	          translate([idler_largo/2,idler_ancho/2,idler_largo/2]) rotate([90,0,0]) cylinder(d=idler_largo, h=idler_ancho, center=true);
	       }
          //Resta bloque bisagra FIXME 
          translate([-1,idler_ancho/2,-idler_margen])
            cube([idler_largo-3, idler_ancho/2+0.01, bisagra_alto+idler_redondeo]);

          //Tornillo(s) de apriete
          translate([0,idler_bolt_margen,idler_alto-idler_bolt_margen]) 
            rotate([0,-90,0]) cylinder(d=t_fary_d, h=1000, center=true);

          //Tornillo eje FIXME!

          

          //Agujero rodamiento
          translate([rodamiento_ext_d/2-guia_margen-idler_margen-filamento_diametro,idler_ancho/2,extruder_alto/2]) 
            rotate([90,0,0]) cylinder(d=rodamiento_ext_d+1, h=rodamiento_ancho,center=true);

          //Eje rodamiento
          translate([rodamiento_ext_d/2-guia_margen-idler_margen-filamento_diametro,0,extruder_alto/2-idler_margen]) 
            rotate([90,0,0]) cylinder(d=rodamiento_int_d-0.2, h=1000, center=true);
          
          translate([-100+rodamiento_ext_d/2-guia_margen-idler_margen-filamento_diametro,-50,extruder_alto/2-idler_margen-7.8/2]) 
            cube([100,100,7.8]);
        }
      }

      //Tornillos motor
      translate([extruder_bolt_margen,0,extruder_bolt_margen]) rotate([90,0,0]) cylinder(d=bolt_diameter, h=1000, center=true);

      *translate([extruder_bolt_margen+bolt_hole_distance,0,extruder_bolt_margen]) rotate([90,0,0]) cylinder(d=bolt_diameter, h=1000, center=true);

      translate([extruder_bolt_margen,0,extruder_bolt_margen+bolt_hole_distance]) rotate([90,0,0]) cylinder(d=bolt_diameter, h=1000, center=true);

      translate([extruder_bolt_margen+bolt_hole_distance,0,extruder_bolt_margen+bolt_hole_distance]) rotate([90,0,0]) cylinder(d=bolt_diameter, h=1000, center=true);


      //Agujero shaft
      translate([extruder_largo/2,0,extruder_alto/2]) rotate([90,0,0]) cylinder(d=shaft_diameter, h=1000, center=true);

      //Tornillo(s) de apriete
      translate(
          [ extruder_largo-idler_largo,
            -idler_ancho-extruder_ancho-idler_margen,
            idler_margen
          ])
        translate([0,idler_bolt_margen,idler_alto-idler_bolt_margen]) 
          rotate([0,-90,0]) cylinder(d=t_fary_d, h=1000, center=true);

    }
  }

//Apoyo hotend
  difference() {
    cube([base_largo,base_ancho,base_alto]);
    
  //Tornillos ancalaje
    translate([base_largo/2-t_anclaje_separacion/2+t_anclaje_desfase,0,base_alto/2]) rotate([90,0,0]) cylinder(d=t_anclaje_d, h=1000, center=true);

    translate([base_largo/2+t_anclaje_separacion/2+t_anclaje_desfase,0,base_alto/2]) rotate([90,0,0]) cylinder(d=t_anclaje_d, h=1000, center=true);    
  }
}

  //Tornillos fary
translate([base_largo/2+hobbed_surco_d/2+filamento_diametro/2-t_fary_separacion/2,base_ancho/2,base_alto/2]) cylinder(d=t_fary_d, h=1000, center=true);

translate([base_largo/2+hobbed_surco_d/2+filamento_diametro/2+t_fary_separacion/2,base_ancho/2,base_alto/2]) cylinder(d=t_fary_d, h=1000, center=true);

//Agujero filamento
translate([base_largo/2+hobbed_surco_d/2+filamento_diametro/2,base_ancho-base_ancho/2,0]) 
  cylinder(d=filamento_diametro+filamento_margen, h=1000, center=true);

}