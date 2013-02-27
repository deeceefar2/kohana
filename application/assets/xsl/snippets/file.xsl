<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform" >

<xsl:output method="html" indent="yes" encoding="utf-8" omit-xml-declaration="yes"/>
<xsl:strip-space elements="*"/>

<xsl:template match="file">
	<xsl:param name="width"/>
	<xsl:param name="height"/>
	<xsl:param name="class"/>
	<xsl:param name="rel"/>
	<xsl:choose>
		<xsl:when test="file_mime = 'image/jpeg'">
			<xsl:call-template name="image">
				<xsl:with-param name="file" select="."/>
				<xsl:with-param name="width" select="$width"/>
				<xsl:with-param name="height" select="$height"/>
				<xsl:with-param name="class" select="$class"/>
				<xsl:with-param name="rel" select="$rel"/>
			</xsl:call-template>
		</xsl:when>
		<xsl:when test="file_mime = 'image/png'">
			<xsl:call-template name="image">
				<xsl:with-param name="file" select="."/>
				<xsl:with-param name="width" select="$width"/>
				<xsl:with-param name="height" select="$height"/>
				<xsl:with-param name="class" select="$class"/>
				<xsl:with-param name="rel" select="$rel"/>
			</xsl:call-template>
		</xsl:when>
		<xsl:when test="file_mime = 'image/gif'">
			<xsl:call-template name="image">
				<xsl:with-param name="file" select="."/>
				<xsl:with-param name="width" select="$width"/>
				<xsl:with-param name="height" select="$height"/>
				<xsl:with-param name="class" select="$class"/>
				<xsl:with-param name="rel" select="$rel"/>
			</xsl:call-template>
		</xsl:when>
	</xsl:choose>
</xsl:template>

<xsl:template name="image">
	<xsl:param name="file"/>
	<xsl:param name="width"/>
	<xsl:param name="height"/>
	<xsl:param name="class"/>
	<xsl:param name="rel"/>
	<xsl:choose>
		<xsl:when test="$rel!=''">
			<a>
				<xsl:attribute name="rel"><xsl:value-of select="$rel"/></xsl:attribute>
				<xsl:attribute name="href"><xsl:value-of select="$file/file_location"/><xsl:value-of select="$file/file_source"/></xsl:attribute>
				<img>
					<xsl:attribute name="alt"><xsl:value-of select="$file/file_name"/></xsl:attribute>
					<xsl:attribute name="title"><xsl:value-of select="$file/file_name"/></xsl:attribute>
					<xsl:attribute name="width"><xsl:value-of select="$width"/></xsl:attribute>
					<xsl:attribute name="height"><xsl:value-of select="$height"/></xsl:attribute>
					<xsl:attribute name="class"><xsl:value-of select="$class"/></xsl:attribute>
					<xsl:attribute name="src"><xsl:value-of select="$file/file_location"/><xsl:value-of select="$file/file_source"/></xsl:attribute>
				</img>
			</a>
		</xsl:when>
		<xsl:otherwise>
			<img>
				<xsl:attribute name="alt"><xsl:value-of select="$file/file_name"/></xsl:attribute>
				<xsl:attribute name="title"><xsl:value-of select="$file/file_name"/></xsl:attribute>
				<xsl:attribute name="width"><xsl:value-of select="$width"/></xsl:attribute>
				<xsl:attribute name="height"><xsl:value-of select="$height"/></xsl:attribute>
				<xsl:attribute name="class"><xsl:value-of select="$class"/></xsl:attribute>
				<xsl:attribute name="src"><xsl:value-of select="$file/file_location"/><xsl:value-of select="$file/file_source"/></xsl:attribute>
			</img>
		</xsl:otherwise>
	</xsl:choose>
</xsl:template>

</xsl:stylesheet>