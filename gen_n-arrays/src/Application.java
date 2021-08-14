import java.util.HashSet;
import java.util.concurrent.ThreadLocalRandom;

public class Application {
    int sizeArray;
    int[][] array;
    int[] sizeLineInArray;

    Application(int n) {
        setSizeArray(n);
        setArrayFirst(new int[sizeArray][]);
        setSizeLine(new int[sizeArray]);

        HashSet<Integer> sizeLineInArray = new HashSet<>();
        int minSizeLine = 1, maxSizeLine = 2 * sizeArray;
        while (sizeLineInArray.size() != sizeArray) {
            sizeLineInArray.add(ThreadLocalRandom.current().nextInt(minSizeLine, maxSizeLine));
        }
        setArraySecond(sizeLineInArray);
    }

    public void setArrayFirst(int[][] array) {
        this.array = array;
    }

    public void setArraySecond(HashSet<Integer> sizeLineInArray) {
        int numLineInArray = 0;
        for (int curSizeLine : sizeLineInArray) {
            this.array[numLineInArray] = new int[curSizeLine];
            this.sizeLineInArray[numLineInArray] = curSizeLine;
            for (int j = 0; j < curSizeLine; j++) {
                int minValue = Integer.MIN_VALUE, maxValue = Integer.MAX_VALUE;
                this.array[numLineInArray][j] = ThreadLocalRandom.current().nextInt(minValue, maxValue);
            }
            numLineInArray++;
        }
    }

    public int getSizeArray() {
        return sizeArray;
    }

    public void setSizeArray(int sizeArray) {
        this.sizeArray = sizeArray;
    }

    public int[][] getArray() {
        return array;
    }

    public int[] getSizeLine() {
        return sizeLineInArray;
    }

    public void setSizeLine(int[] sizeLineInArray) {
        this.sizeLineInArray = sizeLineInArray;
    }

    public void sortArray(int sizeArray, int[] sizeLineInArray, int[][] array) {
        for (int i = 0; i < sizeArray; i++) {
            quickSort(0, sizeLineInArray[i] - 1, array[i]);
            if (i % 2 == 1) {
                for (int j = 0; j < sizeLineInArray[i] / 2; j++) {
                    int tmp = array[i][j];
                    array[i][j] = array[i][sizeLineInArray[i] - 1 - j];
                    array[i][sizeLineInArray[i] - 1 - j] = tmp;
                }
            }
        }
    }

    public void quickSort(int left, int right, int[] a) {
        int first = left;
        int last = right;
        int center = a[(left + right) / 2];
        do {
            while (a[first] < center) {
                first++;
            }
            while (a[last] > center) {
                last--;
            }
            if (first <= last) {
                if (first < last) {
                    int temp = a[first];
                    a[first] = a[last];
                    a[last] = temp;
                }
                first++;
                last--;
            }
        } while (first <= last);

        if (left < last) {
            quickSort(left, last, a);
        }
        if (right > first) {
            quickSort(first, right, a);
        }
    }
}
