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
  
  void drawUnit(float x, float y, boolean playerSide)
  {
    color c = color(0, 255, 0);
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
    float critMultiplier = 2;
    float dmgMultiplier = 1.2;
    
    if(dice <= this.stats.crit)
    {
      damage = round((this.stats.att*critMultiplier) - ((this.stats.att*critMultiplier)*unit.defend()));
      lastDamageValue = damage;
      unit.stats.hp -= damage;
      criticallyHit = true;
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
      damage = round(this.stats.att*dmgMultiplier - ((this.stats.att*dmgMultiplier)*unit.defend()));
      lastDamageValue = damage;
      unit.stats.hp -= damage;
      criticallyHit = false;
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
    this.range = 5;
  }
  
  void statCard(float x, float y)
  {
    super.statCard(x, y);
    text("Type: " + type, x+10, y+60);
  }
}