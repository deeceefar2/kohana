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
			<p><b>Name:</b> <xsl:value-of select="post/name"/></p>
			<p><b>Email:</b> <a href="mailto:{post/email}"><xsl:value-of select="post/email"/></a></p>
			<p><b>Subject:</b> <xsl:value-of select="post/subject"/></p>
			<p><b>Message</b><pre><xsl:value-of select="post/message"/></pre></p>
		</div>
	</div>
</xsl:template>

<xsl:template match="text()"/>

</xsl:stylesheet>