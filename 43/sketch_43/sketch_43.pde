import peasy.*;
import peasy.org.apache.commons.math.*;
import peasy.org.apache.commons.math.geometry.*;
PeasyCam cam;
PShape bot;
PImage img;
int smallPoint;
int largePoint;
int x, y;
int pointillize = 40;

void setup() {
 // cam = new PeasyCam(this, 0, 0, 0, 50);
  frameRate(120);
  size(707, 1000, P3D);
  // imageMode(CENTER);
  background(255);
  img = loadImage("gameboy1.png");
  smallPoint = 4;
  largePoint = 40;
  noFill();
 
  // The file "bot1.svg" must be in the data folder
  // of the current sketch to load successfully
  bot = loadShape("gameboy.svg");
  strokeWeight(5);
  loadPixels();
 //image(img, 0,0);
} 

void draw() {
  // background(1, 39, 99);
/*
  color pix=color(255, 255, 255, 10);
  x = int(random(width));
  y = int(random(height));

  pix = img.get(x, y);

  println(pix);
     image(img, width/2-50, height/2-25);
  if (pix !=0)
  {
    stroke(pix, 128);
    rect(x, y, 40, 40);
  }
    pix = img.get(width/2-50, width/2-50);
     stroke(pix, 128);
     fill(pix);
     rect( width/2-50,  700, 40, 40);

  //shape(bot, 110, 90, 100, 100);  // Draw at coordinate (110, 90) at size 100 x 100
  // shape(bot, 80, 40);            // Draw at coordinate (280, 40) at the default size
  */
  // Pick a random point
  int x = int(random(img.width));
  int y = int(random(img.height));
  int loc = x + y*img.width;
  pointillize =int( random (16, 60));
  // Look up the RGB color in the source image
  loadPixels();
  float r = red(img.pixels[loc]);
  float g = green(img.pixels[loc]);
  float b = blue(img.pixels[loc]);
 // noStroke();
  strokeWeight(5);
  if ((r!=255)&&(b!=255)&&(g!=255))
  {
    stroke(r,g,b,100);
    fill(r,g,b,50);
    pushMatrix();
   // translate(0,0, random(200));
  rect(x+50,y+25,pointillize,pointillize);
  popMatrix();
  }
  // Draw an ellipse at that location with that color

}

void keyPressed(){
if (key == ' ')
saveFrame("######.jpg");
background(255);
}
