final int SCREENX = 400;
final int SCREENY = 400;
final int PADDLEHEIGHT = 15;
final int PADDLEWIDTH = 50;
final int MARGIN = 10;

Player thePlayer;
Ball theBall;
Player theComputer;

void settings(){
  size(SCREENX, SCREENY);
}

void setup(){
  thePlayer = new Player(SCREENY-MARGIN-PADDLEHEIGHT);
  theBall = new Ball();
  theComputer =  new Player(0 +MARGIN + PADDLEHEIGHT);
  ellipseMode(RADIUS);
  
}
void draw(){
  background(0);
  theComputer.move(int(theBall.x));
  
  thePlayer.move(mouseX);
  theBall.move();
  
  theBall.collide(thePlayer); 
  
  theBall.draw();
  
  thePlayer.draw();
  
  
}