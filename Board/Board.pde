import controlP5.*;

//workaround for LL of colors
class myColor{
  private color c;
  public myColor(color c){
    this.c=c;
  }
  public color getColor(){
    return c;
  }
}

ControlP5 cp5;
//PImage img;
//String textValue="";
Textlabel messages;
PFont font = createFont("arial",20);
private boolean ready=false;
private boolean loaded=false;
private int numPlayers;
private int maxPlayers = 4; //we need one method per each person, so we have to set a max
LL<Square> squares=new LL<Square>();
LL<Person> players=new LL<Person>();

void controlEvent(ControlEvent e){
  if(e.isAssignableFrom(Textfield.class)){
    
  }
}

public void person0(String name){
}
public void person1(String name){
}
public void person2(String name){
}
public void person3(String name){
}

public void enter2(int numP){
  if(loaded){
    //add all the entered names to 'players' after initiating them as Persons
    for(int i=0; i<numP; i++){
      String name = cp5.get(Textfield.class,("person"+i)).getText();
      PImage token=null;
      if(i==0) token=loadImage("Tokens/Car.jpg");
      else if(i==1) token=loadImage("Tokens/Dog.jpg");
      else if(i==2) token=loadImage("Tokens/Ship.jpg");
      else if(i==3) token=loadImage("Tokens/Thimble.jpg");
      Person p = new Person(name, squares, token, i+1);
      players.add(p);
    }
    players.forward();
    println("Players: "+players.toString());
    cp5.remove("person0");
    cp5.remove("person1");
    cp5.remove("person2");
    cp5.remove("person3");
    cp5.remove("enter2");
    cp5.remove("messages");
    fill(150);
    //remove all the cp5 stuff
    ready=true;
  
    //if(invalid input)
    //messages.setText("Please enter players' names");
  }
  loaded=true;
}

//opening screen
public void enter(int x){
  String s = cp5.get(Textfield.class,"Enter Number of Players (2-4)").getText();
  try{
    int numP = Integer.parseInt(s);
    cp5.remove(messages);
    //what exactly does the above line do?
    //(I just don't see where messages was ever "added" or something in the first place)
    if(numP>1 && numP<=maxPlayers){
      messages = cp5.addTextlabel("messages")
                    .setText("Enter players' names")
                    .setPosition(200,50)
                    .setFont(font)
                    ;
      cp5.remove("Enter Number of Players (2-4)");//and this?
      numPlayers = numP;
      background(150);
      fill(150);
      cp5.remove("enter");
      for(int i=0; i<numP; i++){
        cp5.addTextfield("person"+i)
           .setPosition(100,100*(1+i))
           .setSize(200,40)
           .setFont(font)
           .setFocus(true)
           .setColor(color(255,0,0))
           ;
      }
      cp5.addBang("enter2")
         //.setPosition(100,100*(numP+1))
         .setPosition(350,400) //that was just a lazy way to handle the button hitting the Squares.  Sorry.
         .setSize(80,40)
         .setValue(numP)
         .getCaptionLabel().align(ControlP5.CENTER, ControlP5.CENTER)
         ; 
    } else{
      messages = cp5.addTextlabel("messages")
                    //.setText("Number of players: "+numP)
                    .setText("Please enter a valid number of players")
                    .setPosition(75,75)
                    .setFont(font)
                    ;
    }
  } catch(Exception e){
    messages.setText("Please enter a valid number of players");
  }
}
public void input(String s){
  println("input("+s+") called");  
}

void setup(){
    
  size(550,550);
  
  //////////////////////////////////////////////////

  //SETTING UP CONTROLP5
  
  //init ControlP5
  cp5 = new ControlP5(this);
         
  //textbox
  cp5.addTextfield("Enter Number of Players (2-4)")
     .setPosition(100,100)
     .setSize(200,40)
     .setFont(font)
     .setFocus(true)
     .setColor(color(255,0,0))
     ;
     
  //bang (basically a button)
  cp5.addBang("enter")
     .setPosition(100,200)
     .setSize(80,40)
     .getCaptionLabel().align(ControlP5.CENTER, ControlP5.CENTER)
     ;   

  //stuff to be printed out in case the user enters invalid input
  //or other stuff the user should know
  messages = cp5.addTextlabel("messages")
                .setText("")
                .setPosition(75,75)
                .setFont(font)
                ;
                 
  //////////////////////////////////////////////////
  
  //SETTING UP PLAYING BOARD
 
  //big thanks to http://en.wikipedia.org/wiki/Template:Monopoly_board_layout
  
  //prepare colors to be assigned to Squares
  
  myColor other = new myColor(#FFFFFF);
  myColor rr = new myColor(#000000);
  myColor brown = new myColor(#8B4513);
  myColor cyan = new myColor(#00FFFF);
  myColor magenta = new myColor(#FF00FF);
  myColor orange = new myColor(#FFA500);
  myColor red = new myColor(#FF0000);
  myColor gold = new myColor(#FFD700);
  myColor green = new myColor(#008000);
  myColor blue = new myColor(#0000FF);
  
  LL<myColor> colors = new LL<myColor>();
  
  colors.add(other);
  colors.add(brown);
  colors.add(other);
  colors.add(brown);
  colors.add(other);
  colors.add(rr);
  colors.add(cyan);
  colors.add(other);
  colors.add(cyan);
  colors.add(cyan);
  colors.add(other);
  colors.add(magenta);
  colors.add(other);
  colors.add(magenta);
  colors.add(magenta);
  colors.add(rr);
  colors.add(orange);
  colors.add(other);
  colors.add(orange);
  colors.add(orange);
  colors.add(other);
  colors.add(red);
  colors.add(other);
  colors.add(red);
  colors.add(red);
  colors.add(rr);
  colors.add(gold);
  colors.add(gold);
  colors.add(other);
  colors.add(gold);
  colors.add(other);
  colors.add(green);
  colors.add(green);
  colors.add(other);
  colors.add(green);
  colors.add(rr);
  colors.add(other);
  colors.add(blue);
  colors.add(other);
  colors.add(blue);
  colors.forward();
  
  
  //prepare names
  
  LL<String> names = new LL<String>();
  
  names.add("GO");
  names.add("Mediterranean Avenue");
  names.add("Community Chest");
  names.add("Baltic Avenue");
  names.add("Income Tax");
  names.add("Reading Railroad");
  names.add("Oriental Avenue");
  names.add("Chance");
  names.add("Vermont Avenue");
  names.add("Connecticut Avenue");
  names.add("IN JAIL");
  names.add("St. Charles Place");
  names.add("Electric Company");
  names.add("Staties Avenue");
  names.add("Virginia Avenue");
  names.add("Pennsylvania Railroad");
  names.add("St. James Place");
  names.add("Community Chest");
  names.add("Tennessee Avenue");
  names.add("New York Avenue");
  names.add("FREE PARKING");
  names.add("Kentucky Avenue");
  names.add("Chance");
  names.add("Indiana Avenue");
  names.add("Illinois Avenue");
  names.add("B&O Railroad");
  names.add("Atlantic Avnue");
  names.add("Ventnor Avenue");
  names.add("Water Works");
  names.add("Marvin Gardens");
  names.add("GO TO JAIL");
  names.add("Pacific Avenue");
  names.add("North Carolina Avenue");
  names.add("Community Chest");
  names.add("Pennsylvania Avenue");
  names.add("Short Line");
  names.add("Chance");
  names.add("Park Place");
  names.add("Luxury Tax");
  names.add("Boardwalk");
  names.forward();
  
  
  //prepare costs
  
  LL<Integer> costs = new LL<Integer>();
  
  costs.add(0);
  costs.add(60);
  costs.add(0);
  costs.add(60);
  costs.add(200);
  costs.add(200);
  costs.add(100);
  costs.add(0);
  costs.add(100);
  costs.add(120);
  costs.add(0);
  costs.add(140);
  costs.add(150);
  costs.add(140);
  costs.add(160);
  costs.add(200);
  costs.add(180);
  costs.add(0);
  costs.add(180);
  costs.add(200);
  costs.add(0);
  costs.add(220);
  costs.add(0);
  costs.add(220);
  costs.add(240);
  costs.add(200);
  costs.add(260);
  costs.add(260);
  costs.add(150);
  costs.add(280);
  costs.add(0);
  costs.add(300);
  costs.add(300);
  costs.add(0);
  costs.add(320);
  costs.add(200);
  costs.add(0);
  costs.add(350);
  costs.add(100);
  costs.add(400); 
  costs.forward(); 
  
  
  color c;
  String n;
  int cst;
  
  //draw board
  for(int i=10;i>0;i--){
     c = colors.getCurrent().getColor();
     colors.forward();
     n = names.getCurrent();
     names.forward();
     cst = (int)(costs.getCurrent());
     costs.forward();
     PImage img=null;
     //prepage images where necessary
     if(i==10){
       img = loadImage("Squares/Go.jpg");
     }else if(i==8){
       img = loadImage("Squares/CommunityChestUpright.jpg");
     }else if(i==5){
       img = loadImage("Squares/RRUpright.jpg");
     }else if(i==3){
       img = loadImage("Squares/ChanceUpright.jpg");
     }
     //create Square with either a color or an image
     if(img!=null){
       squares.add(new Square(i*50,500,50,50,img,n,cst));
     }else{
       squares.add(new Square(i*50,500,50,50,c,n,cst));
     }
  }
  for(int i=10;i>0;i--){
     c = colors.getCurrent().getColor();
     colors.forward();
     n = names.getCurrent();
     names.forward();
     cst = (int)(costs.getCurrent());
     costs.forward();
     PImage img=null;
     if(i==10){
       img = loadImage("Squares/InJailJustVisiting.jpg");
     }else if(i==8){
       img = loadImage("Squares/ElectricCompany.jpg");
     }else if(i==5){
       img = loadImage("Squares/RRLeft.jpg");
     }else if(i==3){
       img = loadImage("Squares/CommunityChestLeft.jpg");
     }
     if(img!=null){
       squares.add(new Square(0,i*50,50,50,img,n,cst));       
     }else{
       squares.add(new Square(0,i*50,50,50,c,n,cst));
     }
  }
  for(int i=0;i<10;i++){
     c = colors.getCurrent().getColor();
     colors.forward();
     n = names.getCurrent();
     names.forward();
     cst = (int)(costs.getCurrent());
     costs.forward();
     PImage img=null;
     if(i==0){
       img = loadImage("Squares/FreeParking.jpg");
     }else if(i==2){
       img = loadImage("Squares/ChanceUpsideDown.jpg");
     }else if(i==5){
       img = loadImage("Squares/RRUpsideDown.jpg");
     }else if(i==8){
       img = loadImage("Squares/WaterWorks.jpg");
     }
     if(img!=null){
       squares.add(new Square(i*50,0,50,50,img,n,cst));       
     }else{
       squares.add(new Square(i*50,0,50,50,c,n,cst));
     }
  }
  for(int i=0;i<10;i++){
     c = colors.getCurrent().getColor();
     colors.forward();
     n = names.getCurrent();
     names.forward();
     cst = (int)(costs.getCurrent());
     costs.forward();
     PImage img=null;
     if(i==0){
       img = loadImage("Squares/GoToJail.jpg");
     }else if(i==3){
       img = loadImage("Squares/CommunityChestRight.jpg");
     }else if(i==5){
       img = loadImage("Squares/RRRight.jpg");
     }else if(i==6){
       img = loadImage("Squares/ChanceRight.jpg");
     }else if(i==8){
       img = loadImage("Squares/IncomeTax.jpg");
     }
     if(img!=null){
       squares.add(new Square(500,i*50,50,50,img,n,cst));       
     }else{
       squares.add(new Square(500,i*50,50,50,c,n,cst));
     }
  }

  //set current at starting point again
  squares.forward();
  
        // squares test
        //  while(squares.getLength()>38)
        //    squares.removeAndMoveBack();
        // yay, it worked
        
        // text test
        //  PFont f=createFont("Arial",16,true);
        //  textFont(f,22);
        //  fill(255);
        //  text(squares.getCurrent().getName(),300,300);
        // this worked, too
  
  // draw board
  for(int i=0;i<squares.getLength();i++){
    squares.getCurrent().draw();
    squares.forward();
  }
  
  
  //init 2 LLs of Cards, print rectangles with access to top cards
  
  //in case any of these is too painful to implement, I suppose we could do a variation on one or two
  //also: to cover passing "GO" and collecting $200, we can have the players "move" with a while loop and, at each Square, check if the current Square is "GO"
  //and if the player is being sent to jail, we'll set the instance var "inJail" (in the Person class) true *before* he moves
  
  //thanks to whoever answered this: https://answers.yahoo.com/question/index?qid=20110528154141AAFwRyu
  //Community Chest: 
  //
  //Advance to Go (Collect $200) 
  //Bank error in your favor – collect $75 
  //Doctor's fees – Pay $50 
  //Get out of jail free – this card may be kept until needed, or sold 
  //Go to jail – go directly to jail – Do not pass Go, do not collect $200 
  //It is your birthday Collect $10 from each player 
  //Grand Opera Night – collect $50 from every player for opening night seats 
  //Income Tax refund – collect $20 
  //Life Insurance Matures – collect $100 
  //Pay Hospital Fees of $100 
  //Pay School Fees of $50 
  //Receive $25 Consultancy Fee 
  //You are assessed for street repairs – $40 per house, $115 per hotel 
  //You have won second prize in a beauty contest– collect $10 
  //You inherit $100 
  //From sale of stock you get $50 
  //Holiday Fund matures - Receive $100 
  //
  //Chance: 
  //
  //Advance to Go (Collect $200) 
  //Advance to Illinois Ave. 
  //Advance token to nearest Utility. If unowned, you may buy it from the Bank. If owned, throw dice and pay owner a total ten times the amount thrown. 
  //Advance token to the nearest Railroad and pay owner twice the rental to which he/she is otherwise entitled. If Railroad is unowned, you may buy it from the Bank. (There are two of these.) 
  //Advance to St. Charles Place – if you pass Go, collect $200 
  //Bank pays you dividend of $50 
  //Get out of Jail free – this card may be kept until needed, or traded/sold 
  //Go back 3 spaces 
  //Go directly to Jail – do not pass Go, do not collect $200 
  //Make general repairs on all your property – for each house pay $25 – for each hotel $100 
  //Pay poor tax of $15 
  //Take a trip to Reading Railroad – if you pass Go collect $200 
  //Take a walk on the Boardwalk – advance token to Boardwalk 
  //You have been elected chairman of the board – pay each player $50 
  //Your building loan matures – collect $150 
  //You have won a crossword competition - collect $100

  LL<Card> Chance=new LL<Card>();
  
  //if a card calls for money to be collected or given away, we can use a negative value
  Chance.add(new Card(0,"Advance To GO",0,false,squares.find("GO")));//200?
  Chance.add(new Card(0,"Advance To Illinois Avenue",0,false,squares.find("Illinois Avenue")));
  Chance.add(new Card(1));
  Chance.add(new Card(0));
  Chance.add(new Card(0,"Advance To St. Charles",0,false,squares.find("St. Charles Place")));
  Chance.add(new Card(0,"Bank pays you dividend of $50",50,false,null));
  //GOOJF
  Chance.add(new Card(2));
  Chance.add(new Card(0,"Go directly to Jail – do not pass Go, do not collect $200",0,true,null));
  //house repairs
  Chance.add(new Card(0,"Pay poor tax of $15",-15,false,null));
  Chance.add(new Card(0,"Take a trip to Reading Railroad",0,false,squares.find("Reading Railroad")));
  Chance.add(new Card(0,"Take a walk on the Boardwalk",0,false,squares.find("Boardwalk")));
  //price of card = (numPlayers-1)(-50)
  Chance.add(new Card(0,"Your building loan matures – collect $150",150,false,null));
  Chance.add(new Card(0,"You have won a crossword competition - collect $100",100,false,null));  
  
  LL<Card> CommunityChest=new LL<Card>();
  
  CommunityChest.add(new Card(1,"Advance To GO",0,false,squares.find("GO")));//200?
  CommunityChest.add(new Card(1,"Bank error in your favor – collect $75",75,false,null));
  CommunityChest.add(new Card(1,"Doctor's fees – Pay $50",-50,false,null));
  //GOOJF
  CommunityChest.add(new Card(1,"Go directly to Jail – do not pass Go, do not collect $200",0,true,null));
  //price of card = (numPlayers-1)(-10)
  //price of card = (numPlayers-1)(-50)
  CommunityChest.add(new Card(1,"Income Tax refund – collect $20",20,false,null));
  CommunityChest.add(new Card(1,"Life Insurance Matures – collect $100",100,false,null));
  CommunityChest.add(new Card(1,"Pay Hospital Fees of $100",-100,false,null));
  CommunityChest.add(new Card(1,"Receive $25 Consultancy Fee",25,false,null));
  //street repairs
  CommunityChest.add(new Card(1,"You have won second prize in a beauty contest– collect $10",10,false,null));
  CommunityChest.add(new Card(1,"You inherit $100",100,false,null));
  CommunityChest.add(new Card(1,"From sale of stock you get $50",50,false,null));
  CommunityChest.add(new Card(1,"Holiday Fund matures - Receive $100",100,false,null));

  //init [LL of] Persons
  //still testing
  //if every Person shares the same instance of squares
  //(since they have to see what information is contained in each Square)
  //we have to set the squares.current to that Person's own position:
  //meaning, we have to have each person keep track of which Square he's on
  //we'd have to search through squares for that particular Square each turn
  //but it's not too much an issue, since we have a limited number of Squares in squares (the LL)
  //so Person can have an instance variable to keep track of which Square he's on at the end of each turn
  //does that work?
  //or did you have something else in mind?
  //(I didn't edit that in the Person class [yet, in case you do disagree])
  
  //init&draw dice
  //P.S. can't put a draw() method in the Die class if it's static
    
}

void draw(){
  background(150);
  //fill(150);
  for(int i=0;i<squares.getLength();i++){
    squares.getCurrent().draw();
    squares.forward();
  }
  for(int i=0;i<players.getLength();i++){
    players.getCurrent().draw();
    players.forward();
  }
}
