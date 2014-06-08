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

  private int numDoubles;
  private boolean again;


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

  //  void initSquares(LL<Square> s){
  //   Square current=s.getCurrent();
  //   s.forward();
  //   Square temp=s.getCurrent();
  //   while(temp!=current){
  //    sq 
  //   }
  //  }

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
    money=1300;//1500;
    inJail=false;
    ownedSquares=new LL<Square>();
    this.token=token;
    this.quadrant=quadrant;
    chanceGOOJF=null;
    chestGOOJF=null;
    again=true;
    while(currentSquare!=squares.find("GO")){
      squares.forward();
      currentSquare=squares.getCurrent();
    }
    

    //println(squares);
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
    //int i=0;
    //    while(i!=1000000000){
    //      i++;
    //    }
    //delay();
    squares.forward();
    currentSquare=squares.getCurrent();
    //println(name+"("+currentSquare.getX()+", "+currentSquare.getY()+")");
    //if(millis()-lastTime>5000)
    draw();
  }

  void move(int n) {
    for (int i=0; i<n; i++) {
      move();
    }
  }

  void moveTo(Square target) {
    // Square tmp = squares.getCurrent();
    //println(target.getName());
    if (target==null) {
      return;
    }
    //println(squares);
    //println("found: "+squares.find(target.getName()));
    if (squares.find(target.getName())==null) {
      println("no target found");
      return;
    }

    //currentSquare=target;
    while (currentSquare != target) {
      //println(currentSquare.toString());
      move();
      // tmp = squares.getCurrent();
    }
    println("done while-looping");
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
    //newTurn();
    canRoll=true;
    setMessage("Roll the dice");
    println("chance method finished");
  }

  void communityChest() {
    println("landed on cc: "+CommunityChest.getCurrent());
    CommunityChest.getCurrent().act(this);
    CommunityChest.forward();
    //newTurn();
    canRoll=true;
    setMessage("Roll the dice");
    println("communityChest method finished");
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
      //newTurn();    
      canRoll=true;
      setMessage("Roll the dice");
      //maybe we could display it with cp5's messages instead
    }
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

  public void forkOverToGovt(int dough) {
    addMoney(0-dough);
    canRoll=true;
    setMessage("Roll the dice");
  }

  public void newTurn() {
    //printSquares();
    println(name+" has $"+money);
    if (again) { //if doubles were rolled, go again
      turn();
    } else { //otherwise, go to the next Person
      players.forward();
      players.getCurrent().turn();
    }
  }


  void turn() {
    //printSquares();
    //as of now, game terminates when one person goes bankrupt
    //kind of defeats the purpose of Monopoly unless it's just two players
    //we'll work on that
    //maybe
    if (money<=0) {
      println(name+" went bankrupt");
      return;
    }

    //temporary decrement to check other parts of method(s)
    //money--;

    //special conditions for jailed Persons
    if (inJail) {
      jailHouseRock();
      players.forward();
      players.getCurrent().turn(); 
      numDoubles=0;
      //may have to reset numDoubles
    } else if (numDoubles>=3) {
      //send to jail if Person rolls 3 doubles in a row
      goToJail();
      players.forward();
      players.getCurrent().turn();
      numDoubles=0;
      //may have to reset numDoubles
    } else {

      //roll dice and move
      ////int newNumDoubles=NumDoubles; //keeps track of # of consecutive doubles a person has rolled
      int roll1=d1.roll();
      int roll2=d2.roll();
      if (roll1==roll2) {
        numDoubles++;
        again=true;
      } else {
        again=false;
      }
      println(name+" rolled "+roll1+"+"+roll2);

      //otherwise, move roll1+roll2 Squares
      move(roll1+roll2);
      //move(4);//testtesttest

      //handle actions depending on which Square this Person lands on
      //we can move some of this code into a separate function to make it cleaner
      String sqName = currentSquare.getName();
      if (sqName.equals("GO TO JAIL")) {
        goToJail();
        players.forward();
        players.getCurrent().turn();
        numDoubles=0;
      } else if (sqName.equals("IN JAIL")||sqName.equals("FREE PARKING")) {
        //newTurn();
        canRoll=true;
        setMessage("Roll the dice");
      } else if (sqName.equals("Community Chest")) {
        communityChest();
      } else if (sqName.equals("Chance")) {
        chance();
      } else if (sqName.equals("Income Tax")) {
        forkOverToGovt(currentSquare.getCost());
        canRoll=true;
        setMessage("Roll the dice");
      } else if (sqName.equals("Luxury Tax")) {
        forkOverToGovt(currentSquare.getCost());
      } else {
        if (currentSquare.hasOwner()) {
          //pay rent
          pay(currentSquare.getOwner(), currentSquare.rent());
          //newTurn();
          canRoll=true;
          setMessage("Roll the dice");
        } else {
          //ask Person if he wants to buy currentSquare
          //doesn't work yet
          purchase(currentSquare);
        }
      }
      /*
      //next turn 
       if (newNumDoubles>initialNumDoubles) { //if doubles were rolled, go again
       turn(newNumDoubles);
       } else { //otherwise, go to the next Person
       players.forward();
       players.getCurrent().turn(0);
       }
       */
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
      image(token, currentSquare.getX()+fracLen/2, currentSquare.getY());
    else if (quadrant==3)
      image(token, currentSquare.getX(), currentSquare.getY()+fracLen/2);
    else
      image(token, currentSquare.getX()+fracLen/2, currentSquare.getY()+fracLen/2);
  }

  boolean hasAll(Square s){
    color target = s.getColor();
    int need = 0;
    Square cur = Board.this.squares.getCurrent();
    Board.this.squares.forward();
    Square tmp = Board.this.squares.getCurrent();    
    while(tmp!=cur){
      if(tmp.getColor()==target){
        need++;
      }
      Board.this.squares.forward();
      tmp = Board.this.squares.getCurrent();
    }
    if(tmp.getColor()==target){
        need++;
    }
    /*
    Board.this.squares.back();
    while(tmp!=Board.this.squares.find("GO")){
      Board.this.squares.forward();
      tmp = Board.this.squares.getCurrent();
    }
    squares.back();
    while(tmp!=squares.find("GO")){
      squares.forward();
      tmp = getCurrent();
    }
    */
    cur = ownedSquares.getCurrent();
    ownedSquares.forward();
    tmp = ownedSquares.getCurrent();
    int have = 0;
    while(tmp!=cur){
      if(tmp.getColor()==target){
        have++;
      }
      ownedSquares.forward();
      tmp = ownedSquares.getCurrent();
    }
    if(tmp.getColor()==target){
        have++;
    }
    println("you need "+need+" and you have "+have);
    return have==need;
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
  void printSquares() {
    println(squares);
  }
  public String toString() {
    return name;
  }
}

