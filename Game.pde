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
      for(Unit unit: player.units)
      {
        board.loadSprite(unit.sprite);
        boolean assignedSpace = false;
        
        while(!assignedSpace)
        {
          int row = int(random(10));
          int col = int(random(2));
          boolean isSet = board.get(row, col);
          if(!isSet)
          {
            board.set(row, col, true);
            assignedSpace = true;
          }//end if
        }//end while
      }//end for
        
      for(Unit unit: ai.units)
      {
        board.loadSprite(unit.sprite);
        boolean assignedSpace = false;
        
        while(!assignedSpace)
        {
          int row = int(random(10));
          int col = int(random(8, 9));
          boolean isSet = board.get(row, col);
          if(!isSet)
          {
            board.set(row, col, true);
            assignedSpace = true;
          }//end if
        }//end while
      }//end for
    }
    else
    {
      for(Unit unit: ai.units)
      {
        board.loadSprite(unit.sprite);
        boolean assignedSpace = false;
        
        while(!assignedSpace)
        {
          int row = int(random(10));
          int col = int(random(2));
          boolean isSet = board.get(row, col);
          if(!isSet)
          {
            board.set(row, col, true);
            assignedSpace = true;
          }//end if
        }//end while
      }//end for
        
      for(Unit unit: player.units)
      {
        board.loadSprite(unit.sprite);
        boolean assignedSpace = false;
        
        while(!assignedSpace)
        {
          int row = int(random(10));
          int col = int(random(8, 10));
          boolean isSet = board.get(row, col);
          if(!isSet)
          {
            board.set(row, col, true);
            assignedSpace = true;
          }//end if
        }//end while
      }//end for
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