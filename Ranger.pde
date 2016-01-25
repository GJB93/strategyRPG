//Dexterity focused unit

class Ranger extends Unit
{
  Ranger()
  {
    super();
    this.range = 3;
    this.moveRange = 3;
    this.type = "Ranger";
    sprite = loadImage("ranger.png");
  }
  
  Ranger(Stats stats)
  {
    super(stats);
    this.range = 3;
    this.moveRange = 3;
    this.type = "Ranger";
    sprite = loadImage("ranger.png");
  }
  
  void attack(Unit unit)
  {
    int dice = int(random(1, 100));
    
    if(dice <= this.stats.crit)
    {
      unit.stats.hp -= (this.stats.att*1.5) - ((this.stats.att*1.5)*unit.defend());
      println("Unit dealt " + ((this.stats.att*1.5) - ((this.stats.att*1.5)*unit.defend())) + " damage");
    }
    else
    {
      unit.stats.hp -= this.stats.att - ((this.stats.att)*unit.defend());
      println("Unit dealt " + (this.stats.att - ((this.stats.att)*unit.defend())) + " damage");
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
    this.range = 5;
  }
}