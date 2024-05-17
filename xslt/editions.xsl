<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet 
    xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:tei="http://www.tei-c.org/ns/1.0"
    xmlns:xs="http://www.w3.org/2001/XMLSchema"
    xmlns:local="http://dse-static.foo.bar"
    xmlns="http://www.w3.org/1999/xhtml"
    version="2.0" exclude-result-prefixes="xsl tei xs local">
    
    <xsl:output encoding="UTF-8" media-type="text/html" method="html" version="5.0" indent="yes" omit-xml-declaration="yes"/>
    
    
    <xsl:import href="./partials/shared.xsl"/>
    <xsl:import href="./partials/html_navbar.xsl"/>
    <xsl:import href="./partials/html_head.xsl"/>
    <xsl:import href="./partials/html_footer.xsl"/>
    <xsl:import href="./partials/aot-options.xsl"/>
    <xsl:import href="./partials/entities.xsl"/>

    <xsl:variable name="prev">
        <xsl:value-of select="replace(tokenize(data(tei:TEI/@prev), '/')[last()], '.xml', '.html')"/>
    </xsl:variable>
    <xsl:variable name="next">
        <xsl:value-of select="replace(tokenize(data(tei:TEI/@next), '/')[last()], '.xml', '.html')"/>
    </xsl:variable>
    <xsl:variable name="teiSource">
        <xsl:value-of select="data(tei:TEI/@xml:id)"/>
    </xsl:variable>
    <xsl:variable name="link">
        <xsl:value-of select="replace($teiSource, '.xml', '.html')"/>
    </xsl:variable>
    <xsl:variable name="doc_title">
        <xsl:value-of select=".//tei:titleStmt/tei:title[1]/text()"/>
    </xsl:variable>


    <xsl:template match="/">

    
        <html class="h-100">
    
            <head>
                <xsl:call-template name="html_head">
                    <xsl:with-param name="html_title" select="$doc_title"></xsl:with-param>
                </xsl:call-template>
                <style>
                    .navBarNavDropdown ul li:nth-child(2) {
                        display: none !important;
                    }
                </style>
            </head>
            <body class="d-flex flex-column h-100">
                <xsl:call-template name="nav_bar"/>
                <main class="flex-shrink-0">
                    <div class="container">


                        <div class="row">
                            <div class="col-md-2 col-lg-2 col-sm-12">
                                <xsl:if test="ends-with($prev,'.html')">
                                    <h1>
                                        <a>
                                            <xsl:attribute name="href">
                                                <xsl:value-of select="$prev"/>
                                            </xsl:attribute>
                                            <i class="bi bi-chevron-left" title="zurück"/>
                                        </a>
                                    </h1>
                                </xsl:if>
                            </div>
                            <div class="col-md-8 col-lg-8 col-sm-12">
                                <h1 align="center">
                                    <xsl:value-of select="$doc_title"/>
                                </h1>
                                <h3 align="center">
                                    <a href="{$teiSource}">
                                        <i class="bi bi-download" title="TEI/XML"/>
                                    </a>
                                </h3>
                            </div>
                            <div class="col-md-2 col-lg-2 col-sm-12" style="text-align:right">
                                <xsl:if test="ends-with($next, '.html')">
                                    <h1>
                                        <a>
                                            <xsl:attribute name="href">
                                                <xsl:value-of select="$next"/>
                                            </xsl:attribute>
                                            <i class="bi bi-chevron-right" title="weiter"/>
                                        </a>
                                    </h1>
                                </xsl:if>
                            </div>
                            <div id="editor-widget">
                                <xsl:call-template name="annotation-options"></xsl:call-template>
                            </div>
                        </div>
                        <div id="teiHeader">
                            <table class="table table-striped">
                                <tbody>
                                    <xsl:if test="//tei:abstract">
                                        <xsl:choose>
                                            <xsl:when test="count(//tei:abstract) &gt; 1">
                                                <xsl:for-each select="//tei:abstract">
                                                    <xsl:variable name="x">
                                                        <xsl:number level="any" count="tei:abstract"/>
                                                    </xsl:variable>
                                                    <tr>
                                                        <th>
                                                            <abbr title="//tei:abstract">Regest
                                                                <xsl:text> Nr. </xsl:text>
                                                                    <xsl:value-of select="$x"/>
                                                            </abbr>
                                                        </th>
                                                        <td>
                                                            <em>
                                                                <xsl:apply-templates select="//tei:abstract[position()=$x]"/>
                                                            </em>
                                                        </td>
                                                    </tr>
                                                </xsl:for-each>
                                            </xsl:when>
                                            <xsl:otherwise>
                                                <tr>
                                                    <th>
                                                        <abbr title="//tei:abstract">Regest</abbr>
                                                    </th>
                                                    <td>
                                                        <em>
                                                            <xsl:apply-templates select="//tei:abstract"/>
                                                        </em>
                                                    </td>
                                                </tr>
                                            </xsl:otherwise>
                                        </xsl:choose>
                                    </xsl:if>
                                    <xsl:if test="//tei:particDesc/tei:listPerson/tei:person">
                                        <tr>
                                            <th>
                                                <abbr title="//tei:particDesc/tei:listPerson/tei:person">Anwesende</abbr>
                                            </th>
                                            <td>
                                                <xsl:for-each select="//tei:particDesc/tei:listPerson/tei:person">
                                                    <xsl:apply-templates/>
                                                    <xsl:if test="position() != last()">
                                                        <xsl:text> · </xsl:text>
                                                    </xsl:if>
                                                </xsl:for-each>
                                            </td>
                                        </tr>
                                    </xsl:if>
                                    <xsl:if test="//tei:supportDesc/tei:extent">
                                        <tr>
                                            <th>
                                                <abbr title="//tei:supportDesc/tei:extent">Extent</abbr>
                                            </th>
                                            <td>
                                                <xsl:apply-templates select="//tei:supportDesc/tei:extent"/>
                                            </td>
                                        </tr>
                                    </xsl:if>
                                </tbody>
                            </table>
                            <button  class="btn btn-primary btn-sm" type="button" data-bs-toggle="collapse" data-bs-target="#metadata" aria-expanded="false" aria-controls="metadata">Metadaten zeigen/verstecken</button>
                        </div>
                        <div class="card-body collapse" id="metadata">
                            <xsl:for-each select="//tei:sourceDesc/tei:msDesc"><!-- Split -->
                                <xsl:variable name="msDivId" select="@xml:id"/>
                                <xsl:variable name="divlink" select="concat('#',$msDivId)"/>
                                <div class="card">
                                <div class="card-body">
                                    <xsl:attribute name="id">m<xsl:value-of select="$msDivId"/>
                                    </xsl:attribute>
                                    <table class="table table-striped">
                                        <tbody>
                                                    <xsl:if test=".//tei:msContents">
                                                        <tr style="background-color:#ccc;font-weight:bold;">
                                                            <th>
                                                                <abbr title="//tei:msContents">Bezeichnung</abbr>
                                                            </th>
                                                            <td>
                                                                <a>
                                                                    <xsl:attribute name="href">
                                                                        <xsl:value-of select="$divlink"/>
                                                                    </xsl:attribute>
                                                                    <xsl:value-of select="normalize-space(string-join(.//tei:msContents//tei:title/descendant-or-self::*[not(name()='expan')]/text(), ''))"/>
                                                                </a>
                                                            </td>
                                                        </tr>
                                                    </xsl:if>
                                            <xsl:if test="./@type">
                                                <tr>
                                                    <th>
                                                        <abbr title="//tei:msDesc/@type">Dokumentenart</abbr>
                                                    </th>
                                                    <td>
                                                        <xsl:value-of select="./@type"/>
                                                    </td>
                                                </tr>
                                            </xsl:if>
                                            <tr>
                                                <th>
                                                    <abbr title="//tei:history/tei:origin">Ort/Datum</abbr>
                                                </th>
                                                <td>
                                                    <xsl:value-of select=".//tei:history/tei:origin/tei:placeName"/>
                                                    <xsl:if test="not(.//tei:history/tei:origin/tei:placeName)">
                                                        <xsl:text>o.O.</xsl:text>
                                                    </xsl:if>
                                                    <xsl:text>, </xsl:text>
                                                    <xsl:value-of select="format-date(xs:date(.//tei:history/tei:origin/tei:date[1]/@when), '[D]. [M02]. [Y0001]')"/>
                                                    <xsl:if test="not(.//tei:history/tei:origin/tei:date/@when)">
                                                        <xsl:text>o.D.</xsl:text>
                                                    </xsl:if>
                                                </td>
                                            </tr>
                                            <xsl:if test=".//tei:msIdentifier">
                                                <tr>
                                                    <th>
                                                        <abbr title="//tei:msIdentifier">Signatur</abbr>
                                                    </th>
                                                    <td>
                                                        <xsl:for-each select=".//tei:msIdentifier/child::*">
                                                            <xsl:choose>
                                                                <xsl:when test="tei:idno">
                                                                    <xsl:for-each select="./tei:idno">
                                                                        <xsl:value-of select="."/>
                                                                        <xsl:if test="position() != last()">, </xsl:if>
                                                                    </xsl:for-each>
                                                                </xsl:when>
                                                                <xsl:otherwise>
                                                                    <abbr>
                                                                        <xsl:attribute name="title">
                                                                            <xsl:value-of select="name()"/>
                                                                        </xsl:attribute>
                                                                        <xsl:value-of select="."/>
                                                                    </abbr>
                                                                </xsl:otherwise>
                                                            </xsl:choose>
                                                            <xsl:if test="position() != last()">, </xsl:if>
                                                        </xsl:for-each><!--<xsl:apply-templates select="//tei:msIdentifier"/>-->
                                                    </td>
                                                </tr>
                                            </xsl:if>
                                            <xsl:if test=".//tei:physDesc">
                                                <tr>
                                                    <th>
                                                        <abbr title="//tei:physDesc">Stückbeschreibung</abbr>
                                                    </th>
                                                    <td>
                                                        <xsl:apply-templates select=".//tei:physDesc"/>
                                                    </td>
                                                </tr>
                                            </xsl:if>
                                            <xsl:if test="..//tei:listWit[@corresp=$divlink]/tei:witness">
                                                <xsl:for-each select="root()//tei:listWit[@corresp=$divlink]/tei:witness/@corresp">
                                                    <xsl:variable name="witId" select="substring-after(., '#')"/>
                                                    <tr>
                                                        <th>
                                                                <abbr>
                                                                <xsl:attribute name="title">//tei:listWit <xsl:value-of select="$witId"/>
                                                                </xsl:attribute>
                                                                Vgl. gedruckte Quelle</abbr>
                                                        </th>
                                                        <td>
                                                            <xsl:for-each select="../tei:bibl">
                                                                <a>
                                                                    <xsl:attribute name="href">../pages/bibl.html#myTable=f<xsl:value-of select="$witId"/>
                                                                    </xsl:attribute>
                                                                    <xsl:value-of select="."/>
                                                                </a>
                                                            </xsl:for-each>
                                                        </td>
                                                    </tr>
                                                </xsl:for-each>
                                            </xsl:if>
                                        </tbody>
                                    </table>
                                </div>
                                </div>
                            </xsl:for-each>
                    </div>
                        <div id="body">
                            <div class="card card-body">
                                <xsl:if test="count(//tei:div) &gt; 1">
                                    <h3 id="clickme">
                                        <abbr title="Für Abschnitte klicken" style="color:#23527c">Abschnitte</abbr>
                                    </h3>
                                    <div id="headings" class="readmore">
                                        <ul>
                                            <xsl:for-each select="/tei:TEI/tei:text/tei:body//tei:div">
                                                <xsl:variable name="msIdlink" select="@decls"/>
                                                <xsl:variable name="msId" select="substring-after($msIdlink,'#')"/>
                                                <li>
                                                    <a>
                                                        <xsl:attribute name="href">
                                                            <xsl:value-of select="$msIdlink"/>
                                                        </xsl:attribute>
                                                        <xsl:value-of select="root()//tei:msDesc[@xml:id=$msId]//tei:title"/>
                                                    </a>
                                                </li>
                                            </xsl:for-each>
                                        </ul>
                                    </div>
                                </xsl:if>
                            </div>
                            <xsl:apply-templates select=".//tei:body"></xsl:apply-templates>
                        </div>
                        <div class="card card-default">
                            <h4>Noten</h4>
                            <xsl:for-each select=".//tei:note[not(./tei:p)][ancestor::tei:body]">
                                <div class="footnotes" id="{local:makeId(.)}">
                                    <xsl:element name="a">
                                        <xsl:attribute name="name">
                                            <xsl:text>fn</xsl:text>
                                            <xsl:number level="any" format="1" count="tei:note[not(./tei:p)][ancestor::tei:body]"/>
                                        </xsl:attribute>
                                        <a>
                                            <xsl:attribute name="href">
                                                <xsl:text>#fna_</xsl:text>
                                                <xsl:number level="any" format="1" count="tei:note[not(./tei:p)][ancestor::tei:body]"/>
                                            </xsl:attribute>
                                            <span style="font-size:7pt;vertical-align:super; margin-right: 0.4em">
                                                <xsl:number level="any" format="1" count="tei:note[not(./tei:p)][ancestor::tei:body]"/>
                                            </span>
                                        </a>
                                    </xsl:element>
                                    <xsl:apply-templates/>
                                </div>
                            </xsl:for-each>
                        </div>
                        <div class="card card-default">
                            <table class="table table-striped">
                                <tbody>
                                    <tr>
                                        <th>
                                            <abbr title="Zitierhilfe">Zitierempfehlung</abbr>
                                        </th>
                                        <td>
                                            <xsl:value-of select="normalize-space(string-join(//tei:titleStmt//tei:title[@type='main']/descendant-or-self::*[not(name()='expan')]/text(), ' '))"/>
                                            <xsl:text>. In: </xsl:text>
                                            <xsl:value-of select="$project_title"/>
                                            <xsl:if test="//tei:titleStmt/tei:editor">
                                                <xsl:text>, hrsg. von </xsl:text>
                                                <xsl:for-each select="//tei:titleStmt/tei:editor[not(@role)]">
                                                    <xsl:value-of select="./tei:persName/tei:forename"/>
                                                    <xsl:text> </xsl:text>
                                                    <xsl:value-of select="./tei:persName/tei:surname"/>
                                                </xsl:for-each>
                                                <xsl:if test="//tei:titleStmt/tei:editor[@role]">
                                                    <xsl:text> unter Mitarbeit von </xsl:text>
                                                    <xsl:for-each select="//tei:titleStmt/tei:editor[@role]">
                                                        <span>
                                                            <xsl:attribute name="title"><xsl:value-of select="./tei:persName/@ref"/></xsl:attribute>
                                                            <xsl:value-of select="./tei:persName/tei:forename"/>
                                                            <xsl:text> </xsl:text>
                                                            <xsl:value-of select="./tei:persName/tei:surname"/>
                                                        </span>
                                                    </xsl:for-each>
                                                </xsl:if>
                                                <xsl:text>, </xsl:text>
                                                <xsl:for-each select="//tei:publicationStmt/tei:pubPlace">
                                                    <xsl:apply-templates/>
                                                </xsl:for-each>
                                                <xsl:text>: </xsl:text>
                                                <xsl:for-each select="//tei:publicationStmt/tei:publisher">
                                                    <xsl:apply-templates/>
                                                </xsl:for-each>
                                            </xsl:if>    
                                            <xsl:text> 2018. URL: </xsl:text>
                                            <xsl:value-of select="$base_url"/>
                                            <xsl:value-of select="$link"/>
                                            <xsl:text>.</xsl:text>
                                        </td>
                                    </tr>
                            <xsl:if test="//tei:titleStmt/tei:respStmt">
                                <tr>
                                    <th>
                                        <abbr title="//tei:titleStmt/tei:respStmt">Verantwortlichkeiten</abbr>
                                    </th>
                                    <td>
                                            <ul>
                                            <xsl:for-each select="//tei:titleStmt/tei:respStmt/tei:resp">
                                            <li>
                                                <xsl:if test="@role">
                                                    <xsl:value-of select="@role"/>
                                                    <xsl:text>: </xsl:text> 
                                                </xsl:if> 
                                                <xsl:value-of select="."/>
                                                        <xsl:text>: </xsl:text>
                                                <xsl:for-each select="following-sibling::tei:name">
                                                    <xsl:value-of select="."/>
                                                    <xsl:if test="position() != last()">, </xsl:if>
                                                </xsl:for-each>
                                            </li>
                                            </xsl:for-each>
                                            </ul>
                                        <xsl:for-each select="//tei:notesStmt/tei:note">
                                            <p>
                                                <xsl:apply-templates select="."/>
                                            </p>
                                        </xsl:for-each>
                                    </td>
                                </tr>
                            </xsl:if>
                            <tr>
                                <th>
                                    <abbr title="//tei:availability//tei:p[1]">Lizenz</abbr>
                                </th>
                                <xsl:choose>
                                    <xsl:when test="//tei:licence[@target]">
                                        <td>
                                            <a class="navlink" target="_blank" rel="noopener noreferrer">
                                                <xsl:attribute name="href">
                                                    <xsl:value-of select="//tei:licence[1]/data(@target)"/>
                                                </xsl:attribute>
                                                <xsl:value-of select="//tei:licence[1]/data(@target)"/>
                                            </a>
                                        </td>
                                    </xsl:when>
                                    <xsl:when test="//tei:licence">
                                        <td>
                                            <xsl:apply-templates select="//tei:licence"/>
                                        </td>
                                    </xsl:when>
                                    <xsl:otherwise>
                                        <td>no license provided</td>
                                    </xsl:otherwise>
                                </xsl:choose>
                            </tr>
                            </tbody>
                            </table>
                    </div>
                    </div>
                    <xsl:for-each select="//tei:back">
                        <div class="tei-back">
                            <xsl:apply-templates/>
                        </div>
                    </xsl:for-each>
                    <div id="loadModal"/>
                </main>
                <xsl:call-template name="html_footer"/>
                <script src="https://unpkg.com/de-micro-editor@0.2.6/dist/de-editor.min.js"></script>
                <script type="text/javascript" src="js/run.js"></script>
                
            </body>
        </html>
    </xsl:template>

    <xsl:template match="tei:div">
        <xsl:variable name="msId" select="substring-after(@decls, '#')"/>
        <xsl:variable name="handId" select="substring-after(@hand, '#')"/>
        <xsl:choose>
            <xsl:when test="@decls">
                <xsl:element name="div">
                    <xsl:attribute name="class">card</xsl:attribute>
                    <xsl:attribute name="id">
                        <xsl:value-of select="$msId"/>
                    </xsl:attribute>
                    <xsl:if test="root()//tei:handNote[@xml:id=$handId]">
                        <xsl:element name="p">
                            <xsl:attribute name="title">//tei:handNote</xsl:attribute>
                            <em>
                            <xsl:text>Hand: </xsl:text>
                            <xsl:value-of select="root()//tei:handNote[@xml:id=$handId]"/>
                        </em>
                        </xsl:element>
                    </xsl:if>
                    <xsl:apply-templates/>
                </xsl:element>
            </xsl:when>
            <xsl:when test="@type='regest'">
                <div>
                    <xsl:attribute name="class">
                        <text>regest</text>
                    </xsl:attribute>
                    <xsl:apply-templates/>
                </div>
            </xsl:when><!-- transcript -->
            <xsl:when test="@type='transcript'">
                <div>
                    <xsl:attribute name="class">
                        <text>transcript</text>
                    </xsl:attribute>
                    <xsl:apply-templates/>
                </div>
            </xsl:when><!-- Anlagen/Beilagen  -->
            <xsl:when test="@xml:id">
                <xsl:element name="div">
                    <xsl:attribute name="id">
                        <xsl:value-of select="@xml:id"/>
                    </xsl:attribute>
                    <xsl:apply-templates/>
                </xsl:element>
            </xsl:when>
            <xsl:otherwise>
                <xsl:apply-templates/>
            </xsl:otherwise>
        </xsl:choose>
    </xsl:template>
    
    <xsl:template match="tei:add">
        <xsl:element name="ins">
            <xsl:attribute name="class">
                <xsl:text>ergaenzt</xsl:text>
            </xsl:attribute>
            <xsl:attribute name="title">
                <xsl:choose>
                    <xsl:when test="@place='margin'">
                        <xsl:text>zeitgenössische Ergänzung am Rand </xsl:text>(<xsl:value-of select="./@place"/>)
                    </xsl:when>
                    <xsl:when test="@place='above'">
                        <xsl:text>zeitgenössische Ergänzung oberhalb </xsl:text>(<xsl:value-of select="./@place"/>)
                    </xsl:when>
                    <xsl:when test="@place='below'">
                        <xsl:text>zeitgenössische Ergänzung unterhalb </xsl:text>(<xsl:value-of select="./@place"/>)
                    </xsl:when>
                    <xsl:when test="@place='inline'">
                        <xsl:text>zeitgenössische Ergänzung in der gleichen Zeile </xsl:text>(<xsl:value-of select="./@place"/>)
                    </xsl:when>
                    <xsl:when test="@place='top'">
                        <xsl:text>zeitgenössische Ergänzung am oberen Blattrand </xsl:text>(<xsl:value-of select="./@place"/>)
                    </xsl:when>
                    <xsl:when test="@place='bottom'">
                        <xsl:text>zeitgenössische Ergänzung am unteren Blattrand </xsl:text>(<xsl:value-of select="./@place"/>)
                    </xsl:when>
                    <xsl:otherwise>
                        <xsl:text>zeitgenössische Ergänzung </xsl:text>
                    </xsl:otherwise>
                </xsl:choose>
                <xsl:if test="@hand">
                    <xsl:variable name="handId" select="substring-after(@hand, '#')"/>
                    <xsl:text>durch </xsl:text>
                    <xsl:value-of select="root()//tei:handNote[@xml:id=$handId]"/>
                    <xsl:text> (</xsl:text>
                        <xsl:value-of select="./@hand"/>
                    <xsl:text>)</xsl:text>
                </xsl:if>
            </xsl:attribute>
            <xsl:text/>
            <xsl:apply-templates/>
            <xsl:text/>
        </xsl:element>
    </xsl:template><!-- app/rdg tooltip testing -->
    <xsl:template match="tei:app">
        <xsl:variable name="handId" select="substring-after(tei:rdg/tei:add/@hand, '#')"/>
            <xsl:element name="span">
                <xsl:attribute name="class">shortRdg</xsl:attribute>
                <xsl:attribute name="href">#</xsl:attribute>
                <xsl:attribute name="data-toggle">tooltip</xsl:attribute>
                <xsl:attribute name="data-placement">top</xsl:attribute>
                <xsl:attribute name="title">
                    <xsl:choose>
                        <xsl:when test="./tei:rdg/tei:subst">
                            <xsl:text>Ersetzung </xsl:text>
                            <xsl:value-of select="tei:rdg/root()//tei:handNote[@xml:id=$handId][1]"/>
                            <xsl:text>: ~</xsl:text>
                            <xsl:value-of select="normalize-space(string-join(./tei:rdg/tei:subst/tei:del/descendant-or-self::*[not(name()='note')]/text(), ' '))"/>
                            <xsl:text>~ 
</xsl:text>
                            <xsl:value-of select="normalize-space(string-join(./tei:rdg/tei:subst/tei:add/descendant-or-self::*[not(name()='note')]/text(), ' '))"/>
                        </xsl:when>
                        <xsl:otherwise>
                            <xsl:value-of select="string-join(tei:rdg/concat(root()//tei:handNote[@xml:id=$handId], ': ', normalize-space(.)),' -- ')"/>
                        </xsl:otherwise>
                    </xsl:choose>
                </xsl:attribute>
                <xsl:attribute name="data-original-title">
                    <xsl:choose>
                        <xsl:when test="./tei:rdg/tei:subst">
                            <xsl:text>Ersetzung </xsl:text>
                            <xsl:value-of select="tei:rdg/root()//tei:handNote[@xml:id=$handId][1]"/>
                            <xsl:text>: ~</xsl:text>
                            <xsl:value-of select="normalize-space(string-join(./tei:rdg/tei:subst/tei:del/descendant-or-self::*[not(name()='note')]/text(), ' '))"/>
                            <xsl:text>~ 
</xsl:text>
                            <xsl:value-of select="normalize-space(string-join(./tei:rdg/tei:subst/tei:add/descendant-or-self::*[not(name()='note')]/text(), ' '))"/>
                        </xsl:when>
                        <xsl:otherwise>
                            <xsl:value-of select="string-join(tei:rdg/concat(root()//tei:handNote[@xml:id=$handId], ': ', normalize-space(.)),' -- ')"/>
                        </xsl:otherwise>
                    </xsl:choose>
                </xsl:attribute>
                <xsl:apply-templates select="./tei:lem"/>
            </xsl:element>
            <xsl:element name="a">
                <xsl:attribute name="name">
                    <xsl:text>fna_</xsl:text>
                    <xsl:number level="any" format="i" count="tei:app"/>
                </xsl:attribute>
                <xsl:attribute name="href">
                    <xsl:text>#fn</xsl:text>
                    <xsl:number level="any" format="i" count="tei:app"/>
                </xsl:attribute>
                <xsl:attribute name="title">
                    <xsl:choose>
                        <xsl:when test="./tei:rdg/tei:subst">
                            <xsl:text>Ersetzung </xsl:text>
                            <xsl:value-of select="tei:rdg/root()//tei:handNote[@xml:id=$handId][1]"/>
                            <xsl:text>: ~</xsl:text>
                            <xsl:value-of select="normalize-space(string-join(./tei:rdg/tei:subst/tei:del/descendant-or-self::*[not(name()='note')]/text(), ' '))"/>
                            <xsl:text>~ 
</xsl:text>
                            <xsl:value-of select="normalize-space(string-join(./tei:rdg/tei:subst/tei:add/descendant-or-self::*[not(name()='note')]/text(), ' '))"/>
                        </xsl:when>
                        <xsl:otherwise>
                            <xsl:value-of select="string-join(tei:rdg/concat(root()//tei:handNote[@xml:id=$handId], ': ', normalize-space(.)),' -- ')"/>
                        </xsl:otherwise>
                    </xsl:choose>
                </xsl:attribute>
                <sup class="shortRdg">
                    <xsl:text>[Variante </xsl:text>
                    <xsl:number level="any" format="i" count="tei:app"/>
                    <xsl:text>]</xsl:text>
                </sup>
            </xsl:element>
            <xsl:element name="span">
                <xsl:attribute name="class">fullRdg</xsl:attribute>
                <xsl:attribute name="style">display:none</xsl:attribute>
                <xsl:value-of select="concat(tokenize(./tei:lem,' ')[1], ' … ', tokenize(./tei:lem,' ')[last()]), string-join(tei:rdg/concat(tei:add/@hand, '] ', normalize-space(.)),' ')"/>
            </xsl:element>
    </xsl:template>
    <xsl:template match="tei:rdg">
        <xsl:if test="preceding-sibling::tei:rdg or following-sibling::tei:rdg">
            <xsl:text>Variante </xsl:text>
            <xsl:number/>
            <xsl:text>: </xsl:text>
        </xsl:if>
        <xsl:apply-templates/>
        <xsl:if test="position() != last()">
            <br/>
        </xsl:if>
    </xsl:template>
    <xsl:template match="tei:lem">
        <xsl:apply-templates/>
    </xsl:template>
    <!-- damage supplied -->
    <xsl:template match="tei:damage">
        <xsl:element name="span">
            <xsl:attribute name="title">
                <xsl:choose>
                    <xsl:when test="./@agent='paper_damage'">Papier beschädigt</xsl:when>
                    <xsl:otherwise>
                        <xsl:value-of select="@agent"/>
                    </xsl:otherwise>
                </xsl:choose>
            </xsl:attribute>
            <xsl:if test="not(following::tei:supplied or descendant::tei:supplied)">
                <xsl:text> […]</xsl:text>
            </xsl:if>
            <xsl:apply-templates/>
        </xsl:element>
    </xsl:template>
    <xsl:template match="tei:supplied">
        <xsl:element name="span">
            <xsl:attribute name="title">editorische Ergänzung
                <xsl:if test="parent::tei:damage">
                    <xsl:text> (</xsl:text>
                    <xsl:choose>
                        <xsl:when test="../@agent='paper_damage'">Papier beschädigt</xsl:when>
                        <xsl:otherwise>
                            <xsl:value-of select="../@agent"/>
                        </xsl:otherwise>
                    </xsl:choose>
                    <xsl:text>)</xsl:text>
                </xsl:if>
            </xsl:attribute>
            <xsl:text>&lt;</xsl:text>
            <xsl:apply-templates/>
            <xsl:text>&gt;</xsl:text>
        </xsl:element>
    </xsl:template>
    <!-- choice -->
    <xsl:template match="tei:sic">
        <xsl:apply-templates/>
        <xsl:element name="span">
            <xsl:attribute name="title">Fehler/Unstimmigkeit im Originaldokument, KS</xsl:attribute>
            <xsl:text> [sic]</xsl:text>
        </xsl:element>
    </xsl:template>
    <xsl:template match="tei:choice">
        <xsl:choose>
            <xsl:when test="tei:sic and tei:corr">
                <span class="corr alternate choice4">
                    <xsl:attribute name="title">Korrektur der Hrsg. aus: „<xsl:value-of select="tei:sic[1]"/>“</xsl:attribute>
                    <xsl:if test="@xml:id">
                        <xsl:attribute name="id" select="@xml:id"/>
                    </xsl:if>
                    <xsl:apply-templates select="tei:corr[1]"/>
                    <span class="hidden altcontent">
                        <xsl:if test="@xml:id">
                            <xsl:attribute name="id" select="@xml:id"/>
                        </xsl:if>
                        <xsl:apply-templates select="tei:sic[1]"/>
                    </span>
                </span>
            </xsl:when>
            <xsl:when test="tei:seg">
                <xsl:text>[</xsl:text>
                <xsl:for-each select="./tei:seg">
                    <xsl:apply-templates/>
                    <xsl:if test="position() != last()">
                        <xsl:text> / </xsl:text>
                    </xsl:if>    
                </xsl:for-each>
                <xsl:text>]</xsl:text>
            </xsl:when>
            <xsl:when test="tei:abbr and tei:expan">
                <xsl:choose>
                    <xsl:when test="ancestor::tei:title">
                        <abbr>
                            <xsl:attribute name="title">
                                <xsl:value-of select="tei:expan"/>
                            </xsl:attribute>
                            <xsl:apply-templates select="tei:abbr[1]"/>
                        </abbr>
                    </xsl:when>
                    <xsl:otherwise>
                        <abbr>
                            <xsl:if test="@xml:id">
                                <xsl:attribute name="id" select="@xml:id"/>
                            </xsl:if>
                            <xsl:attribute name="title">
                                <xsl:value-of select="tei:expan"/>
                            </xsl:attribute>
                            <xsl:apply-templates select="tei:abbr[1]"/>
                            <span class="hidden altcontent">
                                <xsl:if test="@xml:id">
                                    <xsl:attribute name="id" select="@xml:id"/>
                                </xsl:if>
                                <xsl:apply-templates select="tei:expan[1]"/>
                            </span>
                        </abbr>
                    </xsl:otherwise>
                </xsl:choose>
            </xsl:when>
            <xsl:when test="tei:orig and tei:reg">
                <span class="alternate choice6" title="alternate">
                    <xsl:if test="@xml:id">
                        <xsl:attribute name="id" select="@xml:id"/>
                    </xsl:if>
                    <xsl:apply-templates select="tei:reg[1]"/>
                    <span class="hidden altcontent ">
                        <xsl:if test="@xml:id">
                            <xsl:attribute name="id" select="@xml:id"/>
                        </xsl:if>
                        <xsl:apply-templates select="tei:orig[1]"/>
                    </span>
                </span>
            </xsl:when>
        </xsl:choose>
    </xsl:template>
    <!-- Bücher -->
    <!--<xsl:template match="tei:bibl">
        <xsl:element name="span">
            <xsl:apply-templates/>
        </xsl:element>
    </xsl:template>--><!-- Seitenzahlen -->
    <xsl:template match="tei:pb">
        <xsl:choose>        
            <xsl:when test="ancestor::tei:table">
                <xsl:variable name="colno" select="count(ancestor::tei:table/tei:row[1]/tei:cell)"/>
                <xsl:element name="tr">
                    <xsl:element name="td">
                        <xsl:attribute name="style">text-align:right;font-size:12px;</xsl:attribute>
                        <xsl:attribute name="colspan">
                            <xsl:value-of select="$colno"/>
                        </xsl:attribute>
                    <xsl:text>[Bl. </xsl:text>
                    <xsl:value-of select="@n"/>
                    <xsl:text>]</xsl:text>
                </xsl:element>
                </xsl:element>
            </xsl:when>
            <xsl:otherwise>
                <xsl:element name="span">
                    <xsl:attribute name="class">
                    <xsl:text>hr</xsl:text>
                    </xsl:attribute>
                    <xsl:text>[Bl. </xsl:text>
                    <xsl:value-of select="@n"/>
                    <xsl:text>]</xsl:text>
                </xsl:element>
            </xsl:otherwise>
        </xsl:choose>    
    </xsl:template><!-- Tabellen -->
    <xsl:template match="tei:table">
        <xsl:element name="table">
            <xsl:attribute name="class">
                <xsl:choose>
                    <xsl:when test="@rend='rules' and not(parent::tei:signed)">
                        <xsl:text>table table-bordered table-condensed table-hover</xsl:text>
                    </xsl:when>
                    <xsl:when test="parent::tei:signed">
                        <xsl:text>table table-borderless</xsl:text>
                    </xsl:when>
                    <xsl:otherwise>
                        <xsl:text>table table-striped table-condensed table-hover</xsl:text>                        
                    </xsl:otherwise>
                </xsl:choose>
            </xsl:attribute>
            <xsl:element name="tbody">
                <xsl:apply-templates/>
            </xsl:element>
        </xsl:element>
    </xsl:template>
    <xsl:template match="tei:row">
        <xsl:element name="tr">
            <xsl:apply-templates/>
        </xsl:element>
    </xsl:template>
    <xsl:template match="tei:cell">
        <xsl:element name="td">
            <xsl:if test="./@rendition='#u'">
                <xsl:attribute name="style">border-bottom: 1px solid black</xsl:attribute>
                <xsl:attribute name="class">underline</xsl:attribute>
            </xsl:if>
            <xsl:if test="contains(descendant::*/@rend,'#r')">
                <xsl:attribute name="style">text-align:right</xsl:attribute>
            </xsl:if>
            <xsl:if test="./@cols">
                <xsl:attribute name="colspan">
                    <xsl:value-of select="./@cols"/>
                </xsl:attribute>
                <xsl:if test="number(@cols) gt 2">
                    <xsl:attribute name="style">text-align:center</xsl:attribute>
                </xsl:if>
            </xsl:if>
            <xsl:if test="./@rows">
                <xsl:attribute name="rowspan">
                    <xsl:value-of select="./@rows"/>
                </xsl:attribute>
                <xsl:attribute name="style">vertical-align:middle</xsl:attribute>
            </xsl:if>
            <xsl:if test="not(string(number(.))='NaN') or .='-'">
                <xsl:attribute name="style">text-align:right</xsl:attribute>
            </xsl:if>
            <xsl:apply-templates/>
        </xsl:element>
    </xsl:template><!-- Überschriften -->
    <xsl:template match="tei:title">
        <xsl:if test="@xml:id[starts-with(.,'org') or starts-with(.,'ue')]">
            <a>
                <xsl:attribute name="name">
                    <xsl:value-of select="@xml:id"/>
                </xsl:attribute>
                <xsl:text> </xsl:text>
            </a>
        </xsl:if>
        <a>
            <xsl:attribute name="name">
                <xsl:text>hd</xsl:text>
                <xsl:number level="any"/>
            </xsl:attribute>
            <xsl:text> </xsl:text>
        </a>
        <xsl:choose>
            <xsl:when test="@type='sub' or 'desc'">
                <h4>
                    <xsl:apply-templates/>
                </h4>
            </xsl:when>
            <xsl:otherwise>
                <h5>
                    <div>
                        <xsl:apply-templates/>
                    </div>
                </h5>
            </xsl:otherwise>
        </xsl:choose>
    </xsl:template><!--  Quotes / Zitate -->
    <xsl:template match="tei:q">
        <xsl:text>„</xsl:text>
        <xsl:apply-templates/>
        <xsl:text>“</xsl:text>
    </xsl:template><!-- Zeilenumbrüche -->
    <xsl:template match="tei:lb">
        <xsl:choose>
            <xsl:when test="ancestor::tei:note"><!-- fixing line length in @title tooltips -->
                <xsl:text>

</xsl:text>
            </xsl:when>
            <xsl:otherwise>
                <xsl:text> </xsl:text>
                <br/>
            </xsl:otherwise>
        </xsl:choose>
    </xsl:template><!-- Absätze -->
    <xsl:template match="tei:p">
        <xsl:element name="p">
            <xsl:attribute name="id"><xsl:value-of select="local:makeId(.)"/></xsl:attribute>
            <xsl:attribute name="class">yes-index</xsl:attribute>
            <xsl:if test="ancestor::tei:text">
                <xsl:attribute name="class">ed yes-index</xsl:attribute>
            </xsl:if>
            <xsl:if test="./@rendition='#r'">
                <xsl:attribute name="style">
                    <xsl:text>text-align:right; margin-right:3rem;</xsl:text>
                </xsl:attribute>
            </xsl:if>
            <xsl:if test="./@rendition='#et'">
                <xsl:attribute name="style">
                    <xsl:text>margin-left:2rem; text-indent:0rem</xsl:text>
                </xsl:attribute>
            </xsl:if>
            <xsl:apply-templates/>
        </xsl:element>
    </xsl:template>
    <xsl:template match="tei:metamark"><!-- Metamarks -->
        <xsl:apply-templates/>
        <xsl:if test="position() != last() and parent::tei:div and not(following-sibling::tei:metamark)">
            <br/>
        </xsl:if>
        <xsl:if test="position() != last() and parent::tei:div and following-sibling::tei:metamark">
            <span style="margin-left:8rem;"/>
        </xsl:if>
        <xsl:if test="position()"/>
    </xsl:template><!-- Substitutions -->
    <xsl:template match="tei:subst">
        <xsl:apply-templates/>
    </xsl:template><!-- Durchstreichungen -->
    <xsl:template match="tei:del">
        <xsl:element name="del">
            <xsl:if test="@rendition[not(contains(.,' '))]">
                <xsl:variable name="style" select="substring-after(@rendition, '#')"/>
                <xsl:attribute name="style">
                    <xsl:value-of select="root()//tei:rendition[@xml:id=current()/$style]"/>
                </xsl:attribute>
            </xsl:if>
            <xsl:apply-templates/>
            <xsl:text> </xsl:text>
        </xsl:element>
    </xsl:template>
    <xsl:function name="local:fetch-delSpan" as="element(tei:delSpan)?">
    <xsl:param name="n" as="node()"/>
    <!-- del will be the most recent delSpan milestone -->
    <xsl:variable name="del" select="$n/preceding::tei:delSpan[1]"/>
    <!-- $del/id(@spanTo) will be its end anchor -->
    <!-- return $del if its end anchor appears after the argument node -->
    <xsl:sequence select="$del[id(@spanTo) &gt;&gt; $n]"/>
    </xsl:function> 
    <xsl:template match="text()[exists(local:fetch-delSpan(.))]">
        <del>
            <xsl:next-match/>
        </del>
    </xsl:template> 
    <xsl:template match="tei:country">
        <span>
<!--            <xsl:attribute name="style">color:purple</xsl:attribute>-->
            <xsl:attribute name="title">//country</xsl:attribute>
                <xsl:apply-templates/>
        </span>
    </xsl:template>
    <xsl:template match="tei:label">
        <xsl:variable name="handId" select="substring-after(./@hand, '#')"/>
        <xsl:element name="p">
            <xsl:attribute name="class">ed</xsl:attribute>
            <xsl:attribute name="style">margin-left:-1em</xsl:attribute>
            <xsl:attribute name="title">Marginalie
                <xsl:if test="$handId">
                    Hand: <xsl:value-of select="normalize-space(root()//tei:handNote[@xml:id=$handId])"/>
                </xsl:if>
            </xsl:attribute>
            <xsl:apply-templates/>
        </xsl:element>
    </xsl:template>
    <xsl:template match="tei:g">
        <xsl:variable name="glyphId" select="@ref"/>
        <xsl:element name="img">
            <xsl:attribute name="src">
                <xsl:value-of select="root()//tei:charDecl/tei:glyph[$glyphId]/tei:graphic/@url"/>
            </xsl:attribute>
            <xsl:attribute name="title">
                <xsl:value-of select="root()//tei:charDecl/tei:glyph[$glyphId]/tei:desc"/>
            </xsl:attribute>
            <xsl:attribute name="style">width:4em;margin-left:3em;</xsl:attribute>
        </xsl:element>
        <xsl:apply-templates/>
    </xsl:template>
    <xsl:template match="tei:glyph">
        <xsl:variable name="glyphId" select="@ref"/>
        <xsl:element name="img">
            <xsl:attribute name="src">
                <xsl:value-of select="root()//tei:charDecl/tei:glyph[$glyphId]/tei:graphic/@url"/>
            </xsl:attribute>
            <xsl:attribute name="title">
                <xsl:value-of select="root()//tei:charDecl/tei:glyph[$glyphId]/tei:desc"/>
            </xsl:attribute>
            <xsl:attribute name="style">width:4em;margin-left:3em;</xsl:attribute>
        </xsl:element>
        <xsl:apply-templates/>
    </xsl:template>
    <xsl:template match="tei:unclear">
        <xsl:element name="span">
            <xsl:attribute name="title">unsichere Lesung</xsl:attribute>
            <xsl:apply-templates/>
            <xsl:text> [?] </xsl:text>
        </xsl:element>
    </xsl:template>
    <xsl:template match="tei:gap">
        <xsl:element name="span">
        <xsl:choose>
            <xsl:when test="@ana">
                <xsl:attribute name="title">
                    <xsl:value-of select="@ana"/>
                </xsl:attribute>
                <xsl:text> </xsl:text>
                <xsl:apply-templates/>
            </xsl:when>
            <xsl:otherwise>
                    <xsl:attribute name="title">Textlücke
                        <xsl:if test="@extent">
                            <xsl:text> (</xsl:text>
                            <xsl:value-of select="@extent"/>
                            <xsl:if test="@reason">
                                <xsl:text> </xsl:text>
                                <xsl:value-of select="@reason"/>
                            </xsl:if>
                            <xsl:text>)</xsl:text>
                        </xsl:if>
                    </xsl:attribute>
                    <xsl:attribute name="style">font-size:x-small;vertical-align:super;</xsl:attribute>
                    <xsl:text> [Lücke</xsl:text>
                    <xsl:apply-templates/>
                    <xsl:text>] </xsl:text>
            </xsl:otherwise>
        </xsl:choose>
        </xsl:element>
    </xsl:template>
    <xsl:template match="//tei:notesStmt/tei:note">
        <xsl:element name="p">
            <xsl:apply-templates/>
        </xsl:element>
    </xsl:template>
    <xsl:template match="//tei:seg">
        <xsl:apply-templates/>
    </xsl:template>
    <xsl:template match="tei:signed">
        <xsl:variable name="handId" select="substring-after(@hand, '#')"/>
        <xsl:variable name="msId" select="substring-after(parent::tei:div/@decls, '#')"/>
        <xsl:variable name="divtype" select="root()//tei:msDesc[@xml:id=$msId]/@type"/>
        <xsl:choose>
            <xsl:when test="not(contains($divtype,'riginal'))">
                <p class="signed" style="font-size:small">[Unterschriften nicht originalschriftlich: <xsl:value-of select="$divtype"/>]</p>
            </xsl:when>
        </xsl:choose>
        <xsl:choose>
            <xsl:when test="./tei:list">
            <xsl:for-each select="./tei:list/tei:item">
                <xsl:element name="p">
                <xsl:attribute name="class">
                    <xsl:text>signed</xsl:text>
                </xsl:attribute>
                <xsl:attribute name="title">
                    <xsl:text>Hand von </xsl:text>
                    <xsl:value-of select="root()//tei:handNote[@xml:id=$handId]"/>
                    <xsl:text> (</xsl:text>
                    <xsl:value-of select="./@hand"/>
                    <xsl:text>)</xsl:text>
                </xsl:attribute>
                <xsl:apply-templates/>
                </xsl:element>
            </xsl:for-each>
            </xsl:when>
            <xsl:otherwise>
                <xsl:for-each select=".">
                    <xsl:element name="p">
                        <xsl:attribute name="class">
                            <xsl:text>signed</xsl:text>
                        </xsl:attribute>
                        <xsl:attribute name="title">
                            <xsl:text>Hand von </xsl:text>
                            <xsl:value-of select="root()//tei:handNote[@xml:id=$handId]"/>
                            <xsl:text> (</xsl:text>
                            <xsl:value-of select="./@hand"/>
                            <xsl:text>)</xsl:text>
                        </xsl:attribute>
                        <xsl:apply-templates/>
                    </xsl:element>
                </xsl:for-each>
            </xsl:otherwise>
        </xsl:choose>
    </xsl:template>
    
</xsl:stylesheet>
