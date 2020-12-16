# CLEAN UP #################################################

# Clear packages
pacman::p_unload(all)  # Remove all add-ons
# detach("package:datasets", unload = TRUE)  # For base


# Clear environment
rm(list = ls()) 

# Clear console
cat("\014")  # ctrl+L

# Clear mind :)
