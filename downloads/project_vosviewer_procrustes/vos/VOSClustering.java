package com.vosviewer.vos;

/**
 * VOSClustering
 *
 * @author Nees Jan van Eck
 * @author Ludo Waltman
 * @version 1.0.0, 01/11/15
 */

import java.util.Random;
import com.vosviewer.network.Clustering;
import com.vosviewer.network.Network;
import com.vosviewer.network.VOSClusteringTechnique;

public class VOSClustering
{
    private Network network;
    private VOSClusteringParameters parameters;
    private boolean useLinLogModularityNormalization;
    private Random random;
    private double maxQualityFunction;
    private Clustering bestClustering;

    public VOSClustering(Network network, VOSClusteringParameters parameters, boolean useLinLogModularityNormalization)
    {
        this.network = network;
        this.parameters = parameters;
        this.useLinLogModularityNormalization = useLinLogModularityNormalization;
        random = (parameters.getUseRandomSeed()) ? new Random() : new Random(parameters.getFixedSeed());

        bestClustering = null;
        maxQualityFunction = Double.NEGATIVE_INFINITY;
    }

    public void performRandomStart()
    {
        double resolution = parameters.getResolution();
        if (useLinLogModularityNormalization)
            resolution /= 2 * network.getTotalEdgeWeight();
        VOSClusteringTechnique clusteringTechnique = new VOSClusteringTechnique(network, resolution);
        clusteringTechnique.runIteratedSmartLocalMovingAlgorithm(parameters.getNIterations(), random);
        double qualityFunction = clusteringTechnique.calcQualityFunction();
        if ((bestClustering == null) || (qualityFunction > maxQualityFunction))
        {
            bestClustering = clusteringTechnique.getClustering();
            maxQualityFunction = qualityFunction;
        }
    }

    public void performPostProcessing()
    {
        VOSClusteringTechnique clusteringTechnique = new VOSClusteringTechnique(network, bestClustering, parameters.getResolution());
        clusteringTechnique.removeSmallClusters(parameters.getMinClusterSize());
        bestClustering = clusteringTechnique.getClustering();
        bestClustering.orderClustersByNNodes();
    }

    public Clustering getClustering()
    {
        return bestClustering;
    }
}