final int IMAGE_HEIGHT = 50;
final int IMAGE_WIDTH = 50;
final int SCREEN_HEIGHT = 500;
final int SCREEN_WIDTH = 500;
PImage myImage;
Alien theAlien[];

void setup(){
   theAlien = new Alien[10];
   size(500, 500); 
   frameRate(250);
   myImage = loadImage("spacer.GIF");
   init_aliens(theAlien, myImage);
}

void init_aliens(Alien[] theAlien, PImage myImage){
  for(int i=0; i < theAlien.length; i++){
  theAlien[i] = new Alien();
  }
}
void draw(){
  background(255);
  frameRate(50);
  for(int i=0; i<theAlien.length; i++){
    
    theAlien[i].move();
    theAlien[i].draw();
  }
  
}


class Alien{
  float xpos = 50;
  float ypos = 50;
  float xd = 1;
  float yd = 1;
  
  
 

void move(){
  xpos = xpos + xd;
  if(xpos  == SCREEN_WIDTH - IMAGE_WIDTH){
     xd = 0;
     ypos++;
   }
   if(ypos == 100) xd = -1;
   
   if(xpos == 0){
     xd = 0;
     ypos++;
   }
   
   if(ypos == 150) xd = 1;
   if(ypos == 200) xd = -1;
   if(ypos == 250) xd = 1;
   if(ypos == 300) xd = -1;
   if(ypos == 350) xd = 1;
   if(ypos == 400) xd = -1;
   if(ypos == 450) xd = 1;
   


}

   void draw(){
    image(myImage, xpos, ypos, IMAGE_WIDTH, IMAGE_HEIGHT);
   
   
   }
}