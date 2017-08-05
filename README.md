# DualServer
Scripts and blacklists for DualServer.

DualServer, the highly configurable and scalable Windows/Linux DNS/DHCP server, can be found here:

https://sourceforge.net/projects/dhcp-dns-server/

The blacklists are reformatted versions of the Unified Hosts files maintained by Steven Black:

https://github.com/StevenBlack/hosts

Synced regularly to Steven Black's Unified Hosts.

The blacklist file letter codes are as follows:

F: Fake News

G: Gambling

P: Porn

S: Social

The blacklist.txt is only the reformatted unified hosts, blackist-f.txt is the unified hosts and fake news, blacklist-fg.txt is the unified hosts and fake news and gambling, etc.

While the blacklists will work for anyone running DualServer, the AutoUpdate portion of this repo is only for Windows users. If you download the AutoUpdate.zip and extract the contents to your DualServer root, the same directory as your DualServer.ini, it can update your DualServer automatically depending on your preferences without requiring you to have a local git repo of this project. If you plan to always use the same blacklist, you can edit the "URL" variable at the top of the script with the direct URL of the blacklist you prefer and this will bypass having to be prompted for you preferences later.

The unified hosts by itself can block everything from sidebar ads, annoying YouTube video ads, banner ads, and even some invisible embedded analytics trying to gather more information about you. The other files add onto the core unified hosts additional blocks. Once these are configured with your DualServer, these blocks will affect all connected devices using your DualServer DNS service, including laptops, mobile phones, PCs, Macs, Linux, whatever.

Note: A blacklist should be used together with other security measures to be more effective. For instance, a network user could simply change their device's currently configured DNS to get around blacklisting. It's also common for Android devices to automatically use Google DNS as a fallback if they cannot resovle quieries from the DNS servers currently configured on the device either manually or via DHCP. One simple way to make your network slightly more secure would be since your local DNS is on your LAN side, you could therefore configure your network equipment to block requests made by any LAN device other than your server to any server on port 53 on the WAN side to ensure DNS requests can only be made to your local server.

To use these blacklists with DualServer you can either copy and paste their contents under the [DNS_HOSTS] section of the DualServer.ini or simply direct DualServer to the downloaded blacklist file using @blacklist.txt (or whatever the blacklist file name is) directly under the [DNS_HOSTS] section of the DualServer.ini. Please note, however, if you decide to direct DualServer to a file, the "@" line should be the first line in the [DNS_HOSTS] section of the DualServer.ini and all entries for the section must then come from the directed file.
