import java.util.Scanner;

public class Main {
    public static void printArray(int sizeArray, int[] sizeLineInArray, int[][] array) {
        for (int i = 0; i < sizeArray; i++) {
            for (int j = 0; j < sizeLineInArray[i]; j++) {
                System.out.print(array[i][j] + " ");
            }
            System.out.println();
        }
    }

    public static void main(String[] args) {
        Scanner in = new Scanner(System.in);
        System.out.print("Input n: ");
        int n = in.nextInt();

        Application program = new Application(n);

        printArray(program.getSizeArray(), program.getSizeLine(), program.getArray());

        program.sortArray(program.getSizeArray(), program.getSizeLine(), program.getArray());

        System.out.println();
        printArray(program.getSizeArray(), program.getSizeLine(), program.getArray());
    }
}
