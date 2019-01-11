import peasy.*; //<>// //<>// //<>// //<>// //<>// //<>//
Wall3D wall;
PeasyCam cam;
void setup() {
  float depth =1800;
  cam = new PeasyCam(this, width/2, height/2, depth/2, depth*1.25); //generate the camera
  size(707, 1000, P3D);
  noFill();
  wall = new Wall3D(210,5,5);
  setupCamera();
}
void draw() {
  background(200);
  String[] a = {"Ach", "to", "nie", "było", "warte"};
  pushMatrix();
      wall.drawBricks(a, 0);
      popMatrix();
      pushMatrix();
String[] b = {"Jakżesz", "ja", "się", "uspokoję"};
    translate(0,0,75);
    wall.drawBricks(b, 0);
    popMatrix();
          pushMatrix();
String[] c = {"O", "jasna", "gwiazdo", "gdybym", "mógł", "jak", "ty", "wisieć" };
    translate(0,0,150);
    wall.drawBricks(c, 0);
    popMatrix();
  


  rotateCamera();
}
void setupCamera() {

  cam.rotateY(radians(90));
  cam.rotateZ(radians(-90));
}

void rotateCamera() {
  cam.rotateY(radians(1));
}
