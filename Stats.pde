/*
  Stats class calculates and allocates stat numbers
  for each unit. These stats are then used to calculate
  a number of implicit stats such as attack power, ability
  power and health
*/

class Stats
{
  int str;
  int dex;
  int mag;
  int maxHp;
  int maxSp;
  int hp;
  int sp;
  int att;
  int def;
  int eva;
  float spd;
  int crit;
  int abl;

  /*
    Main constructor for the Stats class. It takes a base value for each stat (strength, dexterity and magic),
    then takes another value containing the number of points to be divided out to each stat. Once the all the
    stat points have been divided out, the implicit stats are calculated.
  */
  Stats()
  {
    int statSplit = 20;
    this.str = 10;
    this.dex = 10;
    this.mag = 10;

    while (statSplit > 0)
    {
      int statChoice = int(random(3));

      switch(statChoice)
      {
      case 0:
        {
          int temp = int(random(statSplit+1));
          this.str += temp;
          statSplit -= temp;
          break;
        }

      case 1:
        {
          int temp = int(random(statSplit+1));
          this.dex += temp;
          statSplit -= temp;
          break;
        }

      case 2:
        {
          int temp = int(random(statSplit+1));
          this.mag += temp;
          statSplit -= temp;
          break;
        }

      default:
        {
          println("Error in stat calculation");
          break;
        }
      }//end switch

      calculateImplicitStats();
    }//end while
  }//end Stats()

  Stats(int str, int dex, int mag)
  {
    this.str = str;
    this.dex = dex;
    this.mag = mag;
    calculateImplicitStats();
  }

  void calculateImplicitStats()
  {
    float hpMultiplier = 3;
    float spMultiplier = 1.8;
    float attMultiplier = 1;
    float defMultiplier = 1.2;
    float evaMultiplier = 1.1;
    float spdMultiplier = 0.1;
    float ablMultiplier = 1.2;
    float critMultiplier = 2.0;

    this.hp = int(this.str * hpMultiplier);
    this.maxHp = this.hp;
    this.sp = int(this.mag * spMultiplier);
    this.maxSp = this.sp;
    this.att = int(this.str * attMultiplier);
    this.def = int(this.str * defMultiplier);
    this.eva = int(this.dex * evaMultiplier);
    this.spd = this.dex * spdMultiplier;
    this.abl = int(this.mag * ablMultiplier);
    this.crit = int(this.mag * critMultiplier);
  }
}//end class