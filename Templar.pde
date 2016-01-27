//Strength and Magic cross unit

class Templar extends Unit
{
  Templar()
  {
    super();
    this.range = 1;
    this.moveRange = 2;
    this.type = "Templar";
    sprite = loadImage("templar.png");
  }
  
  Templar(Stats stats)
  {
    super(stats);
    this.range = 1;
    this.moveRange = 2;
    this.type = "Templar";
    sprite = loadImage("templar.png");
  }
  
  void drawUnit(float x, float y, boolean playerSide)
  {
    color c = color(255, 0, 255);
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
    
    if(dice <= this.stats.crit)
    {
      damage = round((this.stats.abl*1.3) - ((this.stats.abl*1.3)*unit.defend()));
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
      damage = round(this.stats.abl - ((this.stats.abl)*unit.defend()));
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
}