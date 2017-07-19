# DualServer
Scripts and blacklists for DualServer.

The blacklists are reformatted versions of the unified hosts files maintained by Steven Black:

https://github.com/StevenBlack/hosts

The blacklist file letter codes are as follows:

F: Fake News

G: Gambling

P: Porn

S: Social

The blacklist.txt is only the unified hosts, blackist-f.txt is the unified hosts and fake news, blacklist-fg.txt is the unified hosts and fake news and gambling, etc.

To use these blacklists with DualServer you can either copy and paste their contents under the [DNS_HOSTS] section of the DualServer.ini or simply direct DualServer to the downloaded blacklist file using @blacklist.txt (or whatever the blacklist file name is) under the [DNS_HOSTS] section of the DualServer.ini. Please note, however, if you decide to direct DualServer to a file, the "@" line should be the first and only uncommented line in the [DNS_HOSTS] section of the DualServer.ini.
