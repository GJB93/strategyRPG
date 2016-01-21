//Dexterity and Strength cross unit

class Swordsman extends Unit
{
  Swordsman()
  {
    super();
    this.range = 1;
  }
  
  void attack(Unit unit)
  {
    int dice = int(random(1, 100));
    
    if(dice <= this.stats.crit)
    {
      unit.stats.hp -= this.stats.att*1.5;
    }
    else
    {
      unit.stats.hp -= this.stats.att;
    }
  }
}