class Bricks
{

  int sum= 0;
  int space = 0;
  float rad = 0;
String[] text;
  Bricks(String[] text, float rad) {
    this.text = text;
    this.rad = rad;
  }
  Bricks() {
  }

  void countSum(){
    for (int w=0; w<text.length; w++) {
      sum += text[w].length();
    }
  }

  void drawBricks(int i) {
      float  y = 160;
        int current = 0;
     for (int j=0; j<text.length; j++) {
      current+=text[j].length();
      float c = map(current, 1, sum, 0, width);
    //  y = map(text.length/2, 1, text.length+15, 0, height);
      // strokeWeight(t[i]);
      stroke(140,255,80);
      strokeWeight(4);
      line(c, i*rad, c, rad*(i+1));
      stroke(140,255,160);
      strokeWeight(1.5);
      line(c, i*rad, c, rad*(i+1));
    }
    sum=0;
    current =0;
    stroke(140,255,80);
    strokeWeight(4);
    line(0, rad*i, width, rad*i);
    stroke(140,255,160);
    strokeWeight(1.5);
    line(0, rad*i, width, rad*i);
  }
  

  }
