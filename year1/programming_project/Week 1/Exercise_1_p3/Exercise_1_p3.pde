int i = -50;
int k = -50;
int j = -50;
void setup(){
size(200, 200);
noStroke(); fill(255, 204, 0);
i=0;
}
void draw(){
background(255);
rect(i, 30, 50, 50);
if(i++ >= 150){
  rect(j, 30, 50, 50);
  if(j++ >= 150){
     rect(k, 30, 50, 50);
     if(k++ >= 150){
     j = -50;
     }
  }
}
}