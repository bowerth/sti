package com.vosviewer.terms;

/**
 * MutableInteger
 *
 * @author Nees Jan van Eck
 * @author Ludo Waltman
 * @version 1.0.4, 09/27/15
 */

public class MutableInteger implements Comparable<MutableInteger>
{
    private int value;

    public MutableInteger(int value)
    {
        this.value = value;
    }

    public Object clone()
    {
        return new MutableInteger(value);
    }

    public boolean equals(Object obj)
    {
        if (obj instanceof MutableInteger)
            return (value == ((MutableInteger)obj).value);
        return false;
    }

    public String toString()
    {
        return String.valueOf(value);
    }

    public int compareTo(MutableInteger anotherMutableInteger)
    {
        int anotherValue = anotherMutableInteger.value;
        if (value < anotherValue)
            return -1;
        else if (value == anotherValue)
            return 0;
        else
            return 1;
    }

    public int getValue()
    {
        return value;
    }

    public void setValue(int value)
    {
        this.value = value;
    }
}