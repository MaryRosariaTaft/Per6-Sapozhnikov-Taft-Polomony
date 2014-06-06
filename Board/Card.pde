import java.io.*;
import java.util.*;

class Card{

    private int type; //0 is Chest, 1 is CommunityChance
    private String text; //written on the Card
    private int value; //if gain/loss of money is involved
    private int spec;//see below
    //0 = advance token to nearest utility
    //1 = advance token to nearest RR
    //2 = go back three spaces
    //3 = get out of jail free (Chance)
    //4 = get out of jail free (Community Chest)
    //5 = house repairs (Chance)
    //6 = street repairs (Community Chest)
    
    private boolean getOutOfJail;
    private Square moveTo;
    //private boolean nearest, RR;
    //private boolean goBackThree;

    Card(){

    }
    
    Card(int type, String text, int value, boolean outJail, Square move){
	this.type=type;
	this.text=text;
	this.value=value;
	spec=-1;
	getOutOfJail = outJail;
	moveTo = move;
    }
    
    //use this constructor for special cases:
    Card(int i){
	switch (i){
        case 0:
	    type = 0;
	    text="Advance token to nearest Utility. If unowned, you may buy it from the Bank. If owned, throw dice and pay owner a total ten times the amount thrown.";
	    value = 0;
	    moveTo=null;
	    break;
        case 1: 
	    type = 0;
	    text="Advance token to the nearest Railroad and pay owner twice the rental to which he/she is otherwise entitled. If Railroad is unowned, you may buy it from the Bank.";
	    value = 0;
	    moveTo=null;
	    break;
        case 2:
	    type=0;
	    text="Go back 3 spaces";
	    value = 0;
	    moveTo = null;
	    break;
        case 3:
	    type=0;
	    text="Get out of Jail free – this card may be kept until needed, or traded/sold";
	    value=0;
	    moveTo=null;
	    break;     
        case 4:
	    type=1;
	    text="Get out of jail free – this card may be kept until needed, or sold";
	    value=0;
	    moveTo=null;
	    break; 
        case 5:
	    type=0;
	    text="Make general repairs on all your property – for each house pay $25 – for each hotel $100";
	    value=0;
	    moveTo=null;
	    break; 
        case 6:
	    type=1;
	    text="You are assessed for street repairs – $40 per house, $115 per hotel";
	    value=0;
	    moveTo=null;
	    break;     
	}
	getOutOfJail = false;
	spec=i;
    }
    
    void act(Person p){
      println(spec);
	switch (spec){
        case -1:
	    if(getOutOfJail){
	    } else {
		regAct(p);
	    }
	    break;
        case 0:
	    nextUtilAct(p);
	    break;
        case 1: 
	    nextRRAct(p);
	    break;
        case 2:
	    goBackThreeAct(p);
	    break;
        case 3:
	    getOutChanceAct(p);
	    break;     
        case 4:
	    getOutChestAct(p);
	    break; 
        case 5:
	    houseRepairsAct(p);
	    break; 
        case 6:
	    streetRepairsAct(p);
	    break;     
	}
    }

    void regAct(Person p){
	p.addMoney(value);
	p.moveTo(moveTo);
    }
  
    //if unowned, can be bought
    //if owned, roll dice and pay owner 10x what you roll
    void nextUtilAct(Person p){
	while(!p.getCurrent().isUtil()){
	    p.move();
	}
        if(p.getCurrentSquare().hasOwner()){
          int roll1=Die.roll();
          int roll2=Die.roll();
          p.pay(p.getCurrentSquare().getOwner(),10*(roll1+roll2));
        }else{
          p.purchase(p.getCurrentSquare());
        }
    }
    //if unowned, can be bought
    //if owned, pay owner 2x rent
    void nextRRAct(Person p){
	while(!p.getCurrent().isRR()){
	    p.move();
	}
        if(p.getCurrentSquare().hasOwner()){
          p.pay(p.getCurrentSquare().getOwner(),2*p.getCurrentSquare().rent());
        }else{
          p.purchase(p.getCurrentSquare());
        }
    }
    void goBackThreeAct(Person p){
	p.back(3);
    }
    //the following 2 methods remove GOOJF cards from their
    //respective decks and then give them to Person p;
    //a Card will be added back to its deck if/when the Person
    //decides to use it to get out of jail
    void getOutChanceAct(Person p){
	p.addCard(Chance.remove());
    }
    void getOutChestAct(Person p){
	p.addCard(CommunityChest.remove());
    }
    void houseRepairsAct(Person p){
	int n = (p.numHouses()*25)+(p.numHotels()*100);
	p.addMoney(0-n);
    }
    void streetRepairsAct(Person p){
	int n = (p.numHouses()*40)+(p.numHotels()*115);
	p.addMoney(0-n);
    } 
  
    int getType(){
      return type;
    }

}
