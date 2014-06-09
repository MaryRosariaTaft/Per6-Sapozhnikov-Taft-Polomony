import java.io.*;
import java.util.*;

class Person {

  private String name;
  private LL<Square> squares; //Squares on the Board
  private LL<Square> ownedSquares;
  private Square currentSquare; //Person's current Square
  private int numRR;
  private int money;
  private boolean inJail;
  private PImage token;
  private int quadrant; //part of the Square in which the Person's token lies
  private Card chanceGOOJF;
  private Card chestGOOJF;

  private int numDoubles;
  private boolean again;


  //set methods
  void setSquare(Square square) {
    this.currentSquare=square;
  }
  void setJail(boolean inJail) {
    this.inJail=inJail;
  }

  Person() {
  }

  Person(String name, LL<Square> squares, PImage token, int quadrant) {
    this.squares=new LL<Square>();
    Square cur = squares.getCurrent();
    squares.forward();
    Square tmp = squares.getCurrent();
    while (tmp!=cur) {
      this.squares.add(tmp);
      squares.forward();
      tmp = squares.getCurrent();
    }
    this.squares.add(tmp);
    //this.squares.forward();
    currentSquare=squares.getCurrent(); //"GO"
    this.name=name;
    money=1300;//1500 + 200 collected @ "GO"
    inJail=false;
    ownedSquares=new LL<Square>();
    numRR=0;
    this.token=token;
    this.quadrant=quadrant;
    chanceGOOJF=null;
    chestGOOJF=null;
    again=true;
    while (currentSquare!=squares.find ("GO")) {
      squares.forward();
      currentSquare=squares.getCurrent();
    }
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
      if (s.isRR()) {
        numRR++;
      }
      ownedSquares.add(s);
    }
  }

  void back(int n) {
    squares.back();
  }

  //  void delay(){
  //    double time=millis();
  //    while(millis()-time<500){
  //      //nothing
  //      //wait
  //      //the grass is growing
  //      //the paint is drying
  //      //MaryBrian's brains is dying
  //    }
  //  }

  void move() {
    if (currentSquare.getName().equals("GO")&&!inJail) {
      money+=200;
    }
    //try to delay move method so that you can see the token moving from square to square
    //doesn't actually work, though
    //int i=0;
    //    while(i!=1000000000){
    //      i++;
    //    }
    //delay();
    squares.forward();
    currentSquare=squares.getCurrent();
    draw();
  }

  void move(int n) {
    for (int i=0; i<n; i++) {
      move();
    }
  }

  void moveTo(Square target) {
    if (target==null) {
      return;
    }
    if (squares.find(target.getName())==null) {
      println("no target found");
      return;
    }
    if(target.getName().equals("IN JAIL")){
      inJail=true;
    }
    while (currentSquare != target) {
      move();
    }
  }

  void goToJail() {
    inJail=true;
    moveTo(squares.find("IN JAIL"));
  }

  void jailHouseRock() {
    //jail stuff

    //*Person is currently forced to use GOOJF card
    //if he doesn't have one, forced to try rolling
    //and forced to pay his way out of jail if he can afford it
    //so basically you have to get out of jail one way or another, unless you're broke

    //cards ahoy
    println(chestGOOJF);
    if (chanceGOOJF!=null) {
      inJail=false;
      Chance.add(chanceGOOJF);
      chanceGOOJF=null;
      println(name+" got out of jail with Card");
    } else if (chestGOOJF!=null) {
      inJail=false;
      CommunityChest.add(chestGOOJF);
      chestGOOJF=null;
      println(name+" got out of jail with Card");
    } else {

      //roll your way out of jail
      int roll1=d1.roll();
      int roll2=d2.roll();
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
    println("landed on chance: "+Chance.getCurrent());
    Chance.getCurrent().act(this);
    Chance.forward();
    canRoll=true;
    setMessage("Roll the dice");
  }

  void communityChest() {
    println("landed on chest: "+CommunityChest.getCurrent());
    CommunityChest.getCurrent().act(this);
    CommunityChest.forward();
    canRoll=true;
    setMessage("Roll the dice");
  }

  //used to ask Person whether he wants to buy the Square he landed on if he can afford it
  void purchase(Square s) {
    if (money>=currentSquare.getCost()) {
      setMessage("Would you like to buy "+currentSquare.getName()+"?");
      usedYes = false;
      cp5.addButton("yes")
        .setPosition(350, 400)
          .setSize(80, 40)
            .setValue((again) ? 1 : 0)
              .getCaptionLabel().align(ControlP5.CENTER, ControlP5.CENTER)
                ;
      usedNo=false;
      cp5.addButton("no")
        .setPosition(350, 450)
          .setSize(80, 40)
            .setValue((again) ? 1 : 0)
              .getCaptionLabel().align(ControlP5.CENTER, ControlP5.CENTER)
                ;
    } else {
      println("you can't afford this"); //or something like that
      canRoll=true;
      setMessage("Roll the dice");
    }
  }

  public void forkOverToGovt(int dough) {
    addMoney(0-dough);
    canRoll=true;
    setMessage("Roll the dice");
  }

  public void newTurn() {
    if (again) { //if doubles were rolled, go again
      turn();
    } else { //otherwise, go to the next Person
      players.forward();
      players.getCurrent().turn();
    }
  }


  void turn() {

    //game terminates when one person goes bankrupt

    if (money<=0) {
      println(name+" went bankrupt");
      return;
    }

    //special conditions for jailed Persons
    if (inJail) {
      jailHouseRock();
      players.forward();
      canRoll=true;
      setMessage("Roll the dice"); 
      numDoubles=0;
      again=false;
      return;
    } else {

      //roll dice and move
      int roll1=d1.roll();
      int roll2=d2.roll();
      if (roll1==roll2) {
        numDoubles++;
        again=true;
        if (numDoubles>=3) {
          //send to jail if Person rolls 3 doubles in a row
          setMessage("You have gone three times in a row! How dare you?!?!");
          goToJail();
          again=false;
          numDoubles=0;
          players.forward();
          canRoll=true;
          setMessage("Roll the dice");
          return;
        }
      } else {
        again=false;
      }
      println(name+" rolled "+roll1+" and "+roll2);

      //otherwise, move roll1+roll2 Squares
      move(roll1+roll2);

      //handle actions depending on which Square this Person lands on
      String sqName = currentSquare.getName();
      if (sqName.equals("GO TO JAIL")) {
        goToJail();
        players.forward();
        canRoll=true;
        setMessage("Roll the dice");
        numDoubles=0;
      } else if (sqName.equals("IN JAIL")||sqName.equals("FREE PARKING")) {
        canRoll=true;
        setMessage("Roll the dice");
      } else if (sqName.equals("Community Chest")) {
        communityChest();
      } else if (sqName.equals("Chance")) {
        chance();
      } else if (sqName.equals("Income Tax")) {
        forkOverToGovt(currentSquare.getCost());
      } else if (sqName.equals("Luxury Tax")) {
        forkOverToGovt(currentSquare.getCost());
      } else {
        if (currentSquare.hasOwner()) {
          //pay rent
          pay(currentSquare.getOwner(), currentSquare.rent());
          canRoll=true;
          setMessage("Roll the dice");
        } else {
          //ask Person if he wants to buy currentSquare
          purchase(currentSquare);
        }
      }
    }
  }

  void addCard(Card c) {
    println("the card recieved was: "+c);
    //0 is a chance Card, 1 is communitychest
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
      image(token, currentSquare.getX()+fracLen/2, currentSquare.getY());
    else if (quadrant==3)
      image(token, currentSquare.getX(), currentSquare.getY()+fracLen/2);
    else
      image(token, currentSquare.getX()+fracLen/2, currentSquare.getY()+fracLen/2);
  }



  boolean hasAll(Square s) {
    color target = s.getColor();
    int need = 0;
    Square cur = Board.this.squares.getCurrent();
    Board.this.squares.forward();
    Square tmp = Board.this.squares.getCurrent();    
    while (tmp!=cur) {
      if (tmp.getColor()==target) {
        need++;
      }
      Board.this.squares.forward();
      tmp = Board.this.squares.getCurrent();
    }
    if (tmp.getColor()==target) {
      need++;
    }
    cur = ownedSquares.getCurrent();
    ownedSquares.forward();
    tmp = ownedSquares.getCurrent();
    int have = 0;
    while (tmp!=cur) {
      if (tmp.getColor()==target) {
        have++;
      }
      ownedSquares.forward();
      tmp = ownedSquares.getCurrent();
    }
    if (tmp.getColor()==target) {
      have++;
    }
    println("you need "+need+" and you have "+have);
    return have==need;
  }

  //get methods
  Square square() {
    return currentSquare;
  }
  boolean inJail() {
    return inJail;
  }
  String name() {
    return name;
  }
  int money() {
    return money;
  }
  void setMoney(int d) {
    money=d;
  }
  Square getCurrent() {
    return squares.getCurrent();
  }
  Square getCurrentSquare() {
    return currentSquare;
  }
  int getNumRR() {
    return numRR;
  }
  int getMoney() {
    return money;
  }
  String getName() {
   return name; 
  }
  void printSquares() {
    println(squares);
  }
  public String toString() {
    return name;
  }
}

