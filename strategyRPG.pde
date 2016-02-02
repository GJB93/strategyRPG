void setup()
{
  size(600, 600);
  game = new Game();
  game.randomTeams();
  game.initialBoard();
  //game.createListOfChoices(3);
}

Game game;

void draw()
{
  background(200);
  //game.offerChoices();
  game.render();
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