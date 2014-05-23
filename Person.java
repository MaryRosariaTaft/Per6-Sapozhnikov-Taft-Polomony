import java.io.*;
import java.util.*;

public class Person{

    private String name;
    //private Square square;
    private LL<Square> squares;
    private int money;
    private boolean inJail;

    public Person(String name, LL<Square> squares){
	this.squares=squares;
	this.name=name;
	square=???temp;//Go
	money=1500;
	inJail=false;
    }

    public void move(){
	squares.forward();

    }

    public void jailHouseRock(){
	//jail stuff
    }

    //return true if Person goes again
    public boolean turn(){
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
	if(???goToJail){
	    inJail=true;
	}
	return again;
    }

}