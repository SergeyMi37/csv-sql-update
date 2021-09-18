Class eshvarov.csv.test
{

/// import from CSV
ClassMethod ImportCSV() As %Status
{
    Set sc = $$$OK
    set sc = ##class(community.csvgen).GenerateFromURL("https://raw.githubusercontent.com/evshvarov/test-ipad/master/gnp.csv",",","dc.data.GNP")
    &sql(
    UPDATE dc_data.Country
    SET Country.gnp=GNP."2020"
    FROM 
    dc_data.Country Country
    INNER JOIN dc_data.GNP GNP
    On Country.name=GNP.CountryName
    )

    if SQLCODE < 0 throw ##class(%Exception.SQL).CreateFromSQLCODE(SQLCODE,"Importing data")


    Return sc
}

}
