#!/bin/bash

echo "Building the Ruby project..."
bundle lock --add-platform x86_64-linux
bundle install
rails db:create
rails db:migrate
rails s
# Add more build commands as needed
