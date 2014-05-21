import java.io.*;
import java.util.*;

pubilc class Die{

    public Die(){

    }

    public int roll(){
	Random r=new Random();
	return r.nextInt(6)+1;
    }

}