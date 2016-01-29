//Dexterity and magic cross unit

class Assassin extends Unit
{
  Assassin()
  {
    super();
    this.range = 1;
    this.moveRange = 3;
    this.type = "Assassin";
    sprite = loadImage("assassin.png");
  }
  
  Assassin(Stats stats)
  {
    super(stats);
    this.range = 1;
    this.moveRange = 3;
    this.type = "Assassin";
    sprite = loadImage("assassin.png");
  }
  
  void drawUnit(float x, float y, boolean playerSide)
  {
    color c = color(0, 255, 255);
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
    float critMultiplier = 3;
    float dmgMultiplier = 2;
    
    if(dice <= this.stats.crit)
    {
      damage = round((this.stats.att*critMultiplier) - ((this.stats.att*critMultiplier)*unit.defend()));
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
      damage = round(this.stats.att*dmgMultiplier - ((this.stats.att*dmgMultiplier)*unit.defend()));
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
    this.stats.crit += 10;
  }
  
  void statCard(float x, float y, float w, float h)
  {
    super.statCard(x, y, w, h);
    text("Type: " + type, x+10, y+60);
  }
}