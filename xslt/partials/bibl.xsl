<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:xs="http://www.w3.org/2001/XMLSchema" 
    xmlns:tei="http://www.tei-c.org/ns/1.0" 
    xmlns="http://www.w3.org/1999/xhtml"
    version="2.0" exclude-result-prefixes="xsl tei xs">
    
    <xsl:template match="tei:witness" name="witness_detail">
        <p id="{@xml:id}">
            <xsl:apply-templates select="node()[not(ancestor-or-self::tei:noteGrp)]"/>
            <xsl:if test=".//tei:note[@type='mentions']">
            <span style="d-block">Erwähnt in:</span>
                <ul>
                    <xsl:for-each select=".//tei:note[@type='mentions']">
                        <li>
                            <a href="{replace(./@target, '.xml', '.html')}">
                                <xsl:value-of select="./text()"/>
                            </a>
                        </li>
                    </xsl:for-each>
                </ul>
            </xsl:if>
        </p>
    </xsl:template>
    <xsl:template match="tei:bibl" name="bibl_detail">
        <span style="d-block" id="{@xml:id}">
            <xsl:apply-templates select="node()[not(ancestor-or-self::tei:noteGrp)]"/>
                <xsl:if test=".//tei:note[@type='mentions']">
                <span style="d-block">Erwähnt in:</span>
                    <ul>
                        <xsl:for-each select=".//tei:note[@type='mentions']">
                            <li>
                                <a href="{replace(./@target, '.xml', '.html')}">
                                    <xsl:value-of select="./text()"/>
                                </a>
                            </li>
                        </xsl:for-each>
                    </ul>
                </xsl:if>
            </span>
    </xsl:template>
    <xsl:template match="tei:p">
        <p><xsl:apply-templates/></p>
    </xsl:template>
    
</xsl:stylesheet>
