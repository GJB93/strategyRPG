//Dexterity and magic cross unit

class Assassin extends Unit
{
  //Assassin has an ability to increase critical strike chance
  int critInc;
  
  /*
    Base constructor for assassin, calls the Unit constructor
    in order to set stats and details about the unit
  */
  Assassin()
  {
    super();
    this.c = color(0, 255, 255);
    this.range = 1;
    this.moveRange = 3;
    this.type = "Assassin";
    this.critInc = 10;
    sprite = loadImage("assassin.png");
  }
  
  /*
    Parameterised constructor for assassin, calls the Unit constructor
    with pre-set stats, then sets class specific stats
  */
  Assassin(Stats stats)
  {
    super(stats);
    this.c = color(0, 255, 255);
    this.range = 1;
    this.moveRange = 3;
    this.type = "Assassin";
    this.critInc = 10;
    sprite = loadImage("assassin.png");
  }
  
  /*
    Method used to draw the unit in its assigned color
  */
  void drawUnit(float x, float y, float w, float h, boolean playerSide)
  {
    super.drawUnit(x, y, w, h, playerSide, c);
  }
  
  /*
    Attack method calculates the amount of HP to be taken
    from a targeted unit, given a defense value. There is
    also a chance for the attack to 'critically strike'
    which increases damage dealt
  */
  void attack(Unit unit)
  {
    int dice = int(random(1, 100));
    int damage;
    float critMultiplier = 3;
    float dmgMultiplier = 2;
    
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