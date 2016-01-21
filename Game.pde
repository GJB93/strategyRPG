class Game
{
  Board board;
  Side player;
  Side ai;
  
  Game()
  {
    board = new Board();
    player = new Player();
    ai = new AI();
  }
}