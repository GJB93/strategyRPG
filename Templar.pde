//Templar unit is a strength/magic melee unit that can heal allies
//Deals damage based on ability power

class Templar extends Unit
{
  int healValue;
  Templar()
  {
    super();
    this.c = color(255, 0, 255);
    this.range = 1;
    this.moveRange = 2;
    this.type = "Templar";
    this.healValue = 10;
    sprite = loadImage("templar.png");
  }

  Templar(Stats stats)
  {
    super(stats);
    this.c = color(255, 0, 255);
    this.range = 1;
    this.moveRange = 2;
    this.type = "Templar";
    this.healValue = 10;
    sprite = loadImage("templar.png");
  }

  void drawUnit(float x, float y, float w, float h, boolean playerSide)
  {
    super.drawUnit(x, y, w, h, playerSide, c);
  }

  void attack(Unit unit)
  {
    int dice = int(random(1, 100));
    int damage;
    float critMultiplier = 2;
    float dmgMultiplier = 1.5;

    if (dice <= this.stats.crit)
    {
      damage = round((this.stats.abl*critMultiplier) - ((this.stats.abl*critMultiplier)*unit.defend()));
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
      damage = round(this.stats.abl*dmgMultiplier - ((this.stats.abl*dmgMultiplier)*unit.defend()));
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
    if ((unit.stats.hp+healValue)>unit.stats.maxHp)
    {
      println("Unit healed for " + (unit.stats.maxHp - unit.stats.hp));
      unit.stats.hp = unit.stats.maxHp;
    } else
    {
      println("Unit healed for 10");
      unit.stats.hp += healValue;
    }
  }

  void statCard(float x, float y)
  {
    super.statCard(x, y);
    text("Type: " + type, x+statcardXinc, y+statcardYinc*6);
  }
}