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
			<h3><xsl:value-of select="report_type/report_type_name"/></h3>
			<xsl:choose>
				<xsl:when test="report_type/report_type_model = 'listing'">
					<p><b>Listing Id:</b> <xsl:value-of select="object/listing_id"/></p>
					<p><b>Listing Name:</b>
						<a>
							<xsl:attribute name="href">
								<xsl:text>http://www.medvoyager.com/listing/</xsl:text>
								<xsl:value-of select="object/listing_slug"/>
								<xsl:text>/</xsl:text>
								<xsl:value-of select="object/listing_id"/>
								<xsl:text>/</xsl:text>
							</xsl:attribute>
							<xsl:value-of select="object/listing_name"/>
						</a>
					</p>
				</xsl:when>
				<xsl:when test="report_type/report_type_model = 'review'">
					<p><b>Review Id:</b> <xsl:value-of select="object/review_id"/></p>
					<p><b>Review Title:</b>
						<a>
							<xsl:attribute name="href">
								<xsl:text>http://www.medvoyager.com/listing/</xsl:text>
								<xsl:value-of select="object/listing/listing_slug"/>
								<xsl:text>/</xsl:text>
								<xsl:value-of select="object/listing_id"/>
								<xsl:text>/#</xsl:text>
								<xsl:value-of select="object/review_id"/>
							</xsl:attribute>
							<xsl:value-of select="object/review_title"/>
						</a>
					</p>
					<p><b>Review Body:</b> <xsl:value-of select="object/review_body"/></p>
				</xsl:when>
			</xsl:choose>
			<p><b>Issue:</b> <xsl:value-of select="report_category/report_category_name"/></p>
			<p><b>Title:</b> <xsl:value-of select="report/report_title"/></p>
			<p><b>Comments:</b> <xsl:value-of select="report/report_text"/></p>
			<xsl:if test="user">
				<p><b>User:</b> <a href="mailto:{user/email}"><xsl:value-of select="user/user_first_name"/> <xsl:value-of select="user/user_last_name"/></a></p>
				<p><b>Object Owner:</b> <a href="mailto:{object_user/email}"><xsl:value-of select="object_user/user_first_name"/> <xsl:value-of select="object_user/user_last_name"/></a></p>
			</xsl:if>
		</div>
	</div>
</xsl:template>

<xsl:template match="text()"/>

</xsl:stylesheet>