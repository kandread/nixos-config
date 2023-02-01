{ config, pkgs, ... }:

{

  programs = {
    mbsync.enable = true;
    offlineimap.enable = false;
    msmtp.enable = true;
    mu.enable = true;
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
      folder_transforms = Trash:deleted Junk:spam Drafts:draft Archive:archived Sent:sent Inbox:inbox
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
          afew -v -n -t
          afew -v -n -m
        '';
        preNew = ''
        # mbsync -a
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
      mu.enable = true;
      offlineimap = {
        enable = false;
        extraConfig = {
          account = {
            maxconnections = 16;
          };
          local = {
            sync_deletes = true;
          };
          # remote = {
          #   folderfilter = '' lambda foldername: foldername in ["INBOX" "Sent" "Drafts" ] '';
          # };
        };
      };
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
