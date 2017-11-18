float oldAngle=-100, oldDist, pas;
int  n=3; 
boolean see=false;
        
        color c = color(random(255),255,255,50);
        
void setup() {
  colorMode(HSB);
  size(600, 600);
  pas=TWO_PI/n; 
  background(0);//
  strokeWeight(2.5);
}

void draw() {
  if (mousePressed) { 
    float an=atan2(mouseY-height/2, mouseX-width/2); 
    float d=dist(mouseX, mouseY, width/2, height/2); 
    if (oldAngle != -100) {
       translate(width/2, height/2);
      for (float a=0; a<TWO_PI; a+=pas) {
        //fill(255);
c = color(random(255),255,255,50);

  drawShape(an, d, a);
    }
    }
    oldAngle = an;
    oldDist=d; 
 } else {
  oldAngle=-100;
 }
}

 

void mousePressed() { 
  oldAngle=atan2(mouseY-height/2, mouseX-width/2); 
  oldDist=dist(mouseX, mouseY, width/2, height/2);
}

void drawShape( float an,  float d,  float a){
int shapeNumber = (int)random(5);
if (shapeNumber == 0)
{
    stroke(c);
line(cos(oldAngle+a)*oldDist, sin(oldAngle+a)*oldDist, cos(an+a)*d, sin(an+a)*d);

}

else if (shapeNumber == 1)
{
    noStroke();
    fill(c);
rect(cos(oldAngle+a)*oldDist, sin(oldAngle+a)*oldDist, cos(an+a)*d, sin(an+a)*d);
}

else if (shapeNumber == 2)
{
    noStroke();
    fill(c);
ellipse(cos(oldAngle+a)*oldDist, sin(oldAngle+a)*oldDist, cos(an+a)*d, sin(an+a)*d);
}

else if (shapeNumber == 3)
{
    noStroke();
    fill(c);
triangle(cos(oldAngle+a)*oldDist, sin(oldAngle+a)*oldDist, sin(oldAngle-a)*oldDist*10, cos(oldAngle-a)*oldDist*10, cos(an+a)*d*2, sin(an+a)*d*4);
}

else if (shapeNumber == 4)
{
    noStroke();
    fill(c);
quad(cos(oldAngle+a)*oldDist*.2, sin(oldAngle+a)*oldDist*.2, -sin(oldAngle-a)*oldDist*.2, -cos(oldAngle-a)*oldDist*.2, cos(an+a)*d*.2, sin(an+a)*d*.4, -cos(an+a)*d*.2, -sin(an+a)*d*.4);
}

}

void keyReleased() {
  if (key=='+') {
    n++;
  } else if (key=='-') {
    n--;
  } else if (key=='c') { 
    background(0);
  }
    n=constrain(n, 1, 200);
    pas=TWO_PI/n;
}