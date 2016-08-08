package com.vosviewer.terms;

/**
 * PatternReplacement
 *
 * @author Nees Jan van Eck
 * @author Ludo Waltman
 * @version 1.0.4, 09/27/15
 */

import java.util.regex.Pattern;

public class PatternReplacement
{
    private Pattern pattern;
    private String replacement;

    public PatternReplacement(String pattern, String replacement)
    {
        this.pattern = Pattern.compile(pattern, Pattern.CASE_INSENSITIVE);
        this.replacement = replacement;
    }

    public boolean isMatch(String text)
    {
        return pattern.matcher(text).find();
    }

    public String apply(String text)
    {
        return pattern.matcher(text).replaceAll(replacement);
    }
}