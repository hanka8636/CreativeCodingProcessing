Layout layout = null;
int xCells = 3;
int yCells = 3;

int x =int(random(xCells));
  int y = int(random(yCells));
  int r = int(random(255));
  int g = int(random(255));
  int b = int(random(255));
  
void setup(){
  size(840,1188);
     layout = new Layout(xCells,yCells);
     layout.countGrid();
     layout.drawCellWithColor(x,y,r,g,b);
}

void draw(){

  background(200);
 
  layout.drawGrid();
  layout.moveCell(x,y);
  //layout.drawRandomCell();
  
  
}
