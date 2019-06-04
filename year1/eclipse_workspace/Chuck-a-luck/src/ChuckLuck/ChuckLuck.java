/* SELF ASSESSMENT 

1. ResolveBet

I have correctly defined ResolveBet which takes the bet type (String) and the Wallet object, and a void return type [Mark out of 7:7 ].
Comment: Yes I used the definition provided in the assignment requirements. It takes a String and the Wallet object and is a void.
My program presents the amount of cash in the wallet and asks the user how much he/she would like to bet [Mark out of 8: 8 ].
Comment: Yes it does.
My program ensures the bet amount is not greater than the cash in the wallet [Mark out of 5: 5 ].
Comment: Yes it does.
My program creates three Dice objects, rolls them and creates a total variable with a summation of the roll values returned [Mark out of 15: 15 ]..
Comment: Yes it does.
My program determines the winnings by comparing the bet type with the total and comparing the bet type with the dice faces for the triple bet [Mark out of 20: 20 ].
Comment: Yes it does.
My program outputs the results (win or loss) and adds the winnings to the wallet if user wins or removes the bet amount from the wallet if the user loses [Mark out of 10: 10 ].
Comment: Yes it does.

2. Main

I ask the user for the amount of cash he/she has, create a Wallet object and put this cash into it [Mark out of 15: 15 ]
Comment: Yes I do.
My program loops continuously until the user either enters quit or the cash in the wallet is 0 [Mark out of 5: 5 ]
Comment: Yes it uses a do-while loop.
I ask the user to enter any of the four bet types or quit [Mark out of 5: 5 ].
Comment: Yes I do.
My program calls resolveBet for each bet type entered [Mark out of 5: 5 ].
Comment: Yes it does.
At the end of the game my program presents a summary message regarding winnings and losses [Mark out of 5: 5 ]
Comment: Yes it does.

 Total Mark out of 100 (Add all the previous marks): 100
*/
package ChuckLuck;

import java.util.Scanner;

public class ChuckLuck {

	public static void main(String[] args) {
		 Scanner inputScanner = new Scanner(System.in);
		 System.out.print("How much money is in your wallet? €");
		 if (inputScanner.hasNextDouble()) {
			 double cash = inputScanner.nextDouble();
			 Wallet myWallet = new Wallet();
			 myWallet.put(cash);
			 boolean finished = false;
			 do {
				 if(myWallet.check() != 0) {
					 System.out.println("The type of bets you can place are: Triple, Field, High and Low.");
					 System.out.print("Enter the type of bet you want to place (or enter quit): ");
					 inputScanner = new Scanner(System.in);
					 if (inputScanner.hasNext("triple") || inputScanner.hasNext("field") || inputScanner.hasNext("high")
							 || inputScanner.hasNext("low") || inputScanner.hasNext("Triple") || inputScanner.hasNext("Field")
							 || inputScanner.hasNext("High") || inputScanner.hasNext("Low")) {
						 String betType = inputScanner.next();
						 betType.toLowerCase();
						 resolveBet(betType, myWallet);
					 }
					 else if(inputScanner.hasNext("quit") || inputScanner.hasNext("Quit")) {
						 finished = true; 
					 }
					 else {
						 System.out.println("Invalid input. Try again.");
					 }
				 }
				 else {
					 finished = true;
					 System.out.println("You ran out of money in your wallet.");
				 }
				 
			 }while(!finished);
			 if(myWallet.check()>cash){
	                double moneyMade=myWallet.check()-cash;
	                System.out.println("You made €"+moneyMade);
	            }
	            else if(myWallet.check()<cash){
	                double moneyLost= cash-myWallet.check();
	                System.out.println("You lost €"+moneyLost);
	            }
	            else if (myWallet.check()==cash)
	                System.out.println("You made and lost nothing.");
	        } else
	            System.out.println("Invalid input. Please enter a valid figure.");
		 
	}
	
	public static boolean triple(Dice[] dices) {

		if(dices[0] == dices[1] && dices[1] == dices[2]) {
			return true;
		}
		else
			return false;
    }
	
	 public static int sum(Dice[] dices) {
	    int diceAdd = 0;
	    for (int i = 0; i < dices.length; i++) {
             diceAdd += dices[i].topFace();
        }
	    return diceAdd;
	    }
	
	public static void resolveBet(String betType, Wallet myWallet) {
		System.out.print("Enter how much money you wish to bet: €");
		Scanner betScanner = new Scanner(System.in);
		boolean finished = false;
		do {
			if(betScanner.hasNextDouble()) {
				finished = true;
				double amountBet = betScanner.nextDouble();
				if(myWallet.get(amountBet)) {
					Dice[] dice = new Dice[3];
					System.out.print("The dice are:");
					
					for (int index = 0; index < dice.length; index++) {
						dice[index] = new Dice();
						dice[index].roll();
						System.out.print(" "+dice[index].topFace());
					}
					System.out.println();
					if(betType.equals("triple")) {
						boolean legitTriple = true;
						for(int index = 0; index < dice.length; index++) {
							if(dice[index].topFace() == 1 || dice[index].topFace() == 6) {
								legitTriple = false;
							}
						}
						if(legitTriple && triple(dice)) {
							myWallet.put(amountBet * 31);
							System.out.println("Congratulations, you won!");
						}
						else {
							System.out.println("Sorry, you lost.");
						}
					}
					else if(betType.equals("field")) {
						int sumOfDice = sum(dice);
						if (sumOfDice < 8 || sumOfDice > 12) {
							myWallet.put(amountBet * 2);
							System.out.println("Congratulations, you won!");
						}
						else {
							System.out.println("Sorry, you lost.");
						}
					}
					else if(betType.equals("high")) {
						int sumOfDice = sum(dice);
						if(sumOfDice > 10 && !triple(dice)) {
							myWallet.put(amountBet * 2);
							System.out.println("Congratulations, you won!");
						}
						else {
							System.out.println("Sorry, you lost.");
						}
					}
					else if(betType.equals("low")) {
						int sumOfDice = sum(dice);
						if(sumOfDice < 11 && !triple(dice)) {
							myWallet.put(amountBet * 2);
							System.out.println("Congratulations, you won!");
						}
						else {
							System.out.println("Sorry, you lost");
						}
					}
					System.out.println(myWallet.toString());
					System.out.println("******************************************");
				}
				else {
					System.out.println("You don't have enough money.");
				}
			}
			else {
				System.out.println("Invalid input. Try again.");
			}
		}while(!finished);
	}
}