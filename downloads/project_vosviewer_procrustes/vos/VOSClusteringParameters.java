package com.vosviewer.vos;

/**
 * VOSClusteringParameters
 *
 * @author Nees Jan van Eck
 * @author Ludo Waltman
 * @version 1.0.0, 01/11/15
 */

public class VOSClusteringParameters implements Cloneable
{
    public static final double RESOLUTION = 1;
    public static final int MIN_CLUSTER_SIZE = 1;
    public static final int N_ITERATIONS = 10;
    public static final int N_RANDOM_STARTS = 10;
    public static final int FIXED_SEED = 0;
    public static final boolean USE_RANDOM_SEED = false;

    private double resolution;
    private int minClusterSize;
    private int nIterations;
    private int nRandomStarts;
    private int fixedSeed;
    private boolean useRandomSeed;

    public VOSClusteringParameters()
    {
        resolution = RESOLUTION;
        minClusterSize = MIN_CLUSTER_SIZE;
        nIterations = N_ITERATIONS;
        nRandomStarts = N_RANDOM_STARTS;
        fixedSeed = FIXED_SEED;
        useRandomSeed = USE_RANDOM_SEED;
    }

    public Object clone()
    {
        VOSClusteringParameters clone;
        try
        {
            clone = (VOSClusteringParameters)super.clone();
        }
        catch (CloneNotSupportedException e)
        {
            return null;
        }
        return clone;
    }

    public double getResolution()
    {
        return resolution;
    }

    public void setResolution(double resolution)
    {
        this.resolution = resolution;
    }

    public int getMinClusterSize()
    {
        return minClusterSize;
    }

    public void setMinClusterSize(int minClusterSize)
    {
        this.minClusterSize = minClusterSize;
    }

    public int getNIterations()
    {
        return nIterations;
    }

    public void setNIterations(int nIterations)
    {
        this.nIterations = nIterations;
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