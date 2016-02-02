//Strength and Magic cross unit

class Templar extends Unit
{
  Templar()
  {
    super();
    this.c = color(255, 0, 255);
    this.range = 1;
    this.moveRange = 2;
    this.type = "Templar";
    sprite = loadImage("templar.png");
  }
  
  Templar(Stats stats)
  {
    super(stats);
    this.c = color(255, 0, 255);
    this.range = 1;
    this.moveRange = 2;
    this.type = "Templar";
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
    if((unit.stats.hp+10)>unit.stats.maxHp)
    {
      println("Unit healed for " + (unit.stats.maxHp - unit.stats.hp));
      unit.stats.hp = unit.stats.maxHp;
    }
    else
    {
      println("Unit healed for 10");
      unit.stats.hp += 10;
    }
  }
  
  void statCard(float x, float y)
  {
    super.statCard(x, y);
    text("Type: " + type, x+10, y+60);
  }
}