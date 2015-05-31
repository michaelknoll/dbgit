dbgit
=====

dbgit is a database repository for managing database snapshots. It is a client server application. The client command is `dbgit`.



Using the dbgit client
----------------------

Use the help command to get an overview of the available commands `dbgit help` or simply `dbgit`:

	Commands:
	  dbgit apply database snapshot tag  # Imports the snapshot with the given tag into the database.
	  dbgit create database [tag]        # Create a local database snapshot for given database using an optionally given tag
	  dbgit delete database tag          # Deletes a local snapshot of a database identified by a given tag name
	  dbgit delete-remote database tag   # Deletes a remote snapshot of a database identified by a given tag name
	  dbgit help [COMMAND]               # Describe available commands or one specific command
	  dbgit ls database                  # Lists all local snapshots for a database
	  dbgit ls-remote database           # Lists all remote snapshots for a database
	  dbgit pull database tag            # Pulls the snapshot identified by database and tag from the remote repository.
	  dbgit push database tag            # Pushes the database snapshot identified by database and tag to the remote repository.
	  dbgit version                      # Show the version of the dbgit client



TODOs
=====

* Version the API of the client/server communication
* Add compression of snapshots
* Add metadata to snapshots
* Move longdesc of Thor file into separate files
* Think about a search path for the client configuration file
  * Write custom configuration into user's home directory, e.g. `~/.dbrepo.conf`
* Implement usage of multiple remote repositories



Author
======

Michael Lihs <mimi@kaktusteam.de>
