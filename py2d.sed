
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
s/def\s\+/auto /g
s/:$/ {/g

# Globals
s/^\(\w\+\)\s\+=\s\+/auto \1 = /g


# Logic
s/\s\+or\s\+/ || /g
s/\s\+and\s\+/ \&\& /g
s/\s\+not\s\+/ !/g

# Objects
s/(self,\?\s\*/(/g
s/self\./this./g
s/(object,\?\s\*/(/g
s/class\s\+\(\w\+\)\s\+\(([^)]\+)\)\? {/class \1 : \2 {/

# Properties
/@property$/d

# Comments
1s/#\([^!]\)/\/\//g
2,$s/#/\/\//g

# Exceptions
s/except\s\*\(.*\)\s\*{/} catch (\1) {/g
s/raise/throw new/g

# Loops and 'in' operator
/^\s*\(if\|while\)\s\?/s/\s*\(\S\+\|([^)]\+)\)\s\+in\s*\(.\+\)\s*{\s*$/ (\2.canFind(\1)) /g
/^\s*\(if\|while\)\s\?/s/\s*\(\S\+\|([^)]\+)\)\s\+!in\s*\(.\+\)\s*{\s*$/ (!\2.canFind(\1)) /g
/^\s*for\s\?/s/for\s*\(\S\+\|([^)]\+)\)\s\+in\s\+\(.\+\)\s*{\s*$/foreach (\1 ; \2) {/g

# Conditions
/^\s*if\s\?/s/if\s\+/if (/g
s/if\s\+(\([^)]\+\)\s\+{/if (\1) {/g
s/else\s\+/} else /g
s/elif\s\+/} else if /g

# Ranges
s/\[:\]/[0..$]/
s/\[\([^:]\+\):\]/[\1..$]/
s/\[:\([^]]\+\)\]/[0..\1]/
s/\[:\([^:]\]\+\):\([^]]\+\)\]/[\1..\2]/

# End of statement
/[^\/*-+\\:,{}\n;]$/s/$/;/

# Common equivalences
s/\(\S\+\)\.join(\([^)]\+\))/\2.join(\1)/g
s/\(\S\+\)\.find(\([^)]\+\))/\1.countUntil(\2)/g
s/\(\W\)print(\([^)]\+\))/\1writeln(\2)/g
s/\(\W\)range(\([^)]\+\))/\1iota(\2)/g
s/\(\W\)len(\([^)]\+\))/\1\2.length/g
s/.append(\([^)]\+\))/~= \1/g

# None
s/None/null/g
