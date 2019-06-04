PFont stdFont; 
final int EVENT_BUTTON1=1; 
final int EVENT_FORWARD=2; 
final int EVENT_BUTTON2=3; 
final int EVENT_BACKWARD=4; 
final int EVENT_NULL=0; 
Widget widget1, widget2, widget3, widget4; 
Screen currentScreen, screen1, screen2; 
void setup(){ 
  stdFont=loadFont("Georgia-BoldItalic-48.vlw"); 
  textFont(stdFont); 
  widget1=new Widget(100, 100, 180, 40,"Button 1", color(200,0,0), stdFont, EVENT_BUTTON1);
  widget2=new Widget(100, 200, 180, 40,"Forward", color(0, 200, 0), stdFont, EVENT_FORWARD);  
  widget3=new Widget(100, 100, 180, 40,"Button 2", color(0,0,200), stdFont, EVENT_BUTTON2); 
  widget4=new Widget(100, 200, 180, 40,"Backward", color(0,200,200), stdFont, EVENT_BACKWARD);  
  size(400, 400); 
  screen1 = new Screen(color(0,128,128)); 
  screen2 = new Screen(color(90,30,160)); 
  screen1.add(widget1);  
  screen1.add(widget2); 
  screen2.add(widget3); 
  screen2.add(widget4); 
  currentScreen = screen1; 
} 
void draw(){ 
  currentScreen.draw(); 
} 
void mousePressed(){ 
  switch(currentScreen.getEvent(mouseX, mouseY)) { 
  case EVENT_BUTTON1: 
    println("***Button 1***"); 
    break; 
  case EVENT_BUTTON2: 
    println("***Button 2***"); 
    break; 
  case EVENT_FORWARD: 
    currentScreen = screen2; 
    break; 
  case EVENT_BACKWARD: 
    currentScreen = screen1; 
    break; 
  }   
} 