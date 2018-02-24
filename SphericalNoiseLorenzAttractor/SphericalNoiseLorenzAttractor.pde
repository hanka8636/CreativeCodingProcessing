import peasy.*;
import peasy.org.apache.commons.math.*;
import peasy.org.apache.commons.math.geometry.*;

//http://paulbourke.net/fractals/lorenz/

float x = 0.01;
float y = 0;
float z = 0;

float a = 10;
float b = 28;
float c = 8.0/3.0;

ArrayList<PVector> points = new ArrayList<PVector>();

PeasyCam cam;

void setup(){
size(800, 800, P3D);
colorMode(HSB);
cam = new PeasyCam(this, 500);
background(0);
}

void draw(){
  float dt = 0.01;
  float dx  = (a * (y - x))*dt;
  float dy  = (x * (b - z)-y)*dt;
  float dz  = (x * y - c * z)*dt;
  
  x = x + dx;
  y = y + dy;
  z = z + dz;
  points.add(new PVector(x, y, z));
    translate(0, 0, -80);
 // translate(width/2, height/2);
  scale(5);
  stroke(255);
  noFill();
  
  float hu = 0;
  
  //beginShape();
  for (PVector v : points){
    smooth();
    
    strokeWeight(0.5);
    stroke(hu, 255, 255);
    point(v.x, v.y, v.z);
   // PVector offset = PVector.random3D();
    //offset.mult(0.1);
   // v.add(offset);
    hu += 0.1;
    if (hu > 255){
      hu = 0;
    }
    
  }
  //endShape();

}

void keyPressed(){
  if(keyCode == 32){
    saveFrame("lorenz-####.jpg");
  }
  }