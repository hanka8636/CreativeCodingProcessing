float inc = 0.1;
float scl = 10;
int cols, rows;
float zoff = 0;
Particle[] particles;
PVector[] flowField;

void setup()
{
  colorMode(HSB);
  size(960, 960, P2D);
  cols = floor(width / scl);
  rows = floor(height / scl);
  
  particles = new Particle[1000];
  for(int i = 0; i < particles.length; ++i)
    particles[i] = new Particle();
    
  flowField = new PVector[cols * rows];
  
  background(0);
}

void draw()
{
  float yoff = 0;
  for(int y = 0; y < rows; y++) {
    float xoff = 0;
    for(int x = 0; x < cols; x++) {
      // set the vector in the flow field
      int index = x + y * cols; 
      float angle = noise(xoff, yoff, zoff) * TWO_PI * 2;
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
      //particles[i].c = color(random(255),255,255,50);
  }
}

void keyPressed(){
  if(keyCode == 32){
    saveFrame("perlinNoise-####.jpg");
  }
  }