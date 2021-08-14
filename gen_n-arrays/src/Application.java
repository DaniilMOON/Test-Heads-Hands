import java.util.Arrays;
import java.util.concurrent.ThreadLocalRandom;

public class Application {

    Application(int n) {
        int[][] array = new int[n][];
        boolean[] usedSizeLine = new boolean[n];
        Arrays.fill(usedSizeLine, false);
        int minSize = 0, maxSize = n;

        for (int i = 0; i < n; i++) {
            int sizeLineArray;
            do {
                sizeLineArray= ThreadLocalRandom.current().nextInt(minSize, maxSize);
            } while (usedSizeLine[sizeLineArray]);
            usedSizeLine[sizeLineArray] = true;

            array[i] = new int[sizeLineArray + 1];
            for (int j = 0; j < sizeLineArray; j++) {
                int minValue = Integer.MIN_VALUE, maxValue = Integer.MAX_VALUE;
                array[i][j] = ThreadLocalRandom.current().nextInt(minValue, maxValue) + 1;
            }
        }
        System.out.println("successfully");
    }
}
