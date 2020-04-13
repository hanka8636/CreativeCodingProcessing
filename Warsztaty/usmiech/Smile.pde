class Smile {
  float x = 250, y =250;
  float radius;
  int steps = 20;
  float step;
  Smile(float radius) {
    this.radius = radius;
  }
  void scaleS(float rad) {
    calculateStep(rad);
    if (radius<rad) {
      radius +=step;
      println("X "+x+" Y "+y);
    }

  }
  void calculateStep(float rad) {

      step = (rad-radius)/steps; 
  }

  void drawSmile() {
   noFill();
  stroke(0);
  strokeWeight(20);
    arc(250, 250, radius, radius, 0, PI);
  }
 
}
