//Magic focused unit

class Mage extends Unit
{
  Mage()
  {
    super();
    this.range = 2;
    this.moveRange = 2;
    this.type = "Mage";
    sprite = loadImage("mage.png");
  }
  
  Mage(Stats stats)
  {
    super(stats);
    this.range = 2;
    this.moveRange = 2;
    this.type = "Mage";
    sprite = loadImage("mage.png");
  }
  
  void drawUnit(float x, float y, boolean playerSide)
  {
    color c = color(0, 0, 255);
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
    float critMultiplier = 1.5;
    float dmgMultiplier = 1;
    
    if(dice <= this.stats.crit)
    {
      damage = round((this.stats.abl*critMultiplier) - ((this.stats.abl*critMultiplier)*unit.defend()));
      lastDamageValue = damage;
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
      damage = round(this.stats.abl*dmgMultiplier - ((this.stats.abl*dmgMultiplier)*unit.defend()));
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
    unit.stats.hp -= (this.stats.abl*2);
  }
  
  void statCard(float x, float y, float w, float h)
  {
    super.statCard(x, y, w, h);
    text("Type: " + type, x+10, y+60);
  }
}