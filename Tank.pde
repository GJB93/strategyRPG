//Strength focused unit

class Tank extends Unit
{
  Tank()
  {
    super();
    this.range = 1;
    this.moveRange = 2;
    this.type = "Tank";
    sprite = loadImage("tank.png");
  }
  
  Tank(Stats stats)
  {
    super(stats);
    this.range = 1;
    this.moveRange = 2;
    this.type = "Tank";
    sprite = loadImage("tank.png");
  }
  
  void attack(Unit unit)
  {
    int dice = int(random(1, 100));
    int damage;
    
    if(dice <= this.stats.crit)
    {
      damage = round((this.stats.att*1.5) - ((this.stats.att*1.5)*unit.defend()));
      unit.stats.hp -= damage;
      
      if(damage > 0)
      {
        println("Critical hit! Unit dealt " + damage + " damage");
      }
      else
      {
        println("Unit dodged the attack!");
      }
    }
    else
    {
      damage = round(this.stats.att - ((this.stats.att)*unit.defend()));
      unit.stats.hp -= damage;
      
      if(damage > 0)
      {
        println("Unit dealt " + damage + " damage");
      }
      else
      {
        println("Unit dodged the attack!");
      }
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
    unit.stats.def += 10;
  }
}