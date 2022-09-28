## import csv and update with SQL
This is an example on how to import CSV data to any table using SQL.

The related article is on Developer Community

## Prerequisites
Make sure you have [git](https://git-scm.com/book/en/v2/Getting-Started-Installing-Git) and [Docker desktop](https://www.docker.com/products/docker-desktop) installed.

## Installation with Docker

Clone/git pull the repo into any local directory

```
$ git clone https://github.com/intersystems-community/objectscript-docker-template.git
```


Open the terminal in a cloned folder and run the container with InterSystems IRIS:

```
$ docker-compose up -d
```

## Installation with ZPM

Open IRIS terminal and run
```
USER>zpm "install import-csv-update-sql"
```

## How to Use it

In this example we use Countries dataset and GNP dataset to change the GNP column in Countries dataset.
we will import GNP CSV with csvgen and then run the SQL update query that will change the data in dc_data.Country class/table for the GNP values from GNP class generated from CSV.
And then we delete GNP class.


Open IRIS terminal:

```
$ docker-compose exec iris iris session iris
USER>
```
1. Import dataset
2. Show the initial value
```
USER>zw ##class(evshvarov.csv.sqlupdate).ImportDataset()
...
[dataset-countries]     Activate SUCCESS
USER>zw ##class(evshvarov.csv.sqlupdate).AddGNP()
"SQLCODE=0"
USER>zw ##class(evshvarov.csv.sqlupdate).ShowGNP()
Country gnp=
1
```
3. Import CSV with the demanded data:
```
USER>zw ##class(evshvarov.csv.sqlupdate).ImportCSV()
Class name: dc.data.GNP
Header: "CountryName" VARCHAR(250),"CountryCode" VARCHAR(250), . . .
Records imported: 2661
```
4. Change the data:
```
USER>zw ##class(evshvarov.csv.sqlupdate).UpdateGNP()
Changes to GNP are made from dc.data.GNP
1
USER>zw ##class(evshvarov.csv.sqlupdate).ShowGNP()
Country Armenia gnp=12424.5488
1
```
5. Delete GNP table:
```
USER>zw ##class(evshvarov.csv.sqlupdate).DropGNP()
dc.data.DNP class is deleted.
1
```
Or you can run all the process with RunAll() method:
```
zw ##class(evshvarov.csv.sqlupdate).RunAll()
```

