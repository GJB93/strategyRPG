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
    moveUnit();
    //showValidMoves();
  }
  
  void checkMouse()
  {
    if(mousePressed)
    {
      if(pmouseX > border && pmouseX < width-border && pmouseY > border && pmouseY < height-border)
      {
        int i = int(map(mouseX, border, width-border, 0, cols));
        int j = int(map(mouseY, border, height-border, 0, rows));
        
        
        boolean isValid = true;
        for(ArrayList<Cell> listCells: cells)
        {
          for(Cell cell: listCells)
          {
            if(cell.cellNumber.x != j && cell.cellNumber.y != i)
            {
              if(cell.isSelected)
              {
                isValid = false;
              }
            }
          }
        }
        
        if(isValid)
        {
          if(mouseButton == LEFT)
          {
            if(cells.get(j).get(i).isOccupied)
            {
              if(cells.get(j).get(i).playerUnit)
              {
                cells.get(j).get(i).unitSelected();
              }
            }
          }
          
          if(mouseButton == RIGHT)
          {
            if(cells.get(j).get(i).isOccupied)
            {
              if(cells.get(j).get(i).playerUnit)
              {
                cells.get(j).get(i).unitUnselected();
              }
            }
          }
        }
      }
    }
  }
  
  void moveUnit()
  {
    if(mousePressed)
    {
      if(pmouseX > border && pmouseX < width-border && pmouseY > border && pmouseY < height-border)
      {
        int i = int(map(mouseX, border, width-border, 0, cols));
        int j = int(map(mouseY, border, height-border, 0, rows));
        Cell selectedCell = null;
        
        for(ArrayList<Cell> listCells: cells)
        {
          for(Cell cell: listCells)
          {
            if(cell.isSelected)
            {
              selectedCell = new Cell(cell);
            }
          }
        }
        
        if(selectedCell != null)
        {
          if(!cells.get(j).get(i).isOccupied)
          {
            println(selectedCell.occupiedBy.fname + " " + selectedCell.occupiedBy.sname);
            cells.get(j).get(i).set(selectedCell.occupiedBy, true);
            selectedCell.unset();
          }
        }
      }
    }
  }
  
  /*
  void showValidMoves()
  {
    Cell selectedCell = null;
    for(ArrayList<Cell> listCells: cells)
    {
      for(Cell cell: listCells)
      {
        if(cell.isSelected)
        {
          selectedCell = cell;
        }
      }
    }
    
    if(selectedCell != null)
    {
      for(int row=0; row<rows; row++)
      {
        for(int col=0; col<cols; col++)
        {
          if(row >= (selectedCell.cellNumber.x-selectedCell.occupiedBy.moveRange) && row <= (selectedCell.cellNumber.x+selectedCell.occupiedBy.moveRange))
          {
            println(row);
            if(cells.get(row).get(col).isOccupied)
            {
              if(cells.get(row).get(col).playerUnit)
              {
                cells.get(row).get(col).allyHighlight();
              }
              else
              {
                cells.get(row).get(col).enemyHighlight();
              }
            }
            else
            {
              cells.get(row).get(col).moveHighlight();
            }
          }
        }
      }
    }
  }
  */
  
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