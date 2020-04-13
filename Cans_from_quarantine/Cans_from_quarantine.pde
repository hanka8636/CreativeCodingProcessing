static XML xml;

 Can can = null;
int col;
void setup() {
  colorMode(HSB);
  rectMode(CENTER);
  size(2048,2048);
  xml = loadXML("cans.xml");
 Can[] cans;
 XMLparser parser= new XMLparser();

  can =parser.parseFirst(can);
   col =can.getBgColor();
  println(col);
  background(col, 100,200);
  can.readSVGBean();
  can.drawCan(); //<>//
  }
  void draw(){}
  
  void mousePressed(){
     col =can.getBgColor();
      background(col, 100,200);
   can.drawCan();
  }
  
  void keyPressed(){
  if (key == ' ')
  saveFrame("########.png");
  }
  
 
