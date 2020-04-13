PImage img;
int smallPoint, largePoint;
int angle = 0;

void setup() {
  size(1280, 720);
  img = loadImage("maxresdefault.jpg");
  smallPoint = 4;
  largePoint = 40;
  imageMode(CENTER);
  noStroke();
  background(255);
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
    pointillize = random(smallPoint, largePoint);
    x = mouseX;
    println("mousex" +x);
    y = mouseY;
    pix = img.get(x, y);
    fill(pix, 128);
    ellipse(x, y, pointillize, pointillize);

    for (int a = 0; a < 100; a++)  {
      float xoff = random(a) * val;
      float yoff = random(a) * val;
      pix = img.get(mouseX+(int)xoff, mouseY+(int)yoff);
      fill(pix, 128);
      rect(mouseX + xoff, mouseY + yoff, val, val);
    }
  }
}
