import java.io.*;
import java.util.*;

class Person {

  private String name;
  private LL<Square> squares; //Squares on the Board
  private LL<Square> ownedSquares;
  private Square currentSquare; //Person's current Square IS NOT UPDATED WHEN PERSON MOVES
  private int money;
  private boolean inJail;
  private PImage token;
  private int quadrant; //part of the Square in which the Person's token lies

  void setSquare(Square square) {
    this.currentSquare=square;
  }
  void setJail(boolean inJail) {
    this.inJail=inJail;
  }
  //name and squares shouldn't be edited; money should only be edited by adding and subtracting, not with a set method

  Person(String name, LL<Square> squares, PImage token, int quadrant) {
    this.squares=squares;
    currentSquare=squares.getCurrent(); //"GO"
    this.name=name;
    money=30;//1500;
    inJail=false;
    ownedSquares=new LL<Square>();
    this.token=token;
    this.quadrant=quadrant;
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
      if (tmp.getHasHotel()) {
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

  void move() {
      squares.forward();
      currentSquare=squares.getCurrent();
      println("("+currentSquare.getX()+", "+currentSquare.getY()+")");
  }
  void back(int n) {
    squares.back();
  }

  //i don't think this method is finished yet, I just made it because it needs to exist
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

  void jailHouseRock() {
    //jail stuff
  }

  //return true if Person goes again
  void turn() {
    if (money<0) {
      return;
    }
    money--;
    draw();
    
    if (time%100==1) {
      println("turn");
      if (inJail) {
        //stuff
      }
      boolean again = false;
      int roll1=Die.roll();
      int roll2=Die.roll();
      if (roll1==roll2) {
        again=true;
      }
      //move roll1+roll2 one by one
      for (int i=0; i<roll1+roll2; i++) {
        move();
      }
      //now the Player is at his new Square
      //if(???goToJail){
      //inJail=true;
      //}
      if (again) {
        turn();
      } else {
        players.forward();
        players.getCurrent().turn();
      }
    } else {
      time=millis();
      turn();
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

  Square square() {
    return currentSquare;
  }
  boolean inJail() {
    return inJail;
  } //although this shouldn't be necessary, since "inJail" is a check in turn()
  String name() {
    return name;
  }
  int money() {
    return money;
  } //not sure this one is even necessary
  void setMoney(int d) {
    money=d;
  };
  Square getCurrent() {
    return squares.getCurrent();
  }

  public String toString() {
    return name;
  }
}

