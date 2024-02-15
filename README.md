# Argon-Flexer
 A barebones token scanner for the Argon ProgLang made using Jflex

## Compiling and Running
1. Make sure to have [jflex](https://www.jflex.de/download.html) installed 
2. Generate: In cmd `jflex scan.flex`
3. Compile: In cmd `javac scanBasic.java`
4. Run: In cmd `java scanBasic input.txt`

## Input
- Add as any input files, just replace "input.txt" when running

## Output
- The tokenlist and the output will be printed to terminal
- Additionally, a txt [output file](output.txt) will be made/overwritten
	- Has the input translated into tokens
	- Has the tokens list after runtime (includes IDs and Numerical Literals)

## Tokens List
- The [Tokens List File](tokenList.txt) has all the possible tokens for the scanner (excluding IDs and Numerical Literals which will be added during runtime)
