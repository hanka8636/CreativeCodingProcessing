var attractors = [];
var particles = [];

function setup() {
  createCanvas(900, 900);
  
//  for (var i = 0; i < 50; i++) {
//    particles.push(new Particle(200, 200));
 // }

 // for (var i = 0; i < 10; i++) {
   // attractors.push(createVector(random(width), random(height)));
 // }

  background(51);

}

function mousePressed(){
  attractors.push(createVector(mouseX, mouseY));
}

function draw() {

  stroke(255);
  strokeWeight(3);
    particles.push(new Particle(random(width), random(height)));
    if (particles.length > 100){
      particles.splice(0,1);
    }
    
  for (var i = 0; i < attractors.length; i++) {
    point(attractors[i].x, attractors[i].y);
  }
  
  for (var i = 0; i < particles.length; i++) {
    var particle = particles[i];
    for (var j = 0; j < attractors.length; j++) {
      particle.attracted(attractors[j]);
    }
    particle.update();
    particle.show();
  }

}