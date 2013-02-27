<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">

<xsl:output method="html" indent="yes" encoding="utf-8" omit-xml-declaration="yes" doctype-public="XSLT-compat"/>
<xsl:strip-space elements="*"/>

<xsl:include href="index.xsl"/>

<xsl:template match="/">
	<xsl:choose>
		<xsl:when test="root/meta/ajax != ''">
			<xsl:apply-templates select="/root/content"/>
		</xsl:when>
		<xsl:otherwise>
			<xsl:apply-templates select="root"/>
		</xsl:otherwise>
	</xsl:choose>
</xsl:template>

<xsl:template match="content">
	<div class="content">
		<div class="threeColumn">
			<div class="padding15All">
				<div class="blueBar">
					<h5><xsl:value-of select="code"/> Error</h5>
				</div>
			</div>
		</div>
		<div class="clearer"></div>
		<div class="threeColumn">
			<div class="padding15All">
				<div class="largeSectionWhite error404">
					<span class="iconCircleXRed floatRight"></span>
					<h4>/<xsl:value-of select="page"/></h4>
					<p><xsl:value-of select="message"/></p>
					<div class="clearer"></div>
				</div>
			</div>
		</div>
		<div class="clearer"></div>
	</div>
</xsl:template>

<xsl:template match="text()"/>

</xsl:stylesheet>