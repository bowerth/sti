package com.vosviewer.terms;

/**
 * NPOccurrenceMatrix
 *
 * @author Nees Jan van Eck
 * @author Ludo Waltman
 * @version 1.0.4, 09/27/15
 */

import java.util.Arrays;
import java.util.TreeMap;
import java.util.Map.Entry;
import java.util.Vector;
import com.vosviewer.SparseMatrixElementInteger;
import com.vosviewer.Thesaurus;

public class NPOccurrenceMatrix
{
    public static final int FROM_NPS_TO_DOCUMENTS = 0;
    public static final int FROM_DOCUMENTS_TO_NPS = 1;

    private TreeMap<String, NPOccurrenceVector> NPTreeMap;
    private Vector<Double[]> documentScores;

    public NPOccurrenceMatrix()
    {
        NPTreeMap = new TreeMap<String, NPOccurrenceVector>();
        documentScores = new Vector<Double[]>();
    }

    @SuppressWarnings("unchecked")
    public Object clone()
    {
        NPOccurrenceMatrix clone = new NPOccurrenceMatrix();
        clone.NPTreeMap = new TreeMap<String, NPOccurrenceVector>();
        for (Entry<String, NPOccurrenceVector> NPTreeMapEntry : NPTreeMap.entrySet())
        {
            String NP = NPTreeMapEntry.getKey();
            NPOccurrenceVector NPOccurrenceVector = (NPOccurrenceVector)NPTreeMapEntry.getValue().clone();
            clone.NPTreeMap.put(NP, NPOccurrenceVector);
        }
        clone.documentScores = (Vector<Double[]>)documentScores.clone();
        return clone;
    }

    public String toString()
    {
        StringBuffer NPOccurrenceMatrixString = new StringBuffer();
        int i = 0;
        for (Entry<String, NPOccurrenceVector> NPTreeMapEntry : NPTreeMap.entrySet())
        {
            NPOccurrenceMatrixString.append(i + ". " + NPTreeMapEntry.getKey() + ": " + NPTreeMapEntry.getValue().toString() + "\r\n");
            i++;
        }
        return NPOccurrenceMatrixString.toString();
    }

    public void addNPOccurrences(Vector<String> NPs, double[] documentScores)
    {
        for (int i = 0; i < NPs.size(); i++)
        {
            String NP = NPs.get(i);
            NPOccurrenceVector NPOccurrenceVector = NPTreeMap.get(NP);
            if (NPOccurrenceVector == null)
            {
                NPOccurrenceVector = new NPOccurrenceVector();
                NPTreeMap.put(NP, NPOccurrenceVector);
            }
            NPOccurrenceVector.addNPOccurrence(this.documentScores.size(), 1);
        }
        if (documentScores != null)
        {
            Double[] documentScores2 = new Double[documentScores.length];
            for (int i = 0; i < documentScores.length; i++)
                documentScores2[i] = documentScores[i];
            this.documentScores.add(documentScores2);
        }
        else
            this.documentScores.add(null);
    }

    public void applyThesaurus(Thesaurus thesaurus)
    {
        String[] NPs = getNPs();
        for (int i = 0; i < NPs.length; i++)
        {
            String replaceBy = thesaurus.replaceBy(NPs[i]);
            if (replaceBy == null)
                NPTreeMap.remove(NPs[i]);
            else if (!replaceBy.equals(NPs[i]))
                if (NPTreeMap.containsKey(replaceBy))
                    NPTreeMap.get(replaceBy).addNPOccurrenceVector(NPTreeMap.remove(NPs[i]));
                else
                    NPTreeMap.put(replaceBy, NPTreeMap.remove(NPs[i]));
        }
    }

    public void removeNP(String NP)
    {
        NPOccurrenceVector NPOccurrenceVector = NPTreeMap.remove(NP);
        if (NPOccurrenceVector != null)
        {
            String shortenedNP = NP;
            NPOccurrenceVector shortenedNPOccurrenceVector = null;
            do
            {
                shortenedNP = shortenNP(shortenedNP);
                if (shortenedNP != null)
                    shortenedNPOccurrenceVector = NPTreeMap.get(shortenedNP);
            }
            while ((shortenedNP != null) && (shortenedNPOccurrenceVector == null));
            if (shortenedNPOccurrenceVector != null)
                shortenedNPOccurrenceVector.addNPOccurrenceVector(NPOccurrenceVector);
        }
    }

    public int getNNPs()
    {
        return NPTreeMap.size();
    }

    public int getNDocuments()
    {
        return documentScores.size();
    }

    public String[] getNPs()
    {
        String[] NPs = new String[NPTreeMap.size()];
        int i = 0;
        for (String NP : NPTreeMap.keySet())
        {
            NPs[i] = NP;
            i++;
        }
        return NPs;
    }

    public int[] getNPTotalOccurrenceFrequencies(boolean binaryCounting)
    {
        int[] NPTotalOccurrenceFrequencies = new int[NPTreeMap.size()];
        int i = 0;
        for (NPOccurrenceVector NPOccurrenceVector : NPTreeMap.values())
        {
            NPTotalOccurrenceFrequencies[i] = NPOccurrenceVector.getNPTotalOccurrenceFrequency(binaryCounting);
            i++;
        }
        return NPTotalOccurrenceFrequencies;
    }

    public int[] getNPTotalOccurrenceFrequenciesScores(boolean binaryCounting)
    {
        int[] NPTotalOccurrenceFrequencies = new int[NPTreeMap.size()];
        int i = 0;
        for (NPOccurrenceVector NPOccurrenceVector : NPTreeMap.values())
        {
            for (Entry<Integer, MutableInteger> NPOccurrenceVectorEntry : NPOccurrenceVector.getEntrySet())
                if (documentScores.get(NPOccurrenceVectorEntry.getKey()) != null)
                    NPTotalOccurrenceFrequencies[i] += binaryCounting ? 1 : NPOccurrenceVectorEntry.getValue().getValue();
            i++;
        }
        return NPTotalOccurrenceFrequencies;
    }

    public int[] getNPTotalCooccurrenceFrequencies(boolean binaryCounting)
    {
        int[] NPTotalCooccurrenceFrequencies = new int[NPTreeMap.size()];
        int[] documentTotalOccurrenceFrequencies = new int[documentScores.size()];
        for (NPOccurrenceVector NPOccurrenceVector : NPTreeMap.values())
            for (Entry<Integer, MutableInteger> NPOccurrenceVectorEntry : NPOccurrenceVector.getEntrySet())
                documentTotalOccurrenceFrequencies[NPOccurrenceVectorEntry.getKey()] += binaryCounting ? 1 : NPOccurrenceVectorEntry.getValue().getValue();
        int i = 0;
        for (NPOccurrenceVector NPOccurrenceVector : NPTreeMap.values())
        {
            for (Entry<Integer, MutableInteger> NPOccurrenceVectorEntry : NPOccurrenceVector.getEntrySet())
                NPTotalCooccurrenceFrequencies[i] += binaryCounting ? (documentTotalOccurrenceFrequencies[NPOccurrenceVectorEntry.getKey()] - 1) : (NPOccurrenceVectorEntry.getValue().getValue() * (documentTotalOccurrenceFrequencies[NPOccurrenceVectorEntry.getKey()] - NPOccurrenceVectorEntry.getValue().getValue()));
            i++;
        }
        return NPTotalCooccurrenceFrequencies;
    }

    public int[] getNPTotalCooccurrenceFrequenciesScores(boolean binaryCounting)
    {
        int[] NPTotalCooccurrenceFrequencies = new int[NPTreeMap.size()];
        int[] documentTotalOccurrenceFrequencies = new int[documentScores.size()];
        for (NPOccurrenceVector NPOccurrenceVector : NPTreeMap.values())
            for (Entry<Integer, MutableInteger> NPOccurrenceVectorEntry : NPOccurrenceVector.getEntrySet())
                documentTotalOccurrenceFrequencies[NPOccurrenceVectorEntry.getKey()] += binaryCounting ? 1 : NPOccurrenceVectorEntry.getValue().getValue();
        int i = 0;
        for (NPOccurrenceVector NPOccurrenceVector : NPTreeMap.values())
        {
            for (Entry<Integer, MutableInteger> NPOccurrenceVectorEntry : NPOccurrenceVector.getEntrySet())
                if (documentScores.get(NPOccurrenceVectorEntry.getKey()) != null)
                    NPTotalCooccurrenceFrequencies[i] += binaryCounting ? (documentTotalOccurrenceFrequencies[NPOccurrenceVectorEntry.getKey()] - 1) : (NPOccurrenceVectorEntry.getValue().getValue() * (documentTotalOccurrenceFrequencies[NPOccurrenceVectorEntry.getKey()] - NPOccurrenceVectorEntry.getValue().getValue()));
            i++;
        }
        return NPTotalCooccurrenceFrequencies;
    }

    public double[][] getNPScores(boolean binaryCounting, int minNScoreOccurrences)
    {
        int nScores = 1;
        boolean nScoresFound = false;
        int i = 0;
        while (!nScoresFound && (i < documentScores.size()))
        {
            if (documentScores.get(i) != null)
            {
                nScores = documentScores.get(i).length;
                nScoresFound = true;
            }
            i++;
        }
        double[][] NPScores = new double[NPTreeMap.size()][nScores];
        i = 0;
        for (NPOccurrenceVector NPOccurrenceVector : NPTreeMap.values())
        {
            double[] totalDocumentScores = new double[nScores];
            int totalOccurrenceFrequency = 0;
            for (Entry<Integer, MutableInteger> NPOccurrenceVectorEntry : NPOccurrenceVector.getEntrySet())
            {
                Double[] documentScores = this.documentScores.get(NPOccurrenceVectorEntry.getKey());
                if (documentScores != null)
                {
                    int frequency = binaryCounting ? 1 : NPOccurrenceVectorEntry.getValue().getValue();
                    for (int j = 0; j < nScores; j++)
                        totalDocumentScores[j] += frequency * documentScores[j];
                    totalOccurrenceFrequency += frequency;
                }
            }
            if (totalOccurrenceFrequency >= minNScoreOccurrences)
                for (int j = 0; j < nScores; j++)
                    NPScores[i][j] = totalDocumentScores[j] / totalOccurrenceFrequency;
            else
                Arrays.fill(NPScores[i], Double.NaN);
            i++;
        }
        return NPScores;
    }

    @SuppressWarnings("unchecked")
    public Vector<SparseMatrixElementInteger>[] getNPOccurrenceMatrix(int storageMethod)
    {
        Vector<SparseMatrixElementInteger>[] NPOccurrenceMatrix = null;
        if (storageMethod == FROM_NPS_TO_DOCUMENTS)
        {
            NPOccurrenceMatrix = new Vector[NPTreeMap.size()];
            int i = 0;
            for (NPOccurrenceVector NPOccurrenceVector : NPTreeMap.values())
            {
                NPOccurrenceMatrix[i] = new Vector<SparseMatrixElementInteger>(NPOccurrenceVector.getEntrySet().size());
                for (Entry<Integer, MutableInteger> NPOccurrenceVectorEntry : NPOccurrenceVector.getEntrySet())
                    NPOccurrenceMatrix[i].add(new SparseMatrixElementInteger(NPOccurrenceVectorEntry.getKey(), NPOccurrenceVectorEntry.getValue().getValue()));
                i++;
            }
        }
        else if (storageMethod == FROM_DOCUMENTS_TO_NPS)
        {
            NPOccurrenceMatrix = new Vector[documentScores.size()];
            for (int i = 0; i < NPOccurrenceMatrix.length; i++)
                NPOccurrenceMatrix[i] = new Vector<SparseMatrixElementInteger>();
            int i = 0;
            for (NPOccurrenceVector NPOccurrenceVector : NPTreeMap.values())
            {
                for (Entry<Integer, MutableInteger> NPOccurrenceVectorEntry : NPOccurrenceVector.getEntrySet())
                    NPOccurrenceMatrix[NPOccurrenceVectorEntry.getKey()].add(new SparseMatrixElementInteger(i, NPOccurrenceVectorEntry.getValue().getValue()));
                i++;
            }
        }
        return NPOccurrenceMatrix;
    }

    @SuppressWarnings("unchecked")
    public Vector<SparseMatrixElementInteger>[] getNPCooccurrenceMatrix(boolean binaryCounting)
    {
        int nNPs = NPTreeMap.size();
        Vector<SparseMatrixElementInteger>[] NPOccurrenceMatrix1 = getNPOccurrenceMatrix(FROM_NPS_TO_DOCUMENTS);
        Vector<SparseMatrixElementInteger>[] NPOccurrenceMatrix2 = getNPOccurrenceMatrix(FROM_DOCUMENTS_TO_NPS);
        Vector<SparseMatrixElementInteger>[] NPCooccurrenceMatrix = new Vector[nNPs];
        int[] cooccurrenceFrequencies = new int[nNPs];
        for (int i = 0; i < nNPs; i++)
        {
            for (int j = 0; j < NPOccurrenceMatrix1[i].size(); j++)
            {
                int k = NPOccurrenceMatrix1[i].get(j).index;
                for (int l = 0; l < NPOccurrenceMatrix2[k].size(); l++)
                    cooccurrenceFrequencies[NPOccurrenceMatrix2[k].get(l).index] += binaryCounting ? 1 : (NPOccurrenceMatrix1[i].get(j).value * NPOccurrenceMatrix2[k].get(l).value);
            }
            NPCooccurrenceMatrix[i] = new Vector<SparseMatrixElementInteger>();
            for (int j = 0; j < nNPs; j++)
            {
                if ((j != i) && (cooccurrenceFrequencies[j] > 0))
                    NPCooccurrenceMatrix[i].add(new SparseMatrixElementInteger(j, cooccurrenceFrequencies[j]));
                cooccurrenceFrequencies[j] = 0;
            }
        }
        return NPCooccurrenceMatrix;
    }

    private String shortenNP(String NP)
    {
        String shortenedNP = null;
        int index = NP.indexOf(' ');
        if (index != -1)
            shortenedNP = NP.substring(index + 1);
        return shortenedNP;
    }
}