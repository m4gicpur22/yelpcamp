import java.util.*;
import java.io.*;

public class Stack{
	//top, size, push, and pop

	private int [] stack;
	private int top;
	private int size;

	//person added to stack
	private String name;
	private String rollno;

	/*public Person(String name, String rollno) {
		this.name = name;
		this.rollno = rollno;
	}

	public String toString(){
		return "Name: " + this.name + "Rollno: " + this.rollno;
	}*/


	public Stack(){
		top = -1;//Set top to a minimum so it updates every time
		size = 50;
		stack = new int [50];
	}

	public Stack(int size){
		top = -1;//Set top to a minimum so it updates every time
		this.size = size;
		stack = new int [this.size];
	}

	public boolean push(int item) {

		if(!isFull()){
		top++;
		stack[top] = item;
		return true;
	}
		return false;
	}

	public boolean isFull(){
		return (top == stack.length - 1);
	}

	public int pop(){
		return stack[top--];
	}

	public boolean isEmpty() {
		return (top == -1);
	}


	public static void main(String[] args){
		Stack instack = new Stack();
		if(!instack.isFull()){
			instack.push(2);
			instack.push(4);
			instack.push(6);
			instack.push(9);

		}

		System.out.println(instack.pop());
		System.out.println(instack.pop());
		System.out.println(instack.pop());
		System.out.println(instack.pop());
	}



}