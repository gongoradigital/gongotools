<?xml version="1.0" encoding="UTF-8"?>
<!--

LGPL  http://www.gnu.org/licenses/lgpl.html
© 2016 LABEX OBVIL, gongoradigital

Table des nœuds
-->
<xsl:transform version="1.0"
  xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
  xmlns:tei="http://www.tei-c.org/ns/1.0"
  exclude-result-prefixes="tei"
  >
  <xsl:output omit-xml-declaration="yes" encoding="UTF-8" method="text" indent="yes"/>
  <xsl:param name="file" select="/*/@xml:id|/*/@n"/>
  <xsl:variable name="apos">'</xsl:variable>
  <xsl:variable name="quot">"</xsl:variable>
  <xsl:variable name="poetica" select="document('../gongoraobra/gongora_obra-poetica.xml')"/>
  <xsl:variable name="lf">
    <xsl:text>&#10;</xsl:text>
  </xsl:variable>
  <xsl:variable name="tab">
    <xsl:text>&#9;</xsl:text>
  </xsl:variable>
  <!-- Index des source -->
  <xsl:key name="sources" match="tei:index[@indexName='resp']" use="@n"/>
  <xsl:key name="names" match="tei:name|tei:persName" use="normalize-space(@key|text())"/>
  <xsl:key name="refs" match="tei:ref[contains( @target, 'obra-poetica')]" use="
substring-before(
  concat(
    substring-after(@target, 'gongora_obra-poetica/'),
    '#'
  ),
  '#'
)
    "/>
  <!-- Racine du document, donner la main au mode graph -->
  <xsl:template match="/">
    <xsl:apply-templates select="/*/tei:text" mode="graph"/>
  </xsl:template>
  <xsl:template name="thead">
    <xsl:text>Id</xsl:text>
    <xsl:value-of select="$tab"/>
    <xsl:text>Label</xsl:text>
    <xsl:value-of select="$tab"/>
    <xsl:text>type</xsl:text>
    <xsl:value-of select="$tab"/>
    <xsl:text>date</xsl:text>
    <xsl:value-of select="$lf"/>
  </xsl:template>
  <xsl:template match="/*/tei:text" mode="graph">
    <table>
      <xsl:call-template name="thead"/>
      <!-- Texte -->
      <!-- id -->
      <xsl:value-of select="/*/@n"/>
      <!-- label -->
      <xsl:value-of select="$tab"/>
      <xsl:value-of select="/*/@n"/>
      <!-- type -->
      <xsl:value-of select="$tab"/>
      <xsl:text>text</xsl:text>
      <xsl:value-of select="substring-before( /*/@n, '_' )"/>
      <xsl:value-of select="$lf"/>
      
      <!--
      <xsl:for-each select=".//tei:index[@indexName='resp']">
        <xsl:variable name="key" select="key('sources', @n)"/>
        <xsl:if test="count($key) &gt; 0 and count($key[1]|.) = 1">
          <xsl:value-of select="@n"/>
          <xsl:value-of select="$tab"/>
          <xsl:value-of select="@n"/>
          <xsl:value-of select="$tab"/>
          <xsl:text>polemista</xsl:text>
          <xsl:value-of select="$lf"/>
        </xsl:if>
      </xsl:for-each>
      -->
      
      <xsl:for-each select=".//tei:name | .//tei:persName">
        <xsl:variable name="id" select="normalize-space(@key|text())"/>
        <xsl:variable name="key" select="key('names', $id)"/>
        <xsl:if test="count($key) &gt; 0 and count($key[1]|.) = 1">
          <!-- Id -->
          <xsl:value-of select="$id"/>
          <xsl:value-of select="$tab"/>
          <!-- Label -->
          <xsl:value-of select="$id"/>
          <xsl:value-of select="$tab"/>
          <!-- type -->
          <xsl:choose>
            <xsl:when test="@type">
              <xsl:value-of select="@type"/>
            </xsl:when>
            <xsl:otherwise>
              <xsl:value-of select="local-name()"/>
            </xsl:otherwise>
          </xsl:choose>
          <xsl:value-of select="$lf"/>
        </xsl:if>
      </xsl:for-each>
      <!-- poèmes -->
      <xsl:for-each select=".//tei:ref[contains( @target, 'obra-poetica')]">
        <xsl:variable name="id" select="
        substring-before(
          concat(
            substring-after(@target, 'gongora_obra-poetica/'),
            '#'
          ),
          '#'
        )
         "/>
        <xsl:variable name="key" select="key('refs', $id)"/>
        <xsl:if test="count( $key) &gt; 0 and count($key[1]|.) = 1">
          <!-- Id -->
          <xsl:value-of select="$id"/>
          <!-- Label -->
          <xsl:value-of select="$tab"/>
          <xsl:variable name="ref" select="$poetica//tei:ref[@target=concat('#', $id)]"/>
          <xsl:value-of select="$ref"/>
          <!-- type -->
          <xsl:value-of select="$tab"/>
          <xsl:value-of select="local-name()"/>
          <!-- date -->
          <xsl:value-of select="$tab"/>
          <xsl:value-of select="$ref/../../tei:cell[2]"/>
          <xsl:value-of select="$lf"/>
        </xsl:if>
      </xsl:for-each>
    </table>
  </xsl:template>
  

</xsl:transform>