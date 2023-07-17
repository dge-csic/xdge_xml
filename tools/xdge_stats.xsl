<?xml version="1.0" encoding="UTF-8"?>
<xsl:transform exclude-result-prefixes="tei" version="1.0" 
  xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
  xmlns="http://www.tei-c.org/ns/1.0" 
  xmlns:tei="http://www.tei-c.org/ns/1.0" 
  >
  <xsl:output encoding="UTF-8" indent="no" method="text"/>
  <xsl:variable name="tab" select="'&#9;'"/>
  <xsl:variable name="lf" select="'&#10;'"/>
  <xsl:template match="/">
    <root>
      <!--
      <xsl:text>volume</xsl:text>
      <xsl:value-of select="$tab"/>
      <xsl:text>name</xsl:text>
      <xsl:value-of select="$tab"/>
      <xsl:text>chars</xsl:text>
      <xsl:value-of select="$tab"/>
      <xsl:text>bibl</xsl:text>
      <xsl:value-of select="$tab"/>
      <xsl:text>cit</xsl:text>
      <xsl:value-of select="$lf"/>
      -->
      <xsl:apply-templates select="/tei:TEI/tei:text/tei:body/tei:entry"/>
    </root>
  </xsl:template>
  <xsl:template match="tei:entry">
    <xsl:value-of select="/*/@xml:id"/>
    <xsl:value-of select="$tab"/>
    <xsl:value-of select="@xml:id"/>
    <xsl:value-of select="$tab"/>
    <xsl:value-of select="normalize-space(concat(@ana, ' ', @type))"/>
    <xsl:value-of select="$tab"/>
    <xsl:value-of select="string-length(normalize-space(.))"/>
    <xsl:value-of select="$tab"/>
    <xsl:value-of select="count(.//tei:bibl)"/>
    <xsl:value-of select="$tab"/>
    <xsl:value-of select="count(.//tei:cit)"/>
    <xsl:value-of select="$lf"/>
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
