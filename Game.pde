class Game
{
  Board board;
  Side playerOne;
  Side playerTwo;
  boolean playerOneFirst;
  
  Game()
  {
    board = new Board();
    playerOne = new Player();
    playerTwo = new Player();
    int coin = int(random(2));
    switch(coin)
    {
      case 0:
      {
        playerOneFirst = true;
        break;
      }
        
      case 1:
      {
        playerOneFirst = false;
        break;
      }
    }
  }
  
  void render()
  {
    if(!board.gameOver)
    {
      board.render();
      textAlign(LEFT, CENTER);
      textSize(16);
      fill(255);
      text("Player One", board.border, width*0.05f);
      textAlign(RIGHT, CENTER);
      text("Player Two", width-board.border, width*0.05f);
    }
    else
    {
      gameOverScreen();
    }
  }
  
  void gameOverScreen()
  {
    background(0);
    textAlign(CENTER, CENTER);
    fill(255);
    text("GAME OVER", width*0.5f, height*0.5f);
  }
  
  void initialBoard()
  {
    if(playerOneFirst)
    {
      for(Unit unit: playerOne.units)
      {
        boolean assignedSpace = false;
        board.setPlayerTurn();
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
        
      for(Unit unit: playerTwo.units)
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
      for(Unit unit: playerTwo.units)
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
        
      for(Unit unit: playerOne.units)
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
    board.checkPlayerUnits(!playerOneFirst);
  }
  
  void takeTurn()
  {
    board.checkMouse();
  }
}