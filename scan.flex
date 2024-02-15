import java.util.*;
import java.io.*;
%%
%class scanBasic
%standalone
%line
%column
%{
    private ArrayList<String> tokens = new ArrayList<String>();
    
    public String output = "";
    
    private void readTokens(String file){
        // Get tokens list from file
        try {
            Scanner s = new Scanner(new File(file));
            while (s.hasNext()){
                tokens.add(s.next());
            }
            s.close();
        } catch(IOException e) {
            System.out.println("IO ERR!");
            e.printStackTrace();
        }
    }

    {
        readTokens("tokenList.txt");
        System.out.println("\nTokens List: " + tokens + "\n\n");
    }
%}

%eof{
    System.out.println(output);
    System.out.println("\n\nTokens List: " + tokens + "\n");

    // initialize output file
    try {
        File outFile = new File("output.txt");
        if (outFile.createNewFile()){
            System.out.println("File created: " + outFile.getName());
        } else {
            System.out.println("File already exists... Overwriting.");
        }

        // write to file
        FileWriter writer = new FileWriter(outFile);
        writer.write(output);
        writer.write("\n\nTokens List: \n");
        for (String token : tokens)
            writer.write(token + "\n");
        writer.close();
    } catch (IOException e) {
            System.out.println("IO ERR!");
            e.printStackTrace();
    }
        
%eof}


LINETERMINATE   = \r|\n|\r\n
WHITESPACE      = {LINETERMINATE} | [\s\t\f]
NUMLIT          = [0-9]+ | 0[b[0|1]* | c[0-7]* | x([0-9]| [A-Fa-f])* ]/* integer only */
ID              = _(([a-zA-Z] | [0-9]) )* | [a-zA-Z](([a-zA-Z] | [0-9]) | _ )*
INVALID_ID      = {NUMLIT}{ID}
INVALID_NUM  = {NUMLIT}\.{NUMLIT}
ESCSEQ          = [\\][ n | t | r | b | \\ | \' | \" | f]
COMMENT         = \/\/(.)*\n | \/\*(.)*\*\/

%state FALLBACK

%%
<YYINITIAL> {
    /* KEYWORDS */
    "reactive"      { output += tokens.get(0); }
    "inert"         { output += tokens.get(1); }
    "mole32"        { output += tokens.get(2); }
    "mole64"        { output += tokens.get(3); }
    "umole32"       { output += tokens.get(4); }
    "umole64"       { output += tokens.get(5); }
    "compound"      { output += tokens.get(6); }
    "carbon"        { output += tokens.get(7); }
    "alkane"        { output += tokens.get(8); }
    "decompose"     { output += tokens.get(9); }
    "input"         { output += tokens.get(10); }
    "print"         { output += tokens.get(11); }
    "and"           { output += tokens.get(12); }
    "or"            { output += tokens.get(13); }
    "not"           { output += tokens.get(14); }
    "is"            { output += tokens.get(15); }
    "isnot"         { output += tokens.get(16); }
    "funnel"        { output += tokens.get(17); }
    "filter"        { output += tokens.get(18); }
    "catalyze"      { output += tokens.get(19); }
    "titrate"       { output += tokens.get(20); }
    "distill"       { output += tokens.get(21); }
    "ferment"       { output += tokens.get(22); }

    /* OPERATORS */
    "+"             { output += tokens.get(25); }
    "-"             { output += tokens.get(26); }
    "*"             { output += tokens.get(27); }
    "/"             { output += tokens.get(28); }
    "^"             { output += tokens.get(29); }
    "--"            { output += tokens.get(30); }
    "++"            { output += tokens.get(31); }

    /* ASSIGNMENT OPERATORS */
    "="             { output += tokens.get(32); }
    "+="            { output += tokens.get(33); }
    "-="            { output += tokens.get(34); }
    "*="            { output += tokens.get(35); }
    "/="            { output += tokens.get(36); }
    "^="            { output += tokens.get(37); }

    /* COMPARISON OPERATORS */
    "<"             { output += tokens.get(38); }
    ">"             { output += tokens.get(39); }
    "<="            { output += tokens.get(40); }
    ">="            { output += tokens.get(41); }

    /* SPECIAL SYMBOLS */
    ","             { output += tokens.get(42); }
    ";"             { output += tokens.get(43); }
    "("             { output += tokens.get(44); }
    ")"             { output += tokens.get(45); }
    "{"             { output += tokens.get(46); }
    "}"             { output += tokens.get(47); }
    {ESCSEQ}        { output += tokens.get(48); }
    {COMMENT}       { output += tokens.get(49); }
    {WHITESPACE}    { output += yytext(); }

    /* LITERALS */
    {INVALID_ID}    { output += "!!! Invalid ID \"" + yytext() + "\" at line " + yyline + " !!!"; }
    {INVALID_NUM}   { output += "!!! Invalid NUMLIT \"" + yytext() + "\" at line " + yyline + " !!!"; }
    {NUMLIT}        { tokens.add(yytext()); output += tokens.get(23) + "(" + tokens.get(tokens.size()-1) +")"; }
    {ID}            {
                        if (tokens.contains(yytext())){
                            output += tokens.get(24) + "(" + tokens.get(tokens.indexOf(yytext())) +")";
                        }else{
                            tokens.add(yytext());
                            output += tokens.get(24) + "(" + tokens.get(tokens.size()-1) +")";
                        }
                    }

    /* UNRECOGNIZED */
    [^]             { yybegin(FALLBACK); }
}

<FALLBACK> {
    [^] { output += "unrecognized: \"" + yytext() + "\" at line " + yyline + " "; }
}


// .+ {System.out.print("Error, pattern not matched <" + yytext() + "> at line " yyline);}

