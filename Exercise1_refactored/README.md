---
title: "Exercise #1 - Downloading Files with R (Refactored)"
output: 
  html_document:
    keep_md: true
---

Primary code is available in `main.R`

## Problem Statement

Problem Statement is available here at  [Daniel Beach's Github repo](https://github.com/danielbeach/data-engineering-practice/tree/main/Exercises/Exercise-1)

## Key Tasks 

1. create a `downloads` folder if it doesn't exist.
2. download the `zip` files `asynchronously`.
3. extract file names from URL to keep original filename.
4. extract csv from `zip` file and delete `zip` file.

All tasks were accomplished with `error handling` and `logging` feature added as extra!

This is my first attempt at async programming so I'd appreciate comments on how to better implement it if I did wrongly.

Thanks and enjoy!

## Update

Code has been refactored to be way more organised and readable.

Run code by running `main.R` script.

Helper functions available in `utilities` folder.

Testing and Containerization coming up!
