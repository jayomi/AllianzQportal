/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com;

import java.math.BigDecimal;
import java.math.RoundingMode;
import java.util.Date;

/**
 *
 * @author AKILAK
 */
public class cal_cost {

    public BigDecimal cal(String num, Date duration) {

        double cost = 0;
        int min = duration.getMinutes();
        if (duration.getSeconds() > 0) {
            min += 1;
        }
        int len = num.length();

        switch (len) {
            case 7:
                if (num.substring(0, 1).equals("2") || num.substring(0, 1).equals("3")) {
                    cost = min * 1.50;
                } else {
                    cost = min * 2.50;
                }
                break;
            case 9:
                if (!num.substring(2, 3).equals("7")) {
                    if (num.substring(2, 3).equals("2") || num.substring(2, 3).equals("3")) {

                        cost = min * 1.50;
                    }
                } else {
                    cost = min * 2.50;
                }
                break;
            case 10:
                if (!num.substring(2, 3).equals("7")) {
                    if (num.substring(4, 5).equals("2") || num.substring(4, 5).equals("3")) {
                        cost = min * 1.50;
                    }
                } else {
                    cost = min * 2.50;
                }
                break;

        }
//        System.out.println("Tot cost for " + num + " " + cost);
        BigDecimal bd = new BigDecimal(cost).setScale(2, RoundingMode.HALF_UP);;
        return bd;
    }

    public String convert(String num) {

        int len = num.length();

        switch (len) {
            case 7:
                num = "011" + num;
                break;
            case 9:
                num = "0" + num;
                break;

        }
        return num;
    }

}
