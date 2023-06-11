[![Say Thanks!](https://img.shields.io/badge/Say%20Thanks-!-1EAEDB.svg)](https://docs.google.com/forms/d/e/1FAIpQLSfBEe5B_zo69OBk19l3hzvBmz3cOV6ol1ufjh0ER1q3-xd2Rg/viewform)

# Unified Hosts Updater for DualServer
Blacklist updater script for DualServer.

**If you are looking for the blacklists, please see the below URL:  
https://scripttiger.github.io/dualserver  
They have been moved to GitHub pages to better manage their git history as well as make downloads easier since they have been getting a lot of traffic by themselves. Because of this move if you are using an older Updater script, it will no longer work and you will need to download this repo again from the below link:  
https://github.com/ScriptTiger/DualServer-AutoUpdate/archive/master.zip**

If you download the repo ZIP and extract the contents to your DualServer root, the same directory as your DualServer.ini, it can update your DualServer for you depending on your preferences after you have marked where you want the Unified Hosts to go without requiring you to have a local git repo of this project. If you plan to always use the same blacklist, you can edit the "URL" variable at the top of the script with the direct URL of the blacklist you prefer and this will bypass having to be prompted for you preferences later.

If you want to ignore or whitelist certain entries from the Unified Hosts and prevent them from appearing in DualServer, just add them to the ignore.txt. These entries are made with regular expressions.  
    .        Wildcard: any character  
    *        Repeat: zero or more occurrences of previous character or class  
    ^        Line position: beginning of line  
    $        Line position: end of line  
    [class]  Character class: any one character in set  
    [^class] Inverse class: any one character not in set  
    [x-y]    Range: any characters within the specified range  
    \x       Escape: literal use of metacharacter x  
    \<xyz    Word position: beginning of word  
    xyz\>    Word position: end of word

After you have extracted the Blacklist_Update.cmd and wget directory into the directory of your choosing and editted the script accordingly for the new paths, insert #### BEGIN UNIFIED HOSTS #### and #### END UNIFIED HOSTS #### into the [DNS_HOSTS] section of the DualerServer.ini and run Blacklist_Update.cmd. After you have inserted the beginning and ending tags, if you run the script again it will automatically replace everything between them with the new blacklist.

This script is currently only interactive and does not support automating it via a scheduled tasks, etc., as it is never wise to do so with any type of service.

For more information about DualServer, the blacklists used by this Updater, as well as some DualServer tamplates and manuals, check out the project's web page:  
https://scripttiger.github.io/dualserver

For more ScriptTiger scripts and goodies, check out ScriptTiger's GitHub Pages website:  
https://scripttiger.github.io/

[![Donate](https://www.paypalobjects.com/en_US/i/btn/btn_donateCC_LG.gif)](https://www.paypal.com/cgi-bin/webscr?cmd=_s-xclick&hosted_button_id=MZ4FH4G5XHGZ4)
