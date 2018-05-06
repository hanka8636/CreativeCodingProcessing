


float halfWidth, halfHeight;
PFont f;



 Fume f1 = null;
 Fume f2 = null;
 Fume f3 = null;
 Fume f4 = null;
Grid g = new Grid();

/////////////////////////////////////////////////////////////////////////////////////////////////

void setup() {
  f =createFont("Comfortaa Light", 16);
  int size = 1024;
  fullScreen();
  background(0);
  noFill();
  strokeWeight(0.05);
  
  halfWidth = width/2;
  halfHeight = height/2;
  pushMatrix();
   f1 = new Fume(size, .15, 0.25);
f1.setupF(halfWidth,halfWidth);

   f2 = new Fume(size, .15, 0.25);
f2.setupF(-halfWidth,-halfWidth);

  f3 = new Fume(size, .15, 0.25);
f3.setupF(-halfWidth,halfWidth);

   f4 = new Fume(size, .15, 0.25);
f4.setupF(halfWidth,-halfWidth);
popMatrix();
}

/////////////////////////////////////////////////////////////////////////////////////////////////

void draw() {
 f1.drawF();
 f2.drawF();
 f3.drawF();
 f4.drawF();
}

void keyPressed(){
if(keyCode == 32)
saveFrame("nice.#######.png");
if(key =='g')
g. drawG();
if(key =='t')
g. drawTitle(f);
if(key =='i')
g. drawInfo();
if(key =='d')
g. drawDate();
}