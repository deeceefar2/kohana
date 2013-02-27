<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">

<xsl:output method="html" indent="yes" encoding="utf-8" omit-xml-declaration="yes" doctype-public="XSLT-compat"/>
<xsl:strip-space elements="*"/>

<xsl:include href="index.xsl"/>
<xsl:include href="snippets/subnav_help.xsl"/>

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
		<xsl:call-template name="subnav_help" />
		<div class="clearer"></div>
		<div class="threeColumn">
			<div class="padding15All">
				<div class="largeSectionWhite">
					<h3>About Us</h3>
					<div class="imgFloatLeft"><img src="/assets/images/theme/content/medvoyager_about_us.png" /></div>
					<p>Life Care Planning Solutions was founded to provide timely and relevant information to individuals who are currently coping with chronic or acute health issues, individuals who’ve been newly diagnosed with a health problem, and to those involved in care planning or care giving. Our goal is to provide comprehensive and immediate health and medical resources to patients, caregivers, and medical professionals in an effort to reduce the time involved in care planning, to enhance freedom and quality of life, and to communicate a sense of comfort and support for those who have medical needs. We intimately know the challenges health issues can present and are truly committed to helping you improve your quality of life by reducing the stress or worry that accompanies care planning and the location of services and resources.</p>
					<div class="clearer"></div>
				</div>
			</div>
		</div>
		<div class="clearer"></div>
		<xsl:apply-templates />
	</div>
</xsl:template>

<xsl:template match="text()"/>

</xsl:stylesheet>