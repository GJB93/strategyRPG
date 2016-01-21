//Strength and Magic cross unit

class Templar extends Unit
{
  Templar()
  {
    super();
    this.range = 1;
  }
  
  void attack(Unit unit)
  {
    int dice = int(random(1, 100));
    
    if(dice <= this.stats.crit)
    {
      unit.stats.hp -= (this.stats.abl*1.3) - ((this.stats.abl*1.3)*unit.defend());
    }
    else
    {
      unit.stats.hp -= this.stats.abl - ((this.stats.abl)*unit.defend());
    }
  }
}