import java.io.*;
import java.util.*;

class Person{

    private String name;
    //Square square;
    private LL<Square> squares;
    private int money;
    private boolean inJail;

    Person(String name, LL<Square> squares){
	this.squares=squares;
	this.name=name;
	//square=???temp;//Go
	money=1500;
	inJail=false;
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

}
