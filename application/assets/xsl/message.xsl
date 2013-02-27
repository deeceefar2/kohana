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
	<xsl:choose>
		<xsl:when test="/root/meta/ajax != ''">
			<xsl:if test="/root/meta/redirect">
				<script type="text/javascript">
				<xsl:comment>
					$(document).ready(function() {
						$(document).bind('cbox_closed', function() {
							window.location = '<xsl:value-of select="/root/meta/redirect"/>';
						});
					});
				//</xsl:comment>
				</script>
			</xsl:if>
		</xsl:when>
	</xsl:choose>
	<div class="content">
		<div class="threeColumn">
			<div class="padding15All">
				<div class="blueBar">
					<h5><xsl:value-of select="message_title"/></h5>
				</div>
			</div>
		</div>
		<div class="clearer"></div>
		<div class="threeColumn">
			<div class="padding15All">
				<div class="largeSectionWhite">
					<div>
						<xsl:attribute name="class">
							<xsl:text>messageText</xsl:text>
							<xsl:choose>
								<xsl:when test="message_icon = 1">
									<xsl:text> iconCircleSuccess</xsl:text>
								</xsl:when>
								<xsl:when test="message_icon = 2">
									<xsl:text> iconCircleError</xsl:text>
								</xsl:when>
								<xsl:when test="message_icon = 3">
									<xsl:text> iconCircleForbidden</xsl:text>
								</xsl:when>
								<xsl:when test="message_icon = 4">
									<xsl:text> iconCircleCheckmark</xsl:text>
								</xsl:when>
								<xsl:when test="message_icon = 5">
									<xsl:text> iconCircleFailure</xsl:text>
								</xsl:when>
								<xsl:otherwise>
									<xsl:text> iconCircleSuccess</xsl:text>
								</xsl:otherwise>
							</xsl:choose>
						</xsl:attribute>
						<xsl:value-of select="message_text"/>
					</div>
				</div>
			</div>
		</div>
		<div class="clearer"></div>
	</div>
</xsl:template>

<xsl:template match="text()"/>

</xsl:stylesheet>