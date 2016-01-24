class Cell
{
  PVector cellNumber;
  PImage cellImage;
  PImage sprite;
  float cellW;
  float cellH;
  float border;
  boolean isOccupied;
  boolean playerUnit;
  boolean isSelected;
  Unit occupiedBy;
  
  Cell()
  {
    cellNumber = new PVector();
    isOccupied = false;
    occupiedBy = null;
  }
  
  Cell(int row, int col, float w, float h, float b)
  {
    cellNumber = new PVector(row, col);
    cellW = w;
    cellH = h;
    border = b;
    isOccupied = false;
    occupiedBy = null;
  }
  
  void drawCell()
  {
    float y = cellNumber.x * cellW;
    float x = cellNumber.y * cellH;
    float cellM = cellW * 0.5f;
    
    stroke(255);
    if(isOccupied)
    {
      if(isSelected)
      {
        displayUnitDetails();
        fill(0, 255, 255, 20);
      }
      else
      {
        fill(200);
      }
      rect(border+x, border+y, cellW, cellH);
      imageMode(CENTER);
      image(sprite, border+x+cellM, border+y+cellM);
    }
    else
    {
      fill(200);
      rect(border+x, border+y, cellW, cellH);
    }
  }
  
  void displayUnitDetails()
  {
    fill(0);
    text(occupiedBy.fname + " " + occupiedBy.sname, 10, 10);
    text(occupiedBy.type, 10, 20);
    text("STR: " + occupiedBy.stats.str, 10, 30);
    text("DEX: " + occupiedBy.stats.dex, 10, 40);
    text("MAG: " + occupiedBy.stats.mag, 10, 50);
  }
  
  void unitSelected()
  {
    this.isSelected = true;
  }
  
  void unitUnselected()
  {
    this.isSelected = false;
  }
  
  void set(Unit unit, boolean playerUnit)
  {
    isOccupied = true;
    occupiedBy = unit;
    this.sprite = unit.sprite;
    this.playerUnit = playerUnit;
  }
  
  void unset()
  {
    isOccupied = false;
    occupiedBy = null;
  }
}