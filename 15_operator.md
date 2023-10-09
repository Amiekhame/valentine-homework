1. Assignment Operator (=):
   - The assignment operator is used to assign a value to a variable. For example: `x=10` assigns the value 10 to the variable `x`.

2. Arithmetic Operators (+, -, *, /, %):
   - These operators perform arithmetic operations. For example: `x=$((5 + 3))` assigns the value 8 to the variable `x`.

3. Comparison Operators (==, !=, -eq, -ne, -lt, -gt, -le, -ge):
   - These operators compare values or conditions. For example: `[ "$x" -eq "$y" ]` checks if `x` is equal to `y`.

4. String Concatenation Operator (+):
   - The `+` operator concatenates strings. For example: `name="John"; greeting="Hello, "$name"!"` combines the variables to form the string "Hello, John!".

5. Logical Operators (&&, ||, !):
   - These operators are used to perform logical operations. `&&` represents logical AND, `||` represents logical OR, and `!` represents logical NOT.

6. Increment/Decrement Operators (++, --):
   - These operators increment or decrement the value of a variable. For example: `x=$((x + 1))` can be shortened to `((x++))`.

7. Conditional Operator (?):
   - The conditional operator is used for shorthand if-else statements. For example: `result=$(( x > y ? x : y ))` assigns the maximum of `x` and `y` to `result`.

8. Command Substitution Operators ($()):
   - The `$()` operator is used to substitute the output of a command. For example: `files=$(ls)` stores the output of the `ls` command to the variable `files`.

9. Arithmetic Expansion Operators (()):
   - The `(( ))` operator is used for arithmetic calculations. For example: `result=$((x + y * 2))` calculates the value of `x + y * 2` and assigns it to `result`.

10. Wildcard/Globbing Operators (*, ?):
    - Wildcards are used to represent patterns when working with files. `*` matches any number of characters, and `?` matches a single character. For example: `ls *.txt` lists all files ending with `.txt`.

11. Redirect Operator (>):
    - The `>` operator redirects the output of a command to a file. For example: `echo "Hello" > file.txt` writes the string "Hello" to the file `file.txt`, overwriting any existing content.

12. Append Operator (>>):
    - The `>>` operator appends the output of a command to an existing file. For example: `echo "World" >> file.txt` appends the string "World" to `file.txt`.

13. Pipe Operator (|):
    - The `|` operator passes the output of one command as input to another. For example: `ls | grep "file"` lists files and then searches for files containing "file".

14. Command Substitution Operator (` `):
    - The `` ` `` operator (backticks) is used to substitute the output of a command. For example: `date=`date +%Y-%m-%d``` stores the current date in the variable `date`.

15. String Comparison Operators (=, !=):
    - These operators compare strings. For example: `[ "$name" = "John" ]` checks if the variable `name` is equal to "John".
