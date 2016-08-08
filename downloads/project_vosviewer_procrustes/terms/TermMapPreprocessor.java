package com.vosviewer.terms;

/**
 * TermMapPreprocessor
 *
 * @author Nees Jan van Eck
 * @author Ludo Waltman
 * @version 1.0.4, 09/27/15
 */

import java.io.BufferedReader;
import java.io.BufferedWriter;
import java.io.FileNotFoundException;
import java.io.FileReader;
import java.io.FileWriter;
import java.io.IOException;
import java.io.InputStream;
import java.util.Arrays;
import java.util.Scanner;
import java.util.Vector;
import com.vosviewer.SparseMatrixElementDouble;
import com.vosviewer.SparseMatrixElementInteger;
import com.vosviewer.Thesaurus;
import opennlp.tools.postag.POSModel;
import opennlp.tools.postag.POSTagger;
import opennlp.tools.postag.POSTaggerME;
import opennlp.tools.sentdetect.SentenceDetector;
import opennlp.tools.sentdetect.SentenceDetectorME;
import opennlp.tools.sentdetect.SentenceModel;
import opennlp.tools.tokenize.Tokenizer;
import opennlp.tools.tokenize.TokenizerME;
import opennlp.tools.tokenize.TokenizerModel;

public class TermMapPreprocessor
{
    public static final String SENTENCE_MODEL_FILE = "en-sent.bin";
    public static final String TOKENIZER_MODEL_FILE = "en-token.bin";
    public static final String TAGGER_MODEL_FILE = "en-pos-maxent.bin";

    public static final PatternReplacement[] SENTENCE_REPLACEMENT_RULES =
        {
            // Replacement rules for HTML characters (http://en.wikipedia.org/wiki/List_of_XML_and_HTML_character_entity_references).
            new PatternReplacement("&amp;", "&"),
            new PatternReplacement("(&quot;|&ldquo;|&rdquo;|&apos;|&lsquo;|&rsquo;|&prime;|&nbsp;|&ensp;|&emsp;|&thinsp;|&middot;|&bull;|&sdot;|&hellip;)", " "),
            new PatternReplacement("(&lt;|&lang;)", " < "),
            new PatternReplacement("(&gt;|&rang;)", " > "),
            new PatternReplacement("&copy;", " (C) "),
            new PatternReplacement("&reg;", " (R) "),
            new PatternReplacement("&plusmn;", " +/- "),
            new PatternReplacement("(&times;|&lowast;)", " * "),
            new PatternReplacement("&divide;", " / "),
            new PatternReplacement("(&ndash;|&mdash;|&minus;)", " - "),
            new PatternReplacement("&real;", " R "),
            new PatternReplacement("&trade;", " TM "),
            new PatternReplacement("&sim;", " ~ "),
            new PatternReplacement("&le;", " <= "),
            new PatternReplacement("&ge;", " >= "),
            new PatternReplacement("&ne;", " <> "),
            new PatternReplacement("(?i)(&)([a-z1-4]+?)(;)", " $2 "),
            new PatternReplacement(" & ", "&"),

            // Replacement rules to improve part-of-speech tagging.
            new PatternReplacement("\\(", " ( "),
            new PatternReplacement("\\)", " ) "),
            new PatternReplacement("%", " % "),
            new PatternReplacement("/", " "),
            new PatternReplacement("\\b-\\b", " "),
            new PatternReplacement("\"", " "),
            new PatternReplacement("'{2}", " "),
            new PatternReplacement(" '", " "),
            new PatternReplacement("' ", " "),
            new PatternReplacement("`{2}", " "),
            new PatternReplacement(" `", " "),
            new PatternReplacement("` ", " "),
            new PatternReplacement("’{2}", " "),
            new PatternReplacement(" ’", " "),
            new PatternReplacement("’ ", " ")
        };

    public static final int DEFAULT_STEP_PARAMETER = 2;

    private SentenceDetector sentenceDetector;
    private Tokenizer tokenizer;
    private POSTagger POSTagger;
    private NPExtractor NPExtractor;

    private NPOccurrenceMatrix NPOccurrenceMatrix;

    @SuppressWarnings("resource")
    public static void main(String[] args) throws IOException
    {
        boolean keyboardInput = true;
        if (args.length == 7)
            keyboardInput = false;
        TermMapPreprocessor termMapPreprocessor = new TermMapPreprocessor();
        Scanner console = new Scanner(System.in);
        System.out.println("Term Map Preprocessor version 1.0.4 by Nees Jan van Eck and Ludo Waltman");
        System.out.println();
        System.out.print("Corpus file: ");
        BufferedReader corpusFileReader = null;
        try
        {
            if (keyboardInput)
                corpusFileReader = new BufferedReader(new FileReader(console.next()));
            else
            {
                System.out.println(args[0]);
                corpusFileReader = new BufferedReader(new FileReader(args[0]));
            }
        }
        catch (FileNotFoundException e)
        {
            System.err.println("Corpus file not found.");
            System.exit(0);
        }
        System.out.println("Extracting noun phrases from corpus file...");
        String document = corpusFileReader.readLine();
        while (document != null)
        {
            termMapPreprocessor.extractNPsFromDocument(document, 1);
            document = corpusFileReader.readLine();
        }
        corpusFileReader.close();
        int nDocuments = termMapPreprocessor.getNDocuments();
        int nNPs1 = termMapPreprocessor.getNNPs();
        System.out.println(nNPs1 + " noun phrases extracted from " + nDocuments + " documents.");
        System.out.print("Minimum number of occurrences of a noun phrase: ");
        String minTotalOccurrenceFrequencyString;
        if (keyboardInput)
            minTotalOccurrenceFrequencyString = console.next();
        else
        {
            System.out.println(args[1]);
            minTotalOccurrenceFrequencyString = args[1];
        }
        int minTotalOccurrenceFrequency = 0;
        try
        {
            minTotalOccurrenceFrequency = Integer.parseInt(minTotalOccurrenceFrequencyString);
        }
        catch(NumberFormatException e)
        {
            System.err.println("Illegal input.");
            System.exit(1);
        }
        System.out.print("Ignore multiple occurrences of a noun phrase in the same document ('0' for no, '1' for yes): ");
        String binaryCountingString;
        if (keyboardInput)
            binaryCountingString = console.next();
        else
        {
            System.out.println(args[2]);
            binaryCountingString = args[2];
        }
        boolean binaryCounting = true;
        if (binaryCountingString.equals("0"))
            binaryCounting = false;
        else if (!binaryCountingString.equals("1"))
        {
            System.err.println("Illegal input.");
            System.exit(1);
        }
        termMapPreprocessor.removeInfrequentNPs(minTotalOccurrenceFrequency, binaryCounting);
        int nNPs2 = termMapPreprocessor.getNNPs();
        System.out.println("Out of the " + nNPs1 + " noun phrases, " + nNPs2 + " meet the occurrence threshold.");
        if (nNPs2 > 0)
        {
            System.out.print("Number of noun phrases to be selected: ");
            String nNPsToSelectedString;
            if (keyboardInput)
                nNPsToSelectedString = console.next();
            else
            {
                System.out.println(args[3]);
                nNPsToSelectedString = args[3];
            }
            int nNPsToSelected = 0;
            try
            {
                nNPsToSelected = Integer.parseInt(nNPsToSelectedString);
            }
            catch(NumberFormatException e) { }
            if (nNPsToSelected <= 0)
            {
                System.err.println("Illegal input.");
                System.exit(1);
            }
            int nNPsToRemove = termMapPreprocessor.getNNPs() - nNPsToSelected;
            if (nNPsToRemove > 0)
            {
                System.out.println("Selecting most relevant noun phrases...");
                termMapPreprocessor.removeIrrelevantNPs(nNPsToRemove, DEFAULT_STEP_PARAMETER, binaryCounting);
            }
            System.out.print("Noun phrase file: ");
            String NPFile;
            if (keyboardInput)
                NPFile = console.next();
            else
            {
                System.out.println(args[4]);
                NPFile = args[4];
            }
            BufferedWriter NPFileWriter = new BufferedWriter(new FileWriter(NPFile));
            String[] NPs = termMapPreprocessor.getNPs();
            for (int i = 0; i < NPs.length; i++)
            {
                NPFileWriter.write(NPs[i]);
                NPFileWriter.newLine();
            }
            NPFileWriter.close();
            System.out.print("Matrix file: ");
            String matrixFile;
            if (keyboardInput)
                matrixFile = console.next();
            else
            {
                System.out.println(args[5]);
                matrixFile = args[5];
            }
            BufferedWriter matrixFileWriter = new BufferedWriter(new FileWriter(matrixFile));
            System.out.print("Matrix file format ('0' for occurrence and '1' for co-occurrence): ");
            String matrixFileFormatString;
            if (keyboardInput)
                matrixFileFormatString = console.next();
            else
            {
                System.out.println(args[6]);
                matrixFileFormatString = args[6];
            }
            Vector<SparseMatrixElementInteger>[] matrix = null;
            if (matrixFileFormatString.equals("0"))
                matrix = termMapPreprocessor.getNPOccurrenceMatrix(1);
            else if (matrixFileFormatString.equals("1"))
                matrix = termMapPreprocessor.getNPCooccurrenceMatrix(binaryCounting);
            else if (!matrixFileFormatString.equals("1"))
            {
                System.err.println("Illegal input.");
                System.exit(1);
            }
            for (int i = 0; i < matrix.length; i++)
            {
                Vector<SparseMatrixElementInteger> sparseMatrixElements = matrix[i];
                for (int j = 0; j < sparseMatrixElements.size(); j++)
                {
                    matrixFileWriter.write((i + 1) + "," + (sparseMatrixElements.get(j).index + 1) + "," + sparseMatrixElements.get(j).value);
                    matrixFileWriter.newLine();
                }
            }
            matrixFileWriter.close();
        }
    }

    public TermMapPreprocessor()
    {
        initSentenceDetector();
        initTokenizer();
        initPOSTagger();
        NPExtractor = new NPExtractor();

        NPOccurrenceMatrix = new NPOccurrenceMatrix();
    }

    private TermMapPreprocessor(SentenceDetector sentenceDetector, Tokenizer tokenizer, POSTagger POSTagger, NPExtractor NPExtractor)
    {
        this.sentenceDetector = sentenceDetector;
        this.tokenizer = tokenizer;
        this.POSTagger = POSTagger;
        this.NPExtractor = NPExtractor;

        NPOccurrenceMatrix = new NPOccurrenceMatrix();
    }

    public Object clone()
    {
        TermMapPreprocessor clone = new TermMapPreprocessor(sentenceDetector, tokenizer, POSTagger, NPExtractor);
        clone.NPOccurrenceMatrix = (NPOccurrenceMatrix)NPOccurrenceMatrix.clone();
        return clone;
    }

    public void extractNPsFromDocument(String document, double documentScore)
    {
        extractNPsFromDocument(document, Double.isNaN(documentScore) ? null : new double[]{documentScore});
    }
    
    public void extractNPsFromDocument(String document, double[] documentScores)
    {
        Vector<String> NPs = new Vector<String>();
        String[] sentences = sentenceDetector.sentDetect(document);
        for (int i = 0; i < sentences.length; i++)
        {
            String sentence = cleanSentence(sentences[i]);
            String[] tokens = tokenizer.tokenize(sentence);
            String[] tags = POSTagger.tag(tokens);
            NPs.addAll(NPExtractor.extract(tokens, tags));
        }
        NPOccurrenceMatrix.addNPOccurrences(NPs, documentScores);
    }

    public void applyThesaurus(Thesaurus thesaurus)
    {
        NPOccurrenceMatrix.applyThesaurus(thesaurus);
    }

    public void removeNP(String NP)
    {
        NPOccurrenceMatrix.removeNP(NP);
    }

    public void removeInfrequentNPs(int minTotalOccurrenceFrequency, boolean binaryCounting)
    {
        String[] NPs = NPOccurrenceMatrix.getNPs();
        int[] NPTotalOccurrenceFrequencies = NPOccurrenceMatrix.getNPTotalOccurrenceFrequencies(binaryCounting);
        for (int i = 0; i < NPTotalOccurrenceFrequencies.length; i++)
            if (NPTotalOccurrenceFrequencies[i] < minTotalOccurrenceFrequency)
                NPOccurrenceMatrix.removeNP(NPs[i]);
    }

    public void removeIrrelevantNPs(int nNPsToRemove, int stepParameter, boolean binaryCounting)
    {
        String[] NPs = NPOccurrenceMatrix.getNPs();
        double[] NPRelevanceScores = getNPRelevanceScores(stepParameter, binaryCounting);
        double[] sortedNPRelevanceScores = Arrays.copyOf(NPRelevanceScores, NPRelevanceScores.length);
        Arrays.sort(sortedNPRelevanceScores);
        double minNPRelevanceScore = sortedNPRelevanceScores[Math.min(nNPsToRemove, sortedNPRelevanceScores.length - 1)];
        int nNPsRemoved = 0;
        for (int i = 0; i < NPRelevanceScores.length; i++)
            if (NPRelevanceScores[i] < minNPRelevanceScore)
            {
                NPOccurrenceMatrix.removeNP(NPs[i]);
                nNPsRemoved++;
            }
        int i = 0;
        while (nNPsRemoved < nNPsToRemove)
        {
            if (NPRelevanceScores[i] == minNPRelevanceScore)
            {
                NPOccurrenceMatrix.removeNP(NPs[i]);
                nNPsRemoved++;
            }
            i++;
        }
    }

    public int getNNPs()
    {
        return NPOccurrenceMatrix.getNNPs();
    }

    public int getNDocuments()
    {
        return NPOccurrenceMatrix.getNDocuments();
    }

    public String[] getNPs()
    {
        return NPOccurrenceMatrix.getNPs();
    }

    public int[] getNPTotalOccurrenceFrequencies(boolean binaryCounting)
    {
        return NPOccurrenceMatrix.getNPTotalOccurrenceFrequencies(binaryCounting);
    }

    public int[] getNPTotalOccurrenceFrequenciesScores(boolean binaryCounting)
    {
        return NPOccurrenceMatrix.getNPTotalOccurrenceFrequenciesScores(binaryCounting);
    }

    public int[] getNPTotalCooccurrenceFrequencies(boolean binaryCounting)
    {
        return NPOccurrenceMatrix.getNPTotalCooccurrenceFrequencies(binaryCounting);
    }

    public int[] getNPTotalCooccurrenceFrequenciesScores(boolean binaryCounting)
    {
        return NPOccurrenceMatrix.getNPTotalCooccurrenceFrequenciesScores(binaryCounting);
    }

    public double[][] getNPScores(boolean binaryCounting, int minNScoreOccurrences)
    {
        return NPOccurrenceMatrix.getNPScores(binaryCounting, minNScoreOccurrences);
    }

    @SuppressWarnings("unchecked")
    public double[] getNPRelevanceScores(int stepParameter, boolean binaryCounting)
    {
        Vector<SparseMatrixElementInteger>[] NPCooccurrenceMatrix = getNPCooccurrenceMatrix(binaryCounting);
        int nNPs = NPCooccurrenceMatrix.length;
        Vector<SparseMatrixElementDouble>[] transitionMatrix = new Vector[nNPs];
        double[] stationaryProbabilities = new double[nNPs];
        double a = 0;
        for (int i = 0; i < nNPs; i++)
        {
            transitionMatrix[i] = new Vector<SparseMatrixElementDouble>(NPCooccurrenceMatrix[i].size());
            double b = 0;
            for (int j = 0; j < NPCooccurrenceMatrix[i].size(); j++)
                b += NPCooccurrenceMatrix[i].get(j).value;
            for (int j = 0; j < NPCooccurrenceMatrix[i].size(); j++)
                transitionMatrix[i].add(new SparseMatrixElementDouble(NPCooccurrenceMatrix[i].get(j).index, NPCooccurrenceMatrix[i].get(j).value / b));
            stationaryProbabilities[i] = b;
            a += b;
        }
        double[] NPRelevanceScores = new double[nNPs];
        if (a > 0)
        {
            for (int i = 0; i < nNPs; i++)
                stationaryProbabilities[i] /= a;
            double[] transitionProbabilities = new double[nNPs];
            for (int i = 0; i < nNPs; i++)
            {
                calcTransitionProbabilities(i, stepParameter, 1, transitionMatrix, transitionProbabilities);
                for (int j = 0; j < nNPs; j++)
                    if (transitionProbabilities[j] > 0)
                    {
                        NPRelevanceScores[i] += transitionProbabilities[j] * Math.log(transitionProbabilities[j] / stationaryProbabilities[j]);
                        transitionProbabilities[j] = 0;
                    }
            }
        }
        else
            for (int i = 0; i < nNPs; i++)
                NPRelevanceScores[i] = 1;
        return NPRelevanceScores;
    }

    public Vector<SparseMatrixElementInteger>[] getNPOccurrenceMatrix(int storageMethod)
    {
        return NPOccurrenceMatrix.getNPOccurrenceMatrix(storageMethod);
    }

    public Vector<SparseMatrixElementInteger>[] getNPCooccurrenceMatrix(boolean binaryCounting)
    {
        return NPOccurrenceMatrix.getNPCooccurrenceMatrix(binaryCounting);
    }

    public void printNPOccurrenceMatrix()
    {
        System.out.println(NPOccurrenceMatrix.toString());
    }

    private void initSentenceDetector()
    {
        InputStream sentenceModelFile = null;
        try
        {
            sentenceModelFile = getClass().getResourceAsStream(SENTENCE_MODEL_FILE);
            SentenceModel sentenceModel = new SentenceModel(sentenceModelFile);
            sentenceDetector = new SentenceDetectorME(sentenceModel);
        }
        catch (IOException e)
        {
            e.printStackTrace();
        }
        finally
        {
            if (sentenceModelFile != null)
                try
                {
                    sentenceModelFile.close();
                }
                catch (IOException e){ }
        }
    }

    private void initTokenizer()
    {
        InputStream tokenizerModelFile = null;
        try
        {
            tokenizerModelFile = getClass().getResourceAsStream(TOKENIZER_MODEL_FILE);
            TokenizerModel tokenizerModel = new TokenizerModel(tokenizerModelFile);
            tokenizer = new TokenizerME(tokenizerModel);
        }
        catch (IOException e)
        {
            e.printStackTrace();
        }
        finally
        {
            if (tokenizerModelFile != null)
                try
                {
                    tokenizerModelFile.close();
                }
                catch (IOException e){ }
        }
    }

    private void initPOSTagger()
    {
        InputStream taggerModelFile = null;
        try
        {
            taggerModelFile = getClass().getResourceAsStream(TAGGER_MODEL_FILE);
            POSModel taggerModel = new POSModel(taggerModelFile);
            POSTagger = new POSTaggerME(taggerModel);
        }
        catch (IOException e)
        {
            e.printStackTrace();
        }
        finally
        {
            if (taggerModelFile != null)
                try
                {
                    taggerModelFile.close();
                }
                catch (IOException e){ }
        }
    }

    private String cleanSentence(String sentence)
    {
        String cleanedSentence = sentence;
        for (int i = 0; i < SENTENCE_REPLACEMENT_RULES.length; i++)
        {
            PatternReplacement sentenceReplacementRule = SENTENCE_REPLACEMENT_RULES[i];
            if (sentenceReplacementRule.isMatch(cleanedSentence))
                cleanedSentence = sentenceReplacementRule.apply(cleanedSentence);
        }
        if (cleanedSentence.matches("^[A-Z0-9[ ]\\p{Punct}]+$"))
            cleanedSentence = cleanedSentence.toLowerCase();
        return cleanedSentence;
    }

    private void calcTransitionProbabilities(int index, int nSteps, double probability, Vector<SparseMatrixElementDouble>[] transitionMatrix, double[] transitionProbabilities)
    {
        if (nSteps > 0)
            for (int i = 0; i < transitionMatrix[index].size(); i++)
                calcTransitionProbabilities(transitionMatrix[index].get(i).index, nSteps - 1, probability * transitionMatrix[index].get(i).value, transitionMatrix, transitionProbabilities);
        else
            transitionProbabilities[index] += probability;
    }
}