# Pin npm packages by running ./bin/importmap

pin "application"  # Pins the main application JavaScript file.
pin "@hotwired/turbo-rails", to: "turbo.min.js"  # Pins Turbo library.
pin "@rails/ujs", to: "rails-ujs.js"  # Pin Rails UJS.
pin "@hotwired/stimulus", to: "stimulus.min.js"  # Pins Stimulus framework.
pin "@hotwired/stimulus-loading", to: "stimulus-loading.js"  # Pins Stimulus Loading module.
pin_all_from "app/javascript/controllers", under: "controllers"  # Pins all controllers.
