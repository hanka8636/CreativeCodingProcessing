class Particle
{
  constructor(x, y) {
    this.pos = createVector(x, y);
    this.vel = p5.Vector.random2D();
    this.acc = createVector();
  }

  update(){
    this.pos.add(this.vel);
    this.pos.add(this.acc);
   }
   
  show(){
    stroke(255,25);
    strokeWeight(1);
    point(this.pos.x, this.pos.y);
  }
  
  attracted(target){
    // var dir = target - this.pos
    const force = p5.Vector.sub(target, this.pos);
    let d = force.mag();
    d = constrain(d, 1, 25)
    const G = 50;
    const magnitude = G/(d*d);
    force.setMag(magnitude);
    this.acc.add(force);
  }
}