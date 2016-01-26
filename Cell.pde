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
  
  Cell(int row, int col, float w, float h, float b)
  {
    cellNumber = new PVector(row, col);
    //cellImage = loadImage("grass.png");
    cellW = w;
    cellH = h;
    //cellImage.resize(ceil(w), ceil(h));
    border = b;
    isOccupied = false;
    unit = null;
  }
  
  void drawCell()
  {
    float y = cellNumber.x * cellW;
    float x = cellNumber.y * cellH;
    float cellM = cellW * 0.5f;
    
    stroke(255);
    rectMode(CORNER);
    imageMode(CENTER);
    if(isOccupied)
    {
      if(isSelected)
      {
        displayUnitDetails();
        fill(0, 255, 255, 20);
      }
      else
      {
        if(allyHighlight)
        {
          fill(0, 255, 0, 50);
        }
        else if(enemyHighlight)
        {
          fill(255, 0, 0, 50);
        }
        else
        {
          fill(200, 200, 200, 50);
        }
      }
      //image(cellImage, border+x+cellM, border+y+cellM);
      rect(border+x, border+y, cellW, cellH);
      if(!unit.hasMoved)
      {
        rectMode(CENTER);
        fill(255);
        rect(border+x+cellM, border+y+cellM, 15, 15);
      }
      
      
      image(sprite, border+x+cellM, border+y+cellM);
      textSize(7);
      fill(0);
      textAlign(CENTER);
      text(unit.stats.hp, border+x+cellM, border+y+cellM+15);
    }
    else
    {
      if(moveHighlight)
      {
        fill(0, 0, 255, 50);
      }
      else
      {
        fill(200);
      }
      rect(border+x, border+y, cellW, cellH);
      //image(cellImage, border+x+cellM, border+y+cellM);
    }
  }
  
  void displayUnitDetails()
  {
    fill(0);
    textSize(11);
    textAlign(LEFT);
    text(unit.fname + " " + unit.sname, 10, 10);
    text(unit.type, 10, 20);
    text("STR: " + unit.stats.str, 10, 30);
    text("DEX: " + unit.stats.dex, 10, 40);
    text("MAG: " + unit.stats.mag, 10, 50);
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
    this.sprite = unit.sprite;
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