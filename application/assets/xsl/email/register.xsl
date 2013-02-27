<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">

<xsl:output method="html" indent="yes" encoding="utf-8" omit-xml-declaration="yes" />
<xsl:strip-space elements="*"/>

<xsl:template match="/">
	<xsl:apply-templates select="/root/content"/>
</xsl:template>

<xsl:template match="content">
	<div class="content">
		<div style="margin: 0 auto;">
			<p>Dear <xsl:value-of select="user/username"/>,</p>
			<p>Thank you for registering for MedVoyager!</p>
		</div>
	</div>
</xsl:template>

<xsl:template match="text()"/>

</xsl:stylesheet>