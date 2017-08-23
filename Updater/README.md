# Unified Hosts Updater for DualServer
Updater script for DualServer.

This project is maintained by ScriptTiger as a subdirectoy of the ScriptTiger DualServer project: https://github.com/ScriptTiger/DualServer

Wget is also a component to this project licensed separately in accordance with its attached documentation.

If you download the Updater.zip and extract the contents to your DualServer root, the same directory as your DualServer.ini, it can update your DualServer for you depending on your preferences after you have marked where you want the Unified Hosts to go without requiring you to have a local git repo of this project. If you plan to always use the same blacklist, you can edit the "URL" variable at the top of the script with the direct URL of the blacklist you prefer and this will bypass having to be prompted for you preferences later.

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
