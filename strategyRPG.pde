void setup()
{
  size(600, 600);
  game = new Game();
  game.randomTeams();
  game.initialBoard();
  menu = new Menu(width, height, 0, 0, color(50));
  menu.addOption("Hello");
  menu.addOption("How");
  menu.addOption("Are");
  menu.addOption("You");
  //game.createListOfChoices(3);
}

Game game;
Menu menu;

void draw()
{
  background(200);
  //game.offerChoices();
  game.render();
  menu.render();
}

void mouseClicked()
{
  game.takeTurn();
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