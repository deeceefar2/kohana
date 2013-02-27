<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">

<xsl:output method="html" indent="yes" encoding="utf-8" omit-xml-declaration="yes" doctype-public="XSLT-compat"/>
<xsl:strip-space elements="*"/>

<xsl:include href="index.xsl"/>
<xsl:include href="snippets/subnav_profile.xsl"/>
<xsl:include href="snippets/listing_small.xsl"/>

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
		<xsl:call-template name="subnav_profile" />
		<div class="clearer"></div>
		<xsl:apply-templates select="bookmarks"/>
	</div>
</xsl:template>

<xsl:template match="bookmarks">
	<div class="browseResults threeColumn floatRight">
		<xsl:choose>
			<xsl:when test="count(bookmark)>0">
				<div class="listingContainer">
					<xsl:apply-templates select="bookmark"/>
				</div>
			</xsl:when>
			<xsl:otherwise>
				<div class="padding15All">
					<div class="largeSectionWhite">
						<h4 style="padding:0; margin:0;">You do not have any bookmarks currently.</h4>
					</div>
				</div>
			</xsl:otherwise>
		</xsl:choose>
	</div>
	<div class="clearRight"></div>
	<!-- <div class="threeColumn floatLeft">
		<div class="padding15All">
			<div class="loadMore whiteBar">
				<div class="loadMoreSection">
					<div class="loadMoreHeading">
						<h5>Load More</h5>
					</div>
					<div class="loadMoreButton"></div>
				</div>
			</div>
		</div>
	</div>
	<div class="clearer"></div> -->
</xsl:template>

<xsl:template match="bookmark">
	<xsl:apply-templates select="listing">
		<xsl:with-param name="type" select="2"/>
		<xsl:with-param name="bookmark_id" select="bookmark_id"/>
	</xsl:apply-templates>
</xsl:template>

<xsl:template match="text()"/>

</xsl:stylesheet>