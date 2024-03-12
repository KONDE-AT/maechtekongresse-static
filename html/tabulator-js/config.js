// holds shared config for all tabulator-js tables

var config = {
    height: 800,
    layout: "fitColumns",
    responsiveLayout: true,
    tooltips: true,
    dataLoader: true
};

var configTOC = {
    height: 800,
    layout: "fitColumns",
    responsiveLayout: true,
    tooltips: true,
    dataLoader: true,
    columns: [
        {title:"#", field:"link", width:20},
        {title:"Sigle", field:"sigle", width:50},
        {title:"Titel", field:"title"},
        {title:"Weitere Dokumente", field:"docs", minWidth:300, width:300, formatter:"textarea", variableHeight:true},
        {title:"Datum", field:"date"},
        {title:"Dateiname", field:"filename"},
    ]
}

var configRegest = {
    height: 800,
    layout: "fitColumns",
    responsiveLayout: true,
    tooltips: true,
    dataLoader: true,
    columns: [
        {title:"#", field:"link", width:20},
        {title:"Sigle", field:"sigle", width:50},
        {title:"Titel", field:"title", width:100},
        {title:"Regest", field:"regest", minWidth:375, width:375, formatter:"textarea", variableHeight:true},
        {title:"Datum", field:"date"},
        {title:"Dateiname", field:"filename"},
    ]
}