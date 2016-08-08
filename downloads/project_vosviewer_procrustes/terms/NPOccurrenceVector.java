package com.vosviewer.terms;

/**
 * NPOccurrenceVector
 *
 * @author Nees Jan van Eck
 * @author Ludo Waltman
 * @version 1.0.4, 09/27/15
 */

import java.util.Set;
import java.util.TreeMap;
import java.util.Map.Entry;

public class NPOccurrenceVector
{
    private TreeMap<Integer, MutableInteger> NPTreeMap;

    public NPOccurrenceVector()
    {
        NPTreeMap = new TreeMap<Integer, MutableInteger>();
    }

    public Object clone()
    {
        NPOccurrenceVector clone = new NPOccurrenceVector();
        clone.NPTreeMap = new TreeMap<Integer, MutableInteger>();
        for (Entry<Integer, MutableInteger> NPTreeMapEntry : NPTreeMap.entrySet())
        {
            int documentNumber = NPTreeMapEntry.getKey();
            MutableInteger NPOccurrenceFrequency = (MutableInteger)NPTreeMapEntry.getValue().clone();
            clone.NPTreeMap.put(documentNumber, NPOccurrenceFrequency);
        }
        return clone;
    }

    public String toString()
    {
        StringBuffer NPOccurrenceVectorString = new StringBuffer();
        for (Entry<Integer, MutableInteger> NPTreeMapEntry : NPTreeMap.entrySet())
        {
            if (NPOccurrenceVectorString.length() > 0)
                NPOccurrenceVectorString.append(", ");
            NPOccurrenceVectorString.append(NPTreeMapEntry.getKey() + "(" + NPTreeMapEntry.getValue().getValue() + ")");
        }
        return NPOccurrenceVectorString.toString();
    }

    public void addNPOccurrence(int documentNumber, int frequency)
    {
        MutableInteger NPOccurrenceFrequency = NPTreeMap.get(documentNumber);
        if (NPOccurrenceFrequency != null)
            NPOccurrenceFrequency.setValue(NPOccurrenceFrequency.getValue() + frequency);
        else
            NPTreeMap.put(documentNumber, new MutableInteger(frequency));
    }

    public void addNPOccurrenceVector(NPOccurrenceVector NPOccurrenceVector)
    {
        for (Entry<Integer, MutableInteger> NPTreeMapEntry : NPOccurrenceVector.NPTreeMap.entrySet())
            addNPOccurrence(NPTreeMapEntry.getKey(), NPTreeMapEntry.getValue().getValue());
    }

    public int getNPTotalOccurrenceFrequency(boolean binaryCounting)
    {
        int NPTotalOccurrenceFrequency = 0;
        if (binaryCounting)
            NPTotalOccurrenceFrequency = NPTreeMap.size();
        else
            for (MutableInteger NPOccurrenceFrequency : NPTreeMap.values())
                NPTotalOccurrenceFrequency += NPOccurrenceFrequency.getValue();
        return NPTotalOccurrenceFrequency;
    }

    public Set<Entry<Integer, MutableInteger>> getEntrySet()
    {
        return NPTreeMap.entrySet();
    }
}