void setup(){
size(707,1000);
}
float x=180.1;
 void draw(){
   smooth();
if((x<360)&&(x>180)){x+=3;}
pushMatrix();
translate(width/2,height/2);// bring zero point to the center 
strokeWeight(5);
stroke(0);
int n = 7;
for(int i=0; i<n; i++){
  int[] t = {3,5,9,2,4,6,7};
  int radius = 50*(i+1);

//pol obwodu PI*50*(i+1)
float circ = 180/t[i];
float len = circ-random(10,30);
float cl = circ - len;
for (int j=0; j<t[i]; j++){
  if(x>180+(circ*(j))&&(x<180+(cl*(j+1))))
point (sin(radians(x))*radius,cos(radians(x))*radius);
}



stroke(255);

//point (sin(radians(x))*50,cos(radians(x))*25);//<ellipse
}
popMatrix();


}