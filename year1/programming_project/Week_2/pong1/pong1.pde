final int SCREENX = 400;
final int SCREENY = 400;
final int PADDLEHEIGHT = 15;
final int PADDLEWIDTH = 50;
final int MARGIN = 10;

Player thePlayer;
Ball theBall;
void settings(){
  size(SCREENX, SCREENY);
}

void setup(){
  thePlayer = new Player(SCREENY-MARGIN-PADDLEHEIGHT);
  theBall = new Ball();
  ellipseMode(RADIUS);
  
}
void draw(){
  background(0);
  thePlayer.move(mouseX);
  theBall.move();
  theBall.collide(thePlayer);
  thePlayer.draw();
  theBall.draw();
}

class Player{
  int xpos;
  int ypos;
  color paddlecolor = color(100);
  
  Player(int screen_y){
  xpos = SCREENX/2;
  ypos = screen_y;
  }
  void move(int x){
  if(x > SCREENX - PADDLEWIDTH) xpos = SCREENX - PADDLEWIDTH;
  else xpos = x;
  }
  void draw(){
  fill(paddlecolor);
  rect(xpos, ypos, PADDLEWIDTH, PADDLEHEIGHT);
  }
}

class Ball{
  float x;
  float y;
  float dx;
  float dy;
  int radius;
  color ballColor = color(200, 100, 50);

Ball(){
  x = random(SCREENX/4, SCREENX/2);
  y = random(SCREENY/4, SCREENY/2);
  dx = random(1, 2);
  dy = random(1, 2);
  radius = 5;
}
void move(){
  x = x + dx;
  y = y + dy;
}
void draw(){
  fill(ballColor);
  ellipse(int(x), int(y), radius, radius);
}
void collide(Player tp){
  if(x - radius <= 0) dx  = -dx;
  else if(x + radius >= SCREENX) dx = -dx;
  
  if(y + radius >= tp.ypos && y - radius < tp.ypos + PADDLEHEIGHT && x >= tp.xpos && x <= tp.xpos + PADDLEWIDTH){
  println("collided!");
  dy = -dy;
  }

}
}
  