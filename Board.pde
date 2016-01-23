class Board
{
  ArrayList<PImage> sprites;
  int rows;
  int cols;
  boolean[][] positionState;
  boolean[][] highlightedCells;
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
          imageMode(CENTER);
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
  
  void highlightCells(int posX, int posY, int range)
  {
    for(int row=0; row<rows; row++)
    {
      for(int col=0; col<cols; col++)
      {
        if(row >= (posX-range))
        {
          float x = col*cellHeight;
          float y = row*cellWidth;
          noStroke();
          fill(0, 255, 255, 50);
          rect(border+x, border+y, cellWidth, cellHeight);
        }
      }
    }
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