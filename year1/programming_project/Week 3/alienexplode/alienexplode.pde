final int IMAGE_HEIGHT = 50;
final int IMAGE_WIDTH = 50;
final int SCREEN_HEIGHT = 500;
final int SCREEN_WIDTH = 500;
PImage alienImage;
PImage explodeImage;
Alien theAlien[];

void setup(){
   theAlien = new Alien[10];
   size(500, 500); 
   frameRate(250);
   alienImage = loadImage("spacer.GIF");
   explodeImage = loadImage("exploding.GIF");
   init_aliens(theAlien, alienImage);
}

void init_aliens(Alien[] theAlien, PImage alienImage){
  for(int i=0; i < theAlien.length; i++){
  theAlien[i] = new Alien();
  }
}
void draw(){
  background(255);
  frameRate(100);
  
  for(int i=0; i<theAlien.length; i++){
    
    theAlien[i].move();
    theAlien[i].draw();
    theAlien[i].explode();
  }
  
}


class Alien{
  float[] xpos = {0, 50, 100, 150, 200, 250, 300, 350, 400, 445};
  float[] ypos = {50, 50, 50, 50, 50, 50, 50, 50 ,50, 50};
  float[] xd = {5, 5, 5, 5, 5, 5, 5, 5, 5, 5};
  float[] yd = {5, 5, 5, 5, 5, 5, 5, 5, 5, 5};
  
  
 

  void move(){
  
  for(int i = 0; i<10; i++){
    xpos[i] = xpos[i] + xd[i];
    if(xpos[i]  == 450){
       xd[i] = 0;
       ypos[i] = ypos[i] + yd[i];
     }
     if(ypos[i] == 100 ) xd[i] = -5;
     if(xpos[i] == 0 ){
       xd[i] = 0;
       ypos[i] = ypos[i] + yd[i];
     }
     //if(ypos[i] == 150) xd[i] = 5;
     //if(ypos[i] == 200 || ypos[i] == 250  || ypos[i] == 300 || ypos[i] == 350 || ypos[i] == 400 || ypos[i] == 450  ){
      // if(xd[i] == 0 && xpos[i] ==0) xd[i] = 5;
      // else if(xd[i] == 0 && xpos[i] ==450) xd[i] = -5;
       //else xd[i] = -xd[i];
     
     if(ypos[i] == 150) xd[i] = 5;
     if(ypos[i] == 200) xd[i] = -5;
     if(ypos[i] == 250) xd[i] = 5;
     if(ypos[i] == 300) xd[i] = -5;
     if(ypos[i] == 350) xd[i] = 5;
     if(ypos[i] == 400) xd[i] = -5;
     if(ypos[i] == 450) xd[i] = 5;
  }
  }




   void draw(){
    for(int i = 0; i<10; i++){
      
      image(alienImage, xpos[i], ypos[i], IMAGE_WIDTH, IMAGE_HEIGHT);
     }
     
   
   
   }
   void explode(){
      for(int i = 0; i<10; i++){ 
       if (xpos[9] == 50 && ypos[9] == 100) image(explodeImage, 50, 100, 70, 70);
       if (xpos[8] == 255 && ypos[8] == 100) image(explodeImage, 255, 100, 70, 70);
       if (xpos[7] == 300 && ypos[7] == 150) image(explodeImage, 300, 150, 70, 70);
       if (xpos[6] == 400 && ypos[6] == 100) image(explodeImage, 400, 100, 70, 70);
       if (xpos[5] == 190 && ypos[5] == 200) image(explodeImage, 190, 200, 70, 70);
       if (xpos[4] == 130 && ypos[4] == 150) image(explodeImage, 130, 150, 70, 70);
       if (xpos[3] == 400 && ypos[3] == 100) image(explodeImage, 400, 100, 70, 70);
       if (xpos[2] == 200 && ypos[2] == 150) image(explodeImage, 200, 150, 70, 70);
       if (xpos[1] == 70 && ypos[1] == 300) image(explodeImage, 70, 300, 70, 70);
       if (xpos[0] == 50 && ypos[0] == 400) image(explodeImage, 50, 400, 70, 70);
       
       
  
       
      }
   }

 }