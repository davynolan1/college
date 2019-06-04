PFont words;
ArrayList<ReviewObject>reviewsList;
String Review1;
ArrayList<Widget>widgetList;
ArrayList<TextWidget>textWidgetList;
color color1 = color(119, 209, 210);
color color2 = color(252, 132, 252);
color color3 = color(250, 214, 255);
color color4 = color(252, 252, 8);
ArrayList<Widget> firstList;
ArrayList<Widget> secondList;
ArrayList<Widget> thirdList;
Table dataSet;
PImage logo;
BusinessObject foundBusiness;

Screen currentQuery;
Screen screenQuery1;                          //query 1 Screen = trending businesses ...homepage
Screen screenQuery2;                           //query 2 Screen = one business (when looked up or clicked on)
Screen screenQuery3;                            //

Screen screenQuery5;                          //query 3 Screen = one user (when looked up or clicked on)
BusinessObject currentBusiness;
BusinessObject anotherBusiness;
BusinessObject thirdBusiness;
BusinessObject searchedBusiness;
BusinessObject mostPopularBusiness;
BusinessObject mostPopularBusiness2;
BusinessObject mostPopularBusiness3;
TextWidget focus; 
Widget optionFocus;
Widget optionNotSelected;

Reviewer mostPopularReviewer;
Reviewer mostPopularReviewer2;
Reviewer mostPopularReviewer3;

Reviewer currentReviewer;

int reviewPrintIndex;

VScrollbar vs1;

void settings() {
  size(SCREEN_WIDTH, SCREEN_HEIGHT);
}

void setup() {
  logo = loadImage("Yelp_Logo.png");
  logo.resize(LOGO_HEIGHT, LOGO_WIDTH);
  background(0);
  reviewsList = new ArrayList<ReviewObject>();
  String[] reviews = loadStrings("reviews_cleaned.csv");
  dataSet = loadTable("reviews_cleaned.csv", "header");                //switch to string[] to run
  PFont words = loadFont("AgencyFB-Reg-30.vlw");
  textFont(words);

  vs1 = new VScrollbar(10, 0, 20, height, 2);

  for (int i=1; i<reviews.length; i++) 
  {
    String[] reviewsProperties = reviews[i].split(",");
    String userId = reviewsProperties[0];
    String userName = reviewsProperties[1];
    String businessId = reviewsProperties[2];
    String businessName = reviewsProperties[3];
    String s = reviewsProperties[4];
    int stars = int(s);
    String date = reviewsProperties[5];

    String u =reviewsProperties[reviewsProperties.length-3];
    int useful = int(u);
    String f = reviewsProperties[reviewsProperties.length-2];
    int funny = int(f);
    String c= reviewsProperties[reviewsProperties.length-1];
    int cool = int(c);
    reviewsProperties= splice(reviewsProperties, "^", 6);
    reviewsProperties=splice(reviewsProperties, "^", reviewsProperties.length-3);
    String stringedReview = join(reviewsProperties, " ");
    println(stringedReview);
    reviewsProperties = stringedReview.split("^");
    String text = reviewsProperties[0];
    text = text.substring(userId.length()+userName.length()+businessId.length()+businessName.length()+s.length()+date.length()+7);
    text = text.substring(0, text.length()-7);
    ReviewObject reviewObject= new ReviewObject(userId, userName, businessId, businessName, stars, date, text, useful, funny, cool);
    reviewsList.add(reviewObject);
  }

  int mostPopular = 1;
  //for (int index=0; index<reviewsList.size(); index++) {                                                                                                                          comment out for fast run
  //  println(index);
  //  ReviewObject tmpReview = reviewsList.get(index);
  //  println(tmpReview.businessName);
  //  BusinessObject testBusiness = new BusinessObject(tmpReview.getBusinessId(), reviewsList, words);        //generates most reviewed place, time intesive
  //  ArrayList testSize = testBusiness.getBusinessReviewList();                                            //DO NOT DELETE
  //  if (testSize.size()>mostPopular) {                                                                      //comment out for fast test run
  //    mostPopularBusiness=testBusiness;
  //    mostPopular=testSize.size();
  //  }
  //}
  //mostPopular = 1;
  //for (int index=0; index<reviewsList.size(); index++) {
  //  //println(index);
  //  ReviewObject tmpReview = reviewsList.get(index);
  //  //println(tmpReview.businessName);
  //  if (tmpReview.getBusinessName().equals(mostPopularBusiness.getBusinessName())) {
  //    index++;
  //  } else {
  //    println(index);
  //    println(tmpReview.businessName);
  //    BusinessObject testBusiness = new BusinessObject(tmpReview.getBusinessId(), reviewsList, words);
  //    ArrayList testSize = testBusiness.getBusinessReviewList();
  //    if (testSize.size()>mostPopular && testBusiness.getBusinessName()!=mostPopularBusiness.getBusinessName()) {
  //      mostPopularBusiness2=testBusiness;
  //      mostPopular=testSize.size();
  //    }
  //  }
  //}
  //mostPopular = 1;
  //for (int index=0; index<reviewsList.size(); index++) {
  //  //println(index);
  //  ReviewObject tmpReview = reviewsList.get(index);
  //  //println(tmpReview.businessName);
  //  if (tmpReview.getBusinessName().equals(mostPopularBusiness.getBusinessName())||tmpReview.getBusinessName().equals(mostPopularBusiness2.getBusinessName())) {
  //    index++;
  //  } else {
  //    println(index);
  //    println(tmpReview.businessName);
  //    BusinessObject testBusiness = new BusinessObject(tmpReview.getBusinessId(), reviewsList, words);
  //    ArrayList testSize = testBusiness.getBusinessReviewList();
  //    if (testSize.size()>mostPopular && testBusiness.getBusinessName()!=mostPopularBusiness.getBusinessName() && testBusiness.getBusinessName()!=mostPopularBusiness2.getBusinessName()) {
  //      mostPopularBusiness3=testBusiness;
  //      mostPopular=testSize.size();
  //    }
  //  }
  //}
  mostPopular = 1;
  for (int index=0; index<reviewsList.size(); index++) {
    println(index);
    ReviewObject tmpReview = reviewsList.get(index);
    println(tmpReview.userName);
    Reviewer testReviewer = new Reviewer(tmpReview.userId, tmpReview.userName, reviewsList);        //generates most reviewed place, time intesive
    ArrayList testSize = testReviewer.userReviewSet;                                            //DO NOT DELETE
    if (testSize.size()>mostPopular) {                                                                      //comment out for fast test run
      mostPopularReviewer=testReviewer;
      mostPopular=testSize.size();
    }
  }
  mostPopular = 1;
  for (int index=0; index<reviewsList.size(); index++) {
    //println(index);
    ReviewObject tmpReview = reviewsList.get(index);
    //println(tmpReview.businessName);
    if (tmpReview.getUserName().equals(mostPopularReviewer.getUserName())) {
      index++;
    } else {
      println(index);
      println(tmpReview.getUserName());
      Reviewer testReviewer = new Reviewer(tmpReview.userId, tmpReview.userName, reviewsList);
      ArrayList testSize = testReviewer.getUserReviewSet();
      if (testSize.size()>mostPopular && testReviewer.getUserName()!=mostPopularReviewer.getUserName()) {
        mostPopularReviewer2=testReviewer;
        mostPopular=testSize.size();
      }
    }
  }
  mostPopular = 1;
  for (int index=0; index<reviewsList.size(); index++) {
    //println(index);
    ReviewObject tmpReview = reviewsList.get(index);
    //println(tmpReview.businessName);
    if (tmpReview.getUserName().equals(mostPopularReviewer.getUserName())||tmpReview.getUserName().equals(mostPopularReviewer2.getUserName())) {
      index++;
    } else {
      println(index);
      println(tmpReview.getUserName());
      Reviewer testReviewer = new Reviewer(tmpReview.userId, tmpReview.userName, reviewsList);
      ArrayList testSize = testReviewer.getUserReviewSet();
      if (testSize.size()>mostPopular && testReviewer.getUserName()!=mostPopularReviewer.getUserName() && testReviewer.getUserName()!=mostPopularReviewer2.getUserName()) {
        mostPopularReviewer3=testReviewer;
        mostPopular=testSize.size();
      }
    }
  }
  //println("The most popular place is " + mostPopularBusiness.getBusinessName());                              comment out for fast run here
  //println("The 2nd most popular place is " + mostPopularBusiness2.getBusinessName());
  //println("The 3rd most popular place is " + mostPopularBusiness3.getBusinessName());
  //println("The most active reviewer is " + mostPopularReviewer.userName);
  //println("The 2nd most active reviewer is " + mostPopularReviewer2.userName);
  //println("Ther 3rd most active review is "+ mostPopularReviewer3.userName);                                    to here

  //currentBusiness = mostPopularBusiness;
  //anotherBusiness = mostPopularBusiness2;
  //thirdBusiness = mostPopularBusiness3;

  currentBusiness = new BusinessObject("AEx2SYEUJmTxVVB18LlCwA", reviewsList, words);    //test-user will be entering the business name and this will generate the ID to be passed in. //for fast run
  anotherBusiness = new BusinessObject("hjk3ox7w1akbEuOgTJ03Bw", reviewsList, words); //for fast run
  thirdBusiness = new BusinessObject("oWTn2IzrprsRkPfULtjZtQ", reviewsList, words); //for fast run
  
  mostPopularBusiness = new BusinessObject("AEx2SYEUJmTxVVB18LlCwA", reviewsList, words);    //for fast run
  mostPopularBusiness2 = new BusinessObject("hjk3ox7w1akbEuOgTJ03Bw", reviewsList, words); //for fast run
  mostPopularBusiness3 = new BusinessObject("oWTn2IzrprsRkPfULtjZtQ", reviewsList, words); //for fast run



  //currentReviewer = new Reviewer("bv2nCi5Qv5vroFiqKGopiw", "Tim", reviewsList);
  //anotherReviewer = new Reviewer("u0LXt3Uea_GidxRW1xcsfg", "Felecia", reviewsList);

  ReviewObject tmp = (ReviewObject) currentBusiness.businessReviewList.get(reviewPrintIndex);
  currentReviewer = new Reviewer(tmp.userId, tmp.userName, reviewsList);


  //searchedBusiness = null;
  //widgets tests
  firstList = new ArrayList<Widget>();                      //widgets that will be on screen 1 (homepage - trending resteraunts)
  secondList = new ArrayList<Widget>();                      //widgets that will be on screen 2 (business page)
  thirdList = new ArrayList<Widget>();
  textSize(30);

  Widget widget1=new Widget(100, 300, 250, 50, 
    currentBusiness.businessName.substring(3, currentBusiness.businessName.length()-3), color(100), 
    words, EVENT_BUTTON1);
  addWidget( widget1, firstList);

  Widget widget2 = new Widget(100, 400, 250, 50, anotherBusiness.businessName.substring(3, anotherBusiness.businessName.length()-3), color(100), words, EVENT_BUTTON2);
  addWidget(widget2, firstList);

  Widget widget3 = new Widget(100, 500, 250, 50, thirdBusiness.businessName.substring(3, thirdBusiness.businessName.length()-3), color(100), words, EVENT_BUTTON3);
  addWidget(widget3, firstList);

  Widget widget1Reviewer=new Widget(580, 300, 250, 50, 
    mostPopularReviewer.userName, color(100), 
    words, EVENT_BUTTON15);
  addWidget( widget1Reviewer, firstList);

  Widget widget2Reviewer = new Widget(580, 400, 250, 50, mostPopularReviewer2.userName, color(100), words, EVENT_BUTTON16);
  addWidget(widget2Reviewer, firstList);

  Widget widget3Reviewer = new Widget(580, 500, 250, 50, mostPopularReviewer3.userName, color(100), words, EVENT_BUTTON17);
  addWidget(widget3Reviewer, firstList);

  Widget widget4 = new Widget(740, 10, 250, 50, 
    "Go back", color(206, 202, 206), 
    words, EVENT_BUTTON4);   
  addWidget( widget4, secondList);
  addWidget(widget4, thirdList);

  Widget widget5 = new Widget(675, 750, 100, 50, "Previous", color(206, 202, 206), words, EVENT_BUTTON5);
  addWidget(widget5, secondList);

  Widget widget6 = new Widget(825, 750, 100, 50, "Next", color(206, 202, 206), words, EVENT_BUTTON6);
  addWidget(widget6, secondList);

  Widget widget7 = new Widget(40, 850, 100, 50, "Previous", color(206, 202, 206), words, USER_PREV);
  addWidget(widget7, thirdList);

  Widget widget8 = new Widget(150, 850, 100, 50, "Next", color(206, 202, 206), words, USER_NEXT);
  addWidget(widget8, thirdList);

  //Widget userNameWidget = new Widget(50, 255, 150, 50, currentReviewer.userName, color(100), words, USER_BUTTON);
  //addWidget(userNameWidget, secondList);

  TextWidget searchBar = new TextWidget(310, 25, 400, 40, //search bar, last parameter is the max input length
    "1. Search User      2. Search Business", color(255), words, SEARCH_BUTTON, 33);
  addWidget(searchBar, firstList);

  Widget searchButton = new Widget(710, 25, 50, 40, "Go!", color(color4), words, EVENT_BUTTON8);
  addWidget(searchButton, firstList);

  Widget userNameWidget = new Widget(50, 240, 150, 50, currentReviewer.userName, color(250, 142, 40), words, USER_BUTTON);
  addWidget(userNameWidget, secondList);

  Widget widget9searchOption1=new Widget(270, 20, 20, 20, 
    "", color(255), 
    words, SEARCH_BY_USER_EVENT);
  addWidget( widget9searchOption1, firstList);

  Widget widget10searchOption2=new Widget(270, 50, 20, 20, 
    "", color(255), 
    words, SEARCH_BY_BUSINESS_EVENT);
  addWidget( widget10searchOption2, firstList);

  screenQuery1 = new Screen(color1, firstList);
  screenQuery2 = new Screen(color2, secondList);
  screenQuery3 = new Screen(color2, secondList);

  screenQuery5 = new Screen(color3, thirdList);

  currentQuery =  screenQuery1;                                                                  //default query = query 1
}

void draw() {
  currentQuery.draw();
  if (currentQuery ==  screenQuery1)
  {
    fill(194, 232, 237);
    stroke(3);
    rect(75, 150, TITLE_WIDTH, TITLE_HEIGHT);
    fill(0);
    text(1, 250, 40);
    text(2, 250, 70);
    text("Trending now", 150, 200);                             //heading for homepage if on homepage screen trending businesses.
    image(logo, 350, 700);
    fill(194, 232, 237);
    stroke(3);
    rect(555, 150, TITLE_WIDTH, TITLE_HEIGHT);
    fill(0);
    text("Active Reviewers", 625, 200);                             //heading for homepage if on homepage screen active users.
  } else if (currentQuery == screenQuery5) {
    currentReviewer.draw();
  } else if (currentQuery ==  screenQuery2)
  {
    currentBusiness.draw();
  } else if (currentQuery == screenQuery3) {
    anotherBusiness.draw();
  }
}
void mouseMoved() {                                                  //widgets highlighted to show they are clickable
  int event;
  widgetList = currentQuery.getWidgets();
  for (int i = 0; i<widgetList.size(); i++) {
    Widget aWidget = (Widget) widgetList.get(i);
    event = aWidget.getEvent(mouseX, mouseY);
    if (event<SEARCH_BUTTON) {
      if (event != EVENT_NULL) {
        aWidget.mouseOver();
      } else
        aWidget.mouseNotOver();
    }
  }
}
void mousePressed() {                                                //function carried out in response to mouse click
  int event;
  widgetList = currentQuery.getWidgets();
  for (int i = 0; i<widgetList.size(); i++) {
    Widget aWidget = (Widget) widgetList.get(i); //checking if regular widget was pressed
    event = aWidget.getEvent(mouseX, mouseY);
    if (event<SEARCH_BUTTON) {
      switch(event) {
      case EVENT_BUTTON1:
        println("button 1!"); 
        currentBusiness = mostPopularBusiness;
        ReviewObject tmpN = (ReviewObject) currentBusiness.businessReviewList.get(reviewPrintIndex);
        currentReviewer = new Reviewer(tmpN.userId, tmpN.userName, reviewsList);
        println("current reviewer is "+currentReviewer.userName);
        println(currentReviewer.userReviewSet.size());
        Widget nxUserNameWidget = new Widget(50, 240, 150, 50, currentReviewer.userName, color(250, 142, 40), words, USER_BUTTON);
        addWidget(nxUserNameWidget, secondList);
        println(currentBusiness.businessReviewList.size());
        currentQuery =  screenQuery2;
        break;
      case EVENT_BUTTON2:
        println("button 2!");
        currentBusiness = mostPopularBusiness2;
        tmpN = (ReviewObject) currentBusiness.businessReviewList.get(reviewPrintIndex);
        currentReviewer = new Reviewer(tmpN.userId, tmpN.userName, reviewsList);
        println("current reviewer is "+currentReviewer.userName);
        println(currentReviewer.userReviewSet.size());
        nxUserNameWidget = new Widget(50, 240, 150, 50, currentReviewer.userName, color(250, 142, 40), words, USER_BUTTON);
        addWidget(nxUserNameWidget, secondList);
        println(currentBusiness.businessReviewList.size());
        currentQuery =  screenQuery2;                            //laura comment - should it not still be screen query 2 i.e. business displaying but current business be switched to the second one?
        break;
      case EVENT_BUTTON3:                                //later on will do whatever function the widget pressed says it does. For now just showing they pressed.
        println("button 3!");
        tmpN = (ReviewObject) currentBusiness.businessReviewList.get(reviewPrintIndex);
        currentReviewer = new Reviewer(tmpN.userId, tmpN.userName, reviewsList);
        println("current reviewer is "+currentReviewer.userName);
        println(currentReviewer.userReviewSet.size());
        nxUserNameWidget = new Widget(50, 240, 150, 50, currentReviewer.userName, color(250, 142, 40), words, USER_BUTTON);
        addWidget(nxUserNameWidget, secondList);
        println(currentBusiness.businessReviewList.size());
        currentBusiness = mostPopularBusiness3;
        currentQuery =  screenQuery2;    //search query
        break;
      case EVENT_BUTTON4:
        reviewPrintIndex = 0;
        currentQuery =  screenQuery1;
        if (focus!=null)
        {
          focus.label="1. Search User      2. Search Business";
        }
        break;
      case EVENT_BUTTON5:
        //println("button 5!");
        if (reviewPrintIndex!=0)reviewPrintIndex--;
        ReviewObject tmpP = (ReviewObject) currentBusiness.businessReviewList.get(reviewPrintIndex);
        currentReviewer = new Reviewer(tmpP.userId, tmpP.userName, reviewsList);
        println("current reviewer is "+currentReviewer.userName);
        println(currentReviewer.userReviewSet.size());
        Widget prUserNameWidget = new Widget(50, 240, 150, 50, currentReviewer.userName, color(250, 142, 40), words, USER_BUTTON);
        addWidget(prUserNameWidget, secondList);
        break;
      case EVENT_BUTTON6:
        println("button 6!"); //next business
        if (reviewPrintIndex<=currentBusiness.businessReviewList.size()) {
          reviewPrintIndex++;
          tmpN = (ReviewObject) currentBusiness.businessReviewList.get(reviewPrintIndex);
          currentReviewer = new Reviewer(tmpN.userId, tmpN.userName, reviewsList);
          println("current reviewer is "+currentReviewer.userName);
          println(currentReviewer.userReviewSet.size());
          nxUserNameWidget = new Widget(50, 240, 150, 50, currentReviewer.userName, color(250, 142, 40), words, USER_BUTTON);
          addWidget(nxUserNameWidget, secondList);
          println(currentBusiness.businessReviewList.size());
        }
        break;
      case USER_BUTTON:
        println("User button!");
        currentQuery = screenQuery5;
        reviewPrintIndex = 0;
        currentBusiness.scrollPos = 0;
        break;
      case EVENT_BUTTON8:
        println("GO! search pressed");      //when user press go takes the input and finds a matching business in function
        String searchWord=focus.getInput();
        if (optionFocus != null)
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
        println("go was executed");

        break;
      case USER_NEXT:
        println("Next user review!");
        if (reviewPrintIndex<currentReviewer.userReviewSet.size()-1)
          reviewPrintIndex++;
        break;
      case USER_PREV:
        println("Previous user review!");
        if (reviewPrintIndex != 0) {
          reviewPrintIndex--;
        }
        break;
      case SEARCH_BY_USER_EVENT:
        if (optionFocus!=null)
        {
          optionNotSelected = optionFocus;
        }
        optionFocus = aWidget;
        if (optionNotSelected!=null)
        {
          optionNotSelected.fillOption();
        }
        optionFocus.fillOption();
        break;
      case SEARCH_BY_BUSINESS_EVENT:                                //laura - allows user to either select search by busines or search by user option(need to add labels to say business/user)
        if (optionFocus!=null)
        {
          optionNotSelected = optionFocus;
        }
        optionFocus = aWidget;
        if (optionNotSelected!=null)
        {
          optionNotSelected.fillOption();
        }
        optionFocus.fillOption();
        break;
      case EVENT_BUTTON15:
        currentReviewer = mostPopularReviewer;
        currentQuery = screenQuery5;
        break;
      case EVENT_BUTTON16:
        currentReviewer = mostPopularReviewer2;
        currentQuery = screenQuery5;
        break;
      case EVENT_BUTTON17:
        currentReviewer = mostPopularReviewer3;
        currentQuery = screenQuery5;
        break;
      }
    } else {
      TextWidget aTextWidget = (TextWidget)widgetList.get(i);
      event = aTextWidget.getEvent(mouseX, mouseY);
      switch(event) {
      case SEARCH_BUTTON:
        aTextWidget.clearBox();
        focus = aTextWidget;
        println("search button");
        break;
      }
    }
  }
}

void keyPressed()
{
  if (focus != null)
  {
    focus.append(key);
    println("label is: "+focus.getInput());      //same issue, has ? when SHIFT is pressed
  }
}

BusinessObject getSearchedBusiness(String searchWord)
{
  BusinessObject foundBusiness = null;
  boolean matchFound = false;
  int count = 1;

  while (!matchFound && count<reviewsList.size())
  {
    PFont words = loadFont("AgencyFB-Reg-30.vlw");
    textFont(words);
    BusinessObject tempBusiness = new BusinessObject(reviewsList.get(count).businessId, reviewsList, words);   //go through each business in review list, get the name and change to lower case, see if it matchs the searched word and if so return this business.
    println("temp business Id is " + tempBusiness.businessId);
    String tempBusName = tempBusiness.businessName.substring(3, tempBusiness.businessName.length()-3).toLowerCase();
    println("Temp bus name = " + tempBusName);
    println("temp bus objects name is " + tempBusiness.businessName);
    println("search word = " + searchWord);

    if (tempBusName.equals(searchWord))
    {
      println("match business found");
      foundBusiness = tempBusiness;
      println(foundBusiness.businessName);
      matchFound = true;
    } else if (!tempBusName.equals(searchWord)) {
      println("did not match a business");
      // text("ERROR - Business not found.", 100, 100);                      //attempting an error message, not working yet.
      count++;
      println(count);
    } else
    {
      text("Searching for business...", 100, 100);                          //attempting an error message, not working yet.
    }
  }
  return foundBusiness;
}
Reviewer getSearchedReviewer(String searchWord)
{
  Reviewer foundReviewer = null;
  boolean matchFound = false;
  int count = 1;
  while (!matchFound && count<reviewsList.size())
  {
    PFont words = loadFont("AgencyFB-Reg-30.vlw");
    textFont(words);
    Reviewer tempReviewer = new Reviewer(reviewsList.get(count).userId, reviewsList.get(count).userName, reviewsList);   //go through each user in review list, get the name and change to lower case, see if it matchs the searched word and if so return this business.
    String tempReviewerName = tempReviewer.userName.toLowerCase();
    println("Temp user name = " + tempReviewerName);
    println("search word = " + searchWord);

    if (tempReviewerName.equals(searchWord))
    {
      println("match reviewer found");
      foundReviewer =tempReviewer;
      println(foundReviewer.userName);
      matchFound = true;
    } else if (!tempReviewerName.equals(searchWord)) {
      println("did not match a user");
      // text("ERROR - Reviewer not found.", 100, 100);                          //attempting an error message, not working yet.
      count++;
      println(count);
    } else
    {
      text("Searching for business...", 100, 100);                              //attempting an error message, not working yet.
    }
  }
  return foundReviewer;
}


void addWidget(Widget theWidget, ArrayList<Widget>widgetList) 
{
  widgetList.add(theWidget);
}