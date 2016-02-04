//Tank is a strength focused melee unit that can take heavy damage
//Deals damage based on attack power

class Tank extends Unit
{
  int defValue;
  Tank()
  {
    super();
    this.c = color(255, 0, 0);
    this.range = 1;
    this.moveRange = 2;
    this.type = "Tank";
    this.defValue = 10;
    sprite = loadImage("tank.png");
  }

  Tank(Stats stats)
  {
    super(stats);
    this.c = color(255, 0, 0);
    this.range = 1;
    this.moveRange = 2;
    this.type = "Tank";
    this.defValue = 10;
    sprite = loadImage("tank.png");
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
    float dmgMultiplier = 0.8;

    if (dice <= this.stats.crit)
    {
      damage = round((this.stats.att*critMultiplier) - ((this.stats.att*1.5)*unit.defend()));
      lastDamageValue = damage;
      unit.stats.hp -= damage;
      criticallyHit = true;
      if (damage > 0)
      {
        println("Critical hit! Unit dealt " + damage + " damage");
      } else
      {
        println("Unit dodged the attack!");
      }
    } else
    {
      damage = round(this.stats.att*dmgMultiplier - ((this.stats.att*dmgMultiplier)*unit.defend()));
      lastDamageValue = damage;
      unit.stats.hp -= damage;
      criticallyHit = false;
      if (damage > 0)
      {
        println("Unit dealt " + damage + " damage");
      } else
      {
        println("Unit dodged the attack!");
      }
    }
  }

  void ability(Unit unit)
  {
    unit.stats.def += defValue;
  }

  void statCard(float x, float y)
  {
    super.statCard(x, y);
    text("Type: " + type, x+statcardXinc, y+statcardYinc*6);
  }
}