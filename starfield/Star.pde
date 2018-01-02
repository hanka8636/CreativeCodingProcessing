class Star {
  float x;
  float y;
  float z;

  float pz;
  float py;

  Star() {
    x = random(-width/2, width/2);
    y = random(-height/2, height/2);
    z = random(width/2);
    pz = z;
  }

  void update () {
    z= z-speed;
    if (z<1)
    {
      z = width/2;
      x = random(-width/2, width/2);
      y = random(-height/2, height/2);
      pz = z;
    }
  }

  void show () {
    fill( random(255), 255, 255, 255);
    noStroke();

    float sx = map(x/z, 0, 1, 0, width/2);
    float sy = map(y/z, 0, 1, 0, height/2);
    float r = map(z, 0, width/2, 16, 0);
    ellipse(sx, sy, r, r);

    float px = map(x/pz, 0, 1, 0, width/2);
    float py = map(y/pz, 0, 1, 0, height/2);
    pz = z;
    stroke( random(255), 100, 100, 255);
    line(px, py, sx, sy);
  }

  void mouseDragged() {

    x = mouseX-xOffset; 
    y = mouseY-yOffset;
  }

  void mousePressed() {
    xOffset = mouseX-x; 
    yOffset = mouseY-y;
  }
}