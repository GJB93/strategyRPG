class Game
{
  Board board;
  Side player;
  Side ai;
  boolean playerFirst;
  
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
        playerFirst = true;
        break;
      }
        
      case 1:
      {
        playerFirst = false;
        break;
      }
    }
  }
  
  void render()
  {
    board.render();
  }
  
  void initialBoard()
  {
    if(playerFirst)
    {
      for(Unit unit: player.units)
      {
        boolean assignedSpace = false;
        
        while(!assignedSpace)
        {
          int row = int(random(board.rows));
          int col = int(random(2));
          boolean isSet = board.get(row, col);
          if(!isSet)
          {
            board.set(row, col, unit, true);
            assignedSpace = true;
          }//end if
        }//end while
      }//end for
        
      for(Unit unit: ai.units)
      {
        boolean assignedSpace = false;
        
        while(!assignedSpace)
        {
          int row = int(random(board.rows));
          int col = int(random(board.cols-2, board.cols));
          boolean isSet = board.get(row, col);
          if(!isSet)
          {
            board.set(row, col, unit, false);
            assignedSpace = true;
          }//end if
        }//end while
      }//end for
    }
    else
    {
      for(Unit unit: ai.units)
      {
        boolean assignedSpace = false;
        
        while(!assignedSpace)
        {
          int row = int(random(board.rows));
          int col = int(random(2));
          boolean isSet = board.get(row, col);
          if(!isSet)
          {
            board.set(row, col, unit, false);
            assignedSpace = true;
          }//end if
        }//end while
      }//end for
        
      for(Unit unit: player.units)
      {
        boolean assignedSpace = false;
        
        while(!assignedSpace)
        {
          int row = int(random(board.rows));
          int col = int(random(board.cols-2, board.cols));
          boolean isSet = board.get(row, col);
          if(!isSet)
          {
            board.set(row, col, unit, true);
            assignedSpace = true;
          }//end if
        }//end while
      }//end for
    }
  }
  
  void takeTurn()
  {
    if(playerFirst)
    {
      for(Unit unit: player.units)
      {
        boolean hasMoved = false;
        while(!hasMoved)
        {
          board.render();
        }
      }
    }
    else
    {
      for(Unit unit: player.units)
      {
        boolean hasMoved = false;
        while(!hasMoved)
        {
          board.render();
        }
      }
    }
  }
}