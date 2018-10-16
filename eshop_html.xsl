<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:xs="http://www.w3.org/2001/XMLSchema" xmlns:ph="https://petrhovorka.com/smartelefon"
    exclude-result-prefixes="xs ph" version="3.0">

    <xsl:output name="html" encoding="UTF-8" method="html"/>
    <xsl:output method="html" encoding="UTF-8"/>
    
    <xsl:decimal-format decimal-separator=","
        grouping-separator=" "/>
    <xsl:template name="zahlavi">
        <div id="zahlavi">
            <h1>SmarTelefon</h1>
        </div>
    </xsl:template>
    <xsl:template name="zapati">
        <div id="zapati">
            <p><xsl:text>&#9400; </xsl:text><xsl:value-of select="year-from-date(current-date())"/><xsl:text> SmarTelefon</xsl:text></p>
        </div>
    </xsl:template>
    <xsl:template match="/">
        <xsl:text disable-output-escaping="yes">&lt;!DOCTYPE html&gt;</xsl:text>
        <html lang="cs" xml:lang="cs">
            <head>
                <title>SmarTelefon</title>
                <meta http-equiv="Content-Type" content="text/html; charset=utf-8"/>
                <link rel="stylesheet" type="text/css" href="styl.css"/> 
                <meta name="viewport" content="width=device-width, initial-scale=1.0" />
            </head>
            <body>
                <xsl:apply-templates/>
            </body>
        </html>
    </xsl:template>
    <xsl:template match="ph:polozky">
        <xsl:call-template name="zahlavi"/>
        <div id="hlavniStranka">
            <xsl:for-each-group select="ph:polozka/ph:parametry/ph:system/ph:nazev" group-by=".">
                <xsl:sort select="upper-case(current-grouping-key())"></xsl:sort>
                <h2><xsl:text>Telefony se systémem </xsl:text><xsl:value-of select="."/><xsl:text> (</xsl:text><xsl:value-of select="count(current-group())"/><xsl:text>)</xsl:text></h2>
                <div class="polozkyGrid">
                    <xsl:for-each select="current-group()/../../..">
                        <xsl:sort select="ph:cena[@typ='aktualni'][@mena='CZK']" data-type="number" order="ascending"/>
                <div class="polozka">
                    <div class="vrsek">
                        <div class="nazev">                    
                            <a href="{generate-id(ph:produktoveCislo)}.html"><xsl:value-of select="ph:vyrobce"/>
                                <xsl:text> </xsl:text>
                                <xsl:value-of select="ph:model"/>
                            </a>
                        </div>
                        <div class="parametry">
                            <xsl:text>Mobilní telefon </xsl:text>
                            <xsl:value-of select="ph:parametry/ph:displej/ph:velikost"/>
                            <xsl:value-of select="ph:parametry/ph:displej/ph:velikost/@jednotka"/>
                            <xsl:text> </xsl:text>
                            <xsl:value-of select="ph:parametry/ph:displej/ph:rozliseni"/>
                            <xsl:text>, procesor </xsl:text>
                            <xsl:value-of select="ph:parametry/ph:cpu/ph:nazev"/>
                            <xsl:text>, RAM </xsl:text>
                            <xsl:value-of select="ph:parametry/ph:ram"/>
                            <xsl:value-of select="ph:parametry/ph:ram/@jednotka"/>
                            <xsl:text>, interní paměť </xsl:text>
                            <xsl:value-of select="ph:parametry/ph:interniUloziste"/>
                            <xsl:value-of select="ph:parametry/ph:interniUloziste/@jednotka"/>
                            <xsl:if test="ph:parametry/ph:externiUloziste">
                                <xsl:text>, </xsl:text>
                                <xsl:value-of select="ph:parametry/ph:externiUloziste"/>
                            </xsl:if>
                            <xsl:text>, fotoaparát zadní </xsl:text>
                            <xsl:value-of select="ph:parametry/ph:fotoaparat[@typ='zadni']/ph:rozliseni"/>
                            <xsl:text> (</xsl:text>
                            <xsl:value-of select="ph:parametry/ph:fotoaparat[@typ='zadni']/ph:svetelnost"/>
                            <xsl:text>)</xsl:text>
                            <xsl:text> + přední </xsl:text>
                            <xsl:value-of select="ph:parametry/ph:fotoaparat[@typ='predni']/ph:rozliseni"/>
                            <xsl:if test="ph:parametry/ph:sim/ph:pocet = 2">
                                <xsl:text>, </xsl:text>
                                <xsl:text>Dual SIM</xsl:text>
                            </xsl:if>
                            <xsl:if test="ph:parametry/ph:konektivita/ph:lte = 'ano'">
                                <xsl:text>, </xsl:text>
                                <xsl:text>LTE</xsl:text>
                            </xsl:if>
                            <xsl:if test="ph:parametry/ph:konektivita/ph:nfc = 'ano'">
                                <xsl:text>, </xsl:text>
                                <xsl:text>NFC</xsl:text>
                            </xsl:if>
                            <xsl:text>, baterie </xsl:text>
                            <xsl:value-of select="ph:parametry/ph:baterie/ph:kapacita"/>
                            <xsl:value-of select="ph:parametry/ph:baterie/ph:kapacita/@jednotka"/>
                            <xsl:text>, </xsl:text>
                            <xsl:value-of select="ph:parametry/ph:system/ph:nazev"/>
                            <xsl:text> </xsl:text>
                            <xsl:value-of select="ph:parametry/ph:system/ph:verze"/>
                        </div>
                    </div>
                    <div class="spodek">
                        <a href="{generate-id(ph:produktoveCislo)}.html">
                        <img>
                            <xsl:attribute name="src">
                                <xsl:text>img/</xsl:text>
                                <xsl:value-of select="ph:obrazek"/>
                            </xsl:attribute>
                            <xsl:attribute name="alt">
                                    <xsl:value-of select="ph:vyrobce"/>
                                    <xsl:text> </xsl:text>
                                    <xsl:value-of select="ph:model"/>
                            </xsl:attribute>
                        </img>
                         </a>
                        <div class="cenaPuvodni">
                            <div class="levy"><xsl:value-of select="format-number(ph:cena[@typ='puvodni'][@mena='CZK'], '### ###')"/><xsl:text>,-</xsl:text></div>
                            <div class="pravy"><xsl:text>-</xsl:text><xsl:value-of select="format-number((1-(ph:cena[@typ='aktualni'][@mena='CZK'])div(ph:cena[@typ='puvodni'][@mena='CZK'])), '##%')"/></div>
                        </div>
                            
                        
                        <div class="cenaAktualni"><xsl:value-of select="format-number(ph:cena[@typ='aktualni'][@mena='CZK'], '### ###')"/><xsl:text>,-</xsl:text></div>
                        <div class="cenaBezDPH"><xsl:text>bez DPH </xsl:text><xsl:value-of select="format-number(round((ph:cena[@typ='aktualni'][@mena='CZK'])div(1+(./../../ph:dph))), '### ###')"/><xsl:text>,-</xsl:text></div>
                        <div class="dostupnost">
                            <xsl:if test="sum(ph:dostupnost/ph:sklad)=0"><span class="neniSkladem"><xsl:text>Není skladem</xsl:text></span></xsl:if>
                            <xsl:if test="sum(ph:dostupnost/ph:sklad)!=0"><span class="skladem"><xsl:text>Skladem </xsl:text><xsl:value-of select="sum(ph:dostupnost/ph:sklad)"/><xsl:text> ks</xsl:text></span></xsl:if>
                        </div>
                    </div>
                </div>
                </xsl:for-each>
                </div>
            </xsl:for-each-group>
        
       
        </div>
        <xsl:call-template name="zapati"/>
        <xsl:apply-templates select="ph:polozka/ph:produktoveCislo"/>
    </xsl:template>

   
    <xsl:template match="ph:polozka/ph:produktoveCislo">
        <xsl:result-document href="{generate-id(.)}.html" format="html" encoding="UTF-8">
            <xsl:text disable-output-escaping="yes">&lt;!DOCTYPE html&gt;</xsl:text>
            <html lang="cs" xml:lang="cs">
                <head>
                    <title><xsl:value-of select="../ph:vyrobce"/><xsl:text> </xsl:text><xsl:value-of select="../ph:model"/><xsl:text> – </xsl:text>SmarTelefon</title>
                    <meta http-equiv="Content-Type" content="text/html; charset=utf-8"/>
                    <link rel="stylesheet" type="text/css" href="styl.css"/> 
                    <meta name="viewport" content="width=device-width, initial-scale=1.0" />
                </head>
                <body>
                    <xsl:call-template name="zahlavi"/>
                    <div id="detailProduktu">
                    <div id="detailVrchni">
                    <div class="levy">
                        <img>
                            <xsl:attribute name="src">
                                <xsl:text>img/</xsl:text>
                                <xsl:value-of select="../ph:obrazek"/>
                            </xsl:attribute>
                            <xsl:attribute name="alt">
                                <xsl:value-of select="../ph:vyrobce"/>
                                <xsl:text> </xsl:text>
                                <xsl:value-of select="../ph:model"/>
                            </xsl:attribute>
                        </img>
                    </div>
                    <div class="pravy">
                        <h2><xsl:value-of select="../ph:vyrobce"/><xsl:text> </xsl:text><xsl:value-of select="../ph:model"/></h2>
                        <div class="parametry">
                            <xsl:text>Mobilní telefon </xsl:text>
                            <xsl:value-of select="../ph:parametry/ph:displej/ph:velikost"/>
                            <xsl:value-of select="../ph:parametry/ph:displej/ph:velikost/@jednotka"/>
                            <xsl:text> </xsl:text>
                            <xsl:value-of select="../ph:parametry/ph:displej/ph:rozliseni"/>
                            <xsl:text>, procesor </xsl:text>
                            <xsl:value-of select="../ph:parametry/ph:cpu/ph:nazev"/>
                            <xsl:text>, RAM </xsl:text>
                            <xsl:value-of select="../ph:parametry/ph:ram"/>
                            <xsl:value-of select="../ph:parametry/ph:ram/@jednotka"/>
                            <xsl:text>, interní paměť </xsl:text>
                            <xsl:value-of select="../ph:parametry/ph:interniUloziste"/>
                            <xsl:value-of select="../ph:parametry/ph:interniUloziste/@jednotka"/>
                            <xsl:if test="../ph:parametry/ph:externiUloziste">
                                <xsl:text>, </xsl:text>
                                <xsl:value-of select="../ph:parametry/ph:externiUloziste"/>
                            </xsl:if>
                            <xsl:text>, fotoaparát zadní </xsl:text>
                            <xsl:value-of select="../ph:parametry/ph:fotoaparat[@typ='zadni']/ph:rozliseni"/>
                            <xsl:text> (</xsl:text>
                            <xsl:value-of select="../ph:parametry/ph:fotoaparat[@typ='zadni']/ph:svetelnost"/>
                            <xsl:text>)</xsl:text>
                            <xsl:text> + přední </xsl:text>
                            <xsl:value-of select="../ph:parametry/ph:fotoaparat[@typ='predni']/ph:rozliseni"/>
                            <xsl:if test="../ph:parametry/ph:sim/ph:pocet = 2">
                                <xsl:text>, </xsl:text>
                                <xsl:text>Dual SIM</xsl:text>
                            </xsl:if>
                            <xsl:if test="../ph:parametry/ph:konektivita/ph:lte = 'ano'">
                                <xsl:text>, </xsl:text>
                                <xsl:text>LTE</xsl:text>
                            </xsl:if>
                            <xsl:if test="../ph:parametry/ph:konektivita/ph:nfc = 'ano'">
                                <xsl:text>, </xsl:text>
                                <xsl:text>NFC</xsl:text>
                            </xsl:if>
                            <xsl:text>, baterie </xsl:text>
                            <xsl:value-of select="../ph:parametry/ph:baterie/ph:kapacita"/>
                            <xsl:value-of select="../ph:parametry/ph:baterie/ph:kapacita/@jednotka"/>
                            <xsl:text>, </xsl:text>
                            <xsl:value-of select="../ph:parametry/ph:system/ph:nazev"/>
                            <xsl:text> </xsl:text>
                            <xsl:value-of select="../ph:parametry/ph:system/ph:verze"/>
                        </div>
                        <div class="viceInfo"><a href="#technickeParametry">Více informací &#x2C5;</a></div>
                        <div class="ceny">
                        <div class="cenaSDPH">
                            <div class="levy">
                                Cena s DPH
                            </div>
                                <div class="pravy">
                                 <xsl:value-of select="format-number(../ph:cena[@typ='aktualni'][@mena='CZK'], '### ###')"/><xsl:text>,–</xsl:text>
                                </div>
                            </div>
                       
                        <div class="cenaBezDPH">
                            <div class="levy">
                                Cena bez DPH
                            </div>
                                <div class="pravy">
                                    <xsl:value-of select="format-number(round(../ph:cena[@typ='aktualni'][@mena='CZK'])div(1+(./../../../ph:dph)), '### ###')"/><xsl:text>,–</xsl:text>
                                </div>
                            </div>
                        </div>
                        <div class="dostupnost">
                            <table>
                                <thead>
                                    <tr>
                                        <th colspan="2">
                                            <xsl:if test="sum(../ph:dostupnost/ph:sklad)=0"><xsl:text>Není skladem</xsl:text></xsl:if>
                                            <xsl:if test="sum(../ph:dostupnost/ph:sklad)!=0"><xsl:text>Skladem </xsl:text><xsl:value-of select="sum(../ph:dostupnost/ph:sklad)"/><xsl:text> ks</xsl:text></xsl:if>
                                        </th>
                                    </tr>
                                </thead>
                                <tbody>
                                    <xsl:if test="../ph:dostupnost/ph:sklad[@mesto='Praha']">
                                    <tr>
                                        <td>Sklad Praha</td>
                                        <td><xsl:value-of select="../ph:dostupnost/ph:sklad[@mesto='Praha']"/><xsl:text> ks</xsl:text></td>
                                    </tr>
                                    </xsl:if>
                                    <xsl:if test="../ph:dostupnost/ph:sklad[@mesto='Brno']">
                                    <tr>
                                        <td>Sklad Brno</td>
                                        <td><xsl:value-of select="../ph:dostupnost/ph:sklad[@mesto='Brno']"/><xsl:text> ks</xsl:text></td>
                                    </tr>
                                    </xsl:if>
                                    <xsl:if test="../ph:dostupnost/ph:sklad[@mesto='Ostrava']">
                                    <tr>
                                        <td>Sklad Ostrava</td>
                                        <td><xsl:value-of select="../ph:dostupnost/ph:sklad[@mesto='Ostrava']"/><xsl:text> ks</xsl:text></td>
                                    </tr>
                                    </xsl:if>
                                </tbody>
                            </table>
                        </div>
                        <div class="ostatni">
                            <div class="levy">
                                <xsl:text>Cena s DPH €</xsl:text><xsl:value-of select="format-number(../ph:cena[@typ='aktualni'][@mena='EUR'], '### ###')"/>
                            </div>
                            <div class="levy">
                                <xsl:text>Cena bez DPH €</xsl:text><xsl:value-of select="format-number(round(../ph:cena[@typ='aktualni'][@mena='EUR'])div(1+(./../../../ph:dph)), '### ###')"/>
                            </div>
                            <div class="levy">
                                <xsl:text>Produktové číslo: </xsl:text><xsl:value-of select="."/>
                            </div>
                        </div>
                    </div>
                    </div>
                    
                    <div id="detailSpodni">
                        <div class="popis">
                        <xsl:value-of select="../ph:popis"/>
                        </div>
                        <xsl:if test="../ph:video">
                            <div class="video">
                                <iframe>
                                    <xsl:attribute name="src">
                                        <xsl:text>https://www.youtube.com/embed/</xsl:text>
                                        <xsl:analyze-string select="../ph:video" regex="^.*(youtu.be/|v/|embed/|watch\?|youtube.com/user/[^#]*#([^/]*?/)*)\??v?=?([^#&amp;\?]*).*">
                                            <xsl:matching-substring>
                                                    <xsl:value-of select="regex-group(3)"/>
                                            </xsl:matching-substring>
                                            <xsl:non-matching-substring>
                                                <xsl:message>
                                                    <xsl:text>Chyba ve vstupních datech: </xsl:text>
                                                    <xsl:value-of select="."/>
                                                </xsl:message>
                                            </xsl:non-matching-substring>
                                        </xsl:analyze-string>
                                        <xsl:text>?rel=0&amp;showinfo=0</xsl:text>
                                    </xsl:attribute>
                                    <xsl:attribute name="allowfullscreen"/>
                                </iframe>
                            </div>
                        </xsl:if>
                        <div id="technickeParametry">
                            <h3>Technické parametry</h3>
                            <table id="technickeParametryTabulka">
                                <tbody>
                                <tr>
                                    <th colspan="2">Základní parametry</th>
                                </tr>
                                <tr>
                                    <td>Úhlopříčka displeje</td>
                                    <td><xsl:value-of select="../ph:parametry/ph:displej/ph:velikost"/>
                                        <xsl:value-of select="../ph:parametry/ph:displej/ph:velikost/@jednotka"/>
                                    </td>
                                </tr>
                                <tr>
                                    <td>Rozlišení displeje</td>
                                    <td><xsl:value-of select="../ph:parametry/ph:displej/ph:rozliseni"/></td>
                                </tr>
                                <tr>
                                    <td>Operační systém</td>
                                    <td><xsl:value-of select="../ph:parametry/ph:system/ph:nazev"/>
                                        <xsl:text> </xsl:text>
                                        <xsl:value-of select="../ph:parametry/ph:system/ph:verze"/>
                                    </td>
                                </tr>
                                    <tr>
                                        <td>Operační paměť</td>
                                        <td><xsl:value-of select="../ph:parametry/ph:ram"/>
                                            <xsl:text> </xsl:text>
                                            <xsl:value-of select="../ph:parametry/ph:ram/@jednotka"/>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td>Interní úložiště</td>
                                        <td><xsl:value-of select="../ph:parametry/ph:interniUloziste"/>
                                            <xsl:text> </xsl:text>
                                            <xsl:value-of select="../ph:parametry/ph:interniUloziste/@jednotka"/>
                                        </td>
                                    </tr>
                                    <xsl:if test="../ph:parametry/ph:externiUloziste">
                                        <tr>
                                            <td>Externí úložiště</td>
                                            <td><xsl:value-of select="../ph:parametry/ph:externiUloziste"/>
                                            </td>
                                        </tr>
                                    </xsl:if>
                                    <tr>
                                        <th colspan="2">Výkon a výdrž</th>
                                    </tr>
                                <tr>
                                    <td>Procesor</td>
                                    <td><xsl:value-of select="../ph:parametry/ph:cpu/ph:nazev"/></td>
                                </tr>
                                    <tr>
                                        <td>Počet jader procesoru</td>
                                        <td>
                                            <xsl:value-of select="../ph:parametry/ph:cpu/ph:pocetJader"/>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td>Frekvence procesoru</td>
                                        <td>
                                            <xsl:value-of select="../ph:parametry/ph:cpu/ph:frekvence"/>
                                            <xsl:text> </xsl:text>
                                            <xsl:value-of select="../ph:parametry/ph:cpu/ph:frekvence/@jednotka"/>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td>Kapacita baterie</td>
                                        <td>
                                            <xsl:value-of select="../ph:parametry/ph:baterie/ph:kapacita"/>
                                            <xsl:text> </xsl:text>
                                            <xsl:value-of select="../ph:parametry/ph:baterie/ph:kapacita/@jednotka"/>
                                        </td>
                                    </tr>
                                    <tr>
                                        <th colspan="2">Fotoaparáty</th>
                                    </tr>
                                    <tr>
                                        <td>Rozlišení zadního fotoaparátu</td>
                                        <td>
                                            <xsl:value-of select="../ph:parametry/ph:fotoaparat[@typ='zadni']/ph:rozliseni"/>
                                        </td>
                                    </tr>
                                    <xsl:if test="../ph:parametry/ph:fotoaparat[@typ='zadni']/ph:svetelnost">
                                    <tr>
                                        <td>Světelnost</td>
                                        <td>
                                            <xsl:value-of select="../ph:parametry/ph:fotoaparat[@typ='zadni']/ph:svetelnost"/>
                                        </td>
                                    </tr>
                                    </xsl:if>
                                    <xsl:if test="../ph:parametry/ph:fotoaparat[@typ='zadni']/ph:blesk">
                                    <tr>
                                        <td>Blesk</td>
                                        <td>
                                            <xsl:value-of select="../ph:parametry/ph:fotoaparat[@typ='zadni']/ph:blesk"/>
                                        </td>
                                    </tr>
                                    </xsl:if>
                                    <xsl:if test="../ph:parametry/ph:fotoaparat[@typ='zadni']/ph:stabilizace">
                                    <tr>
                                        <td>Optická stabilizace</td>
                                        <td>
                                            <xsl:value-of select="../ph:parametry/ph:fotoaparat[@typ='zadni']/ph:stabilizace"/>
                                        </td>
                                    </tr>
                                    </xsl:if>
                                    <tr>
                                        <td>Rozlišení předního fotoaparátu</td>
                                        <td>
                                            <xsl:value-of select="../ph:parametry/ph:fotoaparat[@typ='predni']/ph:rozliseni"/>
                                        </td>
                                    </tr>
                                    <tr>
                                        <th colspan="2">Komunikace</th>
                                    </tr>
                                    <tr>
                                        <td>Bezdrátové technologie</td>
                                        <td>
                                            <xsl:if test="../ph:parametry/ph:konektivita/ph:wifi = 'ano'"><xsl:text>WiFi</xsl:text><xsl:if test="(../ph:parametry/ph:konektivita/ph:lte='ano')||(../ph:parametry/ph:konektivita/ph:bluetooth='ano')||(../ph:parametry/ph:konektivita/ph:nfc='ano')"><xsl:text>, </xsl:text></xsl:if></xsl:if>
                                            <xsl:if test="../ph:parametry/ph:konektivita/ph:lte = 'ano'"><xsl:text>LTE</xsl:text><xsl:if test="(../ph:parametry/ph:konektivita/ph:bluetooth='ano')||(../ph:parametry/ph:konektivita/ph:nfc='ano')"><xsl:text>, </xsl:text></xsl:if></xsl:if>
                                            <xsl:if test="../ph:parametry/ph:konektivita/ph:bluetooth = 'ano'"><xsl:text>Bluetooth</xsl:text><xsl:if test="../ph:parametry/ph:konektivita/ph:nfc = 'ano'"><xsl:text>, </xsl:text></xsl:if></xsl:if>
                                            <xsl:if test="../ph:parametry/ph:konektivita/ph:nfc = 'ano'"><xsl:text>NFC</xsl:text></xsl:if>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td>SIM</td>
                                        <td>
                                            <xsl:value-of select="../ph:parametry/ph:sim/ph:pocet"/>
                                            <xsl:text>× </xsl:text>
                                            <xsl:value-of select="../ph:parametry/ph:sim/@typ"/>
                                            <xsl:text>SIM</xsl:text>
                                        </td>
                                    </tr>
                                    <tr>
                                        <th colspan="2">Ostatní</th>
                                    </tr>
                                    <tr>
                                        <td>Rozměry</td>
                                        <td>
                                            <xsl:value-of select="../ph:parametry/ph:rozmery/ph:s"/>
                                            <xsl:text>×</xsl:text>
                                            <xsl:value-of select="../ph:parametry/ph:rozmery/ph:v"/>
                                            <xsl:text>×</xsl:text>
                                            <xsl:value-of select="../ph:parametry/ph:rozmery/ph:h"/>
                                            <xsl:text> </xsl:text>
                                            <xsl:value-of select="../ph:parametry/ph:rozmery/@jednotka"/>
                                            <xsl:text> (Š×V×H)</xsl:text>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td>Dostupné barvy</td>
                                        <td>
                                            <xsl:value-of select="../ph:parametry/ph:barvy/ph:barva" separator=", " />
                                        </td>
                                    </tr>
                                    <tr>
                                        <td>Obsah balení</td>
                                        <td>
                                                <xsl:value-of select="../ph:parametry/ph:obsahBaleni/ph:polozka" separator=", " />
                                        </td>
                                    </tr>
                                </tbody>
                            </table>
                        </div>
                        </div>
                    </div>
                    <xsl:call-template name="zapati"/>
                </body>
            </html>
        </xsl:result-document>
    </xsl:template>

    <xsl:template match="ph:dph"/>
</xsl:stylesheet>
