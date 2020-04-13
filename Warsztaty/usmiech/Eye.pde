class Eye {
  float x = 250, y =250;
  float radius;
  int steps = 20;
  float stepX;
  float stepY;
  Eye(float radius) {
    this.radius = radius;
  }
  void move(float xEnd, float yEnd) {
    calculateStep(xEnd, yEnd);
    if ((x>xEnd)&&(y>yEnd)) {
      x -=stepX;
      y -=stepY;
      println("X "+x+" Y "+y);
    }
    if ((x<xEnd)&&(y>yEnd)) {
      x +=stepX;
      y -=stepY;
      println("X "+x+" Y "+y);
    }
  }
  void calculateStep(float xEnd, float yEnd) {
    if (x<xEnd)
      stepX = (xEnd-x)/steps; 
    if (x>xEnd)
      stepX = (x-xEnd)/steps; 
    stepY = (y-yEnd)/steps;
  }

  void drawEye() {
    noStroke();
    fill(0, 0, 0);
    ellipse(x, y, radius, radius);
  }
}
