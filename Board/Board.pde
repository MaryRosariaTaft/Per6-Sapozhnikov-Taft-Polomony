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

void setup(){
  
  size(550,550);
  
  //init LL of Squares
  LL<Square> squares=new LL<Square>();
  
  //also have to put text on each Square (the name of that Square/property)
  
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
  
  color c;
  String n;
  
  for(int i=10;i>0;i--){
     c = colors.getCurrent().getColor();
     colors.forward();
     n = names.getCurrent();
     names.forward();
     squares.add(new Square(i*50,500,50,50,c,n));
  }
  for(int i=10;i>0;i--){
     c = colors.getCurrent().getColor();
     colors.forward();
     n = names.getCurrent();
     names.forward();
     squares.add(new Square(0,i*50,50,50,c,n));
  }
  for(int i=0;i<10;i++){
     c = colors.getCurrent().getColor();
     colors.forward();
     n = names.getCurrent();
     names.forward();
     squares.add(new Square(i*50,0,50,50,c,n));
  }
  for(int i=0;i<10;i++){
     c = colors.getCurrent().getColor();
     colors.forward();
     n = names.getCurrent();
     names.forward();
     squares.add(new Square(500,i*50,50,50,c,n)); 
  }

  //set current at starting point again
  squares.forward();
  
  // squares test
  //  while(squares.getLength()>38)
  //    squares.removeAndMoveBack();
  // yay, it worked
  
  // draw border
  for(int i=0;i<squares.getLength();i++){
    squares.getCurrent().draw();
    squares.forward();
  }
  
  // text test
  //  PFont f=createFont("Arial",16,true);
  //  textFont(f,22);
  //  fill(255);
  //  text(squares.getCurrent().getName(),300,300);
  // this worked, too
  
  //init 2 LLs of Cards, print rectangles with access to top cards
  LL<Card> deck1=new LL<Card>();
  LL<Card> deck2=new LL<Card>();
  
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
  
  LL<Person> players=new LL<Person>();
  players.add(new Person("Bob",squares));
  
  //init&draw dice
  //P.S. can't put a draw() method in the Die class if it's static
  
}
