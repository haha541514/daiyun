package com.daiyun.test;
import java.lang.reflect.Field;  
import java.util.ArrayList;
import java.util.List;

public class TypeUtil{
	
	
	public static Class<?> getClass(Object obj) {  
        if (obj instanceof Integer) {  
            return Integer.TYPE;   
        } else if (obj instanceof Boolean) {  
            return Boolean.TYPE;  
        } else if (obj instanceof Long) {  
            return Long.TYPE;  
        } else if (obj instanceof Short) {  
            return Short.TYPE;  
        } else if (obj instanceof Double) {  
            return Double.TYPE;  
        } else if (obj instanceof Float) {  
            return Float.TYPE;  
        } else if (obj instanceof Character) {  
            return Character.TYPE;  
        } else if (obj instanceof Byte) {  
            return Byte.TYPE;  
        }  
        return obj.getClass();  
    }  
    /** 
     * 判断某个对象是否为装箱的基本类型对象或基本类型 
     */  
    public static boolean isBasicType(Object obj) {  
        final String[] types = {"int", "char", "boolean","long", "double", "float", "byte", "short"};  
        String clazzName = getClass(obj).getName();  
        int j = 0;  
        for (int i = 0; i < types.length; i++) {  
            if (clazzName.equals(types[i])) {  
                break;  
            }  
            j++;  
        }  
        if (j <= 7) {  
            return true;   
        } else {  
            return false;  
        }  
    }  
    /** 
     * 判断某对象是否为字符串 
     */  
    public static boolean isString(Object obj) {  
        return obj instanceof String;  
    }  
    /** 
     * 迭代出一个对象的全部基本属性 
     */  
    public static void recurse(Field[] fs, Object obj, List<Object> list) throws IllegalArgumentException, IllegalAccessException {  
          
        for (int i = 0; i < fs.length; i++) {  
            int j = 0;  
            Field f = fs[i];  
            f.setAccessible(true);  
            Object v = f.get(obj);  
            if (isBasicType(v)) {  
                j++;  
                list.add(v);  
            }   
            if (isString(v)) {  
                j++;  
                list.add(v);  
            }  
            if (j == fs.length)  
                continue;  
            if (!(isBasicType(v) || isString(v))) {  
                recurse(v.getClass().getFields(), v, list);  
            }  
        }  
    }  
public static void main(String[] args) throws IllegalArgumentException, IllegalAccessException {  
  
        List<Object> list = new ArrayList<Object>();  
        Name n = new Name("sz", "yy", new Address("aa", "bb"));  
        Person p = new Person(11, n);  
        recurse(p.getClass().getDeclaredFields() ,p, list);  
        System.out.println(list);  
    }  
}  
class Person {  
      
    private int age;  
    private Name name;  
    public Person(int age, Name name) {  
        this.age = age;  
        this.name = name;  
    }  
}  
class Name {  
    public Name(String first, String second, Address address) {  
        this.first = first;  
        this.second = second;  
        this.address = address;  
    }  
    public String first;  
    public String second;  
    public Address address;  
      
}  
class Address {  
    public Address(String age, String name) {  
        this.age = age;  
        this.name = name;  
    }  
    public String age;  
    private String name;  
}  
	  
	
