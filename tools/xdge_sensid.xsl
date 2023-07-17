<?xml version="1.0" encoding="UTF-8"?>
<xsl:transform exclude-result-prefixes="tei" version="1.0" 
  xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
  xmlns="http://www.tei-c.org/ns/1.0" 
  xmlns:tei="http://www.tei-c.org/ns/1.0" 
  >
  <xsl:output encoding="UTF-8" indent="no" method="xml"/>
  <xsl:template match="node()|@*">
    <xsl:copy>
      <xsl:apply-templates select="node()|@*"/>
    </xsl:copy>
  </xsl:template>
  <xsl:template match="tei:sense">
    <xsl:copy>
      <xsl:copy-of select="@*"/>
      <xsl:attribute name="xml:id">
        <xsl:value-of select="ancestor-or-self::tei:entry[1]/@xml:id"/>
        <xsl:text>_</xsl:text>
        <xsl:for-each select="ancestor-or-self::tei:sense">
          <xsl:choose>
            <xsl:when test="tei:num">
              <xsl:value-of select="translate(tei:num, ')', '')"/>
            </xsl:when>
            <xsl:otherwise>
              <xsl:if test="ancestor::tei:sense">-</xsl:if>
              <xsl:number/>
            </xsl:otherwise>
          </xsl:choose>
        </xsl:for-each>
      </xsl:attribute>
      <xsl:apply-templates select="node()"/>
    </xsl:copy>
  </xsl:template>
  <!--
  <xsl:template match="tei:sense[tei:num]/*[self::tei:bibl or self::tei:cit or self::tei:sense][1]">
    <milestone unit="label"/>
    <xsl:copy>
      <xsl:apply-templates select="node()|@*"/>
    </xsl:copy>
  </xsl:template>
  -->
</xsl:transform>
