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
  boolean offerMove;
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
      noFill();
      rect(border+x, border+y, cellW, cellH);
      imageMode(CENTER);
      image(sprite, border+x+cellM, border+y+cellM);
    }
    else
    {
      noFill();
      rect(border+x, border+y, cellW, cellH);
    }
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