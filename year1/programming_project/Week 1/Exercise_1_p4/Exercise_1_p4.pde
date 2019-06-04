int i = -50;
int k = -50;
int j = -50;

int x = 200;
int y = 200;
int z = 200;

void setup(){
size(200, 200);

i=0;
}
void draw(){
background(255);
fill(250, 70, 0);
rect(i, 30, 50, 50);

if(i++ >= 150){
  rect(j, 30, 50, 50);
  if(j++ >= 150){
     rect(k, 30, 50, 50);
     if(k++ >= 200){
     k = -50;
     }
  }
}
fill(150, 100, 0);
rect(x, 110, 50, 50);

if(x-- <= 1){
  rect(y, 110, 50, 50);
  if(y-- <= 1){
  rect(z, 110, 50, 50);
  if(z-- == -50){
  z = 200;
  }
  }
}
}