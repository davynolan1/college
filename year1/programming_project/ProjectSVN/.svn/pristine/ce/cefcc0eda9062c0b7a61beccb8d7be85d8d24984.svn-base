
ArrayList<ReviewObject>reviewsList;
String Review1;

void settings() {
   size(SCREEN_WIDTH,SCREEN_HEIGHT); 
}

void setup() {
  
  reviewsList = new ArrayList<ReviewObject>();
  String[] reviews = loadStrings("reviews_cleaned.csv");
  PFont words = loadFont("AgencyFB-Reg-48.vlw");
  textFont(words);
  textSize(20);
  for(int i=0; i<reviews.length; i++) 
  {
  String[] reviewsProperties = reviews[i].split(",");

          String userId = reviewsProperties[0];
          String userName = reviewsProperties[1];
          String businessId = reviewsProperties[2];
          String businessName = reviewsProperties[3];
          String s = reviewsProperties[4];
          int stars = int(s);
          String date = reviewsProperties[5];
          String text =reviewsProperties[6];
          String u =reviewsProperties[7];
          int useful = int(u);
          String f = reviewsProperties[8];
          int funny = int(f);
          String c= reviewsProperties[9];
          int cool = int(c);
          
          
          ReviewObject reviewObject= new ReviewObject(userId, userName, businessId, businessName, stars, date, text, useful,funny,cool);
          reviewsList.add(reviewObject);    
  }
     println("there are " + reviews.length + " lines");
    
     //println(reviewsList.get(1).toStringReviews()); //test for one instance 
   
   for(int i=0; i<reviewsList.size(); i++)                  //printing all instances
   {
    ReviewObject aReview = (ReviewObject) reviewsList.get(i);
     

     println(aReview.toStringReviews());
   }
    text(reviewsList.get(1).toStringReviews(),50,100);
}