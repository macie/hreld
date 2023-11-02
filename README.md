# hreld - Human-readable relational database

[![CircleCI](https://dl.circleci.com/status-badge/img/gh/macie/hreld/tree/dev.svg?style=shield)](https://dl.circleci.com/status-badge/redirect/gh/macie/hreld/tree/dev)

**WORK IN PROGRESS**

**hreld** implements an operator-stream database based on [The Third Manifesto](https://database.guide/what-is-the-third-manifesto/) (relational algebra).

## Tables

Tables are text files with simple structure, so they can be managed (created/updated) by ordinary text tools (I am using `.tbl` extension to easily recognize them).

Columns are separated by a tab character, and rows - by a newline character. The first line in each table should be the header line with column names starting with `#` character (simplify projection).

> During table creation/edition you need to take care of data consistency and duplicated rows removal (we are in the realm of relational algebra).

Examples:

```sh
$ cat employees.tbl
#EmpId	#EmpName	#DeptId
1	John Doe	3
2	Jane Roe	1

$ cat former_employees.tbl
#EmpId	#EmpName	#DeptId

```

## Alternatives

- text files inside directories
- `/rdb` family:
    - [NoSQL](http://www.strozzi.it/cgi-bin/CSA/tw7/I/en_US/NoSQL/Documentation%20Index) - with indexes; without row locking. Implemented in AWK.
    - [Fsdb](https://www.isi.edu/~johnh/SOFTWARE/FSDB/index.html) - with a rich collection of statistic functions; without indexes and locking. Implemented in Perl.

As any data can be presented in a structured (key-value/tabular) form, you can process any kind of file with simple filters and transformations. The most advanced active projects, that I am aware of are:
- [Nushell](https://www.nushell.sh/) (CLI) - gets tabular representation of a file (content or metadata) and passes them through UNIX-like pipelined filters;
- [Glamorous Toolkit](https://gtoolkit.com/) (GUI) - targeting data exploration. You can bind actions to elements of graphic representation. Data processing is easy thanks to well-thought-out methods from [Pharo collections](https://books.pharo.org/pharo-by-example9/pdf/2022-03-26-index.pdf#chapter.14).

