class Cell
{
  PVector cellNumber;
  PImage cellImage;
  PImage sprite;
  float cellW;
  float cellH;
  float border;
  boolean isOccupied;
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
    float x = cellNumber.x * cellW;
    float y = cellNumber.y * cellH;
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
  
  void set(Unit unit, PImage sprite)
  {
    isOccupied = true;
    occupiedBy = unit;
    this.sprite = sprite;
  }
  
  void unset()
  {
    isOccupied = false;
    occupiedBy = null;
  }
}