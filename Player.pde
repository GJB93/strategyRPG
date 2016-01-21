class Player extends Side
{
  Player()
  {
    super();
    for(int j=0; j<6; j++)
    {
      Stats stats = new Stats();
      int strDexDiff = abs(stats.str - stats.dex);
      int strMagDiff = abs(stats.str - stats.mag);
      int dexMagDiff = abs(stats.dex - stats.mag);
      
      
      if(stats.str > stats.dex && stats.str > stats.mag)
      {
        if(strDexDiff < 5 && strDexDiff < strMagDiff)
        {
          units.add(new Swordsman(stats));
          println("Made a Swordsman");
        }
        else if(strMagDiff < 5)
        {
          units.add(new Templar(stats));
          println("Made a Templar");
        }
        else
        {
          units.add(new Tank(stats));
          println("Made a Tank");
        }
      }
      else if(stats.dex > stats.mag)
      {
        if(dexMagDiff < 5 && dexMagDiff < strDexDiff)
        {
          units.add(new Assassin(stats));
          println("Made an Assassin");
        }
        else if(strDexDiff < 5)
        {
          units.add(new Swordsman(stats));
          println("Made a Swordsman");
        }
        else
        {
          units.add(new Ranger(stats));
          println("Made a Ranger");
        }
      }
      else
      {
        if(dexMagDiff < 5 && dexMagDiff < strMagDiff)
        {
          units.add(new Assassin(stats));
          println("Made an Assassin");
        }
        else if(strMagDiff < 5)
        {
          units.add(new Templar(stats));
          println("Made a Templar");
        }
        else
        {
          units.add(new Mage(stats));
          println("Made a Mage");
        }
      }
    }//end inner for
  }
}