## ANTLR 4 CSV Demo

A small demo project that demonstrates how to use ANTLR 4 to parse a CSV 
file and return the contents as a 2 dimension list of strings (in Java)
as demonstrated in the [ANTLR 3 tutorial posted here](http://bkiers.blogspot.nl/2011/03/2-introduction-to-antlr.html).

To run the Main class:

```java  
public class Main { 
 
  public static void main(String[] args) throws Exception {
    // the input source
    String source =
        "aaa,bbb,ccc" + "\n" +   
        "\"d,\"\"d\",eee,fff";  
      
    // create an instance of the lexer
    CSVLexer lexer = new CSVLexer(new ANTLRInputStream(source));
         
    // wrap a token-stream around the lexer
    CommonTokenStream tokens = new CommonTokenStream(lexer);
          
    // create the parser
    CSVParser parser = new CSVParser(tokens);
    
    // invoke the entry point of our grammar
    List<List<String>> data = parser.file().data;

    // display the contents of the CSV source
    for(int r = 0; r < data.size(); r++) {
      List<String> row = data.get(r);
      for(int c = 0; c < row.size(); c++) {
        System.out.println("(row=" + (r+1) + ",col=" + (c+1) + ") = " + row.get(c));  
      }
    }
  }
} 
```

do the following:

```bash
git clone https://github.com/bkiers/antlr4-csv-demo.git
cd antlr4-csv-demo
ant run
```

which would produce the following output:

<pre>
Buildfile: .../csv/build.xml

init:

generate:
     [echo] generating parser source files...
     [move] Moving 4 files to .../csv/src/gen/csv

compile:
    [javac] Compiling 4 source files to .../csv/build/main

run:
     [java] (row=1,col=1) = aaa
     [java] (row=1,col=2) = bbb
     [java] (row=1,col=3) = ccc
     [java] (row=2,col=1) = d,"d
     [java] (row=2,col=2) = eee
     [java] (row=2,col=3) = fff

BUILD SUCCESSFUL
Total time: 1 second
</pre>
