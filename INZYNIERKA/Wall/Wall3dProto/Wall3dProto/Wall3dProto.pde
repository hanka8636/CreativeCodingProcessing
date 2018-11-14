import peasy.*; //<>// //<>// //<>//
PeasyCam cam;
void setup() {
  size(800, 800, P3D);
  noFill();
  float depth =1800;
  cam = new PeasyCam(this, width/2, height/2, depth/2, depth*1.25); //generate the camera
  cam.rotateY(radians(90));
  cam.rotateZ(radians(-90));
}
void draw() {
  background(200);
  String[] a = {"Ach", "to", "nie", "było", "warte"};
  drawBricks(a);
  //rotateX(radians(15));
  //rotateY(radians(30));
  //rotateZ(radians(90));

  //x -  dlugosc slowa
pushMatrix();
  translate(0, 0, 600); 
  box(100, 50, 75);
  translate(80, 0, 0); 
  box(60, 50, 75);
    translate(40, 0, 0); 
  box(75, 50, 75);
  popMatrix();

  cam.rotateY(radians(1));
}

void drawBricks(String[] a) {
  float d = width/a.length;
  translate(width/a.length, height/2, 0); 
  int prevX = 0;
  int x =0;

  for (int i =0; i<a.length; i++) {
   // fill(50*i);
  // strokeWeight(1+i);
   // pushMatrix();
//   min+((max-min)/2)
 //<>//
    int as = a[i].length();
    x=a[i].length()*30; //<>//
        translate(prevX+((x-prevX)/2), 0, 0);
    box(x, 50, 75);
    //rresetMatrix();
   // popMatrix(); //<>//
    prevX=x;
  }
}
