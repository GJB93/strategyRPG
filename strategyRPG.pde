void setup()
{
  size(600, 600);
  gameStart = false;
  startMenu = true;
  exitButton = new Option(50, 50, width*0.05f, height-(height*0.09f), "Exit to\nmenu", color(50));
  menu = new Menu(width, height, 0, 0, color(200), "Strategy RPG");
  menu.addOption("Start Game");
  menu.addOption("Tutorial");
  menu.addOption("Exit");
  menuOptionClicked = -1;

  //game = new Game();
  //game.createListOfChoices(3);
}

Game game;
Menu menu;
boolean gameStart;
boolean startMenu;
Option nextButton;
Option backButton;
Option exitButton;
int menuOptionClicked;
int elapsed = 0;
int page;

void draw()
{
  background(200);
  //game.offerChoices();
  
  if (!gameStart)
  {
    elapsed = 0;
    menu.render();
    if (menuOptionClicked == 0)
    {
      game = new Game();
      game.randomTeams();
      game.initialBoard();
      startMenu = false;
      gameStart = true;
    }
    if (menuOptionClicked == 1)
    {
      page = 0;
      startMenu = false;
      showTutorial();
    }
    if (menuOptionClicked == 2)
    {
      exit();
    }
  } else
  {
    game.render();
    exitButton.render();
    boolean check = exitButton.checkMouseClick();
    if (game.gameOver)
    {
      if (elapsed != 120)
      {
        elapsed++;
      } else
      {
        gameStart = false;
        startMenu = true;
        menuOptionClicked = -1;
      }
    }
  }
  
}

void mouseClicked()
{
  if (gameStart)
  {
    game.takeTurn();
    if (exitButton.checkMouseClick())
    {
      startMenu = true;
      gameStart = false;
      menuOptionClicked = -1;
    }
  } else if (startMenu)
  {
    menuOptionClicked = menu.checkClick();
  }
}

void keyPressed()
{
  if (key == ' ')
  {
    if (game.gameOver)
    {
      game = new Game();
      game.randomTeams();
      game.initialBoard();
    }
  }
}

void showTutorial()
{
  background(200);
  switch(page)
  {
  case 0:
    {
      textSize(20);
      textAlign(CENTER, CENTER);
      fill(0);
      text("This is a turn based game", width*0.5f, height*0.1f);
      text("Players must move each of their units each turn", width*0.5f, height*0.2f);
      text("The mouse is used to control units in this game", width*0.5f, height*0.3f);
      text("Units highlighted in white can be selected by clicking them", width*0.5f, height*0.4f);
      text("You can move a selected unit to a blue highlighted cell", width*0.5f, height*0.5f);
      text("You can attack a unit that is highlighted in red", width*0.5f, height*0.6f);
      text("A unit dies and is removed from the game when its HP is zero", width*0.5f, height*0.7f);
      text("The game is over once one team has no remaining units", width*0.5f, height*0.8f);
      break;
    }
  }
  exitButton.render();
  if (exitButton.checkMouseClick())
  {
    startMenu = true;
  }
}