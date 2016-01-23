//Magic focused unit

class Mage extends Unit
{
  Mage()
  {
    super();
    this.range = 2;
    this.moveRange = 2;
    this.type = "Mage";
    sprite = new PImage();
  }
  
  Mage(Stats stats)
  {
    super(stats);
    this.range = 2;
    this.moveRange = 2;
    this.type = "Mage";
    sprite = new PImage();
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
  
  float defend()
  {
    int dice = int(random(1,100));
    
    if(dice <= this.stats.eva)
    {
      return 1.0f;
    }
    else
    {
      float ratio = map(this.stats.def, 0, 100, 0, 1);
      return ratio;
    }
  }
  
  void ability(Unit unit)
  {
    unit.stats.hp -= (this.stats.abl*2);
  }
}