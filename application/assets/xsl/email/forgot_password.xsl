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
			<h3>Forgot Password:</h3>
			<p>Did you request a password reset for your MedVoyager account (<xsl:value-of select="user/username"/>)?</p>
			<p>If you requested this password reset, go here:</p>
			<a>
				<xsl:attribute name="href">
					<xsl:text>http://med.dev.colorfulstudio.com/login/token?token=</xsl:text>
					<xsl:value-of select="token"/>
				</xsl:attribute>
				<xsl:text>http://med.dev.colorfulstudio.com/login/token?token=</xsl:text><xsl:value-of select="token"/>
			</a>
			<br/>
			<p>If you didn't make this request, use this link to cancel it:</p>
			<a>
				<xsl:attribute name="href">
					<xsl:text>http://med.dev.colorfulstudio.com/login/token?cancel=1&amp;token=</xsl:text>
					<xsl:value-of select="token"/>
				</xsl:attribute>
				<xsl:text>http://med.dev.colorfulstudio.com/login/token?cancel=1&amp;token=</xsl:text><xsl:value-of select="token"/>
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