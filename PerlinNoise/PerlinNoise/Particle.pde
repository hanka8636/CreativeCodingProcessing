class Particle {
  PVector pos = new PVector(random(width - 1), random(height - 1)); // position
  //PVector pos = new PVector(random(width/2 - 100,width/2 + 100), random(height/2 - 100, height/2+100)); // position
  PVector vel = new PVector(0, 0); // velocity
  PVector acc = new PVector(0, 0); // acceleration
  PVector prevPos = pos.copy(); // previous position
  float maxSpeed = 2;
  //int px= 858/2, py = 536/2;
  public color ct = color(random(255),255,255,25);
   public color c = color(random(255),255,255,75);
  float a = random(200);
  float b = random(200);
  
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
   //  c = color(random(255),255,255,50);
   stroke(c);
    //noStroke();
    strokeWeight(1);
    fill(ct);
    //ellipse(pos.x, pos.y, prevPos.x, prevPos.y);
    //fill(c);
    //rect(pos.x, pos.y, a, b);
    //line(pos.x, pos.y, a, b);
    stroke(c);
    //line(pos.x, pos.y, prevPos.x, prevPos.x);
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