# Always open everything in Finder's list view.
defaults write com.apple.Finder FXPreferredViewStyle Nlsv

# Set the Finder prefs for showing a few different volumes on the Desktop.
defaults write com.apple.finder ShowExternalHardDrivesOnDesktop -bool true
defaults write com.apple.finder ShowRemovableMediaOnDesktop -bool true

# Disable Credential Security Support Provider (CredSSP) authentication for Microsoft Remote Desktop.
defaults write com.microsoft.rdc.macos ClientSettings.EnforceCredSSPSupport 0
