class TextWidget extends Widget {
  int maxLen;

  TextWidget(int x, int y, int width, int height, String label, color widgetColor, PFont font, int event, int maxLen)
  {
    super(x, y, width, height, label, widgetColor, font, event);
    //this.x = x; 
    //this.y = y; 
    //this.width = width; 
    //this.height = height;
    //this.label = label; 
    //this.widgetFont = font;
    //this.event = event;
    this.maxLen = maxLen;
    this.widgetColor = widgetColor;
  }

  void append(char s)
  {
    if (s==BACKSPACE)
    {
      if ( !label.equals(""))
      {
        this.label = label.substring(0, label.length()-1);
      }
    }else if (label.length()<maxLen)
    {
      this.label = label+str(s);
    }
    // else if(key == SHIFT )
    //{
    //this.label = label.substring(0, label.length()-1);
    //}
     if (s == ENTER)
    {
      String searchWord = focus.getInput().substring(0, focus.getInput().length()-1); //enter key is taken off string so it can match the business name string
       {
          if (optionFocus.event == SEARCH_BY_USER_EVENT)
          {
            println("searching by reviewer");
            currentReviewer = getSearchedReviewer(searchWord);
            currentQuery = screenQuery5;
          } else if (optionFocus.event == SEARCH_BY_BUSINESS_EVENT)
          {
            println("searching by business");
            currentBusiness = getSearchedBusiness(searchWord);
            currentQuery = screenQuery2;        //found business becomes current business which is drawn when query 2 is set to the current query.
          }
        }
      println("enter key was executed");
    }
  }

  void clearBox()
  {
    this.label = "";      //when search box clicked it is cleared
  }
  
  void resetSearch()
  {
    this.label= "Search...";
  }
  
  String getInput() {
    return this.label;
  }
  
}