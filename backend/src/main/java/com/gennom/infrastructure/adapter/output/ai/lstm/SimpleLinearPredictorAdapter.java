package com.gennom.infrastructure.adapter.output.ai.lstm;

import com.gennom.application.ports.output.PredictionModelPort;
import org.springframework.stereotype.Component;
import java.util.List;

@Component
public class SimpleLinearPredictorAdapter implements PredictionModelPort {

    // SimulaciÃ³n: modelo lineal simple (para pruebas)
    @Override
    public double predict(double[] features) {
        // features: [lastConsumption, dayOfWeek, month, hour, temperature]
        double last = features[0];
        double hourFactor = features[3] / 24.0;  // 0..1
        double tempFactor = (features[4] - 15) / 20.0; // normalizaciÃ³n burda
        return last * (0.8 + 0.2 * hourFactor + 0.1 * tempFactor);
    }

    @Override
    public void train(List<double[]> features, List<Double> targets) {
        // En una versiÃ³n real aquÃ­ se entrenarÃ­a la LSTM con DeepLearning4j
        System.out.println("Entrenamiento simulado completado.");
    }
}