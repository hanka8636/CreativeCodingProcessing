class Okrag
{
  int allSpaces= 0;
  int space = 0;
  float rad = 0;
String[] text;
  Okrag(String[] text, float rad) {
    this.text = text;
    this.rad = rad;
  }
  Okrag() {
  }

  void countSpaces(int a) {
    for (int w=0; w<text.length; w++) {
      allSpaces = a - (text[w].length());
    }
    space = int(random(a/(text.length-1)-10,a/(text.length-1)));
  }

  float drawCircle(int i) {
    float radius = rad*(i+1);
      int e =270;
      int b=0;
      for (int j=0; j<text.length; j++) {

        if (j==0)
        b = e;
        
        else
         b= b- space;
         //        if((b>89)&&(e<271)){
                   
                   
        e=b-text[j].length();
        if (j==text.length-1){
        e=b+text[j].length();
        arc(width, height/2, radius, radius, radians(b),radians(e));
      }
      else
        arc(width, height/2, radius, radius, radians(e),radians(b));
        println(text[j] + " b" + b + " e"+e +"space "+space);
        
      //  }
      }
      e=270; b=0;
      arc(width/2+100, height/2, radius-15, radius-15, radians(270),radians(263));
      return radius;
    }
  }
