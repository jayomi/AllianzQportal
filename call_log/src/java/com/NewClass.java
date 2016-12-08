/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com;

import java.util.ArrayList;
import java.util.HashSet;
import java.util.Set;

/**
 *
 * @author AKILAK
 */
public class NewClass {

    public static Set<String> getIncoming() {

        Set<String> set = new HashSet<>();
        set.add("1");
        set.add("2");
        set.add("5");
        set.add("7");
        set.add("0");
        set.add("30");
        set.add("31");
        set.add("32");
        set.add("33");
        set.add("34");
        set.add("35");
        set.add("36");
        set.add("37");
        set.add("38");
        set.add("39");
        set.add("40");
        return set;

    }
    
    public static Set<String> getOutgoing() {

        Set<String> set = new HashSet<>();
        set.add("3");
        set.add("4");
        set.add("6");
        set.add("9"); 
        return set;

    }

    public static void main(String[] args) {
//        if (getIncoming().contains("30")) {
//            System.out.println("true");
//        }
       
//        SimpleDateFormat sdf = new SimpleDateFormat("HH:MM");
//        String date= "28.01.15";
//        
//        String d = "20"+date.substring(6, 8) +"/"+ date.substring(3, 5) +"/" +date.substring(0, 2);
//        
//        
//        System.out.println(sdf.format(new Date(d)));
    ArrayList<String> timestampsList = new ArrayList<String>();
        timestampsList.add("00:01:48");
        timestampsList.add("00:02:35");
        timestampsList.add("00:03:45");

        long tm = 0;
        for (String tmp : timestampsList){
            String[] arr = tmp.split(":");
            tm += Integer.parseInt(arr[2]);
            tm += 60 * Integer.parseInt(arr[1]);
            tm += 3600 * Integer.parseInt(arr[0]);
        }

        long hh = tm / 3600;
        tm %= 3600;
        long mm = tm / 60;
        tm %= 60;
        long ss = tm;
        System.out.println(format(hh) + ":" + format(mm) + ":" + format(ss));
    }

    private static String format(long s){
        if (s < 10) return "0" + s;
        else return "" + s;
    }
}
