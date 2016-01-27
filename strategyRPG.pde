void setup()
{
  size(500, 500);
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