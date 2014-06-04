import java.io.*;
import java.util.*;

class LL<E>{

    class Node<E>{

	private E data;
	private Node<E> next, prev;

	Node(E d){
	    this.data=d;
	    next=this;
	    prev=this;
	}

	void setData(E d){data=d;}
	E getData(){return data;}
	void setNext(Node<E> n){next=n;}
	Node<E> getNext(){return next;}
	void setPrev(Node<E> p){prev=p;}
	Node<E> getPrev(){return prev;}

	String toString(){
	    return data.toString();
	}

    }

    private Node<E> current;
    private int length=0;

    //initializes LL if LL is empty, or adds parameter Node after current Node
    void add(E d){
	Node<E> n=new Node<E>(d);
	if(current==null)
	    current=n;
	else{
	    n.setNext(current.getNext());
	    current.getNext().setPrev(n);
	    n.setPrev(current);
	    current.setNext(n);
	    current=n;
	}
        length++;
    }
    
    //extra functionality
    void addBefore(E d){
	Node<E> n=new Node<E>(d);
	if(current==null)
	    current=n;
	else{
	    n.setPrev(current.getPrev());
	    current.getPrev().setNext(n);
	    n.setNext(current);
	    current.setPrev(n);
	    current=n;
	}
    }
    
    //removes current Node
    //null if removing last Node
    //new current is current.getNext() otherwise
    E remove(){
	if(current==null)
	    return null;
	E data=current.getData(); //or getCurrent();
	if(length==1)
	    current=null;
	else{
	    current.getNext().setPrev(current.getPrev());
	    current.getPrev().setNext(current.getNext());
	    current=current.getNext();
	}
	length--;
	return data;
    }
    
    //extra functionality
    E removeAndMoveBack(){
	if(current==null)
	    return null;
	E data=current.getData(); //or getCurrent();
	if(length==1)
	    current=null;
	else{
	    current.getNext().setPrev(current.getPrev());
	    current.getPrev().setNext(current.getNext());
	    current=current.getPrev();
	}
	length--;
	return data;
    }

    void forward(){
	current=current.getNext();
    }

    void back(){
	current=current.getPrev();
    }
    
    int getLength(){
	return length; 
    }

    E getCurrent(){
	if(current==null) return null;
	return current.getData();
    }
    
    E find(String target){
	if(current==null)
	    return null;
	String s=current.toString()+" ";
	Node<E> temp=current.getNext();
	while(temp!=current){
	    if(target.equals(s)){
		return temp.getData();
	    }
	    temp=temp.getNext();
	}
	return null;
    } 

    String toString(){
	if(current==null)
	    return "";
	String s=current.toString()+" ";
	Node<E> temp=current.getNext();
	while(temp!=current){
	    s+=temp.toString()+" ";
	    temp=temp.getNext();
	}
	return s;
    }

}
