<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">

<xsl:output method="html" indent="yes" encoding="utf-8" omit-xml-declaration="yes" doctype-public="XSLT-compat"/>

<xsl:include href="snippets/xml_to_string.xsl" />

<xsl:template match="/">
	<title>API</title>
	<xsl:apply-templates select="root"/>
</xsl:template>

<xsl:template match="root">
<pre>
	<xsl:call-template name="xml-to-string">
		<xsl:with-param name="node-set" select="node()"/>
	</xsl:call-template>
</pre>
</xsl:template>

<xsl:template match="text()"/>

</xsl:stylesheet>