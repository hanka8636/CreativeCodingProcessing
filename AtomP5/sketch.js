var attractor;
var particle;

function setup() {
  createCanvas(400, 400);
  particle = new Particle(200, 100);
  attractor = createVector(200, 200);
   background(51);
  
}

function draw() {
 
  stroke(255);
  strokeWeight(1);
  point(attractor.x, attractor.y);
  // particle.update();
  particle.attracted(attractor);
  particle.update();
  particle.show();
}