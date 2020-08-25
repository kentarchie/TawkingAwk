# TawkingAwk
Introduction to AWK
Tawking AWK

AWK is a lesser known language that is in all Linux distributions.
It is designed for processing and filtering text data using patterns.
It's especially suited to managing logfiles but can be used for most anything.
I think of it as a C interpretor in the command line.
Add in the associative arrays (maps in C# or Java, dicts in Python) and you have a pretty powerful tool.

But why use awk when I have Perl, Python and bash?
If you already know one or more of these, they will
let you do everything awk does.
But I think the syntax of awk is simpler than Perl and bash and more expressive than bash alone.
I think Perl and Python are overkill for many applications.

Here I will go over the basic syntax of the language and how associative arrays work.
Then we'll go over examples and combine AWK with some other tools to manipulate and interpret data.
A quick example. A friend sends you a file of x,y values but made a mistake
and reversed the columns.
This fixes that.
gawk -F "," '{print $2 "," $1 }' < plotdata.txt
