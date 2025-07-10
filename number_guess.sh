#!/bin/bash

PSQL="psql --username=freecodecamp --dbname=number_guess -t --no-align -c"

# Generate secret number
SECRET=$(( RANDOM % 1000 + 1 ))
TRIES=0

# Prompt for username
echo "Enter your username:"
read USERNAME

# Check if user exists
USER_ID=$($PSQL "SELECT user_id FROM users WHERE username = '$USERNAME'")
if [[ -z $USER_ID ]]; then
  # New user
  INSERT_RESULT=$($PSQL "INSERT INTO users(username) VALUES('$USERNAME')")
  echo "Welcome, $USERNAME! It looks like this is your first time here."
else
  # Returning user
  GAMES_PLAYED=$($PSQL "SELECT COUNT(*) FROM games WHERE user_id = $USER_ID")
  BEST_GAME=$($PSQL "SELECT MIN(guesses) FROM games WHERE user_id = $USER_ID")
  echo "Welcome back, $USERNAME! You have played $GAMES_PLAYED games, and your best game took $BEST_GAME guesses."
fi

# Game starts
echo "Guess the secret number between 1 and 1000:"

while true; do
  read GUESS
  ((TRIES++))

  # Input validation
  if [[ ! $GUESS =~ ^[0-9]+$ ]]; then
    echo "That is not an integer, guess again:"
    continue
  fi

  if (( GUESS < SECRET )); then
    echo "It's higher than that, guess again:"
  elif (( GUESS > SECRET )); then
    echo "It's lower than that, guess again:"
  else
    break
  fi
done


echo "You guessed it in $TRIES tries. The secret number was $SECRET. Nice job!"

# Get user_id if not yet
if [[ -z $USER_ID ]]; then
  USER_ID=$($PSQL "SELECT user_id FROM users WHERE username = '$USERNAME'")
fi

# Record game
INSERT_GAME=$($PSQL "INSERT INTO games(user_id, guesses) VALUES($USER_ID, $TRIES)")
