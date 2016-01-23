class Game
{
  Board board;
  Side player;
  Side ai;
  boolean playerTurn;
  boolean aiTurn;
  
  Game()
  {
    board = new Board();
    player = new Player();
    ai = new AI();
    int coin = int(random(2));
    switch(coin)
    {
      case 0:
      {
        playerTurn = true;
        aiTurn = false;
        break;
      }
        
      case 1:
      {
        playerTurn = false;
        aiTurn = true;
        break;
      }
    }
  }
  
  void initialBoard()
  {
    if(playerTurn)
    {
      
    }
  }
  
  void takeTurn()
  {
    if(playerTurn)
    {
      for(Unit unit: player.units)
      {
        
      }
    }
    else
    {
      
    }
  }
}