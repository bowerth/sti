package com.vosviewer.vos;

/**
 * VOSMappingParameters
 *
 * @author Nees Jan van Eck
 * @author Ludo Waltman
 * @version 1.0.0, 01/11/15
 */

public class VOSMappingParameters implements Cloneable
{
    public static final int ATTRACTION = 2;
    public static final int REPULSION = 1;
    public static final int MAX_N_ITERATIONS = 1000;
    public static final double INITIAL_STEP_SIZE = 1;
    public static final double STEP_SIZE_CONVERGENCE = 0.001;
    public static final double STEP_SIZE_REDUCTION = 0.75;
    public static final int REQUIRED_N_QUALITY_FUNTION_IMPROVEMENTS = 5;
    public static final int N_RANDOM_STARTS = 1;
    public static final int FIXED_SEED = 0;
    public static final boolean USE_RANDOM_SEED = false;

    private int attraction;
    private int repulsion;
    private int maxNIterations;
    private double initialStepSize;
    private double stepSizeConvergence;
    private double stepSizeReduction;
    private int requiredNQualityFunctionImprovements;
    private int nRandomStarts;
    private int fixedSeed;
    private boolean useRandomSeed;

    public VOSMappingParameters()
    {
        attraction = ATTRACTION;
        repulsion = REPULSION;
        maxNIterations = MAX_N_ITERATIONS;
        initialStepSize = INITIAL_STEP_SIZE;
        stepSizeConvergence = STEP_SIZE_CONVERGENCE;
        stepSizeReduction = STEP_SIZE_REDUCTION;
        requiredNQualityFunctionImprovements = REQUIRED_N_QUALITY_FUNTION_IMPROVEMENTS;
        nRandomStarts = N_RANDOM_STARTS;
        fixedSeed = FIXED_SEED;
        useRandomSeed = USE_RANDOM_SEED;
    }

    public Object clone()
    {
        VOSMappingParameters clone;
        try
        {
            clone = (VOSMappingParameters)super.clone();
        }
        catch (CloneNotSupportedException e)
        {
            return null;
        }
        return clone;
    }

    public int getAttraction()
    {
        return attraction;
    }

    public void setAttraction(int attraction)
    {
        this.attraction = attraction;
    }

    public int getRepulsion()
    {
        return repulsion;
    }

    public void setRepulsion(int repulsion)
    {
        this.repulsion = repulsion;
    }

    public int getMaxNIterations()
    {
        return maxNIterations;
    }

    public void setMaxNIterations(int maxNIterations)
    {
        this.maxNIterations = maxNIterations;
    }

    public double getInitialStepSize()
    {
        return initialStepSize;
    }

    public void setInitialStepSize(double initialStepSize)
    {
        this.initialStepSize = initialStepSize;
    }

    public double getStepSizeConvergence()
    {
        return stepSizeConvergence;
    }

    public void setStepSizeConvergence(double stepSizeConvergence)
    {
        this.stepSizeConvergence = stepSizeConvergence;
    }

    public double getStepSizeReduction()
    {
        return stepSizeReduction;
    }

    public void setStepSizeReduction(double stepSizeReduction)
    {
        this.stepSizeReduction = stepSizeReduction;
    }

    public int getRequiredNQualityFunctionImprovements()
    {
        return requiredNQualityFunctionImprovements;
    }

    public void setRequiredNQualityFunctionImprovements(int requiredNQualityFunctionImprovements)
    {
        this.requiredNQualityFunctionImprovements = requiredNQualityFunctionImprovements;
    }

    public int getNRandomStarts()
    {
        return nRandomStarts;
    }

    public void setNRandomStarts(int nRandomStarts)
    {
        this.nRandomStarts = nRandomStarts;
    }

    public int getFixedSeed()
    {
        return fixedSeed;
    }

    public void setFixedSeed(int fixedSeed)
    {
        this.fixedSeed = fixedSeed;
    }

    public boolean getUseRandomSeed()
    {
        return useRandomSeed;
    }

    public void setUseRandomSeed(boolean useRandomSeed)
    {
        this.useRandomSeed = useRandomSeed;
    }
}