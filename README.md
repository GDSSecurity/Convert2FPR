# Convert2FPR

The application is packaged in a single jar and can be used as follows:
 
$ java ‐jar convert2FPR.jar findbugs report.xml
 
To supply a custom messages.xml file, use as follows:
 
$ java ‐jar convert2FPR.jar findbugs messages.xml report.xml
 
The output file, in both cases is ./report.fpr .
 
The first parameter (findbugs) represents the input format and maps the correspondent XSL.

Available formats:
- findbugs
- findbug-fast (converts security issues only)
- eslint 
- pmd
