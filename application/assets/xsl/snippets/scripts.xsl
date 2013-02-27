<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">

<xsl:output method="html" indent="yes" encoding="utf-8" omit-xml-declaration="yes" doctype-public="XSLT-compat"/>
<xsl:strip-space elements="*"/>

<xsl:template match="scripts">
	<xsl:apply-templates select="script"/>
</xsl:template>

<xsl:template match="script">
	<script type="text/javascript">
		<xsl:attribute name="src">
			<xsl:if test="cdn">
				<xsl:text>http://static</xsl:text>
				<xsl:value-of select="(position()-1) mod 3 + 1"/>
				<xsl:text>.</xsl:text>
				<xsl:choose>
					<xsl:when test="contains(/root/meta/domain,'www.')">
						<xsl:value-of select="substring(/root/meta/domain, 5)"/>
					</xsl:when>
					<xsl:otherwise>
						<xsl:value-of select="/root/meta/domain"/>
					</xsl:otherwise>
				</xsl:choose>
			</xsl:if>
			<xsl:value-of select="source"/>
		</xsl:attribute>
	</script>
</xsl:template>

<xsl:template match="text()"/>

</xsl:stylesheet>