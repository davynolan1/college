class Bullet {
  /* Insert the code for your Bullet class here.
You need: variables to store the position aand appearance of the bullet.
A constructor
A method to move the bullet
A method to draw the bullet
A method to check for collisions
*/
int xbul;
int ybul;
color bulletcolor = color(150, 0, 0);
int dy;
int life = 255;
boolean bulletVisible = false;


Bullet(int shootingPositionX, int shootingPositionY){
  
  xbul = shootingPositionX;
  ybul = shootingPositionY;
  dy = 1;
  
  
}

void move(){
  
  ybul-= 4;
  if(ybul < 0) life = -1;
  if(life == -1){
    bulletVisible = false;
  }
  
}


void display(){
  
  fill(bulletcolor);
 
  rect(xbul, ybul, 4, 20);
}
}