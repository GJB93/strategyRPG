//Strength and Magic cross unit

class Templar extends Unit
{
  Templar()
  {
    super();
    this.range = 1;
    this.type = "Templar";
  }
  
  Templar(Stats stats)
  {
    super(stats);
    this.range = 1;
    this.type = "Templar";
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
    if((unit.stats.hp+10)>unit.stats.maxHp)
    {
      unit.stats.hp = unit.stats.maxHp;
    }
    else
    {
      unit.stats.hp += 10;
    }
  }
}