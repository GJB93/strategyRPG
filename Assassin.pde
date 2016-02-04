//Assassin is a dexterity/magic cross unit that attacks from melee range
//Assassin has the highest chance to critically strike

class Assassin extends Unit
{
  int critInc;
  Assassin()
  {
    super();
    this.c = color(0, 255, 255);
    this.range = 1;
    this.moveRange = 3;
    this.type = "Assassin";
    this.critInc = 10;
  }

  Assassin(Stats stats)
  {
    super(stats);
    this.c = color(0, 255, 255);
    this.range = 1;
    this.moveRange = 3;
    this.type = "Assassin";
    this.critInc = 10;
  }

  /*
    Method used to draw the unit in its assigned color
   */
  void drawUnit(float x, float y, float w, float h, boolean playerSide)
  {
    super.drawUnit(x, y, w, h, playerSide, c);
  }

  
  void attack(Unit unit)
  {
    int dice = int(random(1, 100));
    int damage;
    float critMultiplier = 3;
    float dmgMultiplier = 2;

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
    this.stats.crit += critInc;
  }

  void statCard(float x, float y)
  {
    super.statCard(x, y);
    text("Type: " + type, x+statcardXinc, y+statcardYinc*6);
  }
}