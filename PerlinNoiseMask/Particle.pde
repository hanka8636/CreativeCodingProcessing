class Particle {
  //PVector pos = new PVector(random(width - 1), random(height - 1)); // position
  PVector pos = new PVector(random(width/2 - 100,width/2 + 100), random(height/2 - 100, height/2+100)); // position
  PVector vel = new PVector(0, 0); // velocity
  PVector acc = new PVector(0, 0); // acceleration
  PVector prevPos = pos.copy(); // previous position
  float maxSpeed = 2;
  int px= 858/2, py = 536/2;
  void update() {
    // keep current position
    prevPos.x = pos.x; 
    prevPos.y = pos.y; 
    
    // apply acceleration and velocitiy
    vel.add(acc); 
    vel.limit(maxSpeed); // limit velocity
    pos.add(vel); 
    
    // handle window edges
    if(pos.x >= width) pos.x = prevPos.x = 0;
    if(pos.x < 0) pos.x = prevPos.x = width - 1;
    if(pos.y >= height) pos.y = prevPos.y = 0;
    if(pos.y < 0) pos.y = prevPos.y = height - 1;
    
    // reset acceleration
    acc.mult(0); 
  }
  
  void applyForce(PVector force) {
    acc.add(force);
  }
  
  void show() {
    
     color c = frog.get(int(pos.x),int(pos.y));
     int red =(int) r1(c);
     int green =(int) g1(c);
     int blue =(int) b1(c);
     int grey = (int)(red+green+blue)/3;
     //color Color =color(grey,grey,grey);
     stroke(0,grey);
     println(grey);
    //stroke(0,frog.get(int(pos.x),int(pos.y))*(-0.0000005));
    strokeWeight(5);
    line(pos.x, pos.y, prevPos.x, prevPos.y);
  }
  
  void follow(PVector[] flowField) {
    // get the index in the flow field
    int x = floor(pos.x / scl);
    int y = floor(pos.y / scl);
    int index = x + y * cols;
    
    // get the force and apply it
    PVector force = flowField[index];
    applyForce(force);
  }
}

int r1(int kolor)
{
return (kolor & 0x00FF0000) >> 16;
}
int g1(int kolor)
{
return (kolor & 0x0000FF00) >> 8;
}
int b1(int kolor)
{
return kolor & 0x000000FF;
}