class Board
{
  int rows;
  int cols;
  ArrayList<ArrayList<Cell>> cells;
  Cell selectedCell;
  float border;
  float cellWidth;
  float cellHeight;
  float cellMiddle;
  boolean hasSelected;
  
  Board()
  {
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
    hasSelected = false;
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
  
  void checkMouse()
  {
    if(pmouseX > border && pmouseX < width-border && pmouseY > border && pmouseY < height-border)
    {
      int row = int(map(mouseY, border, height-border, 0, rows));
      int col = int(map(mouseX, border, width-border, 0, cols));
      
      if(mouseButton == LEFT)
      {
        if(cells.get(row).get(col).isOccupied && !hasSelected && !cells.get(row).get(col).unit.hasMoved)
        {
          if(cells.get(row).get(col).playerUnit)
          {
            cells.get(row).get(col).unitSelected();
            selectedCell = cells.get(row).get(col);
            hasSelected = true;
          }
        }
        else if(!cells.get(row).get(col).isOccupied && hasSelected)
        {
          moveUnit(selectedCell, row, col);
          selectedCell.unit.unitMoved();
          selectedCell.unitUnselected();
          hasSelected = false;
        }
        else if(cells.get(row).get(col).isOccupied && hasSelected)
        {
          if((selectedCell.unit instanceof Templar) && cells.get(row).get(col).playerUnit)
          {
            selectedCell.unit.ability(cells.get(row).get(col).unit);
            selectedCell.unit.unitMoved();
            selectedCell.unitUnselected();
            hasSelected = false;
          }
          
          if(!cells.get(row).get(col).playerUnit)
          {
            selectedCell.unit.attack(cells.get(row).get(col).unit);
            if(cells.get(row).get(col).unit.stats.hp < 1)
            {
              cells.get(row).get(col).unset();
            }
            selectedCell.unit.unitMoved();
            selectedCell.unitUnselected();
            hasSelected = false;
          }
        }
      }
      
      if(mouseButton == RIGHT)
      {
        if(cells.get(row).get(col).isOccupied)
        {
          if(cells.get(row).get(col).playerUnit && hasSelected)
          {
            cells.get(row).get(col).unitUnselected();
            hasSelected = false;
          }
        }
      }
    }
  }
  
  boolean checkPlayerUnits()
  {
    int numberOfUnitsMoved = 0;
    for(ArrayList<Cell> listCells: cells)
    {
      for(Cell cell: listCells)
      {
        if(cell.playerUnit && cell.unit.hasMoved)
        {
          numberOfUnitsMoved++;
        }
      }
    }
    
    if(numberOfUnitsMoved == 6)
    {
      println("All player units have moved, AI's turn");
      return false;
    }
    else
    {
      return true;
    }
  }
  
  void moveUnit(Cell cell, int row, int col)
  {
    cells.get(row).get(col).set(cell.unit, true);
    cells.get(int(cell.cellNumber.x)).get(int(cell.cellNumber.y)).unset();
    cell.unset();
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