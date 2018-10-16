<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:fo="http://www.w3.org/1999/XSL/Format" xmlns:ph="https://petrhovorka.com/smartelefon"
    version="3.0">

    <xsl:output method="xml" encoding="utf-8"/>
    <xsl:decimal-format decimal-separator="," grouping-separator=" "/>
    <xsl:variable name="paddingTabulka">2pt 7pt 1pt 7pt</xsl:variable>
    <xsl:template match="/">
        <fo:root>
            <fo:layout-master-set>
                <fo:simple-page-master margin-bottom="2cm" margin-left="2cm" margin-right="2cm"
                    margin-top="2cm" master-name="my-master">
                    <fo:region-body/>
                    <fo:region-before extent="-1cm"/>
                    <fo:region-after extent="0cm"/>
                </fo:simple-page-master>
            </fo:layout-master-set>
            <fo:page-sequence master-reference="my-master">
                <fo:static-content flow-name="xsl-region-before" font-family="Segoe UI" color="#333" font-size="9pt">
                    <fo:block text-align-last="justify">
                        <xsl:text>SmarTelefon – katalog produktů</xsl:text>
                        <fo:leader leader-pattern="space"/>
                        <xsl:text>Datum generování: </xsl:text>
                        <xsl:value-of select="format-date(current-date(), '[D01]. [M01]. [Y0001]')"
                        />
                    </fo:block>
                </fo:static-content>
                <fo:static-content flow-name="xsl-region-after" font-size="9pt" font-family="Segoe UI" color="#333" text-align="right">
                    <fo:block>
                        <xsl:text>Strana </xsl:text>
                        <fo:page-number/>
                    </fo:block>
                </fo:static-content>
                <fo:flow flow-name="xsl-region-body" text-align="left" font-family="Segoe UI"
                    font-size="10pt" color="#333">
                    <fo:block>
                        <xsl:apply-templates/>
                    </fo:block>
                </fo:flow>
            </fo:page-sequence>
        </fo:root>
    </xsl:template>

    <xsl:template match="ph:polozky">
        <xsl:for-each-group select="ph:polozka/ph:parametry/ph:system/ph:nazev" group-by=".">
            <xsl:sort select="upper-case(current-grouping-key())"/>
            <fo:block font-size="150%" margin-top="10pt" margin-bottom="5pt" break-before="page">
                <xsl:text>Telefony se systémem </xsl:text>
                <xsl:value-of select="."/>
                <xsl:text> (</xsl:text>
                <xsl:value-of select="count(current-group())"/>
                <xsl:text>)</xsl:text>
            </fo:block>

            <xsl:for-each select="current-group()/../../..">
                <xsl:sort select="ph:cena[@typ = 'aktualni'][@mena = 'CZK']" data-type="number"
                    order="ascending"/>

                <fo:table margin-bottom="5pt">
                    <fo:table-column column-width="20%"/>
                    <fo:table-column column-width="80%"/>
                    <fo:table-body>
                        <fo:table-row>
                            <fo:table-cell>
                                <fo:block>
                                    <fo:basic-link internal-destination="{generate-id(.)}">
                                        <fo:external-graphic content-height="scale-to-fit"
                                            height="1.20in" content-width="1.20in"
                                            scaling="non-uniform">
                                            <xsl:attribute name="src">html/img/<xsl:value-of
                                                  select="ph:obrazek"/></xsl:attribute>
                                        </fo:external-graphic>
                                    </fo:basic-link>
                                </fo:block>
                            </fo:table-cell>
                            <fo:table-cell background-color="#e7e7e7" padding="0 7pt 0 7pt">
                                <fo:block>
                                    <fo:block font-weight="bold" background-color="#4E5066"
                                        color="#fff" padding="{$paddingTabulka}">
                                        <fo:basic-link internal-destination="{generate-id(.)}">
                                            <xsl:value-of select="ph:vyrobce"/>
                                            <xsl:text> </xsl:text>
                                            <xsl:value-of select="ph:model"/>
                                        </fo:basic-link>
                                    </fo:block>
                                    <fo:block padding="{$paddingTabulka}" >
                                        <xsl:text>Mobilní telefon </xsl:text>
                                        <xsl:value-of select="ph:parametry/ph:displej/ph:velikost"/>
                                        <xsl:value-of
                                            select="ph:parametry/ph:displej/ph:velikost/@jednotka"/>
                                        <xsl:text> </xsl:text>
                                        <xsl:value-of select="ph:parametry/ph:displej/ph:rozliseni"/>
                                        <xsl:text>, procesor </xsl:text>
                                        <xsl:value-of select="ph:parametry/ph:cpu/ph:nazev"/>
                                        <xsl:text>, RAM </xsl:text>
                                        <xsl:value-of select="ph:parametry/ph:ram"/>
                                        <xsl:value-of select="ph:parametry/ph:ram/@jednotka"/>
                                        <xsl:text>, interní paměť </xsl:text>
                                        <xsl:value-of select="ph:parametry/ph:interniUloziste"/>
                                        <xsl:value-of
                                            select="ph:parametry/ph:interniUloziste/@jednotka"/>
                                        <xsl:if test="ph:parametry/ph:externiUloziste">
                                            <xsl:text>, </xsl:text>
                                            <xsl:value-of select="ph:parametry/ph:externiUloziste"/>
                                        </xsl:if>
                                        <xsl:text>, fotoaparát zadní </xsl:text>
                                        <xsl:value-of
                                            select="ph:parametry/ph:fotoaparat[@typ = 'zadni']/ph:rozliseni"/>
                                        <xsl:text> (</xsl:text>
                                        <xsl:value-of
                                            select="ph:parametry/ph:fotoaparat[@typ = 'zadni']/ph:svetelnost"/>
                                        <xsl:text>)</xsl:text>
                                        <xsl:text> + přední </xsl:text>
                                        <xsl:value-of
                                            select="ph:parametry/ph:fotoaparat[@typ = 'predni']/ph:rozliseni"/>
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
                                        <xsl:value-of
                                            select="ph:parametry/ph:baterie/ph:kapacita/@jednotka"/>
                                        <xsl:text>, </xsl:text>
                                        <xsl:value-of select="ph:parametry/ph:system/ph:nazev"/>
                                        <xsl:text> </xsl:text>
                                        <xsl:value-of select="ph:parametry/ph:system/ph:verze"/>
                                    </fo:block>
                                    <fo:table margin-top="6pt">
                                        <fo:table-column column-width="33.3%"/>
                                        <fo:table-column column-width="33.3%"/>
                                        <fo:table-column column-width="33.3%"/>
                                        <fo:table-body>
                                            <fo:table-row>
                                                <fo:table-cell>
                                                  <fo:block>
                                                  <xsl:if test="sum(ph:dostupnost/ph:sklad) = 0">
                                                  <fo:block color="red">
                                                  <xsl:text>Není skladem</xsl:text>
                                                  </fo:block>
                                                  </xsl:if>
                                                  <xsl:if test="sum(ph:dostupnost/ph:sklad) != 0">
                                                  <fo:block color="green">
                                                  <xsl:text>Skladem </xsl:text>
                                                  <xsl:value-of select="sum(ph:dostupnost/ph:sklad)"/>
                                                  <xsl:text> ks</xsl:text>
                                                  </fo:block>
                                                  </xsl:if>
                                                  </fo:block>
                                                </fo:table-cell>
                                                <fo:table-cell>
                                                  <fo:block text-align="center">
                                                  <xsl:text>Cena bez DPH: </xsl:text>
                                                  <xsl:value-of
                                                  select="format-number(round(ph:cena[@typ = 'aktualni'][@mena = 'CZK']) div (1 + (./../../ph:dph)), '### ###')"/>
                                                  <xsl:text>,–</xsl:text>
                                                  </fo:block>
                                                </fo:table-cell>
                                                <fo:table-cell>
                                                  <fo:block font-weight="bold" text-align="right">
                                                  <xsl:text>Cena s DPH: </xsl:text>
                                                  <xsl:value-of
                                                  select="format-number(ph:cena[@typ = 'aktualni'][@mena = 'CZK'], '### ###')"/>
                                                  <xsl:text>,–</xsl:text>
                                                  </fo:block>
                                                </fo:table-cell>
                                            </fo:table-row>
                                        </fo:table-body>
                                    </fo:table>

                                    <fo:block text-align="right" margin-top="8pt" padding="{$paddingTabulka}" border-bottom="1pt solid #4E5066" font-size="9pt">
                                        <fo:basic-link internal-destination="{generate-id(.)}">
                                            <xsl:text>Více na straně </xsl:text>
                                            <fo:page-number-citation ref-id="{generate-id(.)}"/>
                                        </fo:basic-link>
                                    </fo:block>
                                </fo:block>
                            </fo:table-cell>
                        </fo:table-row>
                    </fo:table-body>
                </fo:table>
            </xsl:for-each>

        </xsl:for-each-group>
        <xsl:apply-templates select="ph:polozka">
            <xsl:sort select="upper-case(./ph:parametry/ph:system/ph:nazev)"/>
            <xsl:sort select="ph:cena[@typ = 'aktualni'][@mena = 'CZK']" data-type="number"/>
        </xsl:apply-templates>
    </xsl:template>

    <xsl:template match="ph:polozka">
        <fo:block font-size="150%" break-before="page" id="{generate-id(.)}" margin-bottom="8pt">
            <xsl:value-of select="ph:vyrobce"/>
            <xsl:text> </xsl:text>
            <xsl:value-of select="ph:model"/>
        </fo:block>
        <fo:table>
            <fo:table-column column-width="32%"/>
            <fo:table-column column-width="40%"/>
            <fo:table-column column-width="28%"/>
            <fo:table-body>
                <fo:table-row>
                    <fo:table-cell number-rows-spanned="5">
                        <fo:block>
                            <fo:external-graphic content-height="scale-to-fit" height="2.00in"
                                content-width="2.00in" scaling="non-uniform">
                                <xsl:attribute name="src">html/img/<xsl:value-of select="ph:obrazek"
                                    /></xsl:attribute>
                            </fo:external-graphic>
                        </fo:block>
                    </fo:table-cell>
                    <fo:table-cell number-columns-spanned="2">
                        <fo:block font-size="9pt">
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
                            <xsl:value-of
                                select="ph:parametry/ph:fotoaparat[@typ = 'zadni']/ph:rozliseni"/>
                            <xsl:text> (</xsl:text>
                            <xsl:value-of
                                select="ph:parametry/ph:fotoaparat[@typ = 'zadni']/ph:svetelnost"/>
                            <xsl:text>)</xsl:text>
                            <xsl:text> + přední </xsl:text>
                            <xsl:value-of
                                select="ph:parametry/ph:fotoaparat[@typ = 'predni']/ph:rozliseni"/>
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
                        </fo:block>
                    </fo:table-cell>
                </fo:table-row>
                <fo:table-row font-size="115%" font-weight="bold">
                    <fo:table-cell>
                        <fo:block margin-top="8pt">Cena s DPH</fo:block>
                    </fo:table-cell>
                    <fo:table-cell>
                        <fo:block color="red" text-align="right" margin-top="8pt">
                            <xsl:value-of
                                select="format-number(ph:cena[@typ = 'aktualni'][@mena = 'CZK'], '### ###')"/>
                            <xsl:text>,–</xsl:text>
                        </fo:block>
                    </fo:table-cell>
                </fo:table-row>
                <fo:table-row>
                    <fo:table-cell>
                        <fo:block>Cena bez DPH</fo:block>
                    </fo:table-cell>
                    <fo:table-cell>
                        <fo:block text-align="right">
                            <xsl:value-of
                                select="format-number(round(ph:cena[@typ = 'aktualni'][@mena = 'CZK']) div (1 + (./../../ph:dph)), '### ###')"/>
                            <xsl:text>,–</xsl:text>
                        </fo:block>
                    </fo:table-cell>
                </fo:table-row>
                <fo:table-row>
                    <fo:table-cell number-columns-spanned="2">
                        <fo:table background-color="#e7e7e7" margin-top="8pt">
                            <fo:table-column column-width="50%"/>
                            <fo:table-column column-width="50%"/>
                            <fo:table-header>
                                <fo:table-row>
                                    <fo:table-cell padding="{$paddingTabulka}"
                                        background-color="#4E5066" color="#fff"
                                        number-columns-spanned="2">
                                        <fo:block font-weight="bold">
                                            <xsl:if test="sum(ph:dostupnost/ph:sklad) = 0">
                                                <xsl:text>Není skladem</xsl:text>
                                            </xsl:if>
                                            <xsl:if test="sum(ph:dostupnost/ph:sklad) != 0">
                                                <xsl:text>Skladem </xsl:text>
                                                <xsl:value-of select="sum(ph:dostupnost/ph:sklad)"/>
                                                <xsl:text> ks</xsl:text>
                                            </xsl:if>
                                        </fo:block>
                                    </fo:table-cell>
                                </fo:table-row>
                            </fo:table-header>
                            <fo:table-body>
                                <xsl:if test="ph:dostupnost/ph:sklad[@mesto = 'Praha']">
                                    <fo:table-row>
                                        <fo:table-cell padding="{$paddingTabulka}">
                                            <fo:block>Sklad Praha</fo:block>
                                        </fo:table-cell>
                                        <fo:table-cell padding="{$paddingTabulka}">
                                            <fo:block text-align="right">
                                                <xsl:value-of
                                                  select="ph:dostupnost/ph:sklad[@mesto = 'Praha']"/>
                                                <xsl:text> ks</xsl:text>
                                            </fo:block>
                                        </fo:table-cell>
                                    </fo:table-row>
                                </xsl:if>
                                <xsl:if test="ph:dostupnost/ph:sklad[@mesto = 'Brno']">
                                    <fo:table-row>
                                        <fo:table-cell padding="{$paddingTabulka}">
                                            <fo:block>Sklad Brno</fo:block>
                                        </fo:table-cell>
                                        <fo:table-cell padding="{$paddingTabulka}">
                                            <fo:block text-align="right">
                                                <xsl:value-of
                                                  select="ph:dostupnost/ph:sklad[@mesto = 'Brno']"/>
                                                <xsl:text> ks</xsl:text>
                                            </fo:block>
                                        </fo:table-cell>
                                    </fo:table-row>
                                </xsl:if>
                                <xsl:if test="ph:dostupnost/ph:sklad[@mesto = 'Ostrava']">
                                    <fo:table-row>
                                        <fo:table-cell padding="{$paddingTabulka}">
                                            <fo:block>Sklad Ostrava</fo:block>
                                        </fo:table-cell>
                                        <fo:table-cell padding="{$paddingTabulka}">
                                            <fo:block text-align="right">
                                                <xsl:value-of
                                                  select="ph:dostupnost/ph:sklad[@mesto = 'Ostrava']"/>
                                                <xsl:text> ks</xsl:text>
                                            </fo:block>
                                        </fo:table-cell>
                                    </fo:table-row>
                                </xsl:if>
                            </fo:table-body>
                        </fo:table>
                    </fo:table-cell>
                </fo:table-row>
                <fo:table-row>
                    <fo:table-cell number-columns-spanned="2">
                        <fo:block font-size="8pt" margin-top="3pt">
                            <fo:table>
                                <fo:table-column column-width="30%"/>
                                <fo:table-column column-width="30%"/>
                                <fo:table-column column-width="40%"/>
                                <fo:table-body>
                                    <fo:table-row>
                                        <fo:table-cell>
                                            <fo:block>
                                                <xsl:text>Cena s DPH €</xsl:text>
                                                <xsl:value-of
                                                  select="format-number(ph:cena[@typ = 'aktualni'][@mena = 'EUR'], '### ###')"
                                                />
                                            </fo:block>
                                        </fo:table-cell>
                                        <fo:table-cell>
                                            <fo:block text-align="center">
                                                <xsl:text>Cena bez DPH €</xsl:text>
                                                <xsl:value-of
                                                  select="format-number(round(ph:cena[@typ = 'aktualni'][@mena = 'EUR']) div (1 + (./../../ph:dph)), '### ###')"
                                                />
                                            </fo:block>
                                        </fo:table-cell>
                                        <fo:table-cell>
                                            <fo:block text-align="right">
                                                <xsl:text>Produktové číslo: </xsl:text>
                                                <xsl:value-of select="ph:produktoveCislo"/>
                                            </fo:block>
                                        </fo:table-cell>
                                    </fo:table-row>
                                </fo:table-body>
                            </fo:table>
                        </fo:block>
                    </fo:table-cell>
                </fo:table-row>
            </fo:table-body>
        </fo:table>
        <fo:block margin-top="10pt" text-align="justify">
            <xsl:value-of select="ph:popis"/>
        </fo:block>
        <fo:block margin="10pt 0 4pt 0" font-size="120%" font-weight="bold">Technické
            parametry</fo:block>
        <fo:table background-color="#e7e7e7">
            <fo:table-column column-width="40%"/>
            <fo:table-column column-width="60%"/>
            <fo:table-body>
                <fo:table-row>
                    <fo:table-cell padding="{$paddingTabulka}" background-color="#4E5066"
                        font-weight="bold" color="#fff" number-columns-spanned="2">
                        <fo:block>Základní parametry</fo:block>
                    </fo:table-cell>
                </fo:table-row>
                <fo:table-row>
                    <fo:table-cell padding="{$paddingTabulka}">
                        <fo:block>Úhlopříčka displeje</fo:block>
                    </fo:table-cell>
                    <fo:table-cell padding="{$paddingTabulka}">
                        <fo:block>
                            <xsl:value-of select="ph:parametry/ph:displej/ph:velikost"/>
                            <xsl:value-of select="ph:parametry/ph:displej/ph:velikost/@jednotka"/>
                        </fo:block>
                    </fo:table-cell>
                </fo:table-row>
                <fo:table-row>
                    <fo:table-cell padding="{$paddingTabulka}">
                        <fo:block>Rozlišení displeje</fo:block>
                    </fo:table-cell>
                    <fo:table-cell padding="{$paddingTabulka}">
                        <fo:block>
                            <xsl:value-of select="ph:parametry/ph:displej/ph:rozliseni"/>
                        </fo:block>
                    </fo:table-cell>
                </fo:table-row>
                <fo:table-row>
                    <fo:table-cell padding="{$paddingTabulka}">
                        <fo:block>Operační systém</fo:block>
                    </fo:table-cell>
                    <fo:table-cell padding="{$paddingTabulka}">
                        <fo:block>
                            <xsl:value-of select="ph:parametry/ph:system/ph:nazev"/>
                            <xsl:text> </xsl:text>
                            <xsl:value-of select="ph:parametry/ph:system/ph:verze"/>
                        </fo:block>
                    </fo:table-cell>
                </fo:table-row>
                <fo:table-row>
                    <fo:table-cell padding="{$paddingTabulka}">
                        <fo:block>Operační paměť</fo:block>
                    </fo:table-cell>
                    <fo:table-cell padding="{$paddingTabulka}">
                        <fo:block>
                            <xsl:value-of select="ph:parametry/ph:ram"/>
                            <xsl:text> </xsl:text>
                            <xsl:value-of select="ph:parametry/ph:ram/@jednotka"/>
                        </fo:block>
                    </fo:table-cell>
                </fo:table-row>
                <fo:table-row>
                    <fo:table-cell padding="{$paddingTabulka}">
                        <fo:block>Interní úložiště</fo:block>
                    </fo:table-cell>
                    <fo:table-cell padding="{$paddingTabulka}">
                        <fo:block>
                            <xsl:value-of select="ph:parametry/ph:interniUloziste"/>
                            <xsl:text> </xsl:text>
                            <xsl:value-of select="ph:parametry/ph:interniUloziste/@jednotka"/>
                        </fo:block>
                    </fo:table-cell>
                </fo:table-row>
                <xsl:if test="ph:parametry/ph:externiUloziste">
                    <fo:table-row>
                        <fo:table-cell padding="{$paddingTabulka}">
                            <fo:block>Externí úložiště</fo:block>
                        </fo:table-cell>
                        <fo:table-cell padding="{$paddingTabulka}">
                            <fo:block>
                                <xsl:value-of select="ph:parametry/ph:externiUloziste"/>
                            </fo:block>
                        </fo:table-cell>
                    </fo:table-row>
                </xsl:if>
                <fo:table-row>
                    <fo:table-cell padding="{$paddingTabulka}" background-color="#4E5066"
                        font-weight="bold" color="#fff" number-columns-spanned="2">
                        <fo:block>Výkon a výdrž</fo:block>
                    </fo:table-cell>
                </fo:table-row>
                <fo:table-row>
                    <fo:table-cell padding="{$paddingTabulka}">
                        <fo:block>Procesor</fo:block>
                    </fo:table-cell>
                    <fo:table-cell padding="{$paddingTabulka}">
                        <fo:block>
                            <xsl:value-of select="ph:parametry/ph:cpu/ph:nazev"/>
                        </fo:block>
                    </fo:table-cell>
                </fo:table-row>
                <fo:table-row>
                    <fo:table-cell padding="{$paddingTabulka}">
                        <fo:block>Počet jader procesoru</fo:block>
                    </fo:table-cell>
                    <fo:table-cell padding="{$paddingTabulka}">
                        <fo:block>
                            <xsl:value-of select="ph:parametry/ph:cpu/ph:pocetJader"/>
                        </fo:block>
                    </fo:table-cell>
                </fo:table-row>
                <fo:table-row>
                    <fo:table-cell padding="{$paddingTabulka}">
                        <fo:block>Frekvence procesoru</fo:block>
                    </fo:table-cell>
                    <fo:table-cell padding="{$paddingTabulka}">
                        <fo:block>
                            <xsl:value-of select="ph:parametry/ph:cpu/ph:frekvence"/>
                            <xsl:text> </xsl:text>
                            <xsl:value-of select="ph:parametry/ph:cpu/ph:frekvence/@jednotka"/>
                        </fo:block>
                    </fo:table-cell>
                </fo:table-row>
                <fo:table-row>
                    <fo:table-cell padding="{$paddingTabulka}">
                        <fo:block>Kapacita baterie</fo:block>
                    </fo:table-cell>
                    <fo:table-cell padding="{$paddingTabulka}">
                        <fo:block>
                            <xsl:value-of select="ph:parametry/ph:baterie/ph:kapacita"/>
                            <xsl:text> </xsl:text>
                            <xsl:value-of select="ph:parametry/ph:baterie/ph:kapacita/@jednotka"/>
                        </fo:block>
                    </fo:table-cell>
                </fo:table-row>
                <fo:table-row>
                    <fo:table-cell padding="{$paddingTabulka}" background-color="#4E5066"
                        font-weight="bold" color="#fff" number-columns-spanned="2">
                        <fo:block>Fotoaparáty</fo:block>
                    </fo:table-cell>
                </fo:table-row>
                <fo:table-row>
                    <fo:table-cell padding="{$paddingTabulka}">
                        <fo:block>Rozlišení zadního fotoaparátu</fo:block>
                    </fo:table-cell>
                    <fo:table-cell padding="{$paddingTabulka}">
                        <fo:block>
                            <xsl:value-of
                                select="ph:parametry/ph:fotoaparat[@typ = 'zadni']/ph:rozliseni"/>
                        </fo:block>
                    </fo:table-cell>
                </fo:table-row>
                <xsl:if test="ph:parametry/ph:fotoaparat[@typ = 'zadni']/ph:svetelnost">
                    <fo:table-row>
                        <fo:table-cell padding="{$paddingTabulka}">
                            <fo:block>Světelnost</fo:block>
                        </fo:table-cell>
                        <fo:table-cell padding="{$paddingTabulka}">
                            <fo:block>
                                <xsl:value-of
                                    select="ph:parametry/ph:fotoaparat[@typ = 'zadni']/ph:svetelnost"
                                />
                            </fo:block>
                        </fo:table-cell>
                    </fo:table-row>
                </xsl:if>
                <xsl:if test="ph:parametry/ph:fotoaparat[@typ = 'zadni']/ph:blesk">
                    <fo:table-row>
                        <fo:table-cell padding="{$paddingTabulka}">
                            <fo:block>Blesk</fo:block>
                        </fo:table-cell>
                        <fo:table-cell padding="{$paddingTabulka}">
                            <fo:block>
                                <xsl:value-of
                                    select="ph:parametry/ph:fotoaparat[@typ = 'zadni']/ph:blesk"/>
                            </fo:block>
                        </fo:table-cell>
                    </fo:table-row>
                </xsl:if>
                <xsl:if test="ph:parametry/ph:fotoaparat[@typ = 'zadni']/ph:stabilizace">
                    <fo:table-row>
                        <fo:table-cell padding="{$paddingTabulka}">
                            <fo:block>Optická stabilizace</fo:block>
                        </fo:table-cell>
                        <fo:table-cell padding="{$paddingTabulka}">
                            <fo:block>
                                <xsl:value-of
                                    select="ph:parametry/ph:fotoaparat[@typ = 'zadni']/ph:stabilizace"
                                />
                            </fo:block>
                        </fo:table-cell>
                    </fo:table-row>
                </xsl:if>
                <fo:table-row>
                    <fo:table-cell padding="{$paddingTabulka}">
                        <fo:block>Rozlišení předního fotoaparátu</fo:block>
                    </fo:table-cell>
                    <fo:table-cell padding="{$paddingTabulka}">
                        <fo:block>
                            <xsl:value-of
                                select="ph:parametry/ph:fotoaparat[@typ = 'predni']/ph:rozliseni"/>
                        </fo:block>
                    </fo:table-cell>
                </fo:table-row>
                <fo:table-row>
                    <fo:table-cell padding="{$paddingTabulka}" background-color="#4E5066"
                        font-weight="bold" color="#fff" number-columns-spanned="2">
                        <fo:block>Komunikace</fo:block>
                    </fo:table-cell>
                </fo:table-row>
                <fo:table-row>
                    <fo:table-cell padding="{$paddingTabulka}">
                        <fo:block>Bezdrátové technologie</fo:block>
                    </fo:table-cell>
                    <fo:table-cell padding="{$paddingTabulka}">
                        <fo:block>
                            <xsl:if test="ph:parametry/ph:konektivita/ph:wifi = 'ano'">
                                <xsl:text>WiFi</xsl:text>
                                <xsl:if
                                    test="(ph:parametry/ph:konektivita/ph:lte = 'ano') || (ph:parametry/ph:konektivita/ph:bluetooth = 'ano') || (ph:parametry/ph:konektivita/ph:nfc = 'ano')">
                                    <xsl:text>, </xsl:text>
                                </xsl:if>
                            </xsl:if>
                            <xsl:if test="ph:parametry/ph:konektivita/ph:lte = 'ano'">
                                <xsl:text>LTE</xsl:text>
                                <xsl:if
                                    test="(ph:parametry/ph:konektivita/ph:bluetooth = 'ano') || (ph:parametry/ph:konektivita/ph:nfc = 'ano')">
                                    <xsl:text>, </xsl:text>
                                </xsl:if>
                            </xsl:if>
                            <xsl:if test="ph:parametry/ph:konektivita/ph:bluetooth = 'ano'">
                                <xsl:text>Bluetooth</xsl:text>
                                <xsl:if test="ph:parametry/ph:konektivita/ph:nfc = 'ano'">
                                    <xsl:text>, </xsl:text>
                                </xsl:if>
                            </xsl:if>
                            <xsl:if test="ph:parametry/ph:konektivita/ph:nfc = 'ano'">
                                <xsl:text>NFC</xsl:text>
                            </xsl:if>
                        </fo:block>
                    </fo:table-cell>
                </fo:table-row>
                <fo:table-row>
                    <fo:table-cell padding="{$paddingTabulka}">
                        <fo:block>SIM</fo:block>
                    </fo:table-cell>
                    <fo:table-cell padding="{$paddingTabulka}">
                        <fo:block>
                            <xsl:value-of select="ph:parametry/ph:sim/ph:pocet"/>
                            <xsl:text>× </xsl:text>
                            <xsl:value-of select="ph:parametry/ph:sim/@typ"/>
                            <xsl:text>SIM</xsl:text>
                        </fo:block>
                    </fo:table-cell>
                </fo:table-row>
                <fo:table-row>
                    <fo:table-cell padding="{$paddingTabulka}" background-color="#4E5066"
                        font-weight="bold" color="#fff" number-columns-spanned="2">
                        <fo:block>Ostatní</fo:block>
                    </fo:table-cell>
                </fo:table-row>
                <fo:table-row>
                    <fo:table-cell padding="{$paddingTabulka}">
                        <fo:block>Rozměry</fo:block>
                    </fo:table-cell>
                    <fo:table-cell padding="{$paddingTabulka}">
                        <fo:block>
                            <xsl:value-of select="ph:parametry/ph:rozmery/ph:s"/>
                            <xsl:text>×</xsl:text>
                            <xsl:value-of select="ph:parametry/ph:rozmery/ph:v"/>
                            <xsl:text>×</xsl:text>
                            <xsl:value-of select="ph:parametry/ph:rozmery/ph:h"/>
                            <xsl:text> </xsl:text>
                            <xsl:value-of select="ph:parametry/ph:rozmery/@jednotka"/>
                            <xsl:text> (Š×V×H)</xsl:text>
                        </fo:block>
                    </fo:table-cell>
                </fo:table-row>
                <fo:table-row>
                    <fo:table-cell padding="{$paddingTabulka}">
                        <fo:block>Dostupné barvy</fo:block>
                    </fo:table-cell>
                    <fo:table-cell padding="{$paddingTabulka}">
                        <fo:block>
                            <xsl:value-of select="ph:parametry/ph:barvy/ph:barva" separator=", "/>
                        </fo:block>
                    </fo:table-cell>
                </fo:table-row>
                <fo:table-row>
                    <fo:table-cell padding="{$paddingTabulka}">
                        <fo:block>Obsah balení</fo:block>
                    </fo:table-cell>
                    <fo:table-cell padding="{$paddingTabulka}">
                        <fo:block>
                            <xsl:value-of select="ph:parametry/ph:obsahBaleni/ph:polozka"
                                separator=", "/>
                        </fo:block>
                    </fo:table-cell>
                </fo:table-row>
            </fo:table-body>
        </fo:table>
    </xsl:template>
    <xsl:template match="ph:dph"></xsl:template>
</xsl:stylesheet>
