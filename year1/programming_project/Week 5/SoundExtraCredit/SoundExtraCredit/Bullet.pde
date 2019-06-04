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

void collide(Alien[] theAliens){
    for(int i=0; i< 10; i++){
      if(xbul > theAliens[i].x && xbul < theAliens[i].x + 30 
      && ybul > theAliens[i].y && ybul < theAliens[i].y + 30){
        theAliens[i].die();
      }
    
    }
    //if(ybul  <= theAliens[0].y && xbul < theAliens[0].x + 30 && xbul >= theAliens[0].x )
    //  theAliens[0].die();
    //if(ybul  <= theAliens[1].y && xbul < theAliens[1].x + 30 && xbul >= theAliens[1].x )
    //  theAliens[1].die();
    //if(ybul  <= theAliens[2].y && xbul < theAliens[2].x + 30 && xbul >= theAliens[2].x )
    //  theAliens[2].die();
    //if(ybul  <= theAliens[3].y && xbul < theAliens[3].x + 30 && xbul >= theAliens[3].x )
    //  theAliens[3].die();
    //if(ybul  <= theAliens[4].y && xbul < theAliens[4].x + 30 && xbul >= theAliens[4].x )
    //  theAliens[4].die();
    //if(ybul  <= theAliens[5].y && xbul < theAliens[5].x + 30 && xbul >= theAliens[5].x )
    //  theAliens[5].die();
    //if(ybul  <= theAliens[6].y && xbul < theAliens[6].x + 30 && xbul >= theAliens[6].x )
    //  theAliens[6].die();
    //if(ybul  <= theAliens[7].y && xbul < theAliens[7].x + 30 && xbul >= theAliens[7].x )
    //  theAliens[7].die();
    //if(ybul  <= theAliens[8].y && xbul < theAliens[8].x + 30 && xbul >= theAliens[8].x )
    //  theAliens[8].die();
    //if(ybul  <= theAliens[9].y && xbul < theAliens[9].x + 30 && xbul >= theAliens[9].x )
    //  theAliens[9].die();
    
    }
  
}