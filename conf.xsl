<?xml version="1.0" encoding="UTF-8"?>
<!--

LGPL  http://www.gnu.org/licenses/lgpl.html
© 2016 Frederic.Glorieux@fictif.org et LABEX OBVIL
-->
<xsl:transform version="1.0"
  xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
  xmlns="http://www.tei-c.org/ns/1.0"
  xmlns:tei="http://www.tei-c.org/ns/1.0"
  exclude-result-prefixes="tei"
>
  <xsl:output omit-xml-declaration="yes" encoding="UTF-8" method="xml" indent="yes"/>
  <xsl:key name="conf" match="tei:sp" use="concat(preceding::tei:listPerson[1]/@xml:id, @who)"/>
  <xsl:key name="role" match="tei:role[@xml:id]" use="'all'"/>

  <xsl:template match="node()|@*">
    <xsl:copy>
      <xsl:apply-templates select="node()|@*"/>
    </xsl:copy>
  </xsl:template>
  <!-- éléments à traverser -->
  <xsl:template match="/">
    <xsl:apply-templates/>
  </xsl:template>
  <xsl:template match="tei:listPerson">
    <xsl:copy>
      <xsl:copy-of select="@*"/>
      <xsl:variable name="conf" select="@xml:id"/>
      <xsl:for-each select="key('role', 'all')">
        <xsl:variable name="role" select="@xml:id"/>
        <xsl:if test="key( 'conf', concat( $conf, $role) )">
          <person corresp="#{$role}"/>
        </xsl:if>
      </xsl:for-each>
    </xsl:copy>
  </xsl:template>

</xsl:transform>
