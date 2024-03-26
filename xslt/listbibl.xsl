<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet 
    xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:tei="http://www.tei-c.org/ns/1.0" xmlns:xs="http://www.w3.org/2001/XMLSchema"
    version="2.0" exclude-result-prefixes="xsl tei xs">
    
    <xsl:output encoding="UTF-8" media-type="text/html" method="html" version="5.0" indent="yes" omit-xml-declaration="yes"/>
    
    
    <xsl:import href="./partials/html_navbar.xsl"/>
    <xsl:import href="./partials/html_head.xsl"/>
    <xsl:import href="./partials/html_footer.xsl"/>
    <!--<xsl:import href="partials/tabulator_dl_buttons.xsl"/>
    <xsl:import href="partials/tabulator_js.xsl"/>-->
    <xsl:import href="./partials/bibl.xsl"/>
    <xsl:import href="./partials/shared.xsl"/>

    <xsl:template match="/">
        <xsl:variable name="doc_title">
            <xsl:value-of select=".//tei:titleStmt/tei:title[1]/text()"/>
        </xsl:variable>
        <html  class="h-100">

            <head>
                <xsl:call-template name="html_head">
                    <xsl:with-param name="html_title" select="$doc_title"></xsl:with-param>
                </xsl:call-template>
            </head>
            
            <body class="d-flex flex-column h-100">
                <xsl:call-template name="nav_bar"/>

                <main>                    
                    <div class="container">                        
                        <h1>
                            <xsl:value-of select="$doc_title"/>
                        </h1>
                        <!-- Literatur.xml -->
                        <xsl:apply-templates select=".//tei:body"/>
                        <xsl:for-each select="//tei:listWit//tei:witness"><!-- listwit.xml -->
                            <p xml:id="{./@xml:id}"><xsl:apply-templates select="*[not(name()='head')]"/></p>
                        </xsl:for-each>
                        <xsl:for-each select="//tei:listBibl//tei:bibl"><!-- listtreaties.xml -->
                            <p xml:id="{./@xml:id}"><xsl:apply-templates/></p>
                        </xsl:for-each>
                    </div>
                </main>
                <xsl:call-template name="html_footer"/>
                <!--<xsl:call-template name="tabulator_js"/>-->
            </body>
        </html>
        <xsl:for-each select=".//tei:bibl[@xml:id]">
            <xsl:variable name="filename" select="concat(./@xml:id, '.html')"/>
            <xsl:variable name="name" select="normalize-space(string-join(./tei:title[1]//text()))"></xsl:variable>
            <xsl:result-document href="{$filename}">
                <html  class="h-100">
                    <head>
                        <xsl:call-template name="html_head">
                        <xsl:with-param name="html_title" select="$name"></xsl:with-param>
                    </xsl:call-template>
                    </head>

                    <body class="d-flex flex-column h-100">
                        <xsl:call-template name="nav_bar"/>
                        <main>
                            <div class="container">
                                <h1>
                                    <xsl:value-of select="$name"/>
                                </h1>
                                <xsl:call-template name="bibl_detail"/>
                            </div>
                        </main>
                        <xsl:call-template name="html_footer"/>
                    </body>
                </html>
            </xsl:result-document>
        </xsl:for-each>
        <xsl:for-each select=".//tei:witness[@xml:id]">
            <xsl:variable name="filename" select="concat(./@xml:id, '.html')"/>
            <xsl:variable name="name" select="normalize-space(string-join(./tei:title[1]//text()))"></xsl:variable>
            <xsl:result-document href="{$filename}">
                <html  class="h-100">
                    <head>
                        <xsl:call-template name="html_head">
                            <xsl:with-param name="html_title" select="$name"></xsl:with-param>
                        </xsl:call-template>
                    </head>
                    <body class="d-flex flex-column h-100">
                        <xsl:call-template name="nav_bar"/>
                        <main>
                            <div class="container">
                                <h1>Zeuge <xsl:value-of select="@xml:id"/></h1>
                                <xsl:call-template name="bibl_detail"/>
                            </div>
                        </main>
                        <xsl:call-template name="html_footer"/>
                    </body>
                </html>
            </xsl:result-document>
        </xsl:for-each>
    </xsl:template>
    
</xsl:stylesheet>