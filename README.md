# MIMIC-III SQLite Database Creation

[MIMIC-III] is a corpus has 58,976 hospital admission and 2,083,180 had written
notes by medical professionals.  This repo contains an automated build process
that creates an SQLite database (file) populated with the [MIMIC-III] corpus
using scripts from the [MIMIC Code Repository].


## Installation

1. Download the source [MIMIC-III] data files as the file
   `mimic-iii-clinical-database-1.4.zip` to this directory.
1. Install [git], and [GNU make]/
1. Run the automation process: `make all`.  This does the following:
   1. Uncompress the `mimic-iii-clinical-database-1.4.zip` of the compressed
      CSV MIMIC-III data files.
   1. Clones the [MIMIC-III code repository], which has the SQLite DB load
      scripts.
   1. Loads the database using the [MIMIC-III code repository] scripts.
   1. Creates some indexes on some tables such as `NOTEEVENTS`, `ADMISSIONS`
      and `PATEINTS`.
1. Create additional indexes to suit your needs.  Use the [post configuration
   script](./src/bin/postconfig.sh) as an example.
1. Check for errors and the existence of the `mimic3.sqlite3` SQLite database
   file.
1. Optionally clear up disk usage: `make cleanall`.



<!-- links -->
[MIMIC-III]: https://mimic.mit.edu/docs/iii/
[SQLite]: https://www.sqlite.org/index.html
[git]: https://git-scm.com
[GNU make]: https://www.gnu.org/software/make/
[MIMIC-III code repository]: https://github.com/MIT-LCP/mimic-code.git
