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
			<h3>Email Confirmation</h3>
			<p>Please click the link below to confirm your email address, and begin using MedVoyager.</p>
			<a>
				<xsl:attribute name="href">
					<xsl:text>http://med.dev.colorfulstudio.com/register/validate?token=</xsl:text>
					<xsl:value-of select="token"/>
				</xsl:attribute>
				<xsl:text>http://med.dev.colorfulstudio.com/register/validate?token=</xsl:text><xsl:value-of select="token"/>
			</a>
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