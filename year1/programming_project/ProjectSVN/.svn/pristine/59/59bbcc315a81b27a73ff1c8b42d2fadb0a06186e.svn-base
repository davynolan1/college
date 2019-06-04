
class ReviewObject {
  String userId;  
  String userName;
  String businessId;
  String businessName;
  int numOfStars;
  String date;
  String text;
  int useful;
  int funny;
  int cool;

  ReviewObject(String userId, String userName, String businessId, String businessName, int numOfStars, String date, String text, 
    int useful, int funny, int cool) {

    this.userId = userId;
    this.userName= userName;
    this.businessId = businessId;
    this.businessName = businessName;
    this.numOfStars = numOfStars;
    this.date = date;
    this.text = text;
    this.useful =useful;
    this.funny=funny;
    this.cool=cool;
  }

  public String toStringReviews()
  {
    String reviewString = ("userId: "+userId+",    userName: " + userName+",    businessId: " + businessId+",   businessName: "+ businessName + 
      ",   stars: "+numOfStars+",   date: " + date+ ",   review: " +text +",   useful: "+useful + ",  funny: "+funny+",  cool:"+cool);
    return reviewString;
  }
  public String getBusinessId() {
    return this.businessId;
  }
  public String getBusinessName(){
    return this.businessName;
  }
  public String getUserName(){
    return this.userName;
  }
}