class Particle {
  float x; 
  float y;
  float vx;
  float vy;
  float alpha;

  Particle() {

    x = mouseX;
    y = mouseY;
    vx =  random(-1, 1);
    vy = random(-5 -1);
    alpha = 255;
  }

  boolean  finished() {
    return alpha < 0;
  }

  void update() {
    x += vx;
    y += vy;
    alpha -=5;
  }

  void show() {
    noStroke();
    fill(255, alpha);
    ellipse(x, y, 16, 16);
  }
}
