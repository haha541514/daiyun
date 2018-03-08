package com.daiyun.test;

public class StringTEST{
	
	
	public static void main(String[] args) {
		run();
	}
	
	public static void run(){
		StringTEST t = new StringTEST();  
		A a = new A();  
		a.age = 10;  
		t.test1(a);  
		System.out.println("main方法中的age="+a.age);  //20,10

	}
	private void test1(A a){  
		a = new A();//2.新加的一行  
		a.age = 20; 
		//20 ,20一个新的对象，hashcode都不同
		System.out.println("test1方法中的age="+a.age); 
	}  
}

class A{
	public int age = 0;  
	
}