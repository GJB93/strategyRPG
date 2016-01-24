class Board
{
  ArrayList<PImage> sprites;
  int rows;
  int cols;
  boolean[][] positionState;
  boolean[][] highlightedCells;
  ArrayList<ArrayList<Cell>> cells;
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
    cellWidth = (width-(border*2))/cols;
    cellHeight = (height-(border*2))/rows;
    cells = new ArrayList<ArrayList<Cell>>();
    for(int row=0; row<rows; row++)
    {
      ArrayList<Cell> temp = new ArrayList<Cell>();
      for(int col=0; col<cols; col++)
      {
        Cell cell = new Cell(row, col, cellWidth, cellHeight, border);
        temp.add(cell);
      }
      cells.add(temp);
    }
  }
  
  void render()
  {
    for(ArrayList<Cell> listCells: cells)
    {
      for(Cell cell: listCells)
      {
        cell.drawCell();
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
          float x = col*cellWidth;
          float y = row*cellHeight;
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
  
  void set(int row, int col, Unit unit)
  {
    if(row >= 0 && row < rows && col >= 0 && col < cols)
    {
      cells.get(row).get(col).set(unit);
    }
  }
  
  boolean get(int row, int col)
  {
    if (row >= 0 && row < rows && col >= 0 && col < cols)
    {
      return cells.get(row).get(col).isOccupied;
    }
    else
    {
      return false;
    }
  } 
}