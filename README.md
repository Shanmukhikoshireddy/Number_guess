# Number_guess
This project is a part of the Relational Database Certification offered by [freeCodeCamp.org](https://www.freecodecamp.org/). It demonstrates how to build a simple number guessing game using Bash scripting and PostgreSQL to persist user data.
# 🎯 Number Guessing Game (Bash + PostgreSQL)


---

## 📌 Project Overview

The number guessing game:
- Generates a **random secret number between 1 and 1000**
- Asks the user to guess the number
- Provides feedback after each guess: whether it's too high or too low
- Tracks the number of guesses it takes
- Stores player history in a **PostgreSQL database**

---

## 📁 Files Included

| File               | Description |
|--------------------|-------------|
| `number_guess.sh`  | Bash script for the game logic and PostgreSQL integration |
| `number_guess.sql` | SQL dump of the `number_guess` database (used for backup or restoration) |

---

## 🛠️ Technologies Used

- **Bash**
- **PostgreSQL**
- `psql` terminal for database interaction
- Git for version control

---

## 🗃️ Database Design

The `number_guess` database contains two tables:

### 1. `users` Table

| Column     | Type         | Description                     |
|------------|--------------|---------------------------------|
| user_id    | SERIAL (PK)  | Unique ID for each user         |
| username   | VARCHAR(22)  | Unique username (max 22 chars)  |

### 2. `games` Table

| Column     | Type         | Description                             |
|------------|--------------|-----------------------------------------|
| game_id    | SERIAL (PK)  | Unique ID for each game                 |
| user_id    | INT (FK)     | Links to `users.user_id`                |
| guesses    | INT          | Number of guesses taken in the game     |
| played_at  | TIMESTAMP    | Date and time when the game was played  |

---

## 🧪 Game Features

- Greets new users with:  
  `Welcome, <username>! It looks like this is your first time here.`

- Greets returning users with their game stats:  
  `Welcome back, <username>! You have played <games_played> games, and your best game took <best_game> guesses.`

- Validates integer input only  
- Tells players if the guess is too high or too low  
- On success, prints:  
  `You guessed it in <number_of_guesses> tries. The secret number was <secret_number>. Nice job!`

---

## 📦 How to Run

1. Make sure PostgreSQL is installed and a user named `freecodecamp` exists.
2. Restore the database (if needed):

   ```bash
   psql -U postgres < number_guess.sql
