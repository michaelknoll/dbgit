dbgit - Database Snapshot Repository
====================================

Dbgit provides a repository for database snapshots. It's a client/server application written in Ruby.



dbgit Server
============

The dbgit server is a Sinatra application. It can be accessed on port 4567 once it's started.



Starting the dbgit server
-------------------------

If you want to run the application manually, use the following commands

    cd server
    rackup

As a developer, use the following command for auto-reloading the application

    cd server
    rackup -E development

Logfiles are written to `server/log/[access|error|server]_log`



dbgit Client
============

There is a dedicated documentation for the client [here](client/README.md)



TODOs
=====

This project is still under heavy construction!!! Do not use it in production yet!

* Ship server as a gem
* Upload gem to gemfiles.org
* Add better error handling to server and the REST client



Author
======

Michael Lihs <mimi@kaktusteam.de>
