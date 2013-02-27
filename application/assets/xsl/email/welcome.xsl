<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">

<xsl:output method="html" indent="yes" encoding="utf-8" omit-xml-declaration="yes" />
<xsl:strip-space elements="*"/>

<xsl:template match="/">
	<xsl:apply-templates select="/root/content"/>
</xsl:template>

<xsl:template match="content">
	<div class="content">
		<div>
			<h3>Welcome to MedVoyager</h3>
			<p>We would like to thank you for choosing MedVoyager as your partner in healthcare searching.</p>
			<br />
			<br />
			Thank you,
			<br />
			MedVoyager
		</div>
	</div>
</xsl:template>

<xsl:template match="text()"/>

</xsl:stylesheet>