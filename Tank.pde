//Strength focused unit

class Tank extends Unit
{
  Tank()
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