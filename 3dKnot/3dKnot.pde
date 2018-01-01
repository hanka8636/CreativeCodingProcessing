//r(beta) = 0.8 + 1.6 * sin(6 * beta)
//theta(beta) = 2 * beta
//phi(beta) = 0.6 * pi * sin(12 * beta)
float angle = 0.0;
ArrayList<PVector> vectors = new ArrayList<PVector>();
float beta = 0; 

void setup(){
size(1000,1000, P3D);
}

void draw(){

 
background(0);
translate(width/2, height/2);


 rotateY(angle);
 angle += 0.01;


  float r = 100 * ( 0.8 + 1.6 * sin(6 * beta));
  float theta = 2 * beta;
  float phi = 0.6 * PI * sin(12 * beta);
  
  float x = r * cos(phi) * cos(theta);
  float y = r * cos(phi) * sin(theta);
  float z = r * sin(phi);
  stroke(255, r, 255);
  vectors.add(new PVector(x, y, z));
  beta += 0.01;
  
noFill();
stroke (255);
strokeWeight(4);
beginShape();
for (PVector v : vectors) 
{
 float d = v.mag();   
 stroke(d, d, 255);
  vertex(v.x, v.y, v.z);
}
endShape();
  

}