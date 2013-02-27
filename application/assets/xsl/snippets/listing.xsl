<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform" >

<xsl:output method="html" indent="yes" encoding="utf-8" omit-xml-declaration="yes"/>
<xsl:strip-space elements="*"/>

<xsl:include href="file.xsl"/>

<xsl:template match="listing">
	<div class="oneColumn floatLeft">
		<a href="/listing/">
			<xsl:attribute name="href"><xsl:text>/listing/</xsl:text><xsl:value-of select="listing_id"/><xsl:text>/</xsl:text><xsl:value-of select="listing_slug"/></xsl:attribute>
		<div class="standardListingWrapper padding15All">
			<div class="standardListing padding12All">
				<xsl:if test="floor(listing_state div 2) mod 2 = 1">
					<span class="standardListingVerified floatRight"><img src="/assets/images/theme/content/check_mark.png" width="17" height="16" /></span>
				</xsl:if>
				<h5>
					<xsl:value-of select="listing_name"/>
				</h5>
				<div class="clearer"></div>
				<div class="standardListingColumn standardListingColumnLeft floatLeft">
					<span class="standardListingCity"><xsl:value-of select="listing_address_street_1"/></span>
					<div class="clearer"></div>
					<xsl:if test="listing_address_street_2 != ''">
						<span class="standardListingCity"><xsl:value-of select="listing_address_street_2"/></span>
						<div class="clearer"></div>
					</xsl:if>
					<span class="standardListingCity"><xsl:value-of select="listing_address_city"/></span>, <span class="standardListingState"><xsl:value-of select="listing_address_state"/></span>
					<div class="clearer"></div>
					<span class="standardListingPhoneNum"><xsl:value-of select="listing_phone"/></span>
					<div class="clearer"></div>
					<div class="standardListingFeedback">
						<span class="standardListingRating floatLeft">
							<span class="standardListingRatingFilled">
								<xsl:attribute name="style"><xsl:text>width:</xsl:text><xsl:value-of select="round((listing_review_value div 5) * 80)"/><xsl:text>px;</xsl:text></xsl:attribute>
								<xsl:value-of select="lsiting_review_value"/>
							</span>
						</span>
						<span class="standardListingRatingNumber floatLeft">(<xsl:value-of select="listing_review_num"/>)</span>
						<div class="clearer"></div>
					</div>
					<div class="clearer"></div>
					<span class="standardListingImage">
						<xsl:apply-templates select="default_image">
							<xsl:with-param name="width" select="132"/>
							<xsl:with-param name="height" select="132"/>
						</xsl:apply-templates>
					</span>
					<div class="clearer"></div>
				</div>
				<div class="standardListingColumn standardListingColumnRight floatLeft" style="text-align: justify">
					<p><xsl:value-of select="listing_information"/></p>
				</div>
			</div>
		</div>
		</a>
	</div>
</xsl:template>

</xsl:stylesheet>