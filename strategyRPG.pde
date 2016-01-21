void setup()
{
  size(500, 500);
  
  for(int i=0; i<10; i++)
  {
    Unit unit = new Unit();
    
    println(unit.fname);
    println(unit.sname);
    println(unit.gender);
    println(unit.stats.str);
    println(unit.stats.dex);
    println(unit.stats.mag);
  }
  
  Board board = new Board();
  
  board.render();
}

void draw()
{
  
}