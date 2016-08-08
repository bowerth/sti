package com.vosviewer.vos;

/**
 * VOSMapping
 *
 * @author Nees Jan van Eck
 * @author Ludo Waltman
 * @version 1.0.0, 01/11/15
 */

import java.util.Random;
import com.vosviewer.network.Layout;
import com.vosviewer.network.Network;
import com.vosviewer.network.VOSLayoutTechnique;

public class VOSMapping
{
    public static final double SIMILARITY_BETWEEN_UNCONNECTED_ITEMS = 0.01;

    private Network network;
    private VOSMappingParameters parameters;
    private Random random;
    private double edgeWeightIncrement;
    private double minQualityFunction;
    private Layout bestLayout;

    public VOSMapping(Network network, VOSMappingParameters parameters)
    {
        this.network = network;

        this.parameters = parameters;
        random = (parameters.getUseRandomSeed()) ? new Random() : new Random(parameters.getFixedSeed());
        edgeWeightIncrement = (network.identifyComponents().getNClusters() > 1) ? SIMILARITY_BETWEEN_UNCONNECTED_ITEMS : 0;

        bestLayout = null;
        minQualityFunction = Double.POSITIVE_INFINITY;
    }

    public void performRandomStart()
    {
        VOSLayoutTechnique layoutTechnique = new VOSLayoutTechnique(network, parameters.getAttraction(), parameters.getRepulsion(), edgeWeightIncrement, random);
        layoutTechnique.runGradientDescentAlgorithm(parameters.getMaxNIterations(), parameters.getInitialStepSize(), parameters.getStepSizeConvergence(), parameters.getStepSizeReduction(), parameters.getRequiredNQualityFunctionImprovements(), random);
        double qualityFunction = layoutTechnique.calcQualityFunction();
        if ((bestLayout == null) || (qualityFunction < minQualityFunction))
        {
            bestLayout = layoutTechnique.getLayout();
            minQualityFunction = qualityFunction;
        }
    }

    public void performPostProcessing()
    {
        bestLayout.standardizeCoordinates(true);
    }

    public Layout getLayout()
    {
        return bestLayout;
    }
}