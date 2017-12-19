
PImage img;
int smallPoint, largePoint;
int angle = 0;

void setup() {
  size(1500, 1000);
  img = loadImage("2.jpg");
  smallPoint = 4;
  largePoint = 40;
  imageMode(CENTER);
  noStroke();
  background(1,59,82);
}

void draw() { 
  //background(255,255,255,10);
  int x=0;
  int y=0;
  color pix=color(255, 255, 255, 10);
  float pointillize=0.0f;
  float val = 0.0f;
  if (mousePressed) {

    angle += 5;
    val = cos(radians(angle)) * 30.0;
    // float pointillize = map(mouseX, 0, width, smallPoint, largePoint);
    pointillize = random(smallPoint, largePoint);
    x = mouseX;
    println("mousex" +x);
    y = mouseY;
    pix = img.get(x, y);
    fill(pix, 128);
   // ellipse(x, y, pointillize, pointillize);

    for (int a = 0; a < 360; a += 135) {
      float xoff = cos(radians(a)) * val;
      float yoff = sin(radians(a)) * val;
      pix = img.get(mouseX+(int)xoff, mouseY+(int)yoff);
      fill(pix, 128);
      rect(mouseX + xoff, mouseY + yoff, val, val);
    }
  }

  for (int i = 50; i <= 250; i +=100) {
    x = mouseX+i;
    y = mouseY-i;
    pix = img.get(x, mouseY);
    fill(pix, 128);
  //  ellipse(x, y, pointillize, pointillize);
    for (int a = 0; a < 360; a += 135) {
      float xoff = cos(radians(a)) * val;
      float yoff = sin(radians(a)) * val;
      pix = img.get(x+(int)xoff, y+(int)yoff);
      fill(pix, 128);
      rect(x+ xoff, y + yoff, val, val);
    }
  }
}

void keyPressed(){
  if(keyCode == 32){
    saveFrame("squarism-####.jpg");
  }
  }