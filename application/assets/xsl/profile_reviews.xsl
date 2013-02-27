<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">

<xsl:output method="html" indent="yes" encoding="utf-8" omit-xml-declaration="yes" doctype-public="XSLT-compat"/>
<xsl:strip-space elements="*"/>

<xsl:include href="index.xsl"/>
<xsl:include href="snippets/subnav_profile.xsl"/>
<xsl:include href="snippets/listing_small.xsl"/>
<xsl:include href="snippets/date.xsl" />

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
		<xsl:choose>
			<xsl:when test="count(reviews/review)>0">
				<xsl:apply-templates select="reviews"/>
			</xsl:when>
			<xsl:otherwise>
				<div class="padding15All">
					<div class="largeSectionWhite">
						<h4 style="padding:0; margin:0;">You do not have any reviews currently.</h4>
					</div>
				</div>
			</xsl:otherwise>
		</xsl:choose>
	</div>
</xsl:template>

<xsl:template match="reviews">
	<xsl:apply-templates select="review"/>
	<!--
	<div class="loadMoreResults">
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
	-->
	<div class="clearer"></div>
</xsl:template>

<xsl:template match="review">
		<xsl:apply-templates select="listing">
			<xsl:with-param name="type" select="1"/>
		</xsl:apply-templates>
		<div class="twoColumn floatRight">
			<div class="reviewListing padding15All">
				<div class="reviewBluebar">
					<span class="reviewRatingContainer floatLeft">
						<div class="reviewRating">
							<span class="reviewRatingFilled">
								<xsl:attribute name="style"><xsl:text>width:</xsl:text><xsl:value-of select="round((review_rating div 5) * 100)"/><xsl:text>px;</xsl:text></xsl:attribute>
							</span>
						</div>
					</span>
					<span class="userActionSmallContainer floatRight">
						<a style="color: #ffffff;">
							<xsl:attribute name="href">
								<xsl:text>/profile/reviews/</xsl:text>
								<xsl:value-of select="review_id"/>
								<xsl:text>/delete</xsl:text>
							</xsl:attribute>
							<xsl:text>Delete</xsl:text>
						</a>
					</span>
					<span class="userActionSmallContainer floatRight" style="margin-right: 20px;">
						<a style="color: #ffffff;">
							<xsl:attribute name="href">
								<xsl:text>/listing/</xsl:text>
								<xsl:value-of select="listing/listing_slug"/>
								<xsl:text>/</xsl:text>
								<xsl:value-of select="listing/listing_id"/>
								<xsl:text>/</xsl:text>
							</xsl:attribute>
							<xsl:text>Edit</xsl:text>
						</a>
					</span>
				</div>
				<div class="reviewContent largeSectionWhite darkGrayText">
					<h5 class="floatRight">
						<span class="reviewDate">
							<xsl:call-template name="secondsAgo">
								<xsl:with-param name="seconds" select="/root/meta/server_time - review_date_modified"/>
							</xsl:call-template>
						</span>
					</h5>
					<h5>"<xsl:value-of select="review_title"/>"</h5>
					<p style="white-space: pre-wrap;"><xsl:value-of select="review_body"/></p>
					<h5 class="floatLeft">- <span class="reviewUsername"><xsl:value-of select="username"/></span></h5>
					<div class="clearer"></div>
				</div>
			</div>
		</div>
		<div class="clearer"></div>
</xsl:template>

<xsl:template match="text()"/>

</xsl:stylesheet>