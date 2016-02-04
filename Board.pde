/*
  Board is used to create and control the grid for the game
  The board has a number of rows and columns, which consist
  of a number of rectangular cells. These cells are maniplulated
  by various methods in the Board class.
*/

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
  boolean winningPlayer;
  String statusMessage;
  
  /*
    Main constructor, sets each variable according to the
    screen width and creates each cell used in the grid.
  */
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
    for (int row=0; row<rows; row++)
    {
      ArrayList<Cell> temp = new ArrayList<Cell>();
      for (int col=0; col<cols; col++)
      {
        Cell cell = new Cell(row, col, cellWidth, cellHeight, borderX, borderY);
        temp.add(cell);
      }
      cells.add(temp);
    }
    hasSelected = false;
    selectedCell = null;
  }

  /*
    Draws the board in its current state
  */
  void render()
  {
    highlightCells(playerOneTurn);
    for (ArrayList<Cell> listCells : cells)
    {
      for (Cell cell : listCells)
      {
        cell.drawCell();
      }
    }
    displayStatusMessage();
    if (hasSelected)
    {
      showStatcard();
    }
  }

  /*
    If a cell containing a unit is selected, a statcard is shown beside
    the selected cell
  */
  void showStatcard()
  {
    if (selectedCell.cellNumber.y*cellWidth+statcardXPos+selectedCell.unit.statcardWidth < width)
    {
      selectedCell.unit.statCard(selectedCell.cellNumber.y*cellWidth+statcardXPos, selectedCell.cellNumber.x*cellHeight);
    } else
    {
      selectedCell.unit.statCard(selectedCell.cellNumber.y*cellWidth-statcardXPos, selectedCell.cellNumber.x*cellHeight);
    }
  }

  /*
    Called by the mouseClicked method in the main program. Checks which cell
    was clicked and passes it to the playerMoves method
  */
  void checkMouse()
  {
    if (pmouseX > borderX && pmouseX < width-borderX && pmouseY > borderY && pmouseY < height-borderY)
    {
      int row = int(map(mouseY, borderY, height-borderY, 0, rows));
      int col = int(map(mouseX, borderX, width-borderX, 0, cols));

      if (mouseButton == LEFT)
      {
        playerMoves(row, col, true, playerOneTurn);
      }

      if (mouseButton == RIGHT)
      {
        playerMoves(row, col, false, playerOneTurn);
      }
    }
  }

  /*
    All the control code is found in this method. If the left mouse is pressed,
    it checks if the cell is occupied, then selects the unit if it belongs to
    the player and hasn't been moved yet. If a unit has been selected already,
    it checks the cell to see if a move, attack or heal is possible for the selected
    unit.
    
    If the right mouse is pressed on the selected unit, then the unit is deselected.
  */
  void playerMoves(int row, int col, boolean leftMouse, boolean playerTurn)
  {

    if (leftMouse)
    {
      if (cells.get(row).get(col).isOccupied)
      {
        if (!hasSelected && !cells.get(row).get(col).unit.hasMoved)
        {
          if (cells.get(row).get(col).playerUnit == playerTurn)
          {
            cells.get(row).get(col).unitSelected();
            selectedCell = cells.get(row).get(col);
            hasSelected = true;
          }
        } else if (hasSelected)
        {
          elapsed = 0;
          if (cells.get(row).get(col).playerUnit == playerTurn)
          {
            if (selectedCell.unit instanceof Templar)
            {
              if (inAttackRange(cells.get(row).get(col), selectedCell))
              {
                if (cells.get(row).get(col).unit.stats.hp < cells.get(row).get(col).unit.stats.maxHp)
                {
                  selectedCell.unit.ability(cells.get(row).get(col).unit);
                  selectedCell.unit.unitMoved();
                } else
                {
                  statusMessage = "Unit is already fully healed";
                }
              } else
              {
                statusMessage = "Unit is not in range";
              }
              selectedCell.unitUnselected();
              hasSelected = false;
            } else
            {
              statusMessage = "Space already occupied by a friendly unit";
              selectedCell.unitUnselected();
              hasSelected = false;
            }
          }

          if (cells.get(row).get(col).playerUnit != playerTurn)
          {
            if (inAttackRange(cells.get(row).get(col), selectedCell))
            {
              selectedCell.unit.attack(cells.get(row).get(col).unit);
              if (selectedCell.unit.lastDamageValue > 0)
              {
                if (selectedCell.unit.criticallyHit)
                {
                  statusMessage = selectedCell.unit.fname + " " + selectedCell.unit.sname + " critically hit " + 
                    cells.get(row).get(col).unit.fname + " " + cells.get(row).get(col).unit.sname + 
                    " for " + selectedCell.unit.lastDamageValue + " damage!";
                } else
                {
                  statusMessage = selectedCell.unit.fname + " " + selectedCell.unit.sname + " attacked " + 
                    cells.get(row).get(col).unit.fname + " " + cells.get(row).get(col).unit.sname + 
                    " for " + selectedCell.unit.lastDamageValue + " damage";
                }
              } else
              {
                statusMessage = cells.get(row).get(col).unit.fname + " " + cells.get(row).get(col).unit.sname + " dodged the attack!";
              }


              if (cells.get(row).get(col).unit.stats.hp < 1)
              {
                cells.get(row).get(col).unset();
                checkUnitsRemaining(!playerTurn);
              }
              selectedCell.unit.unitMoved();
            } else
            {
              statusMessage = "Unit is not in range";
            }
            selectedCell.unitUnselected();
            hasSelected = false;
          }
        }
      } else
      {
        if (hasSelected)
        {
          moveUnit(selectedCell, row, col, playerOneTurn);
          hasSelected = false;
        }
      }
    } else
    {
      if (cells.get(row).get(col).isOccupied)
      {
        if (cells.get(row).get(col).playerUnit == playerTurn && hasSelected)
        {
          selectedCell.unitUnselected();
          hasSelected = false;
        }
      }
    }
    checkPlayerUnits(playerOneTurn);
  }

  /*
    Method displays a status message based on what is occuring at
    each action in the game. Message disappears after two seconds.
  */
  void displayStatusMessage()
  {
    if (elapsed != 120)
    {
      float middleX = width*0.50;
      float yPos = height-(height*0.05);
      fill(255);
      textAlign(CENTER, CENTER);
      textSize(14);
      text(statusMessage, middleX, yPos);
      elapsed++;
    }
  }

  /*
    Method checks to see if a player has moved all their units,
    and switches control to the next player upon every unit being moved
  */
  boolean checkPlayerUnits(boolean playerTurn)
  {
    int numberOfUnitsMoved = 0;
    int numberOfUnits = 0;
    for (ArrayList<Cell> listCells : cells)
    {
      for (Cell cell : listCells)
      {
        if (cell.isOccupied)
        {
          if (cell.playerUnit == playerTurn)
          {
            numberOfUnits++;
          }
          if (cell.unit.hasMoved && (cell.playerUnit == playerTurn))
          {
            numberOfUnitsMoved++;
          }
        }
      }
    }

    if (numberOfUnitsMoved == numberOfUnits)
    {
      setPlayerTurn();
      resetUnits(playerOneTurn);
      return false;
    } else
    {
      return true;
    }
  }

  /*
    Checks if the unit targeted is in range of the currently selected unit
  */
  boolean inAttackRange(Cell target, Cell source)
  {
    if (target.cellNumber.y >= source.cellNumber.y-source.unit.range && 
      target.cellNumber.y <= source.cellNumber.y+source.unit.range && 
      target.cellNumber.x >= source.cellNumber.x-source.unit.range && 
      target.cellNumber.x <= source.cellNumber.x+source.unit.range)
    {
      return true;
    } else
    {
      return false;
    }
  }

  /*
    Checks if the cell targeted is in movement range of the currently selected unit
  */
  boolean checkMove(Cell target, Cell source)
  {
    if (target.cellNumber.y >= source.cellNumber.y-source.unit.moveRange && 
      target.cellNumber.y <= source.cellNumber.y+source.unit.moveRange && 
      target.cellNumber.x >= source.cellNumber.x-source.unit.moveRange && 
      target.cellNumber.x <= source.cellNumber.x+source.unit.moveRange)
    {
      return true;
    } else
    {
      return false;
    }
  }

  /*
    Toggles the player turn
  */
  void setPlayerTurn()
  {
    playerOneTurn = !playerOneTurn;
  }

  /*
    Highlights each cell surrounding the selected cell based on
    what is contained within the surrounding cell.
  */
  void highlightCells(boolean playerTurn)
  {
    if (selectedCell != null && selectedCell.isSelected)
    {
      for (ArrayList<Cell> listCells : cells)
      {
        for (Cell cell : listCells)
        {
          if (cell.cellNumber.y >= selectedCell.cellNumber.y-selectedCell.unit.moveRange && 
            cell.cellNumber.y <= selectedCell.cellNumber.y+selectedCell.unit.moveRange && 
            cell.cellNumber.x >= selectedCell.cellNumber.x-selectedCell.unit.moveRange && 
            cell.cellNumber.x <= selectedCell.cellNumber.x+selectedCell.unit.moveRange)
          {
            if (cell.isOccupied && inAttackRange(cell, selectedCell))
            {
              if (cell.playerUnit == playerTurn)
              {
                if (selectedCell.unit instanceof Templar)
                {
                  cell.allyHighlight();
                }
              } else
              {
                cell.enemyHighlight();
              }
            } else
            {
              cell.moveHighlight();
            }
          }
        }
      }
    } else
    {
      for (ArrayList<Cell> listCells : cells)
      {
        for (Cell cell : listCells)
        {
          cell.undoAllHighlights();
        }
      }
    }
  }
  
  /*
    Reset the move state of each unit belonging to a specified player
  */
  void resetUnits(boolean playerTurn)
  {
    for (ArrayList<Cell> listCells : cells)
    {
      for (Cell cell : listCells)
      {
        if (cell.isOccupied)
        {
          if (cell.playerUnit == playerTurn)
          {
            cell.unit.resetMoveState();
          }
        }
      }
    }
  }

  /*
    Checks how many units remain for a specified player
  */
  void checkUnitsRemaining(boolean playerTurn)
  {
    int unitsLeft = 0;
    for (ArrayList<Cell> listCells : cells)
    {
      for (Cell cell : listCells)
      {
        if (cell.isOccupied)
        {
          if (cell.playerUnit == playerTurn)
          {
            unitsLeft++;
          }
        }
      }
    }

    if (unitsLeft < 1)
    {
      winningPlayer = !playerTurn;
      gameOver = gameOver();
    }
  }
  
  /*
    Checks a cell to see if it is empty, and if so, moves the
    unit into the target cell
  */
  void moveUnit(Cell cell, int row, int col, boolean playerTurn)
  {
    if (checkMove(cells.get(row).get(col), cell))
    {
      cells.get(row).get(col).set(cell.unit, playerTurn);
      cells.get(row).get(col).unit.unitMoved();
      cells.get(row).get(col).unitUnselected();
      cell.unset();
    } else
    {
      elapsed = 0;
      statusMessage = "You cannot move there!";
      cell.unitUnselected();
    }
  }

  //Sets the game to be over
  boolean gameOver()
  {
    return true;
  }

  /*
    Sets a chosen cell to contain a unit for a specific player
  */
  void set(int row, int col, Unit unit, boolean playerUnit)
  {
    if (row >= 0 && row < rows && col >= 0 && col < cols)
    {
      cells.get(row).get(col).set(unit, playerUnit);
    }
  }

  //Checks if the cell at a chosen row and col is occupied
  boolean get(int row, int col)
  {
    if (row >= 0 && row < rows && col >= 0 && col < cols)
    {
      return cells.get(row).get(col).isOccupied;
    } else
    {
      return false;
    }
  }
}