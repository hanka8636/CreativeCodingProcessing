class Layout{
  int xCells;
  int yCells;
  Cell cells[][];
  Layout(int x, int y){
  this.xCells = x;
  this.yCells = y;
  cells =  new Cell[xCells][yCells];
  }
  void countGrid(){
    for(int i =0; i<xCells; i++){
      for(int j = 0; j<yCells; j++){
        cells[i][j]= new Cell(width/xCells*i, height/yCells*j, width/xCells, height/yCells);
        //line(0,height/yCells*j, width, height/yCells*j);
      }
    }
  }
  void drawGrid(){
    strokeWeight(1);
    stroke(0,0,0);
    noFill();
        for(int i =0; i<xCells; i++){
      for(int j = 0; j<yCells; j++){
        line(0,height/yCells*j, width, height/yCells*j);
        line(width/xCells*i,0, width/xCells*i, height);
      }
    }
    //fill(0,0,0);
    //rect(0,height/yCells, width/xCells, height/yCells);
    
  }
  
  void drawRandomCell(){
     int x =int(random(xCells));
  int y = int(random(yCells));
    cells[x][y].applyRandomColor();
    cells[x][y].drawCell(); //<>//
   
  }
  
    void drawCellWithColor(int x, int y, int r, int g, int b){
     
    cells[x][y].applyColor(r,g,b);
    cells[x][y].drawCell();
   
  }
  
  void drawCell(int x, int y){
     
    cells[x][y].drawCell();
   
  }
  
   void moveCell(int x, int y){
    if (x<(xCells-1)) 
   // Cell temp = new Cell(cells[x+1][y+1]);
    drawCell(x+1,y);
    else
    drawCell(x-1,y);
   
  }
}
