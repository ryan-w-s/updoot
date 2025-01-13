# Updoot

Link sharing social media app using Ruby on Rails

## Running

This project uses docker compose, so in the root folder, just run `docker-compose up -d` which sets up the web and postgres containers.

You will also need to run database migrations, with `bin/rails db:migrate`.

These commands are held in the `help.ps1` script for easy restarting.

## Features

* Users and logins
* Collections
* Posts (text only, no embedding)
* Voting (updoot) system
* Home feed of watched collections with popularity ranking
