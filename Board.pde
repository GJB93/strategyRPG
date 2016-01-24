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
    checkMouse();
  }
  
  void checkMouse()
  {
    if(mousePressed)
    {
      if(pmouseX > border && pmouseX < width-border && pmouseY > border && pmouseY < height-border)
      {
        int i = int(map(mouseX, border, width-border, 0, cols));
        int j = int(map(mouseY, border, height-border, 0, rows));
        
        if(cells.get(j).get(i).isOccupied)
        {
          if(cells.get(j).get(i).playerUnit)
          {
            cells.get(j).get(i).offerMove();
          }
        }
      }
    }
  }
  
  void set(int row, int col, Unit unit, boolean playerUnit)
  {
    if(row >= 0 && row < rows && col >= 0 && col < cols)
    {
      cells.get(row).get(col).set(unit, playerUnit);
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