//Magic focused unit

class Mage extends Unit
{
  Mage()
  {
    super();
    this.c = color(0, 0, 255);
    this.range = 2;
    this.moveRange = 2;
    this.type = "Mage";
    sprite = loadImage("mage.png");
  }
  
  Mage(Stats stats)
  {
    super(stats);
    this.c = color(0, 0, 255);
    this.range = 2;
    this.moveRange = 2;
    this.type = "Mage";
    sprite = loadImage("mage.png");
  }
  
  void drawUnit(float x, float y, float w, float h, boolean playerSide)
  {
    super.drawUnit(x, y, w, h, playerSide, c);
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
      damage = round(this.stats.abl*dmgMultiplier - ((this.stats.abl*dmgMultiplier)*unit.defend()));
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
  
  void ability(Unit unit)
  {
    unit.stats.hp -= (this.stats.abl*2);
  }
  
  void statCard(float x, float y)
  {
    super.statCard(x, y);
    text("Type: " + type, x+statcardXinc, y+statcardYinc*6);
  }
}