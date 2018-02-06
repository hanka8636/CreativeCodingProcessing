//r(beta) = 0.8 + 1.6 * sin(6 * beta)
//theta(beta) = 2 * beta
//phi(beta) = 0.6 * pi * sin(12 * beta)
float angle = 0.0;
ArrayList<PVector> vectors = new ArrayList<PVector>();
float beta = 0; 
color c = color(random(255),255,255);
void setup(){
size(1000,1000, P3D);
colorMode(HSB);
}

void draw(){

 
background(0);
translate(width/2, height/2);


 rotateY(angle);
 angle += 0.01;

/*
  float r = 100 * ( 0.8 + 1.6 * sin(6 * beta));
  float theta = 2 * beta;
  float phi = 0.6 * PI * sin(12 * beta);
*/  
/*
  float r = 240 * 0.6 * sin(0.5 * PI + 6 * beta);
  float theta = 4 * beta;
  float phi = 0.2 * PI * sin(6 * beta);

  float x = r * cos(phi) * cos(theta);
  float y = r * cos(phi) * sin(theta);
  float z = r * sin(phi);
 */ 

  float t = random(2);
  t = 1.5;
  float x = 10*(cos(beta) + cos(3*beta)) + cos(2*beta) + cos(4*beta); 
  float y = 6*sin(beta) + 10*sin(3*beta) ;
  float z = 4*sin(3*beta)*sin(5*beta / 2) + 4*sin(4*t) - 2*sin(6*beta) ;

  //float k=1; // see Trefoil Knot.
  //float k=2;
  // where 0 < u < (4 k + 2) pi
 //float u = 2.1;
  //float x = cos(u)*(2 - cos(2*u/(2*k + 1)));
  //float y = sin(u)*( 2 - cos(2*u/(2*k + 1)));
  //float z = -sin(2*u/(2*k + 1));
  
 // float u = 0.1;
 // float x = 41*cos(u) - 18*sin(u) - 83*cos(2*u) - 83*sin(2*u) - 11*cos(3*u) + 27*sin(3*u);
  //float y = 36*cos(u) + 27*sin(u) - 113*cos(2*u) + 30*sin(2*u) + 11*cos(3*u) - 27*sin(3*u);
 // float z = 45*sin(u) - 30*cos(2*u) + 113*sin(2*u) - 11*cos(3*u) + 27*sin(3*u);
//where 0 < u < 2 pi
  
  stroke(c);
  vectors.add(new PVector(20*x, 20*y, 20*z));
  //vectors.add(new PVector(x, y, z));
  beta += 0.01;
  //u += 0.01;
noFill();
stroke (255);
strokeWeight(6);
//rect(width/2, height/2,40,40);
beginShape();
for (PVector v : vectors) 
{
 float d = v.mag();   
 stroke(d, d, 255);
  vertex(v.x, v.y, v.z);

}
endShape();
 
}


void keyPressed(){
  if(keyCode == 32){
    saveFrame("knot-####.jpg");
  }
  }