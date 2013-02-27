<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform" >

<xsl:output method="html" indent="yes" encoding="utf-8" omit-xml-declaration="yes"/>
<xsl:strip-space elements="*"/>

<xsl:include href="file.xsl"/>
<xsl:include href="abbreviate.xsl"/>

<xsl:template match="listing">
	<xsl:param name="type"/>
	<xsl:param name="bookmark_id"/>
	<div class="oneColumn floatLeft">
		<div class="standardListingWrapper padding15All floatLeft">
			<div class="standardListing padding12All">
				<div class="standardListingTitleBar">
					<xsl:if test="floor(listing_state div 2) mod 2 = 1">
						<img class="floatRight" src="/assets/images/theme/content/check_mark.png" width="17" height="16" />
					</xsl:if>
					<xsl:if test="$type=2">
						<a class="deleteListing floatRight modalLink">
							<xsl:attribute name="href">
								<xsl:text>/profile/bookmarks/</xsl:text>
								<xsl:value-of select="$bookmark_id"/>
								<xsl:text>/delete</xsl:text>
							</xsl:attribute>
						</a>
					</xsl:if>
					<xsl:if test="$type=3">
						<!--
						<a class="deleteListing floatRight">
							<xsl:attribute name="href">
								<xsl:text>/profile/bookmarks/</xsl:text>
								<xsl:value-of select="$bookmark_id"/>
								<xsl:text>/delete</xsl:text>
							</xsl:attribute>
						</a>
						<a class="editListing floatRight">
							<xsl:attribute name="href">
								<xsl:text>/profile/bookmarks/</xsl:text>
								<xsl:value-of select="$bookmark_id"/>
								<xsl:text>/delete</xsl:text>
							</xsl:attribute>
						</a>
						-->
					</xsl:if>
					<a>
						<xsl:attribute name="href"><xsl:text>/listing/</xsl:text><xsl:value-of select="listing_slug"/><xsl:text>/</xsl:text><xsl:value-of select="listing_id"/>/</xsl:attribute>
						<h5 class="listingSmallTitle">
							<xsl:call-template name="abbreviate">
								<xsl:with-param name="string" select="listing_name"/>
								<xsl:with-param name="length" select="27"/>
							</xsl:call-template>
						</h5>
					</a>
				</div>
				<a class="standardListingColumn standardListingColumnLeft floatLeft">
					<xsl:attribute name="href"><xsl:text>/listing/</xsl:text><xsl:value-of select="listing_slug"/><xsl:text>/</xsl:text><xsl:value-of select="listing_id"/>/</xsl:attribute>
					<div class="listingLine">
						<span>
							<xsl:call-template name="abbreviate">
								<xsl:with-param name="string" select="listing_address_street_1"/>
								<xsl:with-param name="length" select="22"/>
							</xsl:call-template>
						</span>
					</div>
					<xsl:if test="listing_address_street_2 != ''">
						<div class="listingLine">
							<span>
								<xsl:call-template name="abbreviate">
									<xsl:with-param name="string" select="listing_address_street_2"/>
									<xsl:with-param name="length" select="27"/>
								</xsl:call-template>
							</span>
						</div>
					</xsl:if>
					<div class="listingLine">
						<span>
							<xsl:call-template name="abbreviate">
								<xsl:with-param name="string" select="listing_address_city"/>
								<xsl:with-param name="length" select="27"/>
							</xsl:call-template>
						</span>
						<xsl:text>, </xsl:text>
						<span>
							<xsl:call-template name="abbreviate">
								<xsl:with-param name="string" select="listing_address_state"/>
								<xsl:with-param name="length" select="27"/>
							</xsl:call-template>
						</span>
						<xsl:text> </xsl:text>
						<span>
							<xsl:call-template name="abbreviate">
								<xsl:with-param name="string" select="listing_address_zip"/>
								<xsl:with-param name="length" select="27"/>
							</xsl:call-template>
						</span>
					</div>
					<div class="listingLine">
						<span><xsl:value-of select="listing_phone"/></span>
					</div>
					<div class="standardListingBase">
						<div class="standardListingFeedback">
							<div class="standardListingRating floatLeft">
								<div class="standardListingRatingFilled">
									<xsl:attribute name="style">
										<xsl:text>width:</xsl:text>
										<xsl:choose>
											<xsl:when test="listing_review_value = ''">
												<xsl:text>0;</xsl:text>
											</xsl:when>
											<xsl:otherwise>
												<xsl:value-of select="round((listing_review_value div 5) * 80)"/>
												<xsl:text>px;</xsl:text>
											</xsl:otherwise>
										</xsl:choose>
									</xsl:attribute>
								</div>
							</div>
							<div class="standardListingRatingNumber floatLeft">(<xsl:value-of select="listing_review_num"/>)</div>
						</div>
						<div class="standardListingImage">
							<xsl:choose>
								<xsl:when test="default_image">
									<xsl:call-template name="image">
										<xsl:with-param name="file" select="default_image"/>
										<xsl:with-param name="width" select="132"/>
										<xsl:with-param name="height" select="132"/>
									</xsl:call-template>
								</xsl:when>
								<xsl:otherwise>
									<xsl:text>No Image</xsl:text>
								</xsl:otherwise>
							</xsl:choose>
						</div>
						<div class="clearer"></div>
					</div>
					<div class="clearer"></div>
				</a>
				<a class="standardListingColumn standardListingColumnRight floatLeft" style="text-align: justify">
					<xsl:attribute name="href"><xsl:text>/listing/</xsl:text><xsl:value-of select="listing_slug"/><xsl:text>/</xsl:text><xsl:value-of select="listing_id"/>/</xsl:attribute>
					<p><xsl:value-of select="listing_information"/></p>
				</a>
			</div>
		</div>
	</div>
</xsl:template>

</xsl:stylesheet>