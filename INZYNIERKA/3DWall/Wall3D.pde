
class Wall3D {
  float brickHeight =75;
  float brickDepth = 100;
  float maxW = 0; 
  
  Wall3D() {
  }
  
    Wall3D(int vl, int words, int countVerces) {
      defineBrickHeight(countVerces);
      defineMaxBrickLength(vl,words);
  }
  
  void  defineBrickHeight(int countVerces) {
    brickHeight=0.7*height/countVerces*2;
  } 
  
  //vl - dlugosc najdluzszego wersu
  //word - dlugosc najdluzszego slowa w tekscie
  //words - liczba slow w najdluzszym wersie w tekscie
  void defineMaxBrickLength(int vl, int words){
  float maxV = map(vl,0, width-200,0, width*2);
   maxW = maxV/words;
  }
  
  float defineBrickLength(int word){
  float brickLength = map(word, 1, 30, 10, maxW*50);
  return brickLength;
  }

  void drawBricks(String[] a, int j) {
    translate(width/a.length, height/2, 0); 
    float prevX = 0;
    int x =0;

    for (int i =0; i<a.length; i++) {
      // fill(50*i);
      // strokeWeight(1+i);
      // pushMatrix();
      //   min+((max-min)/2)
      int b = a[i].length();
    float brickLength = defineBrickLength(b); //<>//

      translate(prevX+((brickLength-prevX)/2), 0, 0);
      box(brickLength, brickDepth, brickHeight);
      //rresetMatrix();
      // popMatrix();
      prevX=brickLength;
    }
  }
}
