package com.gennom.application.ports.output;

import java.util.List;

public interface PredictionModelPort {
    double predict(double[] features);
    void train(List<double[]> features, List<Double> targets);
}