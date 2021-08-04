<?xml version="1.0" encoding="UTF-8"?>
<xsl:transform version="1.1" xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns="http://www.w3.org/1999/xhtml" xmlns:tei="http://www.tei-c.org/ns/1.0"
    exclude-result-prefixes="tei" xmlns:exslt="http://exslt.org/common" xmlns:php="http://php.net/xsl"
    xmlns:date="http://exslt.org/dates-and-times" extension-element-prefixes="exslt php date">
    <!-- XSL stylesheet to select only some XML elements, discarding everything else -->

        <xsl:template match="tei:etym">
            <xsl:copy-of select="* | text() | @*"/>
    </xsl:template>
        <!-- <xsl:template match="tei:entry">
        <xsl:value-of select="@xml:id" />
        <xsl:text> : </xsl:text>   
    </xsl:template>
remove text content of all other XML nodes: -->
    <xsl:template match="text()" />
</xsl:transform>