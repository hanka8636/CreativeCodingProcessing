float oldAngle=-100, oldDist, pas;
int  n=3; 
boolean see=false;
        
        color c = color(random(255),255,255,50);
        
void setup() {
  colorMode(HSB);
  size(600, 600);
  pas=TWO_PI/n; 
  background(0);//strokeWeight(5);
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
        stroke(c);
        fill(c);
           stroke(c);
  line(mouseX, mouseY, cos(an+a)*d, sin(an+a)*d);
        //line(cos(oldAngle+a)*oldDist, sin(oldAngle+a)*oldDist, cos(an+a)*d, sin(an+a)*d);
        // rect(cos(oldAngle+a)*oldDist, sin(oldAngle+a)*oldDist, cos(an+a)*d, sin(an+a)*d);
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

void drawShape(){
int shapeNumber = (int)random(5);
if (shapeNumber == 0)
{
   stroke(c);
  line(mouseX, mouseY, 5, 5);
}

}

void keyReleased() {
  if (key=='+') {
    n++;
  } else if (key=='-') {
    n--;
  } else if (keyCode==10) { 
    background(255);
  }
    n=constrain(n, 1, 200);
    pas=TWO_PI/n;
}