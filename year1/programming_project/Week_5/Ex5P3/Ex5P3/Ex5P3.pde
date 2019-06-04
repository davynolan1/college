final int SCREENX =400;
final int SCREENY = 400;
final int BULLETWIDTH=5;
final int BULLETHEIGHT=5;
final int MARGIN=10;
final int GAP=5;

final int PADDLEHEIGHT = 15;
final int PADDLEWIDTH = 50;
boolean clicked = false;



Alien theAliens[];
Player thePlayer;
Bullet[] theBullet;
//Bomb theBomb;
Bomb myBomb;

void setup(){
  size(400, 400);
  PImage normalImg, explodeImg;
  normalImg= loadImage("spacer.GIF");
  explodeImg = loadImage("exploding.GIF");
  theAliens = new Alien[10];
  thePlayer = new Player(SCREENY-MARGIN-PADDLEHEIGHT);
  theBullet = new Bullet[9];
 
  
  
  init_bullets(theBullet, thePlayer.xposi, thePlayer.yposi);
  init_aliens(theAliens,normalImg, explodeImg);
 
}
void init_bullets(Bullet[] theBullet, int xposi, int yposi){
  for (int i = 0; i<9; i++){
      theBullet[i] = new Bullet(xposi, yposi);
}
}

void init_aliens(Alien baddies[], PImage okImg, PImage exImg){
  for(int i=0; i<baddies.length; i++){
  // This is buggy, what is the problem?
  baddies[i] = new Alien(i*(okImg.width+GAP), 0, okImg, exImg);
  }
}


void draw(){


background(0);

thePlayer.move(mouseX);
thePlayer.draw();
for (int i = 0; i<9; i++){
  
  
  if(theBullet[i].bulletVisible == true){
    theBullet[i].display();
    theBullet[i].move();
    theBullet[i].collide(theAliens);
  
  }
}

for(int i=0; i<theAliens.length; i++){
theAliens[i].move();
theAliens[i].draw();
Bomb myBomb=theAliens[i].getBomb();


if(myBomb!= null){
if(myBomb.collide(thePlayer)){
  noLoop();
  background(255);
  textSize(50);
  text("GAME OVER",50, 200);

}
}



      

}

}

  





void mousePressed(){
  for(int i = 0; i<9; i++){
    if(!theBullet[i].bulletVisible){
      theBullet[i].bulletVisible = true;
      theBullet[i].life = 255;
      theBullet[i].xbul = thePlayer.xposi + PADDLEWIDTH/2;
      theBullet[i].ybul = thePlayer.yposi - PADDLEHEIGHT - MARGIN;
      break;
    }
  }
}

class Alien {
  int x, y, direction;
  int status;
  PImage normalImg, explodeImg;
  //Bomb myBomb;
  Alien (int xpos, int ypos, PImage okImg, PImage exImg){
  x = xpos;
  y = ypos;
  status = ALIEN_ALIVE;
  normalImg=okImg;
  explodeImg=exImg;
  direction=FORWARD;
  myBomb = null;
  }

void move(){
  if(myBomb!= null){
myBomb.move();
if(myBomb.offScreen())
myBomb=null;
}
else if(status==ALIEN_ALIVE)
if(random(0, 100)<1) myBomb=new
Bomb(x, y);
  
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
  if(myBomb!=null)
    myBomb.draw();

  
  if(status==ALIEN_ALIVE)
    image(normalImg, x, y);
  else if(status!=ALIEN_DEAD){
    image(explodeImg, x, y);
    status++;
  }
  
// otherwise dead, don't draw anything
}
Bomb getBomb(){
    return myBomb;
}
void die(){
  if(status==ALIEN_ALIVE)
     status++;
}
void game_over(){
  noLoop();
}
}