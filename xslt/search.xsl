<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:tei="http://www.tei-c.org/ns/1.0" xmlns:xs="http://www.w3.org/2001/XMLSchema"
    version="2.0" exclude-result-prefixes="xsl tei xs">

    <xsl:output encoding="UTF-8" media-type="text/html" method="html" version="5.0" indent="yes"
        omit-xml-declaration="yes"/>


    <xsl:import href="./partials/html_navbar.xsl"/>
    <xsl:import href="./partials/html_head.xsl"/>
    <xsl:import href="partials/html_footer.xsl"/>
    <xsl:template match="/">
        <xsl:variable name="doc_title" select="'Volltextsuche'"/>
        <html class="h-100">
            <head>
                <xsl:call-template name="html_head">
                    <xsl:with-param name="html_title" select="$doc_title"/>
                </xsl:call-template>
            </head>

            <body class="d-flex flex-column h-100">
                <xsl:call-template name="nav_bar"/>
                <div class="container">

                    <div>
                        <h1 class="fw-light">Mächtekongresse Suche</h1>
                        <div id="searchbox"/>
                        <div id="stats-container"/>
                        <div id="current-refinements"/>
                        <div id="clear-refinements"/>
                    </div>

                    <div class="row py-lg-5">
                        <div class="col-md-3">
                            <h3>Sortierung</h3>
                            <div id="sort-by"></div>
                            <h3 class="pt-2">Kongress</h3>
                            <div id="refinement-list-conference"/>
                            <h3 class="pt-2">Personen</h3>
                            <div id="refinement-list-persons"/>
                            <h3 class="pt-2">Orte</h3>
                            <div id="refinement-list-places"/>
                        </div>

                        <div class="col">
                            <div id="pagination" class="p-3"/>
                            <div id="hits"/>

                        </div>
                    </div>

                </div>
                <xsl:call-template name="html_footer"/>
                <link rel="stylesheet"
                    href="https://cdn.jsdelivr.net/npm/instantsearch.css@7/themes/algolia-min.css"/>
                <script src="https://cdn.jsdelivr.net/npm/instantsearch.js@4.46.0"/>
                <script src="https://cdn.jsdelivr.net/npm/typesense-instantsearch-adapter@2/dist/typesense-instantsearch-adapter.min.js"/>
                <script src="js/search.js"/>
            </body>
        </html>
    </xsl:template>
</xsl:stylesheet>
