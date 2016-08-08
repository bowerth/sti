package com.vosviewer.terms;

/**
 * NPExtractor
 *
 * @author Nees Jan van Eck
 * @author Ludo Waltman
 * @version 1.0.4, 09/27/15
 */

import java.text.Normalizer;
import java.text.Normalizer.Form;
import java.util.Vector;

public class NPExtractor
{
    public static final int MIN_N_CHARACTERS = 3;

    public static final String[] SINGULAR_NOUN_TAGS = { "NN", "NNP"};
    public static final String[] PLURAL_NOUN_TAGS = { "NNS", "NNPS"};
    public static final String[] ADJECTIVE_TAGS = { "JJ", "JJR", "JJS" };
    public static final String[] STOP_WORDS = {"any", "some", "certain", "other", "different", "various", "several", "such", "varied"};

    public static final String[] UNCOUNTABLE_WORDS = {"equipment", "information", "rice", "money", "species", "series", "fish", "sheep", "data", "metadata"};

    public static final PatternReplacement[] SINGULAR_RULES =
        {
            // Regular.
            new PatternReplacement("s$", ""),
            new PatternReplacement("(n)ews$", "$1ews"),
            new PatternReplacement("([ti])a$", "$1um"),
            new PatternReplacement("((a)naly|(b)a|(d)iagno|(p)arenthe|(p)rogno|(s)ynop|(t)he)ses$", "$1$2sis"),
            new PatternReplacement("(^analy)ses$", "$1sis"),
            new PatternReplacement("([^f])ves$", "$1fe"),
            new PatternReplacement("(hive)s$", "$1"),
            new PatternReplacement("(tive)s$", "$1"),
            new PatternReplacement("([lr])ves$", "$1f"),
            new PatternReplacement("([^aeiouy]|qu)ies$", "$1y"),
            new PatternReplacement("(s)eries$", "$1eries"),
            new PatternReplacement("(m)ovies$", "$1ovie"),
            new PatternReplacement("(x|ch|ss|sh)es$", "$1"),
            new PatternReplacement("([m|l])ice$", "$1ouse"),
            new PatternReplacement("(bus)es$", "$1"),
            new PatternReplacement("(o)es$", "$1"),
            new PatternReplacement("(shoe)s$", "$1"),
            new PatternReplacement("(cris|ax|test)es$", "$1is"),
            new PatternReplacement("(octop|vir)i$", "$1us"),
            new PatternReplacement("(alias|status|virus)es$", "$1"),
            new PatternReplacement("^(ox)en", "$1"),
            new PatternReplacement("(vert|ind)ices$", "$1ex"),
            new PatternReplacement("(matr)ices$", "$1ix"),
            new PatternReplacement("(quiz)zes$", "$1"),
            new PatternReplacement("(ba)ses$", "$1se"),
            // Irregular.
            new PatternReplacement("(p)eople$", "$1erson"),
            new PatternReplacement("(m)en$", "$1an"),
            new PatternReplacement("(c)hildren$", "$1hild"),
            new PatternReplacement("(s)exes$", "$1ex"),
            new PatternReplacement("(m)oves$", "$1ove"),
            new PatternReplacement("(wa)ves$", "$1ve")
        };

    public Vector<String> extract(String[] tokens, String[] tags)
    {
        Vector<String> NPs = new Vector<String>();
        int i = tokens.length - 1;
        while (i >= 0)
        {
            String token = clean(tokens[i]);
            String tag = tags[i];
            boolean isNoun;
            if (isPluralNoun(tag))
            {
                token = singularize(token);
                isNoun = true;
            }
            else if (isSingularNoun(tag))
                isNoun = true;
            else
                isNoun = false;
            if (isNoun && isLegalWord(token))
            {
                StringBuffer NP = new StringBuffer(token);
                i--;
                boolean isNP = true;
                while ((i >= 0) && isNP)
                {
                    token = clean(tokens[i]);
                    tag = tags[i];
                    if ((isNoun(tag) || isAdjective(tag)) && isLegalWord(token))
                    {
                        NP.insert(0, token + " ");
                        i--;
                    }
                    else
                        isNP = false;
                }
                if (NP.length() >= MIN_N_CHARACTERS)
                    NPs.add(0, NP.toString());
            }
            else
                i--;
        }
        return NPs;
    }

    private String clean(String token)
    {
        //return token.replaceAll("[^\\p{Alnum}[ ]&]", "").toLowerCase();
        String cleanedToken = Normalizer.normalize(token, Form.NFD).replaceAll("\\p{InCombiningDiacriticalMarks}+", "");
        cleanedToken = token.replaceAll("[^\\p{Alnum}[ ]&]", "");
        cleanedToken = cleanedToken.replaceAll("^&", "");
        cleanedToken = cleanedToken.replaceAll("&", " & ");
        return cleanedToken.toLowerCase();
    }

    private String singularize(String token)
    {
        PatternReplacement singularRule = null;
        if (!isUncountableWord(token))
        {
            int i = SINGULAR_RULES.length - 1;
            while ((singularRule == null) && (i >= 0))
            {
                if (SINGULAR_RULES[i].isMatch(token))
                    singularRule = SINGULAR_RULES[i];
                i--;
            }
        }
        if (singularRule != null)
            return singularRule.apply(token);
        return token;
    }

    private boolean isLegalWord(String token)
    {
        if (token.matches("[^\\p{Alpha}]*"))
            return false;
        for (int i = 0; i < STOP_WORDS.length; i++)
            if (token.equals(STOP_WORDS[i]))
                return false;
        return true;
    }

    private boolean isUncountableWord(String token)
    {
        for (int i = 0; i < UNCOUNTABLE_WORDS.length; i++)
            if (token.equals(UNCOUNTABLE_WORDS[i]))
                return true;
        return false;
    }

    private boolean isSingularNoun(String tag)
    {
        for (int i = 0; i < SINGULAR_NOUN_TAGS.length; i++)
            if (tag.equals(SINGULAR_NOUN_TAGS[i]))
                return true;
        return false;
    }

    private boolean isPluralNoun(String tag)
    {
        for (int i = 0; i < PLURAL_NOUN_TAGS.length; i++)
            if (tag.equals(PLURAL_NOUN_TAGS[i]))
                return true;
        return false;
    }

    private boolean isNoun(String tag)
    {
        return isSingularNoun(tag) || isPluralNoun(tag);
    }

    private boolean isAdjective(String tag)
    {
        for (int i = 0; i < ADJECTIVE_TAGS.length; i++)
            if (tag.equals(ADJECTIVE_TAGS[i]))
                return true;
        return false;
    }
}