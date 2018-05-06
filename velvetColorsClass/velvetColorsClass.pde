


float halfWidth, halfHeight;




 Fume f1 = null;
 Fume f2 = null;
 Fume f3 = null;
 Fume f4 = null;


/////////////////////////////////////////////////////////////////////////////////////////////////

void setup() {
  int size = 1024;
  fullScreen();
  background(0);
  noFill();
  strokeWeight(0.05);
  
  halfWidth = width/2;
  halfHeight = height/2;
   f1 = new Fume(size);
f1.setupF(halfWidth,halfWidth);

   f2 = new Fume(size);
f2.setupF(-halfWidth,-halfWidth);

  f3 = new Fume(size);
f3.setupF(-halfWidth,halfWidth);

   f4 = new Fume(size);
f4.setupF(halfWidth,-halfWidth);

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
}