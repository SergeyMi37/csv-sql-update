Class evshvarov.csv.sqlupdate
{

/// the whole process
ClassMethod RunAll() As %Status
{
    Set sc = $$$OK
    zw ..ImportDataset()
    zw ..ShowGNP()
    zw ..ImportCSV()
    zw ..UpdateGNP()
    zw ..ShowGNP()
    zw ..DropGNP()

    Return sc
}

/// import from CSV and update with SQL
ClassMethod ImportCSV() As %Status
{
    set sc = ##class(community.csvgen).GenerateFromURL("https://raw.githubusercontent.com/evshvarov/csv-sql-update/master/gnp.csv",",","dc.data.GNP")
    Return sc
}

ClassMethod UpdateGNP() As %Status
{
    Set sc = $$$OK
    
    &sql(
        UPDATE dc_data.Country
        SET Country.gnp=GNP."2020"
        FROM 
        dc_data.Country Country
        INNER JOIN dc_data.GNP GNP
        On Country.name=GNP.CountryName
    )

    if SQLCODE < 0 throw ##class(%Exception.SQL).CreateFromSQLCODE(SQLCODE,"Importing data")

    w "Changes to GNP are made from dc.data.GNP",!

    Return sc
}

/// Import dataset
ClassMethod ImportDataset() As %Status
{
    Set sc = $$$OK
    set sc=$zpm("install dataset-countries")
    Return sc
}

/// Write SQL result with countries GNP
ClassMethod ShowGNP() As %Status
{
    Set sc = $$$OK
    &sql(
        SELECT TOP 1 name,gnp into :name,:gnp  from dc_data.Country 
    )
    if SQLCODE < 0 throw ##class(%Exception.SQL).CreateFromSQLCODE(SQLCODE,"Show Country GNP")
    write "Country ",name," gnp=",gnp,!

    Return sc
}

ClassMethod DropGNP() As %Status
{
    Set sc = $$$OK
    &sql(
        DROP TABLE dc_data.GNP
    )
    if SQLCODE < 0 throw ##class(%Exception.SQL).CreateFromSQLCODE(SQLCODE,"Drop csv table")
    write "dc.data.DNP class is deleted.",!

    Return sc
}

}
