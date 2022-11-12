{ config, pkgs, ... }:

{
 
  programs = {
    mbsync.enable = true;
    msmtp.enable = true;
    afew = {
      enable = true;
      extraConfig = ''
      [SpamFilter]
      [KillThreadsFilter]
      [ListMailsFilter]
      [ArchiveSentMailsFilter]
      sent_tag = sent
      [FolderNameFilter]
      maildir_separator = /
      folder_explicit_list = "umass/Sent" "umass/Trash" "umass/Junk" "umass/Archive" "umass/Drafts"
      folder_transforms = "umass/Trash":deleted "umass/Junk":spam "umass/Drafts":draft "umass/Archive":archived "umass/Sent":sent      
      [Filter.1]
      query = 'to:andreadis.jhm@ametsoc.org'
      tags = +jhm
      message = JHM messages
      [MailMover]
      folders = umass/Inbox umass/Sent
      rename = True
      umass/Inbox = 'tag:spam':umass/Junk 'tag:deleted':umass/Trash 'tag:sent':umass/Sent 'tag:draft':umass/Drafts 'tag:archived':umass/Archive
      umass/Sent = 'tag:deleted':umass/Trash
      [InboxFilter]
      '';
    };
    notmuch = {
      enable = true;
      new = {
        tags = [ "new" ];
        ignore = [ "Archive1" "Conversation History" "Unsent Messages" ];
      };
      search.excludeTags = [ "deleted" "spam" "archived" ];
      extraConfig = {
        index = {
          "header.List" = "List-ID";
        };
      };
      hooks = {
        postNew = ''
          notmuch tag +deleted folder:"umass/Trash"
          notmuch tag +spam folder:"umass/Junk"
          notmuch tag +archived folder:"umass/Archive"
          notmuch tag +sent folder:"umass/Sent"
          notmuch tag +draft folder:"umass/Drafts"
          notmuch tag +jhm to:andreadis.jhm@ametsoc.org
        '';
        preNew = ''
        # mbsync -a
        '';
        postInsert = ''
          function safeMove { s=''${1##*/}; s=''${s%%,*}; mv -f ''$1 ''$2/''$s; }
          for i in ''$(notmuch search --exclude=false --output=files tag:deleted AND NOT folder:"umass/Trash"); do safeMove $i ~/Mail/umass/Trash/cur; done
          for i in ''$(notmuch search --exclude=false --output=files tag:spam AND NOT folder:"umass/Junk"); do safeMove $i ~/Mail/umass/Junk/cur; done
          for i in ''$(notmuch search --exclude=false --output=files tag:sent AND NOT folder:"umass/Sent"); do safeMove $i ~/Mail/umass/Sent/cur; done
          for i in ''$(notmuch search --exclude=false --output=files tag:archived AND NOT folder:"umass/Archive"); do safeMove $i ~/Mail/umass/Archive/cur; done
        '';
      };
    };
  };

  services = {
    mbsync = {
      enable = true;
      frequency = "*:0/5";
    };
  };

  accounts.email = {
    maildirBasePath = "Mail";
  };

  accounts.email.accounts = {
    umass = {
      primary = true;
      address = "kandread@umass.edu";
      aliases = [ "andreadis.jhm@ametsoc.org" ];
      userName = "kandread@umass.edu";
      realName = "Kostas Andreadis";
      passwordCommand = "cat /run/secrets/umass";
      imap = {
        host = "localhost";
        port = 1143;
        tls = {
          enable = false;
          useStartTls = false;
        };
      };
      maildir.path = "umass";
      notmuch.enable = true;
      mbsync = {
        enable = true;
        create = "maildir";
        expunge = "both";
        remove = "both";
        patterns = [ "*" "!Archive1" "!Conversation History" "!Unsent Messages" "!Trash/Trash" "!Trash/Sent" ];
        extraConfig = {
          account = { AuthMech = "LOGIN"; };
          remote = { UseNamespace = "yes"; };
        };
      };
      smtp = {
        host = "localhost";
        port = 1025;
        tls = {
          enable = false;
          useStartTls = false;
        };
      };
      msmtp = {
        enable = true;
        extraConfig = {
          auth = "login";
          logfile = "~/.cache/msmtp.log";
        };
      };
    };
  };
  
}
