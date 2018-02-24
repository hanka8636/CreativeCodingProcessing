function Particle(x,y)
{
  this.pos = createVector(x, y);
  this.vel = p5.Vector.random2D();
   this.acc = createVector();
   
   this.update = function(){
     this.pos.add(this.vel);
     this.pos.add(this.acc);
   }
   
  this.show = function(){
  stroke(255,25);
  strokeWeight(1);
  point(this.pos.x, this.pos.y);
  }
  
  this.attracted = function(target){
    // var dir = target - this.pos
    var force = p5.Vector.sub(target, this.pos);
    var d = force.mag();
    d = constrain(d, 1, 25)
    var G = 50;
    var magnitude = G/(d*d);
    force.setMag(magnitude);
    this.acc.add(force);
  }
}