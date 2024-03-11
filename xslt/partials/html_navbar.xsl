<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns="http://www.w3.org/1999/xhtml"
    xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:tei="http://www.tei-c.org/ns/1.0"
    xmlns:xs="http://www.w3.org/2001/XMLSchema" exclude-result-prefixes="#all" version="2.0">
    <xsl:template match="/" name="nav_bar">
        <header>
            <nav class="navbar navbar-expand-lg bg-body-tertiary">
                <div class="container-fluid">
                    <a class="navbar-brand" href="index.html">
                        <xsl:value-of select="$project_short_title"/>
                    </a>
                    <button class="navbar-toggler" type="button" data-bs-toggle="collapse" data-bs-target="#navbarSupportedContent" aria-controls="navbarSupportedContent" aria-expanded="false" aria-label="Toggle navigation">
                        <span class="navbar-toggler-icon"></span>
                    </button>
                    <div class="collapse navbar-collapse" id="navbarSupportedContent">
                        <ul class="navbar-nav me-auto mb-2 mb-lg-0">
                            <li class="nav-item dropdown">
                                <a class="nav-link dropdown-toggle" href="#" role="button" data-bs-toggle="dropdown" aria-expanded="false">Projekt</a>
                            <ul class="dropdown-menu">
                                    <li>
                                        <a class="dropdown-item" href="about.html">Home</a>
                                    </li>
                                    <li>
                                        <a class="dropdown-item" href="imprint.html">Impressum</a>
                                    </li>
                                </ul>
                        	</li>
                        <li class="dropdown" id="toc">
                            <a href="#" class="dropdown-toggle" data-toggle="dropdown">Inhaltsverzeichnis</a>
                            <ul class="dropdown-menu">
                                <li>
                                    <a href="../pages/show.html?document=Einleitung.xml&amp;directory=meta">Einleitung</a>
                                </li>
                                <li class="dropdown-submenu">
                                    <a href="toc.html?collection=editions">Dokumente</a>
                                    <ul class="dropdown-menu">
                                        <li>
                                        <a href="toc.html?filterstring=A">Kongress von Aachen 1818</a>
                                    </li>
                                <li>
                                        <a href="toc.html?filterstring=T">Kongress von Troppau/Opava 1820</a>
                                    </li>
                                <li>
                                        <a href="toc.html?filterstring=L">Kongress von Laibach/Ljubljana 1821</a>
                                    </li>
                                <li>
                                        <a href="toc.html?filterstring=V">Kongress von Verona 1822</a>
                                    </li>
                                    </ul>
                                </li>
                                <li class="dropdown-submenu">
                                    <a href="toc.html?collection=meta">Bestandsbeschreibungen</a>
                                    <ul class="dropdown-menu">
                                        <li>
                                            <a href="../pages/show.html?document=BestandsbeschreibungAachen.xml&amp;directory=meta">Kongress von Aachen 1818</a>
                                        </li>
                                        <li>
                                            <a href="../pages/show.html?document=BestandsbeschreibungTroppau.xml&amp;directory=meta">Kongress von Troppau/Opava 1820</a>
                                        </li>
                                        <li>
                                            <a href="../pages/show.html?document=BestandsbeschreibungLaibach.xml&amp;directory=meta">Kongress von Laibach/Ljubljana 1821</a>
                                        </li>
                                        <li>
                                            <a href="../pages/show.html?document=BestandsbeschreibungVerona.xml&amp;directory=meta">Kongress von Verona 1822</a>
                                        </li>
                                    </ul>
                                </li>
                                <li class="dropdown-submenu">
                                    <a href="../pages/regesten.html">Regesten</a>
                                    <ul class="dropdown-menu">
                                        <li>
                                            <a href="../pages/regesten.html?collection=editions&amp;filterstring=A">Kongress von Aachen 1818</a>
                                        </li>
                                        <li>
                                            <a href="../pages/regesten.html?collection=editions&amp;filterstring=T">Kongress von Troppau/Opava 1820</a>
                                        </li>
                                        <li>
                                            <a href="../pages/regesten.html?collection=editions&amp;filterstring=L">Kongress von Laibach/Ljubljana 1821</a>
                                        </li>
                                        <li>
                                            <a href="../pages/regesten.html?collection=editions&amp;filterstring=V">Kongress von Verona 1822</a>
                                        </li>
                                    </ul>
                                </li>
                                <li class="dropdown-submenu">
                                    <a href="toc.html?collection=meta">Über die Edition</a>
                                    <ul class="dropdown-menu">
                                        <li>
                                            <a href="../pages/show.html?document=Einleitung.xml&amp;directory=meta">Einleitung</a>
                                        </li>
                                        <li>
                                            <a href="../pages/show.html?document=Einleitung_kurz.xml&amp;directory=meta">Kurzeinleitung</a>
                                        </li>
                                        <li>
                                            <a href="../pages/show.html?document=Editionsrichtlinien.xml&amp;directory=meta">Editionsrichtlinien</a>
                                        </li>
                                        <li>
                                            <a href="../pages/show.html?document=about.xml&amp;directory=meta">Zur technischen Umsetzung</a>
                                        </li>
                                        <li>
                                            <a href="../pages/show.html?document=Danksagung.xml&amp;directory=meta">Danksagung</a>
                                        </li>
                                    </ul>
                                </li>
                                <li>
                                    <a href="../pages/index.html#mapped">Überblickskarte</a>
                                </li>
                            </ul>
                        </li>
                        <li class="nav-item dropdown disabled">
                                <a class="nav-link dropdown-toggle" href="#" role="button" data-bs-toggle="dropdown" aria-expanded="false">Register</a>
                                <ul class="dropdown-menu">
                                    <li>
                                        <a class="dropdown-item" href="listperson.html">Personen</a>
                                    </li>
                                    <li>
                                        <a class="dropdown-item" href="listplace.html">Orte</a>
                                    </li>
                                    <li>
                                        <a class="dropdown-item" href="listorg.html">Organisationen</a>
                                    </li>
                                    <li>
                                        <a class="dropdown-item" href="listbibl.html">Werke</a>
                                    </li>
                                </ul>
                            </li>

                            <li class="nav-item">
                                <a title="Suche" class="nav-link" href="search.html">Suche</a>
                            </li>
                    </ul>
                </div>
                </div>
            </nav>
            
        </header>
    </xsl:template>
</xsl:stylesheet>