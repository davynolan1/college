int i;
void setup(){
size(200, 200);
noStroke(); fill(255, 204, 0);
i=0;
}
void draw(){
background(255);
rect(i, 20, 50, 50);
if(i++>=199) i=0;
}