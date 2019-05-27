#note you would continue to have the cached credentials available for other repositories (if any)

#disable use of the Git credential cache
git config --global --unset credential.helper

#if this has been set in the system configuration file
git config --system --unset credential.helper

#Or use manager helper on windows
git config --global credential.helper manager