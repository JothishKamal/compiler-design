
import java.io.*;
import java.util.*;

public class _12LexicalAnalyzer {

    private static final Set<String> keywords = new HashSet<>(Arrays.asList(
            "auto", "break", "case", "char", "const", "continue", "default", "do", "double", "else", "enum", "extern",
            "float", "for", "goto", "if", "int", "long", "register", "return", "short", "signed", "sizeof", "static",
            "struct", "switch", "typedef", "union", "unsigned", "void", "volatile", "while"));

    public static void main(String[] args) throws IOException {
        if (args.length != 1) {
            System.out.println("Usage: java LexicalAnalyzer <file>");
            return;
        }

        try (BufferedReader br = new BufferedReader(new FileReader(args[0]))) {
            StringBuilder sb = new StringBuilder();
            String line;
            while ((line = br.readLine()) != null) {
                sb.append(line).append("\n");
            }
            analyze(sb.toString());
        }
    }

    private static void analyze(String code) {
        StringTokenizer st = new StringTokenizer(code, " \t\n+-*/%=&|!<>;:,.(){}[]", true);

        while (st.hasMoreTokens()) {
            String token = st.nextToken().trim();
            if (token.isEmpty()) {
                continue;
            }

            if (keywords.contains(token)) {
                System.out.println("<KEYWORD, " + token + ">");
            } else if (token.matches("[_a-zA-Z][_a-zA-Z0-9]*")) {
                System.out.println("<IDENTIFIER, " + token + ">");
            } else if (token.matches("[0-9]+")) {
                System.out.println("<NUMBER, " + token + ">");
            } else if (token.matches("[+\\-*/%=&|!<>^~]+")) {
                System.out.println("<OPERATOR, " + token + ">");
            } else {
                System.out.println("<SPECIAL, " + token + ">");
            }
        }
    }
}
