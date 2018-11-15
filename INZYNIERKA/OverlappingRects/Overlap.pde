class Overlap{
ArrayList comparable;
float[][] matrix; 
Overlap(int verc){
  matrix = new float[verc][verc];
}
 
void setSim(int i, float[] sim ){
  for (int j=0; j<sim.length; j++){
  matrix[i][j] = sim[j];
  }
}
 
void drawRect(){


}



}
