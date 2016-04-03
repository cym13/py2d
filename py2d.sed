
# Shebang
1s/^#!.*$/#!\/usr\/bin\/env rdmd/

# Imports
2s/^/import std.stdio, std.range, std.algorithm, std.conv, std.array;\n\n/
s/import re$/import std.regex;/g

# Strings
s/"""$/ *\//
s/"""/\/* /
s/'/"/g

# Functions
s/def /auto /g
s/:$/ {/g

# Globals
s/^\(\w\+\) = /auto \1 = /g


# Logic
s/ or / || /g
s/ and / \&\& /g
s/ not / !/g

# Objects
s/(self,\? \?/(/g
s/self\./this./g
s/(object,\? \?/(/g

# Properties
/@property$/d

# Comments
1s/#\([^!]\)/\/\//g
2,$s/#/\/\//g

# Excptions
s/except/catch/g
s/raise/throw new/g

# Loops and 'in' operator
/^\s*\(if\|while\)\s\?/s/\s*\(\S\+\|([^)]\+)\)\s*in\s*\(.\+\)\s*{\s*$/ (\2.canFind(\1)) /g
/^\s*\(if\|while\)\s\?/s/\s*\(\S\+\|([^)]\+)\)\s*!in\s*\(.\+\)\s*{\s*$/ (!\2.canFind(\1)) /g
/^\s*for\s\?/s/for\s*\(\S\+\|([^)]\+)\)\s\+in\s\+\(.\+\)\s*{\s*$/foreach (\1 ; \2) {/g

# Conditions
/^\s*if /s/if /if (/g
s/if (\([^)]\+\) {/if (\1) {/g
s/else /} else /g
s/elif /} else if /g

# Ranges
s/\[:\]/[0..$]/
s/\[\([^:]\+\):\]/[\1..$]/
s/\[:\([^]]\+\)\]/[0..\1]/
s/\[:\([^:]\]\+\):\([^]]\+\)\]/[\1..\2]/

# End of statement
/[^\/*-+\\:,{}]$/s/$/;/

# Common equivalences
s/\(\S\+\)\.join(\([^)]\+\))/\2.join(\1)/g
s/\(\S\+\)\.find(\([^)]\+\))/\1.countUntil(\2)/g
s/\(\W\)print(\([^)]\+\))/\1writeln(\2)/g
s/\(\W\)range(\([^)]\+\))/\1iota(\2)/g
s/\(\W\)len(\([^)]\+\))/\1\2.length/g
s/.append(\([^)]\+\))/~= \1/g

# None
s/None/null/g
