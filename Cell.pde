class Cell
{
  PVector cellNumber;
  boolean isOccupied;
  Unit occupiedBy;
  
  Cell()
  {
    cellNumber = new PVector();
    isOccupied = false;
    occupiedBy = null;
  }
  
  Cell(int row, int col)
  {
    cellNumber = new PVector(row, col);
    isOccupied = false;
    occupiedBy = null;
  }
  
  void set(Unit unit)
  {
    isOccupied = true;
    occupiedBy = unit;
  }
  
  void unset()
  {
    isOccupied = false;
    occupiedBy = null;
  }
}