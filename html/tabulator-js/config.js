// holds shared config for all tabulator-js tables

var config = {
    height: 800,
    layout: "fitColumns",
    responsiveLayout: true,
    tooltips: true,
    dataLoader: true,
    columns: [
        {title:"#", field:"link", width:20},
        {title:"Sigle", field:"sigle", width:50},
        {title:"Titel", field:"title"},
        {title:"Weitere Dokumente", field:"docs"},
        {title:"Datum", field:"date"},
        {title:"Dateiname", field:"filename"},
    ]
};
