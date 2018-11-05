class Futura{
  int radius = 0;
  int[] versesL;
  int maxVerL = 0;
  int[] mostCommon;
  Futura(String[] verses){
    
  }
  Futura(int[] versesL, int[] mostCommon){
   
    this.versesL = versesL;
    this.mostCommon = mostCommon;
  }
void futura(){
  noFill();
  stroke(255);
  int randX = int(random(-150, 150));
   int randY = int(random(-350, 450));
  pushMatrix();
  translate(randX, randY);
  strokeWeight(versesL.length);
  ellipse(width/2, height/2, int(0.5*radius), int(0.5*radius));
  
  for (int i=0; i<versesL.length; i++){
    pushMatrix();
    translate(width/2, height/2);
    rotate(radians(random(360)));
    strokeWeight(int(0.05*versesL[i]));
    ellipse(0, 0, int(radius*0.5), versesL[i]);
    popMatrix();
  }
  popMatrix();
}

void radSetup(){
  for (int i = 0; i<versesL.length; i++){
    if(versesL[i] > maxVerL)
    maxVerL = versesL[i];
  }
  radius = 3 * maxVerL;
  
}
void drawMostCommon(){
  fill(255);
  noStroke();
  for(int i=0; i<5; i++){
    ellipse(int(random(width-100)), int(random(height-100)), mostCommon[i]*2, mostCommon[i]*2);
  }
}
}
