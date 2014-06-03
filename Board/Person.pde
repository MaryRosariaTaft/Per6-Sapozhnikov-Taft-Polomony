import java.io.*;
import java.util.*;

class Person{

    private String name;
    private LL<Square> squares; //Squares on the Board
    private LL<Square> ownedSquares;
    private Square currentSquare; //Person's current Square
    private int money;
    private boolean inJail;
    private PImage token;
    private int quadrant; //part of the Square in which the Person's token lies
    
    void setSquare(Square square){this.currentSquare=square;}
    void setJail(boolean inJail){this.inJail=inJail;}
    //name and squares shouldn't be edited; money should only be edited by adding and subtracting, not with a set method

    Person(String name, LL<Square> squares, PImage token, int quadrant){
	this.squares=squares;
        currentSquare=squares.getCurrent(); //"GO"
	this.name=name;
	money=1500;
	inJail=false;
        ownedSquares=new LL<Square>();
        this.token=token;
        this.quadrant=quadrant;
    }

  void buy(Square s){
    if(s.getCost()>money){
       //IAMPOOREXCEPTION 
    } else{
      money-=s.getCost();
      ownedSquares.add(s);
    }
  }

    void move(){
	squares.forward();
    }

    void jailHouseRock(){
	//jail stuff
    }

    //return true if Person goes again
    boolean turn(){
	if(inJail){
	    //stuff
	}
	boolean again = false;
	int roll1=Die.roll();
	int roll2=Die.roll();
	if(roll1==roll2){
	    again=true;
	}
	//move roll1+roll2 one by one
	for(int i=0; i<roll1+roll2; i++){
	    move();
	}
	//now the Player is at his new Square
	//if(???goToJail){
	    //inJail=true;
	//}
	return again;
    }
    
    void draw(){
      if(quadrant==1)
        image(token,currentSquare.getX(),currentSquare.getY());
      else if(quadrant==2)
        image(token,currentSquare.getX()+25,currentSquare.getY());
      else if(quadrant==3)
        image(token,currentSquare.getX(),currentSquare.getY()+25);
      else
        image(token,currentSquare.getX()+25,currentSquare.getY()+25);      
    }
    
    Square square(){return currentSquare;}
    boolean inJail(){return inJail;} //although this shouldn't be necessary, since "inJail" is a check in turn()
    String name(){return name;}
    int money(){return money;} //not sure this one is even necessary
    
    public String toString(){
      return name;
    }

}
