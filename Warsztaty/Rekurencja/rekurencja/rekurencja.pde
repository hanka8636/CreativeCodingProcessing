void setup() {
  size(1000, 1000);
}

void draw() {
  frameRate(5);
  rectMode(CENTER);
  background(0);
  stroke(255);
  noFill();
  drawRect(width/2, height/2, 400);
  noLoop();
}

void drawRect(float x, float y, float d) {
  rect(x, y, d, d);
  if (d > 2) {
    float newD =0.5* d;// * random(0.25, 0.75);
    drawRect(x + newD, y, newD);
    // drawRect(x - newD, y, newD);
    //  drawRect(x, y + newD, newD);
    // drawRect(x, y - newD, newD);
  }
}
