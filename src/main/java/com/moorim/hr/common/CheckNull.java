package com.moorim.hr.common;
/**
 * 해당 문자열이나 정수가 NULL인지 체크하는 CLASS
 */
public class CheckNull
{

    public static String checkString(String str)
    {
        if(str == null || str.equals("")) return "";
        else return str.trim();
    }

    public static int checkInt(String str)
    {
        if(str == null || str.equals("")) return 0;
        else return Integer.parseInt(str);
    }

    public static int checkInt(String str, int defaultInt)
    {
        try {
            if(str == null || str.equals("")) return defaultInt;
            else return Integer.parseInt(str);
        } catch(NumberFormatException e) {
            return defaultInt;
        }
    }

    public static String checkString(String str, String defaultStr)
    {
        if(str == null || str.equals("")) return defaultStr;
        else return str.trim();
    }

    public static String[] checkString(String[] str)
    {
        for(int i = 0; i < str.length; i++) {
            str[i] = checkString(str[i]);
        }
        return str;
    }

    public static int[] checkInt(String[] str)
    {
        int[] returnInt = new int[str.length];
        for(int i = 0; i < str.length; i++) {
            returnInt[i] = checkInt(str[i]);
        }
        return returnInt;
    }

}
