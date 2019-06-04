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
Bomb theBomb;


void setup(){
  size(400, 400);
  PImage normalImg, explodeImg;
  normalImg= loadImage("spacer.GIF");
  explodeImg = loadImage("exploding.GIF");
  theAliens = new Alien[10];
  thePlayer = new Player(SCREENY-MARGIN-PADDLEHEIGHT);
  theBullet = new Bullet[9];
  theBomb = new Bomb(random(0, 400), 0);
  
  
  init_bullets(theBullet, thePlayer.xposi, thePlayer.yposi);
  init_aliens(theAliens,normalImg, explodeImg);
  //init_bombs(theBomb, random(0, 400), 0); 
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

//void init_bombs(Bomb theBomb){
//  if(random(0, 500)<1){
//  for(int i=0; i<theBomb.length; i++){
//     theBomb[i] = new Bomb(random(0, SCREENX - 20), 0);
//   }
//  }

//}
void draw(){

if(!theBomb.collide(thePlayer)) background(0);


if(!theBomb.collide(thePlayer))thePlayer.move(mouseX);
thePlayer.draw();
for (int i = 0; i<9; i++){
  
  
  if(theBullet[i].bulletVisible == true){
    theBullet[i].display();
    theBullet[i].move();
    theBullet[i].collide(theAliens);
  
  }
}

for(int i=0; i<theAliens.length; i++){
if(!theBomb.collide(thePlayer))theAliens[i].move();
theAliens[i].draw();

//if(random(0, 500)<1)theAliens[i].die();
}



      
theBomb.draw();
if(!theBomb.collide(thePlayer))theBomb.move(random(0, 400));
if(theBomb.collide(thePlayer)){
  background(255);
  textSize(50);
  text("GAME OVER",50, 200);

}
}
   // }
  





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