//Dexterity and Strength cross unit

class Swordsman extends Unit
{
  Swordsman()
  {
    super();
    this.range = 1;
    this.moveRange = 3;
    this.type = "Swordsman";
    sprite = loadImage("swordsman.png");
  }
  
  Swordsman(Stats stats)
  {
    super(stats);
    this.range = 1;
    this.moveRange = 3;
    this.type = "Swordsman";
    sprite = loadImage("swordsman.png");
  }
  
  void drawUnit(float x, float y, boolean playerSide)
  {
    color c = color(255, 255, 0);
    fill(c);
    noStroke();
    if(playerSide)
    {
      rectMode(CENTER);
      rect(x, y, 10, 10);
    }
    else
    {
      ellipseMode(CENTER);
      ellipse(x, y, 10, 10);
    }
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
    this.goAgain = true;
  }
}