#!/bin/bash

echo "Building the Ruby project..."
bundle install
rails db:create
rails db:migrate
rails s
# Add more build commands as needed
