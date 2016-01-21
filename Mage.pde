//Magic focused unit

class Mage extends Unit
{
  Mage()
  {
    super();
    this.range = 2;
  }
  
  void attack(Unit unit)
  {
    int dice = int(random(1, 100));
    
    if(dice <= this.stats.crit)
    {
      unit.stats.hp -= this.stats.abl*1.3;
    }
    else
    {
      unit.stats.hp -= this.stats.abl;
    }
  }
}