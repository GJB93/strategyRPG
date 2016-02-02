void setup()
{
  size(600, 600);
  gameStart = false;
  
  menu = new Menu(width, height, 0, 0, color(200), "Strategy RPG");
  menu.addOption("Start Game");
  menu.addOption("Tutorial");
  menu.addOption("Exit");
  menuOptionClicked = -1;
  
  //game.createListOfChoices(3);
}

Game game;
Menu menu;
boolean gameStart;
int menuOptionClicked;
int elapsed = 0;

void draw()
{
  background(200);
  //game.offerChoices();
  if(!gameStart)
  {
    elapsed = 0;
    menu.render();
    if(menuOptionClicked == 0)
    {
      game = new Game();
      game.randomTeams();
      game.initialBoard();
      gameStart = true;
    }
    if(menuOptionClicked == 2)
    {
      exit();
    }
    
    menuOptionClicked = -1;
  }
  else
  {
    game.render();
    if(game.gameOver)
    {
      if(elapsed != 120)
      {
        elapsed++;
      }
      else
      {
        gameStart = false;
      }
    }
  }
}

void mouseClicked()
{
  if(gameStart)
  {
    game.takeTurn();
  }
  else
  {
    menuOptionClicked = menu.checkClick();
  }
}

void keyPressed()
{
  if(key == ' ')
  {
    if(game.gameOver)
    {
      game = new Game();
      game.randomTeams();
      game.initialBoard();
    }
  }
}