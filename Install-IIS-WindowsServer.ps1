# Install Microsoft IIS Server
import-module servermanager
add-windowsfeature web-server -includeallsubfeature
