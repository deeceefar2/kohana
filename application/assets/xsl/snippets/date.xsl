<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">

<xsl:output method="html" indent="yes" encoding="utf-8" omit-xml-declaration="yes" doctype-public="XSLT-compat"/>
<xsl:strip-space elements="*"/>

<xsl:template name="secondsAgo">
	<xsl:param name="seconds"/>
	<xsl:param name="recursive"/>
	<xsl:call-template name="timeDivider">
		<xsl:with-param name="seconds" select="$seconds"/>
		<xsl:with-param name="recursive" select="$recursive"/>
	</xsl:call-template>
	<xsl:text>ago</xsl:text>
</xsl:template>

<xsl:template name="timeDivider">
	<xsl:param name="seconds"/>
	<xsl:param name="recursive"/>
	<xsl:choose>
		<xsl:when test="$seconds &gt; 86400">
			<xsl:value-of select="floor($seconds div 86400)"/>
			<xsl:choose>
				<xsl:when test="floor($seconds div 86400)>1">
					<xsl:text> days </xsl:text>
				</xsl:when>
				<xsl:otherwise>
					<xsl:text> day </xsl:text>
				</xsl:otherwise>
			</xsl:choose>
			<xsl:if test="$recursive = 1">
				<xsl:call-template name="timeDivider">
					<xsl:with-param name="seconds" select="$seconds mod 86400"/>
					<xsl:with-param name="recursive" select="$recursive"/>
				</xsl:call-template>
			</xsl:if>
		</xsl:when>
		<xsl:when test="$seconds &gt; 3600">
			<xsl:value-of select="floor($seconds div 3600)"/>
			<xsl:choose>
				<xsl:when test="floor($seconds div 3600)>1">
					<xsl:text> hours </xsl:text>
				</xsl:when>
				<xsl:otherwise>
					<xsl:text> hour </xsl:text>
				</xsl:otherwise>
			</xsl:choose>
			<xsl:if test="$recursive = 1">
				<xsl:call-template name="timeDivider">
					<xsl:with-param name="seconds" select="$seconds mod 3600"/>
					<xsl:with-param name="recursive" select="$recursive"/>
				</xsl:call-template>
			</xsl:if>
		</xsl:when>
		<xsl:when test="$seconds &gt; 60">
			<xsl:value-of select="floor($seconds div 60)"/>
			<xsl:choose>
				<xsl:when test="floor($seconds div 60)>1">
					<xsl:text> minutes </xsl:text>
				</xsl:when>
				<xsl:otherwise>
					<xsl:text> minute </xsl:text>
				</xsl:otherwise>
			</xsl:choose>
			<xsl:if test="$recursive = 1">
				<xsl:call-template name="timeDivider">
					<xsl:with-param name="seconds" select="$seconds mod 60"/>
					<xsl:with-param name="recursive" select="$recursive"/>
				</xsl:call-template>
			</xsl:if>
		</xsl:when>
		<xsl:otherwise>
			<xsl:value-of select="$seconds"/>
			<xsl:text> seconds </xsl:text>
		</xsl:otherwise>
	</xsl:choose>
</xsl:template>

<xsl:template match="text()"/>

</xsl:stylesheet>