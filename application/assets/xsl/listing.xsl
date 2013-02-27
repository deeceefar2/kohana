<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">

<xsl:output method="html" indent="yes" encoding="utf-8" omit-xml-declaration="yes" doctype-public="XSLT-compat"/>
<xsl:strip-space elements="*"/>

<xsl:include href="index.xsl"/>

<xsl:include href="snippets/file.xsl"/>
<xsl:include href="snippets/google_maps.xsl"/>
<xsl:include href="snippets/url-encode.xsl" />
<xsl:include href="snippets/date.xsl" />
<xsl:include href="snippets/subnav_listings.xsl" />
<xsl:include href="snippets/field_value_processor.xsl" />

<xsl:template match="/">
	<xsl:choose>
		<xsl:when test="root/meta/ajax=1">
			<xsl:apply-templates select="/root/content"/>
		</xsl:when>
		<xsl:otherwise>
			<xsl:apply-templates select="root"/>
		</xsl:otherwise>
	</xsl:choose>
</xsl:template>

<xsl:template match="content">
	<div class="content">
		<xsl:call-template name="subnav_listings">
			<xsl:with-param name="crumbs" select="listing_categories"/>
		</xsl:call-template>
		<xsl:apply-templates select="listing" mode="title_bar"/>

		<div class="oneColumn floatLeft">
			<xsl:apply-templates select="listing_files"/>
			<xsl:apply-templates select="listing" mode="contact"/>
		</div>
		<xsl:if test="listing/listing_info != ''">
			<xsl:apply-templates select="listing" mode="info"/>
		</xsl:if>
		<xsl:choose>
			<xsl:when test="listing_fields/listing_field">
				<xsl:apply-templates select="listing_fields"/>
				<xsl:apply-templates select="listing" mode="reviews"/>
			</xsl:when>
			<xsl:otherwise>
				<xsl:apply-templates select="listing" mode="reviews"/>
			</xsl:otherwise>
		</xsl:choose>
		<xsl:apply-templates select="reviews"/>
	</div>
</xsl:template>

<xsl:template match="listing_categories">
	<xsl:apply-templates select="category[category_slug!='root']">
		<xsl:sort select="category_depth" data-type="text" order="ascending" />
	</xsl:apply-templates>
</xsl:template>

<xsl:template match="category">
	<xsl:param name="parent_id" select="parent_id"/>
	<a>
		<xsl:attribute name="href">
			<xsl:text>/listings/category/</xsl:text>
			<xsl:apply-templates select="../category[category_id=$parent_id]" mode="crumbhref"/>
			<xsl:value-of select="category_slug"/>
			<xsl:text>/</xsl:text>
		</xsl:attribute>
		<xsl:value-of select="category_name"/>
		<xsl:if test="position() != last()">
			<xsl:text> / </xsl:text>
		</xsl:if>
	</a>
</xsl:template>

<xsl:template match="category" mode="crumbhref">
	<xsl:param name="parent_id" select="parent_id"/>
	<xsl:choose>
		<xsl:when test="category_slug='root'">
		</xsl:when>
		<xsl:otherwise>
			<xsl:apply-templates select="../category[category_id=$parent_id]" mode="crumbhref"/>
			<xsl:value-of select="category_slug"/>
			<xsl:text>/</xsl:text>
		</xsl:otherwise>
	</xsl:choose>
</xsl:template>

<xsl:template match="listing" mode="title_bar">
	<div class="threeColumn">
		<div class="padding15All">
			<div class="largeSectionWhite">
				<h1 class="listingTitle floatLeft"><xsl:value-of select="listing_name"/></h1>

				<xsl:if test="floor(listing_state div 2) mod 2 = 1">
					<div class="listingPremiumRibbon floatLeft"></div>
				</xsl:if>
				<div class="userActionContainer floatRight">
					<span class="userAction floatRight">
					<xsl:choose>
						<xsl:when test="bookmark != ''">
							<a class="bookmarkListing modalLink">
								<xsl:attribute name="href"><xsl:value-of select="/root/meta/url"/>/bookmark_delete</xsl:attribute>
								<xsl:text>Delete Bookmark</xsl:text>
							</a>
						</xsl:when>
						<xsl:otherwise>
							<a class="bookmarkListing modalLink">
								<xsl:attribute name="href"><xsl:value-of select="/root/meta/url"/>/bookmark</xsl:attribute>
								<xsl:text>Bookmark</xsl:text>
							</a>
						</xsl:otherwise>
					</xsl:choose>
					</span>
					<span class="userAction floatRight">
						<a class="reportListing modalLink">
							<xsl:attribute name="href"><xsl:value-of select="/root/meta/url"/>/report</xsl:attribute>
							<xsl:text>Report</xsl:text>
						</a>
					</span>
					<span class="userAction floatRight">
						<a class="contactListing modalLink">
							<xsl:attribute name="href"><xsl:value-of select="/root/meta/url"/>/contact</xsl:attribute>
							<xsl:text>Contact</xsl:text>
						</a>
					</span>
				</div>
				<div class="clearer"></div>
			</div>
			<div class="clearer"></div>
		</div>
		<div class="clearer"></div>
	</div>
	<div class="clearer"></div>
</xsl:template>

<xsl:template match="listing_files">
		<div class="padding15All">
			<div class="largeSectionWhite">
				<div class="listingDefaultImage">
					<xsl:choose>
						<xsl:when test="default_image">
							<xsl:call-template name="image">
								<xsl:with-param name="file" select="default_image"/>
								<xsl:with-param name="width" select="260"/>
								<xsl:with-param name="height" select="260"/>
								<xsl:with-param name="rel" select="concat('gallery_', listing_id)"/>
								<xsl:with-param name="class" select="'premiumListingLargeImage floatLeft'"/>
							</xsl:call-template>
						</xsl:when>
						<xsl:otherwise>
							<xsl:text>No Image</xsl:text>
						</xsl:otherwise>
					</xsl:choose>
				</div>
				<div class="clearer"></div>
				<div class="listingThumbs">
					<xsl:apply-templates select="../files">
						<xsl:with-param name="default_image_id" select="listing_default_image_id"/>
					</xsl:apply-templates>
					<div class="clearer"></div>
				</div>
			</div>
		</div>
</xsl:template>

<xsl:template match="listing" mode="info">
	<div class="twoColumn floatRight">
		<div class="padding15All">
			<div class="largeSectionWhite listingInfo darkGrayText">
				<h4>Info</h4>
				<p><xsl:value-of select="listing_information"/></p>
				<div class="clearer"></div>
			</div>
		</div>
	</div>
</xsl:template>

<xsl:template match="listing" mode="contact">
	<div class="padding15All">
		<div class="largeSectionWhite darkGrayText">
			<h4>Contact</h4>
			<div class="listingContactInfo">
			<dl class="listingContactInfo">
				<xsl:if test="listing_website!=''">
					<dt class="floatLeft listingWebsite"></dt>
					<dd class="floatLeft">
						<a href="{listing_website}">
							<xsl:choose>
								<xsl:when test="string-length(listing_name) > 30">
									<xsl:value-of select="substring(listing_name,1,27)"/>
									<xsl:text>...</xsl:text>
								</xsl:when>
								<xsl:otherwise>
									<xsl:value-of select="listing_name"/>
								</xsl:otherwise>
							</xsl:choose>
						</a>
					</dd>
					<div class="clearer"></div>
				</xsl:if>
				<xsl:if test="listing_email!=''">
					<dt class="floatLeft listingEmail"></dt>
					<dd class="floatLeft">
						<a class="darkGrayText">
							<xsl:attribute name="href">
								<xsl:text>mailto:</xsl:text>
								<xsl:value-of select="listing_email"/>
							</xsl:attribute>
							<xsl:value-of select="listing_email"/>
						</a>
					</dd>
					<div class="clearer"></div>
				</xsl:if>
				<xsl:if test="listing_phone!=''">
					<dt class="floatLeft listingPhone"></dt>
					<dd class="floatLeft">
						<xsl:value-of select="listing_phone"/>
					</dd>
					<div class="clearer"></div>
				</xsl:if>
				<xsl:if test="listing_fax!=''">
					<dt class="floatLeft listingFax"></dt>
					<dd class="floatLeft">
						<xsl:value-of select="listing_fax"/>
					</dd>
					<div class="clearer"></div>
				</xsl:if>
			</dl>
			</div>
			<xsl:if test="1 = 1">
				<!--
				floor(listing_state div 2) mod 2 = 1
				<xsl:call-template name="get-google-map">
					<xsl:with-param name="map-type" select="'ROADMAP'"/>
					<xsl:with-param name="zoom-level" select="'17'"/>
					<xsl:with-param name="location-name" select="location_name"/>
					<xsl:with-param name="street-address" select="listing_address_street_1"/>
					<xsl:with-param name="city" select="listing_address_city"/>
					<xsl:with-param name="state" select="listing_address_state"/>
					<xsl:with-param name="zip-code" select="listing_address_zip"/>
					<xsl:with-param name="map-width" select="'260px'"/>
					<xsl:with-param name="map-height" select="'360px'"/>
					<xsl:with-param name="latlong">
						<xsl:value-of select="listing_address_lat"/>
						<xsl:text>, </xsl:text>
						<xsl:value-of select="listing_address_long"/>
					</xsl:with-param>
					<xsl:with-param name="document">
						<xsl:choose>
							<xsl:when test="/root/meta/render = 'client'">
								<xsl:text>no</xsl:text>
							</xsl:when>
							<xsl:otherwise>
								<xsl:text>yes</xsl:text>
							</xsl:otherwise>
						</xsl:choose>
					</xsl:with-param>
					<xsl:with-param name="label" select="'no'"/>
				</xsl:call-template>
				-->
				<a>
					<xsl:attribute name="href">
						<xsl:text>http://maps.google.com/?q=</xsl:text>
						<xsl:call-template name="url-encode">
							<xsl:with-param name="str">
								<xsl:value-of select="listing_address_street_1"/>
								<xsl:if test="listing_address_street_2 != ''">
									<xsl:text>, </xsl:text>
									<xsl:value-of select="listing_address_street_2"/>
								</xsl:if>
								<xsl:text>, </xsl:text>
								<xsl:value-of select="listing_address_city"/>
								<xsl:text>, </xsl:text>
								<xsl:value-of select="listing_address_state"/>
								<xsl:text> </xsl:text>
								<xsl:value-of select="listing_address_zip"/>
							</xsl:with-param>
						</xsl:call-template>
					</xsl:attribute>
					<img>
						<xsl:attribute name="src">
							<xsl:text>http://maps.googleapis.com/maps/api/staticmap?size=260x360&amp;maptype=roadmap&amp;sensor=false</xsl:text>
							<xsl:text>&amp;style=feature:road|hue:0x1D76BB|saturation:100|lightness:-5</xsl:text>
							<xsl:text>&amp;style=feature:landscape|hue:0xedfe20|saturation:100|lightness:-53</xsl:text>
							<xsl:text>&amp;markers=size:normal|color:white|label:O|</xsl:text>
							<xsl:call-template name="url-encode">
								<xsl:with-param name="str">
									<xsl:value-of select="listing_address_street_1"/>
									<xsl:text>, </xsl:text>
									<xsl:value-of select="listing_address_city"/>
									<xsl:text>, </xsl:text>
									<xsl:value-of select="listing_address_state"/>
									<xsl:text> </xsl:text>
									<xsl:value-of select="listing_address_zip"/>
								</xsl:with-param>
							</xsl:call-template>
						</xsl:attribute>
					</img>
				</a>
			</xsl:if>
			<br/>
			<h5><xsl:value-of select="listing_name"/></h5>
			<span class="listingAddress">
				<xsl:value-of select="listing_address_street_1"/><br/>
				<xsl:if test="listing_address_street_2 != ''">
					<xsl:value-of select="listing_address_street_2"/><br/>
				</xsl:if>
				<xsl:value-of select="listing_address_city"/>, <xsl:value-of select="listing_address_state"/><br/>
				<xsl:value-of select="listing_address_zip"/><br/>
			</span>
		</div>
	</div>
</xsl:template>

<xsl:template match="listing_fields">
	<div class="twoColumn floatRight">
		<div class="padding15All">
			<div class="largeSectionWhite listingInfo darkGrayText">
				<h4>Properties</h4>
				<dl class="formValues">
					<xsl:apply-templates select="listing_field"/>
				</dl>
				<div class="clearer"></div>
			</div>
		</div>
	</div>
</xsl:template>

<xsl:template match="listing" mode="reviews">
	<div class="twoColumn floatRight">
		<div class="padding15All reviewsAndRating">
			<div class="blueBar">
				<span class="reviewNumber floatLeft">
					<h5>User Reviews</h5>
				</span>
				<span class="ratingContainer floatRight">
					<span class="overallRating floatLeft">
						<h5>Overall Rating (<xsl:value-of select="listing_review_num"/>)</h5>
					</span>
					<div class="listingRating">
						<div class="listingRatingFilled">
							<xsl:attribute name="style"><xsl:text>width:</xsl:text><xsl:value-of select="round((listing_review_value div 5) * 100)"/><xsl:text>px;</xsl:text></xsl:attribute>
						</div>
					</div>
				</span>
			</div>
			<div class="largeSectionWhite">
				<xsl:choose>
					<xsl:when test="/root/meta/user != ''">
						<script type="text/javascript">
							$(function(){
								$("#starify").children().not(":input").hide();

								// Create stars from :radio boxes
								$("#starify").stars({
									cancelShow: false
								});
							});
						</script>
						<form class="listingForm" method="post">
							<xsl:attribute name="action">
								<xsl:value-of select="/root/meta/url"/>
								<xsl:text>/review</xsl:text>
							</xsl:attribute>
							<input name="csrf" type="hidden">
								<xsl:attribute name="value"><xsl:value-of select="/root/meta/csrf"/></xsl:attribute>
							</input>
							<xsl:if test="review">
								<input name="review_id" type="hidden" value="{review/review_id}"/>
							</xsl:if>
							<dl class="formSection">

								<!-- Rating -->
								<dt class="floatLeft">
									Rating
								</dt>
								<dd class="halfPageText floatLeft">
									<div id="starify">
										<label for="vote1" class="blockLabel">
											<input type="radio" name="review_rating" id="vote1" value="1">
												<xsl:if test="review/review_rating=1 or /root/meta/post/review_rating=1">
													<xsl:attribute name="checked">checked</xsl:attribute>
												</xsl:if>
											</input>
										</label>
										<label for="vote2" class="blockLabel">
											<input type="radio" name="review_rating" id="vote2" value="2">
												<xsl:if test="review/review_rating=2 or /root/meta/post/review_rating=2">
													<xsl:attribute name="checked">checked</xsl:attribute>
												</xsl:if>
											</input>
										</label>
										<label for="vote3" class="blockLabel">
											<input type="radio" name="review_rating" id="vote3" value="3">
												<xsl:choose>
													<xsl:when test="review">
														<xsl:if test="review/review_rating=3 or /root/meta/post/review_rating=3">
															<xsl:attribute name="checked">checked</xsl:attribute>
														</xsl:if>
													</xsl:when>
													<xsl:otherwise>
														<xsl:attribute name="checked">checked</xsl:attribute>
													</xsl:otherwise>
												</xsl:choose>
											</input>
										</label>
										<label for="vote4" class="blockLabel">
											<input type="radio" name="review_rating" id="vote4" value="4">
												<xsl:if test="review/review_rating=4 or /root/meta/post/review_rating=4">
													<xsl:attribute name="checked">checked</xsl:attribute>
												</xsl:if>
											</input>
										</label>
										<label for="vote5" class="blockLabel">
											<input type="radio" name="review_rating" id="vote5" value="5">
												<xsl:if test="review/review_rating=5 or /root/meta/post/review_rating=5">
													<xsl:attribute name="checked">checked</xsl:attribute>
												</xsl:if>
											</input>
										</label>
									</div>
								</dd>
								<div class="clearer"></div>

								<!-- Title -->
								<xsl:if test="errors/review_title">
									<span class="formError floatLeft">
										<xsl:value-of select="errors/review_title" />
									</span>
									<div class="clearer"></div>
								</xsl:if>
								<dt class="floatLeft">
									<label for="review_title">Title</label>
								</dt>
								<dd class="halfPageTextbox floatLeft">
									<input class="reviewTitle" id="review_title" type="text" name="review_title" placeholder="(optional)" tabindex="2">
										<xsl:choose>
											<xsl:when test="review">
												<xsl:attribute name="value">
													<xsl:value-of select="review/review_title"/>
												</xsl:attribute>
											</xsl:when>
											<xsl:otherwise>
												<xsl:attribute name="value">
													<xsl:value-of select="/root/meta/post/review_title"/>
												</xsl:attribute>
											</xsl:otherwise>
										</xsl:choose>
									</input>
								</dd>
								<div class="clearer"></div>

								<!-- Body -->
								<xsl:if test="errors/review_body">
									<span class="formError floatLeft">
										<xsl:value-of select="errors/review_body" />
									</span>
									<div class="clearer"></div>
								</xsl:if>
								<dt class="floatLeft">
									<label for="review_body">Comment</label>
								</dt>
								<dd class="halfPageTextarea floatLeft">
									<textarea class="reviewBody" id="review_body" name="review_body" tabindex="3" placeholder="(optional)">
										<xsl:choose>
											<xsl:when test="review">
												<xsl:value-of select="review/review_body"/>
											</xsl:when>
											<xsl:otherwise>
												<xsl:value-of select="/root/meta/post/review_body"/>
											</xsl:otherwise>
										</xsl:choose>
									</textarea>
								</dd>
								<div class="clearer"></div>

								<dt class="floatLeft"></dt>
								<dd class="formSubmit floatLeft">
									<input class="formButton floatRight" type="submit" value="Submit" tabindex="4"/>
								</dd>
								<div class="clearer"></div>
							</dl>
							<div class="clearer"></div>
						</form>
					</xsl:when>
					<xsl:otherwise>
						<h4 class="floatRight">
							<a>
								<xsl:attribute name="href">
									<xsl:text>/login?redirect=</xsl:text>
									<xsl:value-of select="/root/meta/uri"/>
								</xsl:attribute>
								<xsl:text>Sign in</xsl:text>
							</a>
							<xsl:text> to submit a review</xsl:text>
						</h4>
					</xsl:otherwise>
				</xsl:choose>
				<div class="clearer"></div>
			</div>
		</div>
	</div>
</xsl:template>

<xsl:template match="reviews">
	<div class="twoColumn floatRight">
		<div class="padding15All">
			<xsl:apply-templates select="review"/>
		</div>
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
	</div>
</xsl:template>

<xsl:template match="review">
	<div class="reviewBluebar">
		<span class="reviewRatingContainer floatLeft">
			<div class="reviewRating">
				<span class="reviewRatingFilled">
					<xsl:attribute name="style"><xsl:text>width:</xsl:text><xsl:value-of select="round((review_rating div 5) * 100)"/><xsl:text>px;</xsl:text></xsl:attribute>
				</span>
			</div>
		</span>
		<span class="userActionSmallContainer floatRight">
			<a class="reportReviewSmall modalLink" name="{review_id}">
				<xsl:attribute name="href"><xsl:text>report_review/</xsl:text><xsl:value-of select="review_id"/></xsl:attribute>
				<xsl:text>Report</xsl:text>
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
		<xsl:if test="/root/content/listing/user_id = /root/meta/user/user_id and floor(/root/content/listing/listing_state div 2) mod 2 = 1 and reply_id=''">
			<a class="replyToComment floatRight">[Reply To Comment]</a>
		</xsl:if>
		<div class="clearer"></div>
	</div>
</xsl:template>

<xsl:template match="files">
	<xsl:param name="default_image_id"/>
	<xsl:apply-templates select="file[file_id != $default_image_id and position()&lt;6]">
		<xsl:with-param name="width" select="50"/>
		<xsl:with-param name="height" select="50"/>
		<xsl:with-param name="class" select="'listingSmallImage floatLeft'"/>
		<xsl:with-param name="rel" select="concat('gallery_', ../listing/listing_id)"/>
	</xsl:apply-templates>
	<script type="text/javascript">
		$('a[rel=<xsl:value-of select="concat('gallery_', ../listing/listing_id)"/>]').colorbox({rel:'<xsl:value-of select="concat('gallery_', ../listing/listing_id)"/>'});
	</script>
</xsl:template>

<xsl:template match="text()"/>

</xsl:stylesheet>