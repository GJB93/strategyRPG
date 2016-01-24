void setup()
{
  size(500, 500);
  game = new Game();
  game.initialBoard();
}

Game game;

void draw()
{
  game.board.render();
}