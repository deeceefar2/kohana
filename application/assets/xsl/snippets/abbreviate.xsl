<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform" >

<xsl:output method="html" indent="yes" encoding="utf-8" omit-xml-declaration="yes"/>
<xsl:strip-space elements="*"/>

<xsl:template name="abbreviate">
	<xsl:param name="length"/>
	<xsl:param name="string"/>
	<xsl:choose>
		<xsl:when test="string-length($string) > number($length)">
			<xsl:value-of select="substring( $string, 1, number($length)-3 )"/>
			<xsl:text>...</xsl:text>
		</xsl:when>
		<xsl:otherwise>
			<xsl:value-of select="$string"/>
		</xsl:otherwise>
	</xsl:choose>
</xsl:template>

</xsl:stylesheet>