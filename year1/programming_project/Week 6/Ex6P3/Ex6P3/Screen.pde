class Screen { 
  ArrayList screenWidgets; 
  color screenColor; 
  Screen(color currentcolor){ 
    screenWidgets=new ArrayList(); 
    screenColor=currentcolor; 
  } 
  void add(Widget myWidget){ 
    screenWidgets.add(myWidget); 
  }
  void draw(){ 
    background(screenColor); 
    for(int i = 0; i<screenWidgets.size(); i++){ 
      Widget aWidget = (Widget)screenWidgets.get(i); 
      aWidget.draw(); 
    } 
    
  } 
  int getEvent(int mx, int my){ 
    for(int i = 0; i<screenWidgets.size(); i++){ 
      Widget aWidget = (Widget) screenWidgets.get(i); 
      int event = aWidget.getEvent(mouseX,mouseY); 
      if(event != EVENT_NULL){ 
        return event; 
      } 
    } 
    return EVENT_NULL; 
  } 
}