/*
  Each cell has the same height, width and border values
  Whether they are highlighted in certain colours depends
  on the board state, and which cell is selected. Each cell
  can be occupied, and the unit that occupies the cell is held
  as an object.
*/

class Cell
{
  PVector cellNumber;
  PImage cellImage;
  float cellW;
  float cellH;
  float borderX;
  float borderY;
  boolean isOccupied;
  boolean playerUnit;
  boolean isSelected;
  boolean moveHighlight;
  boolean allyHighlight;
  boolean enemyHighlight;
  Unit unit;

  Cell()
  {
    cellNumber = null;
    isOccupied = false;
    unit = null;
  }

  Cell(int row, int col, float w, float h, float bx, float by)
  {
    cellNumber = new PVector(row, col);
    cellW = w;
    cellH = h;
    borderX = bx;
    borderY = by;
    isOccupied = false;
    unit = null;
  }

  /*
    Method draws the cell according to the specified width and height,
    and also highlights the cell if is to be highlighted. It also draws
    the unit that the cell contains if one exists
  */
  void drawCell()
  {
    float y = cellNumber.x * cellH;
    float x = cellNumber.y * cellW;
    float cellMx = cellW * 0.5f;
    float cellMy = cellH * 0.5f;
    float unitToCellRatio = 0.4f;
    float unitHighlightOffset = 10;

    stroke(255);
    rectMode(CORNER);
    imageMode(CENTER);
    if (isOccupied)
    {
      if (isSelected)
      {
        fill(0, 255, 255, 20);
      } else
      {
        if (allyHighlight)
        {
          fill(0, 255, 0, 50);
        } else if (enemyHighlight)
        {
          fill(255, 0, 0, 50);
        } else
        {
          fill(200, 200, 200, 50);
        }
      }
      rect(borderX+x, borderY+y, cellW, cellH);
      if (!unit.hasMoved)
      {
        fill(255);
        if (playerUnit)
        {
          rectMode(CENTER);
          rect(borderX+x+cellMx, borderY+y+cellMy, (cellW*unitToCellRatio)+unitHighlightOffset, (cellH*unitToCellRatio)+unitHighlightOffset);
        } else
        {
          ellipseMode(CENTER);
          ellipse(borderX+x+cellMx, borderY+y+cellMy, (cellW*unitToCellRatio)+unitHighlightOffset, (cellH*unitToCellRatio)+unitHighlightOffset);
        }
      }


      unit.drawUnit(borderX+x+cellMx, borderY+y+cellMy, cellW*unitToCellRatio, cellH*unitToCellRatio, playerUnit);
    } else
    {
      if (moveHighlight)
      {
        fill(0, 0, 255, 50);
      } else
      {
        fill(200);
      }
      rect(borderX+x, borderY+y, cellW, cellH);
    }
  }

  void unitSelected()
  {
    this.isSelected = true;
  }

  void unitUnselected()
  {
    this.isSelected = false;
  }

  void moveHighlight()
  {
    moveHighlight = true;
  }

  void allyHighlight()
  {
    allyHighlight = true;
  }

  void enemyHighlight()
  {
    enemyHighlight = true;
  }

  void undoAllHighlights()
  {
    moveHighlight = false;
    allyHighlight = false;
    enemyHighlight = false;
  }

  void set(Unit unit, boolean playerUnit)
  {
    isOccupied = true;
    this.unit = unit;
    this.isSelected = false;
    this.playerUnit = playerUnit;
  }

  Cell get()
  {
    return this;
  }

  void unset()
  {
    isOccupied = false;
    unit = null;
    playerUnit = false;
    this.isSelected = false;
  }
}