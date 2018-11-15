class RectVers {
  float rWidth; //srednia dlugosc wersu w slowach
  float rHeight; //liczba linijek w strofie
  int x; 
  int y;
  float[] similarity; //wymiar similarity to liczba zwrotek
  RectVers(int len, int x, int y, float rWidth, float rHeight) {
    this.rWidth = rWidth;
    this.rHeight = rHeight;
    this.x = x;
    this.y = y;
    similarity = new float[len];
  }
  
    RectVers(int len, float rWidth, float rHeight) {
    this.rWidth = rWidth;
    this.rHeight = rHeight;
    similarity = new float[len];
  }
  
    RectVers(int len, float rWidth) {
    this.rWidth = rWidth;
    similarity = new float[len];
  }
  
  //sprowadzenie podobienstwa tylko do tablicy wspolczynnikami w liczbie rownej zliczonym wersom, jest bardzo mało adekwatne i uproszczone, ale niech na razie bedzie
  void setSimilarity(int i, float sim){
  similarity[i] = sim;
  }
  
  void setX(int x){
    this.x = x;
  
  }
  
}
