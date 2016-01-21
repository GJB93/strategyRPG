class Stats
{
  int str;
  int dex;
  int mag;
  
  Stats()
  {
    int statSplit = 20;
    this.str = 0;
    this.dex = 0;
    this.mag = 0;
    
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
      }//end switch
    }//end while
  }//end Stats()
  
  Stats(int str, int dex, int mag)
  {
    this.str = str;
    this.dex = dex;
    this.mag = mag;
  }
}//end class