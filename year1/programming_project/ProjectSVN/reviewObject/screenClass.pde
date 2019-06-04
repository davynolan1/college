class Screen{
  int event;
  color backgroundColor;
  ArrayList<Widget>widgetList;
  ArrayList<TextWidget> textWidgetList;
  
  Screen(color backgroundColor, ArrayList<Widget>screenWidgets)
  {
    this.backgroundColor = backgroundColor;
    widgetList = new ArrayList<Widget>();
    widgetList = screenWidgets;
  }
  

  int getEvent()
  {      
    int event = EVENT_NULL;

    for (int i = 0; i<widgetList.size(); i++) {
      Widget aWidget = (Widget) widgetList.get(i);
      
      switch(aWidget.getEvent(mouseX, mouseY))
      {
      case EVENT_BUTTON1:
        event =EVENT_BUTTON1;
        break;
      case EVENT_BUTTON2:
        event = EVENT_BUTTON2;
        break;
      case EVENT_BUTTON3:
        event = EVENT_BUTTON3;
        break;
      case EVENT_BUTTON4:
        event = EVENT_BUTTON4;
       break; 
      }
    }
     return event;
  }

    void draw() {
    background(backgroundColor);
    for (int i = 0; i<widgetList.size(); i++) {
      Widget aWidget = (Widget)widgetList.get(i);
      aWidget.draw();
    }
  }
  
  public ArrayList getWidgets()
  {
    return this.widgetList;
  }
  
}