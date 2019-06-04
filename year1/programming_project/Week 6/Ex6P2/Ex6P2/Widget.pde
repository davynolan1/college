class Widget {
  int x, y, width, height;
  String label; int event;
  color widgetColor, labelColor;
  PFont widgetFont;
  int white;

  Widget(int x,int y, int width, int height, String label,
  color widgetColor, PFont widgetFont, int event){
    this.x=x; 
    this.y=y; 
    this.width = width; 
    this.height= height;
    this.label=label; 
    this.event=event; 
    this.widgetColor=widgetColor; 
    this.widgetFont=widgetFont;
    labelColor= color(0);
   }
  void draw(){
    stroke(white);
    fill(widgetColor);
    rect(x,y,width,height);
    fill(labelColor);
    text(label, x+10, y+height-10);
    if(getEvent(mouseX, mouseY) == EVENT_NULL){
      white = 0;
    }
    if(widget1.getEvent(mouseX, mouseY)!= EVENT_NULL){
      widget1.white = 255;
      widget2.white = 0;
      widget3.white = 0;
    }
    if(widget2.getEvent(mouseX, mouseY)!= EVENT_NULL){
      widget1.white = 0;
      widget2.white = 255;
      widget3.white = 0;
    }
    if(widget3.getEvent(mouseX, mouseY)!= EVENT_NULL){
      widget1.white = 0;
      widget2.white = 0;
      widget3.white = 255;
    }
  }
  int getEvent(int mX, int mY){
     if(mX>x && mX < x+width && mY >y && mY <y+height){
        return event;
     }
     return EVENT_NULL;
  }
}