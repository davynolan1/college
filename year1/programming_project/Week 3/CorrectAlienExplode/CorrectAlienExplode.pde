final int SCREENX=400;
final int SCREENY=400;
final int GAP=10;
final int ALIEN_ALIVE=0;
final int ALIEN_DEAD=6;
final int FORWARD=0;
final int BACKWARD=1;

Alien theAliens[];
void setup(){
  size(400, 400);
  PImage normalImg, explodeImg;
  normalImg= loadImage("spacer.GIF");
  explodeImg = loadImage("exploding.GIF");
  theAliens = new Alien[10];
  init_aliens(theAliens,normalImg, explodeImg);
}

void init_aliens(Alien baddies[], PImage okImg, PImage exImg){
  for(int i=0; i<baddies.length; i++){
  // This is buggy, what is the problem?
  baddies[i] = new Alien(i*(okImg.width+GAP), 0, okImg, exImg);
  }
}
void draw(){
background(0);
for(int i=0; i<theAliens.length; i++){
theAliens[i].move();
theAliens[i].draw();
if(random(0, 500)<1)theAliens[i].die();
}
}

class Alien {
  int x, y, direction;
  int status;
  PImage normalImg, explodeImg;
 
  Alien (int xpos, int ypos, PImage okImg, PImage exImg){
  x = xpos;
  y = ypos;
  status = ALIEN_ALIVE;
  normalImg=okImg;
  explodeImg=exImg;
  direction=FORWARD;
  }

void move(){
  if(direction==FORWARD){
    if(x+normalImg.width<SCREENX-1)
    x++;
    else{
    direction=BACKWARD;
    y+=normalImg.height+GAP;
    }
  }
  else if(x>0) x--;
  else {
  direction=FORWARD;
  y+=normalImg.height+GAP;
  }
}
void draw(){
  if(status==ALIEN_ALIVE)
    image(normalImg, x, y);
  else if(status!=ALIEN_DEAD){
    image(explodeImg, x, y);
    status++;
  }
// otherwise dead, don't draw anything
}
void die(){
  if(status==ALIEN_ALIVE)
     status++;
}
}