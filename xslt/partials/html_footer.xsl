<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet 
    xmlns="http://www.w3.org/1999/xhtml"
    xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:xs="http://www.w3.org/2001/XMLSchema"
    exclude-result-prefixes="#all"
    version="2.0">
    <xsl:template match="/" name="html_footer">
        <footer class="footer mt-auto py-3 bg-body-tertiary">
            
                <div class="row">
                    <div class="row text-center">
                        <div class="col-lg-1 col-md-2 col-sm-2 col-xs-6 col-3">
                            <a href="https://www.oeaw.ac.at/ihb/" class="navlink" target="_blank">
                                <img src="images/inzlogo_1.png" alt="INZ"/>
                            </a>
                        </div>
                        <div class="col-lg-1 col-md-2 col-sm-2 col-xs-6 col-3">
                            <a href="https://www.oeaw.ac.at/acdh/" class="navlink" target="_blank">
                                <img src="images/logo.png" alt="ACDH" width="40%"/>
                            </a>
                        </div>
                        <div class="col-lg-1 col-md-2 col-sm-2 col-xs-6 col-3">
                            <a href="https://www.fwf.ac.at/de/" class="navlink" target="_blank">
                                <img src="images/fwf-logo_vektor_var2-01.svg" alt="FWF" width="85%"/>
                            </a><br/>
                            <a href="https://pf.fwf.ac.at/de/wissenschaft-konkret/project-finder?search%5Bproject_number%5D=P+28448" target="_blank" style="display:block;align:left;margin-top:3px">P-28448</a>
                        </div>
                        <div class="col-lg-1 col-md-2 col-sm-2 col-xs-6 col-3">
                            <a href="imprint.html" class="navlink text-right" target="_blank">
                                Impressum/Datenschutz
                            </a>
                        </div>
                        <div class="float-end me-3">
                            <a href="{$github_url}"><i class="bi bi-github"></i></a>
                        </div>
                    </div>
                </div>
        </footer>
        <script src="https://code.jquery.com/jquery-3.6.3.min.js" integrity="sha256-pvPw+upLPUjgMXY0G+8O0xUf+/Im1MZjXxxgOcBQBXU=" crossorigin="anonymous"></script>
        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js" integrity="sha384-C6RzsynM9kWDrMNeT87bh95OGNyZPhcTNXj1NW7RuBCsyN/o0jlpcV8Qyq46cDfL" crossorigin="anonymous"></script>
        
        
    </xsl:template>
</xsl:stylesheet>