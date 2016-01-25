//Dexterity and magic cross unit

class Assassin extends Unit
{
  Assassin()
  {
    super();
    this.range = 1;
    this.moveRange = 3;
    this.type = "Assassin";
    sprite = loadImage("assassin.png");
  }
  
  Assassin(Stats stats)
  {
    super(stats);
    this.range = 1;
    this.moveRange = 3;
    this.type = "Assassin";
    sprite = loadImage("assassin.png");
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
    this.stats.crit += 10;
  }
}