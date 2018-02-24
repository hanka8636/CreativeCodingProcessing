var attractor;
var particles = [];

function setup() {
  createCanvas(400, 400);
  for (var i = 0; i<50; i++){
      particles.push(new Particle(200, 100));
  }

  attractor = createVector(200, 200);
   background(51);
  
}

function draw() {
 
  stroke(255);
  strokeWeight(1);
  point(attractor.x, attractor.y);
  for (var i = 0; i<particles.length; i++){
     var particle = particles[i];
  // particle.update();
  particle.attracted(attractor);
  particle.update();
  particle.show();
  }

}