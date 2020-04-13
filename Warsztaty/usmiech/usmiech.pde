Eye eye1; //<>//
Eye eye2;
Smile smile;
int noseColor =0;
boolean check = false;
boolean check2 = false;
void setup() {
  frameRate(24);
  size(500, 500);
  eye1 = new Eye(50);
  eye2 = new Eye(50);
  smile = new Smile(100);
}
void draw() {
  background(150);  
  noStroke();
  if (check2 ==true)
    drawCircl();
  eye1.drawEye();
  eye2.drawEye();

  smile.drawSmile();
  noStroke();
  fill(noseColor, 0, 0);
  ellipse(250, 250, 150, 150); 

  if (check ==true) {
    eye1.move(150, 125);
    eye2.move(350, 125);
    smile.scaleS(350);
  }
}

void mouseClicked() {
  check = !check;
}

void keyPressed() {
  if (key ==' ')
    noseColor += 25;
  if (key =='b')
    check2 = !check2;
}

void drawCircl() {
  float radius = random(50, 150);
  noStroke();
  fill(255);
  ellipse (150, 125, radius, radius);
  ellipse (350, 125, radius, radius);
}
