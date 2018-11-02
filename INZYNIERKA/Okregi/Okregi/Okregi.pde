void setup() {
  size(707, 1000);
  background(0);
}
float x=180.1;
void draw() {
  smooth();
  noLoop();
 noFill();
  strokeWeight(5);
  stroke(255);
  int n = 3;
    //float cl = circ - len; //dlugosc slowa
    int a = 180;
    float prevA=180;
    int allSpaces= 0;
      int[] t = {3, 5, 9, 2, 4, 6, 7};
for (int i=0; i<t.length; i++) {
  
  int[] tab = new int[t[i]];
  println(t[i]+": " );
for(int w=0; w<t[i]; w++){
tab[w]=int(random(1,15));
print(tab[w]+" " );
 allSpaces = a - (20*tab[w]);
}
println();
    int radius = 20*(i+1);
    int e =90;
     int b=0;
int space = a/(t[i]-1);
      for (int j=0; j<t[i]; j++) {
        if (j==0)
        b = e;
        else
         b= e+ space;
        e=b+tab[j];
        
        arc(width-10, height/2, radius*(i+1), radius*(i+1), radians(b),radians(e));

      }
    }

    stroke(255);

    //point (sin(radians(x))*50,cos(radians(x))*25);//<ellipse
  
/*
        arc(width-20, height/2,160, 160, radians(90),radians(270));
        arc(width-20, height/2,90, 90, radians(180),radians(185));
        arc(width-20, height/2,90, 90, radians(185+50),radians(247));
        arc(width-20, height/2,90, 90, radians(297),radians(307));
        arc(width-20, height/2,90, 90, radians(357),radians(360));
  
*/

}
