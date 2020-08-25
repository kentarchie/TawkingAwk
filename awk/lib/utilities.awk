#!/usr/bin/awk -f

function push(A,B) { A[length(A)+1] = B }

# from https://www.gnu.org/software/gawk/manual/html_node/Walking-Arrays.html
#arr is the initial array to process, name is a string with the name of the array
# i is a helper variable used in the recursion
#example walk_array(Data, "Data",      i)

function walk_array(arr, name,      i)
{
    for (i in arr) {
        if (isarray(arr[i]))
            walk_array(arr[i], (name "[" i "]"))
        else
            printf("%s[%s] = %s\n", name, i, arr[i])
    }
} # walk_array
