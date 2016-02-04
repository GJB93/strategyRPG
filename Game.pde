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
  int numberOfUnitsPerTeam;
  float middleX;
  float middleY;
  
  Game()
  {
    middleX = width*0.5f;
    middleY = height*0.5f;
    numberOfUnitsPerTeam = 6;
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
      float playerOneXpos = board.borderX;
      float playerTwoXpos = width - board.borderX;
      float yPos = height*0.05f;
      board.render();
      textAlign(LEFT, CENTER);
      textSize(16);
      fill(255);
      text("Player One", playerOneXpos, yPos);
      textAlign(RIGHT, CENTER);
      text("Player Two", playerTwoXpos, yPos);
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
    textSize(32);
    fill(255);
    if(board.winningPlayer)
    {
      text("GAME OVER \n Player One wins!", middleX, middleY);
    }
    else
    {
      text("GAME OVER \n Player Two wins!", middleX, middleY);
    }
  }
  
  void createRandomTeam(ArrayList<Unit> units)
  {
    for(int i=0; i<numberOfUnitsPerTeam; i++)
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
    int numberOfPossCols = 2;
    for(Unit unit: playerOneUnits)
    {
      boolean assignedSpace = false;
      
      while(!assignedSpace)
      {
        int row = int(random(board.rows));
        int col = int(random(numberOfPossCols));
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
        int col = int(random(board.cols-numberOfPossCols, board.cols));
        boolean isSet = board.get(row, col);
        if(!isSet)
        {
          board.set(row, col, unit, false);
          assignedSpace = true;
        }//end if
      }//end while
    }//end for
    board.resetUnits(playerOneFirst);
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
    int diffValue = 5;
    
    if(stats.str > stats.dex && stats.str > stats.mag)
    {
      if(strDexDiff < diffValue && strDexDiff < strMagDiff)
      {
        return new Swordsman(stats);
      }
      else if(strMagDiff < diffValue)
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
      if(dexMagDiff < diffValue && dexMagDiff < strDexDiff)
      {
        return new Assassin(stats);
      }
      else if(strDexDiff < diffValue)
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
      if(dexMagDiff < diffValue && dexMagDiff < strMagDiff)
      {
        return new Assassin(stats);
      }
      else if(strMagDiff < diffValue)
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