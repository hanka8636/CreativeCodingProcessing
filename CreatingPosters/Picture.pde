class Picture {
  void drawPict() {
    rect(30, height/2, 400, 400);
  }

  void drawSplatter() {
    fill(180, 0, 115);
    float drip = int (random(5));
    //ellipse(mouseX, mouseY, drip, drip); 
    if (frameCount % 30 ==0)
    {
      drawCircles(width/2, height/2, 130, 13);

    }
   
  }

  void drawCircles(float x, float y, int radius, int level)
  {
    noStroke();
    float tt = 126 * level / 6.0; 
    fill (tt, 0, 116);
    ellipse(x, y, radius*2, radius*2);
    if (level > 1) {
      level = level - 1;
      int num = int (random(2, 5));
      for (int i=0; i<num; i++) { 
        float a = random(0, TWO_PI);
        float nx = x + cos(a) * 6.0 * level; 
        float ny = y + sin(a) * 6.0 * level; 
        drawCircles(nx, ny, radius/2, level);
      }
    }
  }
}