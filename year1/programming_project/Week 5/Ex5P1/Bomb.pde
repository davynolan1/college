class Bomb {
  float xbomb;
  int ybomb;
  int bombdy;
  int bombLife = 255;
  //boolean bombVisible = true;
  
  color bombColor = color(0, 255, 0);
  
  Bomb(float dropPositionX,int dropPositionY){
    xbomb = dropPositionX;
    ybomb = dropPositionY;
    bombdy = 1;
  
  }
  
  void move(float xbom){
    ybomb += 3;
    //if(ybomb > 400) bombLife = -1;
    //if(bombLife == -1){
    //  bombVisible = false;
    //}
  }
  
  void draw(){
    fill (bombColor);
    ellipse (xbomb, ybomb, 20, 20);
  }

boolean offScreen(){
    boolean bombGone = false;
    if(ybomb > 400) bombLife = -1;
    if(bombLife == -1){
      bombGone = true;
    }
    return bombGone;
  }


}