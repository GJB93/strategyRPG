void setup()
{
  size(500, 500);
  game = new Game();
  game.initialBoard();
}

Game game;

void draw()
{
  background(200);
  game.render();
}

void mouseClicked()
{
  game.takeTurn();
}