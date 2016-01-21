class Player extends Side
{
  Player()
  {
    super();
    while(units.size() < 6)
    {
      Unit unit = new Unit();
    }
  }
}