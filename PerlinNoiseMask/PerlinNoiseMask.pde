float inc = 0.51;
float scl = 10;
int cols, rows;
float zoff = 0;
Particle[] particles;
PVector[] flowField;
PImage frog;
void setup()
{
  frog = loadImage("above.jpg");
  size(2000, 1200, P2D);
  cols = floor(width / scl);
  rows = floor(height / scl);
  
  particles = new Particle[2000];
  for(int i = 0; i < particles.length; ++i)
    particles[i] = new Particle();
    
  flowField = new PVector[cols * rows];
  
  background(255);
}

void draw()
{
  float yoff = 0;
  for(int y = 0; y < rows; y++) {
    float xoff = 0;
    for(int x = 0; x < cols; x++) {
      // set the vector in the flow field
      int index = x + y * cols; 
      float angle = noise(xoff, yoff, zoff) * TWO_PI * 4;
      PVector v = PVector.fromAngle(angle);
      v.setMag(1); // set the power of the field on the particle
      flowField[index] = v;
      
      xoff += inc;
    }
    yoff += inc;
    zoff += 0.0003; // rate the flow field changes
  }
  
  // update and draw the particles
  for(int i = 0; i < particles.length; ++i) {
    particles[i].follow(flowField);
    particles[i].update();
    particles[i].show();
  }
}

void keyPressed(){
  if(keyCode == 32){
    saveFrame("perlinMask-####.jpg");
  }
  }