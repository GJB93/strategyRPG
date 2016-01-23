class Board
{
  ArrayList<PImage> sprites;
  int rows;
  int cols;
  boolean[][] positionState;
  boolean[][] nextState;
  float border;
  float cellWidth;
  float cellHeight;
  
  Board()
  {
    sprites = new ArrayList<PImage>();
    this.rows = 10;
    this.cols = 10;
    border = width*0.1f;
    positionState = new boolean[rows][cols];
    nextState = new boolean[rows][cols];
    cellWidth = (width-(border*2))/cols;
    cellHeight = (height-(border*2))/rows;
  }
  
  void render()
  {
    for(int row=0; row<rows; row++)
    {
      for(int col=0;col<cols; col++)
      {
        float x = col*cellHeight;
        float y = row*cellWidth;
        noFill();
        stroke(255);
        rect(border+x, border+y, cellWidth, cellHeight);
      }
    }
  }
  
  void showPossibleMoves()
  {
    
  }
  
  void set(int row, int col, boolean value)
  {
    if(row >= 0 && row < rows && col >= 0 && col < cols)
    {
      positionState[row][col] = value;
    }
  }
  
  boolean get(int row, int col)
  {
    if (row >= 0 && row < rows && col >= 0 && col < cols)
    {
      return positionState[row][col];
    }
    else
    {
      return false;
    }
  } 
}