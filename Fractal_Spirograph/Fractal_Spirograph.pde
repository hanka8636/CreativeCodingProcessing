
void setup(){
  size(800,800);
  background(51);
}

void draw(){
  float r = 100;
  float x  = width/2;
  float y = height/2;

  
stroke(255);
noFill();
ellipse(x, y, r*2, r*2);

float r2 = r/2;
float x2 =  x + r + r2;

ellipse(x2, y, r2*2, r2*2);
}