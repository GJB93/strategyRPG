class Board
{
  int rows;
  int cols;
  int elapsed;
  ArrayList<ArrayList<Cell>> cells;
  Cell selectedCell;
  float borderX;
  float borderY;
  float cellWidth;
  float cellHeight;
  float cellMiddle;
  float statcardXPos;
  boolean hasSelected;
  boolean playerOneTurn;
  boolean gameOver;
  String statusMessage;
  
  Board()
  {
    this.rows = 10;
    this.cols = 10;
    borderX = width*0.1f;
    borderY = height*0.1f;
    elapsed = 120;
    cellWidth = (width-(borderX*2))/cols;
    cellHeight = (height-(borderY*2))/rows;
    cells = new ArrayList<ArrayList<Cell>>();
    playerOneTurn = true;
    gameOver = false;
    statcardXPos = width*0.2f;
    for(int row=0; row<rows; row++)
    {
      ArrayList<Cell> temp = new ArrayList<Cell>();
      for(int col=0; col<cols; col++)
      {
        Cell cell = new Cell(row, col, cellWidth, cellHeight, borderX, borderY);
        temp.add(cell);
      }
      cells.add(temp);
    }
    hasSelected = false;
    selectedCell = null;
  }
  
  void render()
  {
    highlightCells(playerOneTurn);
    for(ArrayList<Cell> listCells: cells)
    {
      for(Cell cell: listCells)
      {
        cell.drawCell();
      }
    }
    displayStatusMessage();
    if(hasSelected)
    {
      showStatcard();
    }
  }
  
  void showStatcard()
  {
    if(selectedCell.cellNumber.y*cellWidth+statcardXPos+selectedCell.unit.statcardWidth < width)
      {
        selectedCell.unit.statCard(selectedCell.cellNumber.y*cellWidth+statcardXPos,selectedCell.cellNumber.x*cellHeight);
      }
      else
      {
        selectedCell.unit.statCard(selectedCell.cellNumber.y*cellWidth-statcardXPos,selectedCell.cellNumber.x*cellHeight);
      }
  }
  
  void checkMouse()
  {
    if(pmouseX > borderX && pmouseX < width-borderX && pmouseY > borderY && pmouseY < height-borderY)
    {
      int row = int(map(mouseY, borderY, height-borderY, 0, rows));
      int col = int(map(mouseX, borderX, width-borderX, 0, cols));
      
      if(mouseButton == LEFT)
      {
        playerMoves(row, col, true, playerOneTurn);
      }
      
      if(mouseButton == RIGHT)
      {
        playerMoves(row, col, false, playerOneTurn);
      }
    }
  }
  
  void playerMoves(int row, int col, boolean leftMouse, boolean playerTurn)
  {
    
    if(leftMouse)
    {
      if(cells.get(row).get(col).isOccupied)
      {
        if(!hasSelected && !cells.get(row).get(col).unit.hasMoved)
        {
          if(cells.get(row).get(col).playerUnit == playerTurn)
          {
            cells.get(row).get(col).unitSelected();
            selectedCell = cells.get(row).get(col);
            hasSelected = true;
          }
        }
        else if(hasSelected)
        {
          elapsed = 0;
          if(cells.get(row).get(col).playerUnit == playerTurn)
          {
            if(selectedCell.unit instanceof Templar)
            {
              if(inAttackRange(cells.get(row).get(col), selectedCell))
              {
                if(cells.get(row).get(col).unit.stats.hp < cells.get(row).get(col).unit.stats.maxHp)
                {
                  selectedCell.unit.ability(cells.get(row).get(col).unit);
                  selectedCell.unit.unitMoved();
                }
                else
                {
                  statusMessage = "Unit is already fully healed";
                }
              }
              else
              {
                statusMessage = "Unit is not in range";
              }
              selectedCell.unitUnselected();
              hasSelected = false;
            }
            else
            {
              statusMessage = "Space already occupied by a friendly unit";
              selectedCell.unitUnselected();
              hasSelected = false;
            }
          }
          
          if(cells.get(row).get(col).playerUnit != playerTurn)
          {
            if(inAttackRange(cells.get(row).get(col), selectedCell))
            {
              selectedCell.unit.attack(cells.get(row).get(col).unit);
              if(selectedCell.unit.lastDamageValue > 0)
              {
                if(selectedCell.unit.criticallyHit)
                {
                  statusMessage = selectedCell.unit.fname + " " + selectedCell.unit.sname + " critically hit " + 
                                  cells.get(row).get(col).unit.fname + " " + cells.get(row).get(col).unit.sname + 
                                    " for " + selectedCell.unit.lastDamageValue + " damage!";
                }
                else
                {
                  statusMessage = selectedCell.unit.fname + " " + selectedCell.unit.sname + " attacked " + 
                                  cells.get(row).get(col).unit.fname + " " + cells.get(row).get(col).unit.sname + 
                                    " for " + selectedCell.unit.lastDamageValue + " damage";
                }
              }
              else
              {
                statusMessage = cells.get(row).get(col).unit.fname + " " + cells.get(row).get(col).unit.sname + " dodged the attack!";
              }
              
              
              if(cells.get(row).get(col).unit.stats.hp < 1)
              {
                cells.get(row).get(col).unset();
                checkUnitsRemaining(!playerTurn);
              }
              selectedCell.unit.unitMoved();
            }
            else
            {
               statusMessage = "Unit is not in range";
            }
            selectedCell.unitUnselected();
            hasSelected = false;
          }
        }
      }
      else
      {
        if(hasSelected)
        {
          moveUnit(selectedCell, row, col, playerOneTurn);
          hasSelected = false;
        }
      }
    }
    else
    {
      if(cells.get(row).get(col).isOccupied)
      {
        if(cells.get(row).get(col).playerUnit == playerTurn && hasSelected)
        {
          selectedCell.unitUnselected();
          hasSelected = false;
        }
      }
    }
    checkPlayerUnits(playerOneTurn);
  }
  
  void displayStatusMessage()
  {
    if(elapsed != 120)
    {
      fill(255);
      textAlign(CENTER, CENTER);
      textSize(14);
      text(statusMessage, width*0.50, height-(height*0.05));
      elapsed++;
    }
  }
  
  boolean checkPlayerUnits(boolean playerTurn)
  {
    int numberOfUnitsMoved = 0;
    int numberOfUnits = 0;
    for(ArrayList<Cell> listCells: cells)
    {
      for(Cell cell: listCells)
      {
        if(cell.isOccupied)
        {
          if(cell.playerUnit == playerTurn)
          {
            numberOfUnits++;
          }
          if(cell.unit.hasMoved && (cell.playerUnit == playerTurn))
          {
            numberOfUnitsMoved++;
          }
          
        }
      }
    }
    
    if(numberOfUnitsMoved == numberOfUnits)
    {
      setPlayerTurn();
      resetUnits(playerOneTurn);
      return false;
    }
    else
    {
      return true;
    }
  }
  
  boolean inAttackRange(Cell target, Cell source)
  {
    if(target.cellNumber.y >= source.cellNumber.y-source.unit.range && 
        target.cellNumber.y <= source.cellNumber.y+source.unit.range && 
          target.cellNumber.x >= source.cellNumber.x-source.unit.range && 
            target.cellNumber.x <= source.cellNumber.x+source.unit.range)
    {
      return true;
    }
    else
    {
      return false;
    }
  }
  
  boolean checkMove(Cell target, Cell source)
  {
    if(target.cellNumber.y >= source.cellNumber.y-source.unit.moveRange && 
        target.cellNumber.y <= source.cellNumber.y+source.unit.moveRange && 
          target.cellNumber.x >= source.cellNumber.x-source.unit.moveRange && 
            target.cellNumber.x <= source.cellNumber.x+source.unit.moveRange)
    {
      return true;
    }
    else
    {
      return false;
    }
  }
  
  void setPlayerTurn()
  {
    playerOneTurn = !playerOneTurn;
  }
  
  void highlightCells(boolean playerTurn)
  {
    if (selectedCell != null && selectedCell.isSelected)
    {
      for(ArrayList<Cell> listCells: cells)
      {
        for(Cell cell: listCells)
        {
          if(cell.cellNumber.y >= selectedCell.cellNumber.y-selectedCell.unit.moveRange && 
              cell.cellNumber.y <= selectedCell.cellNumber.y+selectedCell.unit.moveRange && 
                cell.cellNumber.x >= selectedCell.cellNumber.x-selectedCell.unit.moveRange && 
                  cell.cellNumber.x <= selectedCell.cellNumber.x+selectedCell.unit.moveRange)
          {
            if(cell.isOccupied && inAttackRange(cell, selectedCell))
            {
              if(cell.playerUnit == playerTurn)
              {
                if(selectedCell.unit instanceof Templar)
                {
                  cell.allyHighlight();
                }
              }
              else
              {
                cell.enemyHighlight();
              }
            }
            else
            {
              cell.moveHighlight();
            }
          }
        }
      }
    }
    else
    {
      for(ArrayList<Cell> listCells: cells)
      {
        for(Cell cell: listCells)
        {
          cell.undoAllHighlights();
        }
      }
    }
  }
  
  void resetUnits(boolean playerTurn)
  {
    for(ArrayList<Cell> listCells: cells)
    {
      for(Cell cell: listCells)
      {
        if(cell.isOccupied)
        {
          if(cell.playerUnit == playerTurn)
          {
            cell.unit.resetMoveState();
          }
        }
      }
    }
  }
  
  void checkUnitsRemaining(boolean playerTurn)
  {
    int unitsLeft = 0;
    for(ArrayList<Cell> listCells: cells)
    {
      for(Cell cell: listCells)
      {
        if(cell.isOccupied)
        {
          if(cell.playerUnit == playerTurn)
          {
            unitsLeft++;
          }
        }
      }
    }
    
    if(unitsLeft < 1)
    {
      gameOver = gameOver();
    }
  }
  
  void moveUnit(Cell cell, int row, int col, boolean playerTurn)
  {
    if(checkMove(cells.get(row).get(col), cell))
    {
      cells.get(row).get(col).set(cell.unit, playerTurn);
      cells.get(row).get(col).unit.unitMoved();
      cells.get(row).get(col).unitUnselected();
      //elapsed = 0;
      //statusMessage = cell.unit.fname + " " + cell.unit.sname + " moved to space " + row + ", " + col;
      //cells.get(int(cell.cellNumber.x)).get(int(cell.cellNumber.y)).unset();
      cell.unset();
    }
    else
    {
      //println("Invalid move");
      elapsed = 0;
      statusMessage = "You cannot move there!";
      cell.unitUnselected();
    }
  }
  
  boolean gameOver()
  {
    return true;
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