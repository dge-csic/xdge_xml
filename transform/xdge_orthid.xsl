<?xml version="1.0" encoding="UTF-8"?>
<xsl:transform exclude-result-prefixes="tei" version="1.0" xmlns:tei="http://www.tei-c.org/ns/1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
  <xsl:output encoding="UTF-8" indent="yes" method="text"/>
  <xsl:variable name="lf">
    <xsl:text>&#10;</xsl:text>
  </xsl:variable>
  <xsl:variable name="tab">
    <xsl:text>&#9;</xsl:text>
  </xsl:variable>
  <xsl:template match="/">
    <xsl:text>File</xsl:text>
    <xsl:value-of select="$tab"/>
    <xsl:text>@xml:id</xsl:text>
    <xsl:value-of select="$tab"/>
    <xsl:text>type</xsl:text>
    <xsl:value-of select="$tab"/>
    <xsl:text>orth</xsl:text>
    <xsl:value-of select="$lf"/>
    <refs>
      <xsl:apply-templates select="document('../xdge1.xml')/*"/>
      <xsl:apply-templates select="document('../xdge2.xml')/*"/>
      <xsl:apply-templates select="document('../xdge3.xml')/*"/>
      <xsl:apply-templates select="document('../xdge4.xml')/*"/>
      <xsl:apply-templates select="document('../xdge5.xml')/*"/>
      <xsl:apply-templates select="document('../xdge6.xml')/*"/>
      <xsl:apply-templates select="document('../xdge7.xml')/*"/>
      <xsl:apply-templates select="document('../xdge8.xml')/*"/>
    </refs>
  </xsl:template>
  <xsl:template match="*">
    <xsl:apply-templates select="*"/>
  </xsl:template>
  <xsl:template match="tei:entry">
    <xsl:variable name="id" select="@xml:id"/>
    <xsl:variable name="type" select="@type"/>
    <xsl:variable name="file" select="/tei:TEI/@xml:id"/>
    
    <xsl:for-each select="tei:form/tei:orth">
      <xsl:value-of select="$file"/>
      <xsl:value-of select="$tab"/>
      <xsl:value-of select="$id"/>
      <xsl:value-of select="$tab"/>
      <xsl:choose>
        <xsl:when test="position() &gt; 1">
          <xsl:value-of select="position()"/>
        </xsl:when>
        <xsl:otherwise>
          <xsl:value-of select="$type"/>
        </xsl:otherwise>
      </xsl:choose>
      <xsl:value-of select="$tab"/>
      <xsl:value-of select="."/>
      <xsl:value-of select="$lf"/>
    </xsl:for-each>
  </xsl:template>
</xsl:transform>
