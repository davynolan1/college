class BusinessObject {
  int numOfStars;
  String businessId;
  String businessName;
  ArrayList businessReviewList=new ArrayList<ReviewObject>();
  int avgStars;
  PImage star = loadImage("starImage.png");
  PImage blankStar = loadImage("blankStarImage.png");
  PFont font;
  float barWidth1;
  float barWidth2;
  float barWidth3;
  float barWidth4;
  float barWidth5;
  int reviewXpos;
  int reviewYpos;
  Widget userWidget;
  float scrollPos;
  Reviewer theReviewer;

  BusinessObject(String businessId, ArrayList<ReviewObject> reviews, PFont font) {
    int index = 0;
    boolean nameFound = false;
    while (!nameFound && index<reviews.size()) {
      ReviewObject tmpReview = (ReviewObject)reviews.get(index);
      if (tmpReview.businessId.equals(businessId)) {
        this.businessName=tmpReview.businessName;
        nameFound=true;
      } else {
        index++;
      }
    }
    for (int count=0; count<reviews.size(); count++) {
      ReviewObject tmpReview = (ReviewObject)reviews.get(count);
      if (tmpReview.businessName.equals(businessName)) {
        businessReviewList.add(tmpReview); 
        //println(count); 
        //println(tmpReview.businessName);//all reviews of this particular business will be stored in businessReviewList
        this.numOfStars+=tmpReview.numOfStars;
      }
    }

    this.font=font;
    textFont(font);
    avgStars = numOfStars/businessReviewList.size();
  }

  void draw() {
    scrollPos = vs1.getPos();
    vs1.update();
    vs1.display();
    fill(0);
    if(businessName.equals("#N/A")){
      text(businessName, 100, 100+scrollPos);
    }
    else{
      text(businessName.substring(3, businessName.length()-3), 100, 100+scrollPos);
    }
    text("Bar Chart of Stars", 700, 370+scrollPos);
    text("Amount of Stars", 700, 630+scrollPos);

    //average stars printed to screen
    star.resize(STAR_WIDTH, STAR_HEIGHT);
    blankStar.resize(STAR_WIDTH, STAR_HEIGHT);
    int starXpos = 50;
    int blankStarXpos = 275;
    for (int i=0; i < avgStars; i++)
    {
      image(star, starXpos, 150+scrollPos);
      starXpos+=55;
    }
    for(int j=0; j<5-avgStars; j++){
        image(blankStar, blankStarXpos, 150+scrollPos);
        blankStarXpos -= 55;
    }

    //int starStart=1900;
    //for (int index=1; index<=avgStars; index++) {          //does not work in practise yet but leave in.
    //  image(star, starStart, 1900);
    //  delay(2000);
    // starStart+=STAR_WIDTH;
    //}




    //drawing bar chart
    barWidth1 = 0;
    barWidth2 = 0;
    barWidth3 = 0;
    barWidth4 = 0;
    barWidth5 = 0;

    int numStart = 440;
    noStroke();
    rect(700, 400+scrollPos, 5, 200);                      //axis for rectangle
    rect(700, 600+scrollPos, 400, 5);
    for (int j=5; j>=1; j--) {                      //labelling axis with nunbers

      image(star, 650, numStart - 40+scrollPos);
      text(int(j), 670, numStart+scrollPos);
      numStart += 40;
    }


    for (int index=0; index<businessReviewList.size(); index++) {
      ReviewObject temp = (ReviewObject)businessReviewList.get(index);
      if (temp.numOfStars == 1) {
        barWidth1 += 2.5;
        fill(206, 6, 6);
        rect(705, 400+(BAR_HEIGHT*4)+scrollPos, barWidth1, BAR_HEIGHT);
      }
      if (temp.numOfStars == 2) {
        barWidth2 += 2.5;
        fill(245, 150, 7);
        rect(705, 400+(BAR_HEIGHT*3)+scrollPos, barWidth2, BAR_HEIGHT);
      }
      if (temp.numOfStars == 3) {
        barWidth3 += 2.5;
        fill(244, 245, 7);
        rect(705, 400+(BAR_HEIGHT*2)+scrollPos, barWidth3, BAR_HEIGHT);
      }
      if (temp.numOfStars == 4) {
        barWidth4 += 2.5;
        fill(145, 245, 59);
        rect(705, 400+BAR_HEIGHT+scrollPos, barWidth4, BAR_HEIGHT);
      }
      if (temp.numOfStars == 5) {
        barWidth5 += 2.5;
        fill(52, 233, 26);
        rect(705, 400+scrollPos, barWidth5, BAR_HEIGHT);
      }
    }

    //drawing the users review up 
    ReviewObject userReview =(ReviewObject)businessReviewList.get(reviewPrintIndex);      //test single instance ... WHEN next widget is pressed it should go to next review.
    int i = 0;
    // Widget userWidget = new Widget();
    stroke(0);
    fill(255,149,149);
    rect(20, 310+scrollPos, 610, 100);
    fill(180, 248, 255);
    rect(20, 370+scrollPos, 610, reviewYpos-350);
    noStroke();
    fill(0);

    text("Date: "+userReview.date, 400, 350+scrollPos);

    String text = "";
    String[] textString =  userReview.text.split(" ");                          //make a string array of thr words in review text
    reviewXpos = 25; 
    reviewYpos = 400;
    for (int j=0; j<textString.length; j++)                                    //prints each word one by one, moving the xpos by number of charachters in the word + number.
    {
      text = textString[j];
      char[] textChar = text.toCharArray();
      int wordLength = textChar.length*15;                                      //moving forward xpos after each word by word length *15 so enough space.

      if (textChar.length>0) {

        String lastCharachter = str(textChar[textChar.length-1]);
        if (lastCharachter.equals("."))
        {
          wordLength = textChar.length*200;                                         //after full stop indents the text.
        } else if (lastCharachter.equals("!"))
        {
          wordLength = textChar.length*200;
        }
        if (text.equals("a"))                                                        //"a" is small so need to have more space between next word
        {
          wordLength = wordLength +5;
        }
      }
      text(text, reviewXpos, reviewYpos+scrollPos);
      reviewXpos = reviewXpos+wordLength;
      if (reviewXpos+wordLength>470)                                                //when gets to limit of xpos and can't go further across screen xpos resets and ypos moves down a line to indent.
      {
        reviewYpos = reviewYpos+30;
        reviewXpos = 25;
      }
    }
    text("Star Rating : "+userReview.numOfStars+"/5", 25, 350+scrollPos);
    text("Page "+(reviewPrintIndex+1)+ " of "+(businessReviewList.size()), 730, 850+scrollPos);
   
   //theReviewer = new Reviewer(userReview.userId; userReview.userName; businessReviewsList);
  }
    public String getBusinessId(){
    return this.businessId;
  }
  public String getBusinessName(){
    return this.businessName;
  }
  public ArrayList getBusinessReviewList(){
    return this.businessReviewList;
  }
}