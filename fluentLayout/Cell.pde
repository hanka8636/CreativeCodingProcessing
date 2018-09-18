class Cell{
  float x;
  float y;
  float cWidth;
  float cHeight;
  int r= 0, g = 0, b = 0;
  
   Cell(Cell cell){
  this.x = cell.x;
  this.y =  cell.y;
  this.cWidth = cell.cWidth;
  this.cHeight = cell.cHeight;
  this.r = cell.r;
  this.g = cell.g;
  this.b = cell.b;
  }
  
  Cell(float x, float y, float w, float h){
  this.x = x;
  this.y =  y;
  this.cWidth = w;
  this.cHeight = h;
  }
  
  Cell(float x, float y, float w, float h, int r, int g, int b){
  this.x = x;
  this.y =  y;
  this.cWidth = w;
  this.cHeight = h;
  
  this.r = r;
  this.g = g;
  this.b = b;
  }
  
  void drawCell(){
    noStroke();
    fill(r, g, b);
    rect(x, y, cWidth, cHeight);
  }
  
  void applyRandomColor(){
   r = int(random(255));
   g = int(random(255));
   b = int(random(255));
  }
  
  void applyColor(int r, int g, int b){
   this.r = r;
   this.g = g;
   this.b = b;
  }
}
