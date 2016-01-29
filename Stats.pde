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
  
  Stats()
  {
    int statSplit = 20;
    this.str = 10;
    this.dex = 10;
    this.mag = 10;
    
    while(statSplit > 0)
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
    this.hp = this.str * 3;
    this.maxHp = this.hp;
    this.sp = int(this.mag * 1.8f);
    this.maxSp = this.sp;
    this.att = int(this.str);
    this.def = int(this.str * 1.2f);
    this.eva = int(this.dex * 1.1f);
    this.spd = this.dex * 0.1f;
    this.abl = int(this.mag * 1.5f);
    this.crit = int(this.mag * 1.5f);
  }
}//end class