//Swordsman is a strength/dexterity melee unit that can move long distances
//Deals damage based on a multiplied attack power

class Swordsman extends Unit
{
  Swordsman()
  {
    super();
    this.c = color(255, 255, 0);
    this.range = 1;
    this.moveRange = 3;
    this.type = "Swordsman";
    sprite = loadImage("swordsman.png");
  }

  Swordsman(Stats stats)
  {
    super(stats);
    this.c = color(255, 255, 0);
    this.range = 1;
    this.moveRange = 3;
    this.type = "Swordsman";
    sprite = loadImage("swordsman.png");
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
      damage = round((this.stats.att*critMultiplier) - ((this.stats.att*critMultiplier)*unit.defend()));
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
    this.goAgain = true;
  }

  void statCard(float x, float y)
  {
    super.statCard(x, y);
    text("Type: " + type, x+statcardXinc, y+statcardYinc*6);
  }
}