class Player extends Side
{
  Player()
  {
    super();
  }
  
  void showChoices()
  {
    for(int i=0; i<6; i++)
    {
      ArrayList<Unit> choices = new ArrayList<Unit>();
      for(int j=0; j<3; j++)
      {
        Stats stats = new Stats();
        int strDexDiff = abs(stats.str - stats.dex);
        int strMagDiff = abs(stats.str - stats.mag);
        int dexMagDiff = abs(stats.dex - stats.mag);
        
        if(strDexDiff < 5 && strDexDiff <= strMagDiff && strDexDiff <= dexMagDiff)
        {
          choices.add(new Swordsman(stats));
          println("Made a Swordsman");
        }
        else if(strMagDiff < 5 && strMagDiff <= dexMagDiff)
        {
          choices.add(new Templar(stats));
          println("Made a Templar");
        }
        else if(dexMagDiff < 5)
        {
          choices.add(new Assassin(stats));
          println("Made an Assassin");
        }
        else if(stats.str > stats.dex && stats.str > stats.mag)
        {
          choices.add(new Tank(stats));
          println("Made a Tank");
        }
        else if(stats.dex > stats.mag)
        {
          choices.add(new Ranger(stats));
          println("Made a Ranger");
        }
        else
        {
          choices.add(new Mage(stats));
          println("Made a Mage");
        }
      }//end inner for
      
      boolean choice = false;
      float rectW = width/3;
      while(!choice)
      {
        for(int j=0; j<choices.size(); j++)
        {
          fill(255);
          rect(j*rectW, 0, rectW, height);
          stroke(0);
          text(choices.get(j).fname + " " + choices.get(j).sname, (j*rectW)+10, 10);
          text(choices.get(j).type, (j*rectW)+10, 20);
          text(choices.get(j).stats.str, (j*rectW)+10, 30);
          text(choices.get(j).stats.dex, (j*rectW)+10, 40);
          text(choices.get(j).stats.mag, (j*rectW)+10, 50);
        }
      }
    }//end outer for
  }
}