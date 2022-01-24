cp -R /Users/admin20/Library/Developer/Xcode/DerivedData/NameAndPassword-edkqmlaoaehpvrewayxolrytytly/Build/Products/Debug/NameAndPassword.bundle /Library/Security/SecurityAgentPlugins/

sudo chown -R root:wheel /Library/Security/SecurityAgentPlugins/NameAndPassword.bundle
sudo chmod -R 755 /Library/Security/SecurityAgentPlugins/NameAndPassword.bundle

security authorizationdb write system.login.console < system.login.console.custom.txt
