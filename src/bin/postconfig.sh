#!/bin/sh

# this script adds indexes to the mimic3 SQLite DB

BIN=sqlite3
DB_FILE=$1

function add_indexes() {
    echo "adding indexes"
    $BIN ${DB_FILE} <<EOF
create index noteevents_text_id on noteevents(text);
create index noteevents_category_id on noteevents(category);
create index noteevents_description_id on noteevents(description);
create index admissions_hadm_id on admissions(hadm_id);
create index admissions_subject_id on admissions(subject_id);
create index admissions_diagnosis on admissions(diagnosis);
create index patients_subject_id on patients(subject_id);
EOF
}


function main() {
    echo "post processing steps on : ${DB_FILE}"
    add_indexes
}

main
