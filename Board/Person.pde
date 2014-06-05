import java.io.*;
import java.util.*;

class Person {

  private String name;
  private LL<Square> squares; //Squares on the Board
  private LL<Square> ownedSquares;
  private Square currentSquare; //Person's current Square
  private int money;
  private boolean inJail;
  private PImage token;
  private int quadrant; //part of the Square in which the Person's token lies
  private Card chanceGOOJF;
  private Card chestGOOJF;


  //set methods
  //name and squares shouldn't be edited; money should only be edited by adding and subtracting, not with a set method
  void setSquare(Square square) {
    this.currentSquare=square;
  }
  void setJail(boolean inJail) {
    this.inJail=inJail;
  }

  Person() {
  }

  Person(String name, LL<Square> squares, PImage token, int quadrant) {
    this.squares=squares;
    currentSquare=squares.getCurrent(); //"GO"
    this.name=name;
    money=15;//1500;
    inJail=false;
    ownedSquares=new LL<Square>();
    this.token=token;
    this.quadrant=quadrant;
    chanceGOOJF=null;
    chestGOOJF=null;
  }

  int numHouses() {
    int ans=0;
    Square cur = ownedSquares.getCurrent();
    ownedSquares.forward();
    Square tmp = ownedSquares.getCurrent();
    while (tmp!=cur) {
      tmp = ownedSquares.getCurrent();
      ans+=tmp.getNumHouses();
      ownedSquares.forward();
    }     
    return ans;
  }

  int numHotels() {
    int ans=0;
    Square cur = ownedSquares.getCurrent();
    ownedSquares.forward();
    Square tmp = ownedSquares.getCurrent();
    while (tmp!=cur) {
      tmp = ownedSquares.getCurrent();
      if (tmp.hasHotel()) {
        ans++;
      }
      ownedSquares.forward();
    }     
    return ans;
  }

  void buy(Square s) {
    if (s.getCost()>money) {
      //IAMPOOREXCEPTION
    } else {
      money-=s.getCost();
      ownedSquares.add(s);
    }
  }

  void back(int n) {
    squares.back();
  }

  void move() {
    squares.forward();
    currentSquare=squares.getCurrent();
    if (currentSquare.getName().equals("GO")&&!inJail) {
      money+=200;
    }
    println(name+"("+currentSquare.getX()+", "+currentSquare.getY()+")");
  }

  void move(int n) {
    for (int i=0; i<n; i++) {
      move();
    }
  }

  void moveTo(Square target) {
    while (squares.getCurrent () != target) {
      move();
    }
  }

  void goToJail() {
    inJail=true;
    moveTo(squares.find("GO TO JAIL"));
  }

  void jailHouseRock() {
    //jail stuff

    //    //temp stuff
    //    if(money<=0)
    //      inJail=false;
    //    money--;

    if (chanceGOOJF!=null) {
      //ask to use card (maybe use y/n Buttons?)
      //if(yes){
      //  inJail=false;
      //  Chance.add(chanceGOOJF);
      //  chanceGOOJF=null;
      //}
    } else if (chestGOOJF!=null) {
      //ask to use card
      //if(yes)
      //  inJail=false;
      //  CommunityChest.add(chestGOOJF);
      //  chestGOOJF=null;
      //}
    } else {

      //*Person is currently forced to try rolling
      //Person is then forced to pay his way out of jail if he can afford it
      //so basically you get out of jail one way or another, unless you're broke
      //temporary (maybe)

      //roll your way out of jail
      int roll1=Die.roll();
      int roll2=Die.roll();
      if (roll1==roll2) {
        inJail=false;
      }
      //fork over money
      else {
        //stuck in jail if you can't pay it
        if (money>=50) {
          money-=50;
          inJail=false;
        }
      }
    }
  }

  void chance() {
    //println("landed on ch");
    Chance.getCurrent().act(this);
    Chance.forward();
  }

  void communityChest() {
    //println("landed on cc");
    CommunityChest.getCurrent().act(this);
    CommunityChest.forward();
  }

  //used to ask Person whether he wants to buy the Square he landed on if he can afford it
  void purchase(Square s) {
    //if(money>=currentSquare.getCost()){
    //    Button yes = new Button("Yes", color(0, 200, 0), 200, 250);
    //    Button no = new Button("No", color(200, 3, 50), 300, 250);
    //    //while loop? while(!yes.clicked()||!no.clicked()) ?
    //    yes.draw();
    //    no.draw();
    //    if(yes){
    //      money-=currentSquare.getCost());
    //      ownedSquares.add(currentSquare);
    //      currentSquare.setOwner(this);
    //    }
    //    //else, do nothing, keep playing
    //}else{
    //    println("you can't afford this"); //or something like that
    //    //maybe we could display it with cp5's messages instead
    //}
  }

  void turn(int initialNumDoubles) {

    //as of now, game terminates when one person goes bankrupt
    //kind of defeats the purpose of Monopoly unless it's just two players
    //we'll work on that
    //maybe
    if (money<=0) {
      println(name+" went bankrupt");
      return;
    }

    //temporary decrement to check other parts of method(s)
    money--;

    //special conditions for jailed Persons
    if (inJail) {
      jailHouseRock();
      players.forward();
      players.getCurrent.turn(0);
    } else if (initialNumDoubles>=3) {
      //send to jail if Person rolls 3 doubles in a row
      goToJail();
      players.forward();
      players.getCurrent().turn(0);
    } else {

      //roll dice and move
      int newNumDoubles=initialNumDoubles; //keeps track of # of consecutive doubles a person has rolled
      int roll1=Die.roll();
      int roll2=Die.roll();
      if (roll1==roll2) {
        newNumDoubles++;
      }
      println(name+" rolled "+roll1+"+"+roll2);

      //otherwise, move roll1+roll2 Squares
      move(roll1+roll2);

      //handle actions depending on which Square this Person lands on
      //we can move some of this code into a separate function to make it cleaner
      String sqName = currentSquare.getName();
      if (sqName.equals("GO TO JAIL")) {
        goToJail();
        players.forward();
        players.getCurrent().turn(0);
      } else if (sqName.equals("Community Chest")) {
        communityChest();
      } else if (sqName.equals("Chance")) {
        chance();
      } else {
        if (currentSquare.hasOwner()) {
          //pay rent
          pay(currentSquare.getOwner(), currentSquare.rent());
        } else {
          //ask Person if he wants to buy currentSquare
          //doesn't work yet
          purchase(currentSquare);
        }
      }

      //next turn 
      if (newNumDoubles>initialNumDoubles) { //if doubles were rolled, go again
        turn(newNumDoubles);
      } else { //otherwise, go to the next Person
        players.forward();
        players.getCurrent().turn(0);
      }
    }
  }

  void addCard(Card c) {
    //0 is a chance Card, 1 is cchest
    if (c.getType()==0) {
      chanceGOOJF=c;
    } else {
      chestGOOJF=c;
    }
  }

  //positive for pay, negative for get paid
  void pay(Person other, int d) {
    money-=d;
    other.addMoney(d);
  }
  void addMoney(int d) {
    money+=d;
  }

  void draw() {
    if (quadrant==1)
      image(token, currentSquare.getX(), currentSquare.getY());
    else if (quadrant==2)
      image(token, currentSquare.getX()+25, currentSquare.getY());
    else if (quadrant==3)
      image(token, currentSquare.getX(), currentSquare.getY()+25);
    else
      image(token, currentSquare.getX()+25, currentSquare.getY()+25);
  }


  //get methods

  Square square() {
    return currentSquare;
  }
  //this shouldn't be necessary, since "inJail" is a check in turn(), but might as well
  boolean inJail() {
    return inJail;
  }
  String name() {
    return name;
  }
  int money() {
    return money;
  }
  //not sure this one is even necessary
  void setMoney(int d) {
    money=d;
  }
  //not sure this is correct
  Square getCurrent() {
    return squares.getCurrent();
  }
  Square getCurrentSquare() {
    return currentSquare;
  }
  public String toString() {
    return name;
  }
}

