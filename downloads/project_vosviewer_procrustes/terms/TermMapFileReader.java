package com.vosviewer.terms;

/**
 * TermMapFileReader
 *
 * @author Nees Jan van Eck
 * @author Ludo Waltman
 * @version 1.0.4, 09/27/15
 */

import java.io.BufferedReader;
import java.io.File;
import java.io.IOException;
import java.io.InputStream;
import java.io.LineNumberReader;
import java.net.URI;
import java.util.Vector;
import com.vosviewer.CharsetInputStreamReader;
import com.vosviewer.FileData;
import com.vosviewer.FileDataValues;
import com.vosviewer.FileParser;
import com.vosviewer.FileReadException;
import com.vosviewer.FileSettings;

public class TermMapFileReader
{
    private FileSettings fileSettings;

    private Vector<String> documents;
    private FileDataValues scoreAttributes;

    public static void main(String[] args) throws IOException
    {
        TermMapFileReader reader = new TermMapFileReader(new FileSettings());
        reader.openFiles(new File("test21//corpus.txt").toURI().toString(), new File("test21//scores2.txt").toURI().toString());
    }

    public TermMapFileReader(FileSettings fileSettings)
    {
        this.fileSettings = fileSettings;
    	documents = new Vector<String>();
    	scoreAttributes = new FileDataValues(FileData.SCORE_COLUMN_HEADER);
    }

    public void openFiles(String corpusFile, String scoresFile) throws IOException
    {
        try
        {
            readCorpusFile(FileParser.getInputStream(new URI(corpusFile)));
        }
        catch (Exception e)
        {
            if ((e instanceof FileReadException) && (((FileReadException)e).getLineNumber() != -1))
                throw new IOException("Error while reading VOSviewer coprus file (line " + ((FileReadException)e).getLineNumber() + "): " + e.getMessage());
            throw new IOException("Error while reading VOSviewer corpus file: " + e.getMessage());
        }
        if (scoresFile != null)
            try
            {
                readScoresFile(FileParser.getInputStream(new URI(scoresFile)));
            }
            catch (Exception e)
            {
                if ((e instanceof FileReadException) && (((FileReadException)e).getLineNumber() != -1))
                    throw new IOException("Error while reading VOSviewer scores file (line " + ((FileReadException)e).getLineNumber() + "): " + e.getMessage());
                throw new IOException("Error while reading VOSviewer scores file: " + e.getMessage());
            }
        else
        {
            Vector<Double> scores = new Vector<Double>(documents.size());
            for (int i = 0; i < documents.size(); i++)
                scores.add(1.0);
            scoreAttributes = new FileDataValues(FileData.SCORE_COLUMN_HEADER, scores);
        }
    }

    public Vector<String> getDocuments()
    {
        return documents;
    }

    public FileDataValues getScores()
    {
        return scoreAttributes;
    }

    public int getNDocuments()
    {
        return documents.size();
    }

    private void readCorpusFile(InputStream inputStream) throws IOException
    {
        BufferedReader reader = null;
        try
        {
            reader = new BufferedReader(new CharsetInputStreamReader(inputStream, fileSettings));
            String document = reader.readLine();
            while (document != null)
            {
                documents.add(document);
                document = reader.readLine();
            }
            reader.close();
        }
        finally
        {
            if (reader != null)
                reader.close();
        }
        if (documents.size() == 0)
            throw new FileReadException("File is empty.");
    }

    private void readScoresFile(InputStream inputStream) throws IOException
    {
        LineNumberReader reader = null;
        Vector<String> parsedHeaderLine;
        Vector<Vector<String>> parsedLines = new Vector<Vector<String>>();
        Vector<Integer> lineNumbers = new Vector<Integer>();
        int nColumns;
        Vector<Integer> scoreColumns = new Vector<Integer>();
        try
        {
            reader = new LineNumberReader(new CharsetInputStreamReader(inputStream, fileSettings));
            String headerLine = reader.readLine();
            char delimiter = FileParser.detectHeaderLineDelimiter(headerLine);
            parsedHeaderLine = FileParser.parseDelimitedLine(headerLine, delimiter, reader.getLineNumber());
            if (parsedHeaderLine == null)
                throw new FileReadException("File is empty.");
            nColumns = parsedHeaderLine.size();
            if (nColumns > 1)
                for (int i = 0; i < nColumns; i++)
                {
                    String header = parsedHeaderLine.get(i).toLowerCase();
                    if (header.equals(""))
                        throw new FileReadException("Column header is empty.", reader.getLineNumber());
                    else if (header.matches(FileData.SCORE_COLUMN_HEADER + "[<].*[>]"))
                        scoreColumns.add(i);
                    else
                        throw new FileReadException(FileParser.formatFileNameForErrorMessage(header.toUpperCase()) + " is not a valid column header.", reader.getLineNumber());
                    if (header.matches(".*?[<].*[>]"))
                    {
                        String label = header.replaceFirst("(.*?[<])(.*)([>])", "$2");
                        if (label.matches("(.*[<>\\[\\]_\"\t].*)|(\\s)*"))
                            throw new FileReadException(FileParser.formatFileNameForErrorMessage(header.toUpperCase()) + " is not a valid column header.", reader.getLineNumber());
                    }
                }
            else
            {
                String header = parsedHeaderLine.get(0).toLowerCase();
                if (header.matches(FileData.SCORE_COLUMN_HEADER + "[<].*[>]"))
                {
                    String label = header.replaceFirst("(.*?[<])(.*)([>])", "$2");
                    if (label.matches("(.*[<>\\[\\]_\"\t].*)|(\\s)*"))
                        throw new FileReadException(FileParser.formatFileNameForErrorMessage(header.toUpperCase()) + " is not a valid column header.", reader.getLineNumber());
                    scoreColumns.add(0);
                }
                else if (!header.equals(FileData.SCORE_COLUMN_HEADER))
                {
                    parsedLines.add(parsedHeaderLine);
                    lineNumbers.add(reader.getLineNumber());
                }
            }
            Vector<String> parsedLine = FileParser.parseDelimitedLine(reader.readLine(), delimiter, reader.getLineNumber());
            while (parsedLine != null)
            {
                if (parsedLine.size() != nColumns)
                    throw new FileReadException("Incorrect number of columns.", reader.getLineNumber());
                if (nColumns > 1)
                {
                    boolean allAvailable = true;
                    boolean allUnavailable = true;
                    for (int i = 0; i < nColumns; i++)
                    {
                        boolean isNaN = Double.isNaN(FileParser.parseScore(parsedLine.get(i), true, reader.getLineNumber()));
                        allAvailable &= !isNaN;
                        allUnavailable &= isNaN;
                    }
                    if (!allAvailable && !allUnavailable)
                        throw new FileReadException("The scores of a document must either all be available or all be unavailable.", reader.getLineNumber());
                }
                parsedLines.add(parsedLine);
                lineNumbers.add(reader.getLineNumber());
                parsedLine = FileParser.parseDelimitedLine(reader.readLine(), delimiter, reader.getLineNumber());
            }
            reader.close();
            int nDocuments = parsedLines.size();
            if (documents.size() != nDocuments)
                throw new FileReadException("The number of documents must be the same as in the VOSviewer corpus file.");
            if (scoreColumns.isEmpty())
            {
                Vector<Double> scores = new Vector<Double>(nDocuments);
                for (int i = 0; i < nDocuments; i++)
                    scores.add(FileParser.parseScore(parsedLines.get(i).get(0), true, lineNumbers.get(i)));
                scoreAttributes = new FileDataValues(FileData.SCORE_COLUMN_HEADER, scores);
            }
            else
            {
                scoreAttributes = new FileDataValues(FileData.SCORE_COLUMN_HEADER);
                for (int j = 0; j < scoreColumns.size(); j++)
                {
                    int column = scoreColumns.get(j);
                    String label = parsedHeaderLine.get(column).replaceFirst("(.*?[<])(.*)([>])", "$2");
                    Vector<Double> values = new Vector<Double>(nDocuments);
                    for (int i = 0; i < nDocuments; i++)
                        values.add(FileParser.parseScore(parsedLines.get(i).get(column), true, lineNumbers.get(i)));
                    scoreAttributes.addAttribute(label, values);
                }
            }
            reader.close();
        }
        finally
        {
            if (reader != null)
                reader.close();
        }
    }
}