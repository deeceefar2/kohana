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
			<h3>Review of <xsl:value-of select="listing/listing_name"/></h3>
			<p><b>Listing Id:</b> <xsl:value-of select="listing/listing_id"/></p>
			<p><b>Listing Name:</b>
				<a>
					<xsl:attribute name="href">
						<xsl:text>http://www.medvoyager.com/listing/</xsl:text>
						<xsl:value-of select="listing/listing_slug"/>
						<xsl:text>/</xsl:text>
						<xsl:value-of select="listing/listing_id"/>
						<xsl:text>/</xsl:text>
					</xsl:attribute>
					<xsl:value-of select="listing/listing_name"/>
				</a>
			</p>
			<p><b>Review Title:</b>
				<a>
					<xsl:attribute name="href">
						<xsl:text>http://www.medvoyager.com/listing/</xsl:text>
						<xsl:value-of select="review/listing/listing_slug"/>
						<xsl:text>/</xsl:text>
						<xsl:value-of select="review/listing_id"/>
						<xsl:text>/#</xsl:text>
						<xsl:value-of select="review/review_id"/>
					</xsl:attribute>
					<xsl:value-of select="review/review_title"/>
				</a>
			</p>
			<p><b>Review Body:</b> <pre><xsl:value-of select="review/review_body"/></pre></p>
		</div>
	</div>
</xsl:template>

<xsl:template match="text()"/>

</xsl:stylesheet>