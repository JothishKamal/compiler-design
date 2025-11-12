
import java.io.*;

public class _11FileHandling {

    public static void main(String[] args) {
        if (args.length != 1) {
            System.out.println("Usage: java FileHandling <filename>");
            return;
        }

        try (BufferedReader br = new BufferedReader(new FileReader(args[0]))) {
            String line;
            while ((line = br.readLine()) != null) {
                System.out.println(line);
            }
        } catch (IOException e) {
            System.out.println("Error: " + e.getMessage());
        }
    }
}
