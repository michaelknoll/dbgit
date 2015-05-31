Database Repository Server
==========================

This project provides a database repository server.



Starting the Database Repository Server
---------------------------------------

If you want to run the application manually, use the following commands (make sure to start the application with sudo!)

    rackup

As a developer working on the Box API, use the following command for auto-reloading the application and additional CORS origins

    rackup -E development

Logs are written to `<application directory>/log/server_log`



TODOs
=====

* Provide start / stop scripts for running the database repository as a service



Author
======

Michael Lihs <mimi@kaktusteam.de>
