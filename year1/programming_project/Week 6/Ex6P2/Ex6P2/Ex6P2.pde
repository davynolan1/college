PFont stdFont;
final int EVENT_BUTTON1=1;
final int EVENT_BUTTON2=2;
final int EVENT_BUTTON3=3;
final int EVENT_NULL=0;
final int SQUAREX = 260;
final int SQUAREY = 150;
final int SQWIDTH = 80;
final int SQHEIGHT = 80;
Widget widget1, widget2, widget3;
ArrayList widgetList;
int red;
int green;
int blue;


void setup(){
  
  stdFont=loadFont("Georgia-BoldItalic-48.vlw");
  textFont(stdFont);
  textSize(30);
  background(128,128,128);
  
  
  widget1=new Widget(30, 70, 180, 40,"Red", color(255,0,0),stdFont, EVENT_BUTTON1);
  widget2=new Widget(30, 170, 180, 40,"Green", color(0,255,0),stdFont, EVENT_BUTTON2);
  widget3=new Widget(30, 270, 180, 40,"Blue", color(0,0,255),stdFont, EVENT_BUTTON3);
 
  size(400, 400);
  
  widgetList = new ArrayList();
  widgetList.add(widget1); 
  widgetList.add(widget2);
  widgetList.add(widget3);

}

void draw(){
  
  for(int i = 0; i<widgetList.size(); i++){
  Widget aWidget = (Widget)widgetList.get(i);
  aWidget.draw();
  
  }
  
  fill(red,green,blue);
  stroke(0);
  rect(SQUAREX, SQUAREY, SQWIDTH, SQHEIGHT);
}

 
  


void mousePressed(){
  int event;
  
  for(int i = 0; i<widgetList.size(); i++){
  Widget aWidget = (Widget) widgetList.get(i);
       event = aWidget.getEvent(mouseX,mouseY);
       switch(event) {
         case EVENT_BUTTON1:
           red = 255;
           green = 0;
           blue = 0;
           //println("button 1!");
           break;
         case EVENT_BUTTON2:
           red = 0;
           green = 255;
           blue = 0;
           //println("button 2!");
           break;
         case EVENT_BUTTON3:
           red = 0;
           green = 0;
           blue = 255;
           //println("button 3!");
           break;
       }  
  }
 
}