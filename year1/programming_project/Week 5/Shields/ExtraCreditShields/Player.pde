class Player {
  
/* Insert your code from week 2 here to begin with, again you need
to remember the position and appearance of the Player, a constructor,
methods to move the player, and to draw the player */
 int xposi;
  int yposi;
  
  
  color paddlecolor = color(150);
  
  Player(int screen_y){
  xposi = SCREENX/2;
  yposi = screen_y;

  }
  void move(int x){
  if(x > SCREENX - PADDLEWIDTH) xposi = SCREENX - PADDLEWIDTH;
  else xposi = x;
  
  
  }
  void draw(){
  fill(paddlecolor);
  rect(xposi, yposi, PADDLEWIDTH, PADDLEHEIGHT);

  }
}