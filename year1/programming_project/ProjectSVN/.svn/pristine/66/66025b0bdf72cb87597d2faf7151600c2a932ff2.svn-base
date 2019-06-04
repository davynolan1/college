class Widget {
  int x, y, width, height;
  String label; 
  int event;
  color widgetColor, labelColor;
  PFont widgetFont;
  int strokeNumber;


  Widget(int x, int y, int width, int height, String label, 
    color widgetColor, PFont widgetFont, int event) {
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

  void draw() {
    strokeWeight(4);
    stroke(strokeNumber);
    fill(widgetColor);
    rect(x, y+currentBusiness.scrollPos + anotherBusiness.scrollPos+currentReviewer.scrollPos, width, height);
    fill(labelColor);
    text(label, x+10, y+height-10+currentBusiness.scrollPos + anotherBusiness.scrollPos+currentReviewer.scrollPos);
  }

  int getEvent(int mX, int mY) {
    if (mX>x && mX < x+width && mY >y+currentBusiness.scrollPos + anotherBusiness.scrollPos+currentReviewer.scrollPos && mY <y+height+currentBusiness.scrollPos + anotherBusiness.scrollPos+currentReviewer.scrollPos) {
      return event;
    }
    return EVENT_NULL;
  }

  void mouseOver ()
  {
    this.strokeNumber= 255;
  }

  void mouseNotOver()
  {
    this.strokeNumber = 0;
  }
  
  void setWidgetColor(color theColor) {
   this.widgetColor = theColor; 
  }
  
  void fillOption ()
{
  if (optionFocus!=null)
  {
    optionFocus.setWidgetColor(color4);
  }
  if(optionNotSelected!=null)
  {
    optionNotSelected.setWidgetColor(255);
    
  }
}
}