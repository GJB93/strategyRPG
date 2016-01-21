void setup()
{
  size(500, 500);
  
  /*
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
  
  //board.render();
  
  Templar templar = new Templar();
  Assassin assassin = new Assassin();
  Tank tank = new Tank();
  
  println(tank.stats.hp);
  templar.attack(tank);
  println(tank.stats.hp);
  templar.ability(tank);
  println(tank.stats.hp);
  */
  
  player = new Player();
  
  for(int i=0; i<player.units.size(); i++)
  {
    println(player.units.get(i).fname + " " + player.units.get(i).sname);
  }
  
  println("Pass");
}

Player player;

void draw()
{
  
}