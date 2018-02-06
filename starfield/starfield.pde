Star[] stars = new Star[800];

//variable "speed" - speed of stars.
float speed, bx, by;
float xOffset = 0.0; 
float yOffset = 0.0; 

void setup() {
  colorMode(HSB);
  size(600, 600);
  bx = width/2.0;
  by = height/2.0;

  for (int i = 0; i < stars.length; i++) {
    stars[i] = new Star();
  }
}

void draw() {

  speed = map(mouseX, 0, width, 0, 50);
  background(0);
  translate(width/2, height/2);
  for (int i = 0; i < stars.length; i++) {
    stars[i].update();
    stars[i].show();
  }
}