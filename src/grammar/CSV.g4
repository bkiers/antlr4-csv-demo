grammar CSV;

@header {
  package csv;
}

file returns [List<List<String>> data]  
@init {$data = new ArrayList<List<String>>();}  
 : (row {$data.add($row.list);})+ EOF  
 ; 
  
row returns [List<String> list]  
@init {$list = new ArrayList<String>();}  
 : a=value {$list.add($a.val);} (Comma b=value {$list.add($b.val);})* (LineBreak | EOF)  
 ;

value returns [String val]  
 : SimpleValue {$val = $SimpleValue.text;}  
 | QuotedValue   
   { 
     $val = $QuotedValue.text; 
     $val = $val.substring(1, $val.length()-1); // remove leading- and trailing quotes 
     $val = $val.replace("\"\"", "\""); // replace all `""` with `"` 
   }  
 ;  

Comma  
 : ','  
 ;  
  
LineBreak  
 : '\r'? '\n'  
 | '\r'  
 ;  
  
SimpleValue  
 : ~[,\r\n"]+  
 ;  
  
QuotedValue  
 : '"' ('""' | ~'"')* '"'  
 ;  
