# Regular Expression Checker - Build Task

This is an Azure DevOps task that will check files against a regular expression and count the number of matches it finds. The result will then fail the build if the total count does not match that set in the task (default of 0).

## Common Uses

* Set the expected count to 0 and use a wide search area to ensure committed files do not contain the set pattern. E.g. fail builds if source files contain profanity or references to compromised libraries.
* Set the expected count to a known number and check a specific file to ensure certain lines are not modified.

## Available Settings
### Regular Expression
A regular expression to check files against.
### Root Directory
The directory the check will search in, this is recursive.
### File Path RegEx
A regular expression to filter files on their full path, only matching items will be searched. If left blank all files in the search directory are included.
### Number of expected matches
If the number of matches does not equal this value the task will fail.

Find the project source on GitHub <https://github.com/jynxeh/AzureDevOpsRegExChecker>.