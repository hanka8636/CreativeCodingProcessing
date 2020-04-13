ArrayList<Particle> particles;

void setup() {
  size(1000, 1000);
  particles  =  new ArrayList<Particle>();
  background(0);
}

void draw() {
  //background(0);
  for (int i =0; i<10; i++) {
    if (mousePressed) {
      Particle p = new Particle();
      particles.add(p);
    }
  }
  for (int i = particles.size() - 1; i>=0; i--) {
    Particle p = particles.get(i);
    p.update();
    p.show();
    if (p.finished()) {
      particles.remove(i);
    }
  }
}
