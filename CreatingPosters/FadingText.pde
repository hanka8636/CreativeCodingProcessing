class FadingText {
  String txt;
  float alpha;
  float r, g, b, x, y;

  FadingText (String _txt) {
    txt = _txt;
    alpha = 50;
    r = random(125, 255);
    g = random(125, 255);
    b = random(125, 255);

    x = random(0, 1280);
    y = random(100, 720);
  }

  void display() {
    if (frameCount%30 ==0)
    {
          textSize(15);
    noStroke();
    float tt = 126 * 13 / 6.0; 
    fill (tt, 0, 116);
    //fill(r, g, b, alpha);
    text(txt, x, y);
    alpha-=4;// fading speed
   }
    

  }

  boolean isDone() {  
    return alpha < 0;
  }
}