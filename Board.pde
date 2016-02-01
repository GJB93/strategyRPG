class Board
{
  int rows;
  int cols;
  int elapsed;
  ArrayList<ArrayList<Cell>> cells;
  Cell selectedCell;
  float border;
  float cellWidth;
  float cellHeight;
  float cellMiddle;
  boolean hasSelected;
  boolean playerOneTurn;
  boolean gameOver;
  String attackMessage;
  
  Board()
  {
    this.rows = 10;
    this.cols = 10;
    border = width*0.1f;
    elapsed = 120;
    cellWidth = (width-(border*2))/cols;
    cellHeight = (height-(border*2))/rows;
    cells = new ArrayList<ArrayList<Cell>>();
    playerOneTurn = true;
    gameOver = false;
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
    displayAttackMessage();
    if(hasSelected)
    {
      if(selectedCell.cellNumber.y*cellWidth+100+120 < width)
      {
        selectedCell.unit.statCard(selectedCell.cellNumber.y*cellWidth+100,selectedCell.cellNumber.x*cellHeight);
      }
      else
      {
        selectedCell.unit.statCard(selectedCell.cellNumber.y*cellWidth-100,selectedCell.cellNumber.x*cellHeight);
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
          if((selectedCell.unit instanceof Templar) && cells.get(row).get(col).playerUnit == playerTurn)
          {
            if(inAttackRange(cells.get(row).get(col), selectedCell))
            {
              selectedCell.unit.ability(cells.get(row).get(col).unit);
              selectedCell.unit.unitMoved();
            }
            else
            {
              println("Unit not in range");
            }
            selectedCell.unitUnselected();
            hasSelected = false;
          }
          
          if(cells.get(row).get(col).playerUnit == !playerTurn)
          {
            if(inAttackRange(cells.get(row).get(col), selectedCell))
            {
              selectedCell.unit.attack(cells.get(row).get(col).unit);
              if(selectedCell.unit.lastDamageValue > 0)
              {
                if(selectedCell.unit.criticallyHit)
                {
                  attackMessage = selectedCell.unit.fname + " " + selectedCell.unit.sname + " critically hit " + 
                                  cells.get(row).get(col).unit.fname + " " + cells.get(row).get(col).unit.sname + 
                                    " for " + selectedCell.unit.lastDamageValue + " damage!";
                }
                else
                {
                  attackMessage = selectedCell.unit.fname + " " + selectedCell.unit.sname + " attacked " + 
                                  cells.get(row).get(col).unit.fname + " " + cells.get(row).get(col).unit.sname + 
                                    " for " + selectedCell.unit.lastDamageValue + " damage";
                }
              }
              else
              {
                attackMessage = cells.get(row).get(col).unit.fname + " " + cells.get(row).get(col).unit.sname + " dodged the attack!";
              }
              
              elapsed = 0;
              if(cells.get(row).get(col).unit.stats.hp < 1)
              {
                cells.get(row).get(col).unset();
              }
              selectedCell.unit.unitMoved();
            }
            else
            {
              println("Unit not in range");
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
  
  void displayAttackMessage()
  {
    if(elapsed != 120)
    {
      fill(255);
      textAlign(LEFT, CENTER);
      textSize(11);
      text(attackMessage, width*0.20, height-(height*0.05));
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
    int unitsLeft = 0;
    for(ArrayList<Cell> listCells: cells)
    {
      for(Cell cell: listCells)
      {
        if(cell.isOccupied)
        {
          if(cell.playerUnit == playerTurn && cell.unit.hasMoved)
          {
            cell.unit.resetMoveState();
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
      println("Valid move");
      cells.get(row).get(col).set(cell.unit, playerTurn);
      cells.get(row).get(col).unit.unitMoved();
      cells.get(row).get(col).unitUnselected();
      //cells.get(int(cell.cellNumber.x)).get(int(cell.cellNumber.y)).unset();
      cell.unset();
    }
    else
    {
      println("Invalid move");
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