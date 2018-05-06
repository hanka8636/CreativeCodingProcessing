class Grid{
  void drawG(){ 
    noFill();
    stroke(255, 255, 255);
    strokeWeight(5);
    translate(0,0);
    rect(width/6,height/6, width/1.5, height/1.5);
    strokeWeight(.05);
  }
  
  void drawTitle(PFont f){
    textFont(f,200);
    fill(255,255,255);
    text("R A N D O M",width/2.5, height/2);
    noFill();
  }
  
   void drawInfo(){
    textSize(32);
    fill(255,255,255);
    text("It's example of random Gaussian",mouseX,mouseY);
    noFill();
  }
  
  void drawDate(){
    textSize(100);
    stroke(255, 255, 255);
    strokeWeight(15);
    fill(255,255,255);
    text("07",100,200);
    text("05",100,300);
    noFill();
    strokeWeight(.05);
  }
}