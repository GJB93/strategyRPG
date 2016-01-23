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
  float cellMiddle;
  
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
    cellMiddle = cellWidth*0.5f;
  }
  
  void render()
  {
    int spriteCount = 0;
    for(int row=0; row<rows; row++)
    {
      for(int col=0;col<cols; col++)
      {
        float x = col*cellHeight;
        float y = row*cellWidth;
        stroke(255);
        if(positionState[row][col])
        {
          noFill();
          rect(border+x, border+y, cellWidth, cellHeight);
          image(sprites.get(spriteCount), border+x+cellMiddle, border+y+cellMiddle);
          spriteCount++;
        }
        else
        {
          noFill();
          rect(border+x, border+y, cellWidth, cellHeight);
        }
      }
    }
  }
  
  void update()
  {
    
  }
  
  void loadSprite(PImage sprite)
  {
    sprites.add(sprite);
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