#!/bin/bash

# Save the current working directory in an environment variable.
INITIAL_WORKING_DIRECTORY=$(pwd)
DBT_DIR="dbt_project/dbtlearn"

echo $PROFILES_DIR

# This line changes to current working directory to where
# the analysis.sh file is.
# cd "$(dirname "$0")0"
cd $DBT_DIR
echo "moved to: \"$(pwd)\""
# echo "dbt project folder set as: \"${INITIAL_WORKING_DIRECTORY}\""
# Create an environment variable with the relative path to the
# derived data directory.
# DERIVED_DATA_DIRECTORY=../dbt_project2

# Create the derived data  directory if it does not already exist.
# mkdir -p $DERIVED_DATA_DIRECTORY

# This code streams the content of the raw data file into the sed
# stream editor. The sed stream editor is used to edit the content
# of the stream. Finally, the output of sed is redirected to a
# derived_data.txt file in the derived data directory.
cp ${PROFILES_DIR}/profiles.yml .
sed -e "s/_user_/Fudged/g"  ./profiles.yml
sed -e "s/_password_/PassFudged/g"  ./profiles.yml

# Go back to where we were before changing into the
# scripts directory.
# cd $INITIAL_WORKING_DIRECTORY