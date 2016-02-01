class Game
{
  Board board;
  ArrayList<Unit> playerOneUnits;
  ArrayList<Unit> playerTwoUnits;
  ArrayList<Unit> playerChoices;
  boolean playerOneFirst;
  boolean gameStart;
  boolean teamSetup;
  boolean gameOver;
  
  Game()
  {
    gameStart = false;
    teamSetup = false;
    gameOver = false;
    board = new Board();
    playerOneUnits = new ArrayList<Unit>();
    playerTwoUnits = new ArrayList<Unit>();
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
      gameOver = true;
      gameOverScreen();
    }
  }
  
  void gameOverScreen()
  {
    background(0);
    textAlign(CENTER, CENTER);
    fill(255);
    text("GAME OVER \n Press any key to start again", width*0.5f, height*0.5f);
  }
  
  void createRandomTeam(ArrayList<Unit> units)
  {
    for(int i=0; i<6; i++)
    {
      units.add(createUnit());
    }
  }
  
  void createListOfChoices(int numberOfChoices)
  {
    playerChoices = new ArrayList<Unit>();
    for(int i=0; i<numberOfChoices; i++)
    {
      playerChoices.add(createUnit());
    }
  }
  
  void offerChoices()
  {
    float w = width/ (float)playerChoices.size();
    float h = height *0.8f;
    float topBorder = height*0.1f;
    for(int choice=0; choice<playerChoices.size(); choice++)
    {
      playerChoices.get(choice).statCard(w*choice, topBorder);
    }
  }
  
  void randomTeams()
  {
    createRandomTeam(playerOneUnits);
    createRandomTeam(playerTwoUnits);
    teamSetup = true;
  }
  
  void initialBoard()
  {
    if(playerOneFirst)
    {
      for(Unit unit: playerOneUnits)
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
        
      for(Unit unit: playerTwoUnits)
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
      board.checkPlayerUnits(playerOneFirst);
    }
    else
    {
      for(Unit unit: playerTwoUnits)
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
        
      for(Unit unit: playerOneUnits)
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
      board.setPlayerTurn();
    }
    
    gameStart = true;
  }
  
  void takeTurn()
  {
    board.checkMouse();
  }
  
  void teamsSet()
  {
    teamSetup = true;
  }
  
  Unit createUnit()
  {
    Stats stats = new Stats();
    int strDexDiff = abs(stats.str - stats.dex);
    int strMagDiff = abs(stats.str - stats.mag);
    int dexMagDiff = abs(stats.dex - stats.mag);
    
    
    if(stats.str > stats.dex && stats.str > stats.mag)
    {
      if(strDexDiff < 5 && strDexDiff < strMagDiff)
      {
        return new Swordsman(stats);
      }
      else if(strMagDiff < 5)
      {
        return new Templar(stats);
      }
      else
      {
        return new Tank(stats);
      }
    }
    else if(stats.dex > stats.mag)
    {
      if(dexMagDiff < 5 && dexMagDiff < strDexDiff)
      {
        return new Assassin(stats);
      }
      else if(strDexDiff < 5)
      {
        return new Swordsman(stats);
      }
      else
      {
        return new Ranger(stats);
      }
    }
    else
    {
      if(dexMagDiff < 5 && dexMagDiff < strMagDiff)
      {
        return new Assassin(stats);
      }
      else if(strMagDiff < 5)
      {
        return new Templar(stats);
      }
      else
      {
        return new Mage(stats);
      }
    }
  }
}