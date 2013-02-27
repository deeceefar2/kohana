<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:date="http://exslt.org/dates-and-times">

<xsl:output method="html" indent="yes" encoding="utf-8" omit-xml-declaration="yes" doctype-public="XSLT-compat"/>
<xsl:strip-space elements="*"/>

<xsl:include href="index.xsl"/>
<xsl:include href="snippets/subnav_profile.xsl"/>
<xsl:include href="snippets/file.xsl"/>

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
		<div class="padding15All">
			<div class="largeSectionWhite">
				<div class="reportThankYou">
					<span class="iconCircleCheckmarkGreen floatLeft"></span>
					<p>W9 Tax Form</p>
				</div>
				<p>
					<xsl:text>Lorem ipsum dolor sit amet, consectetur adipiscing elit. Donec urna velit, pellentesque quis tincidunt at, vehicula nec eros. Vestibulum ante ipsum primis in faucibus orci luctus et ultrices posuere cubilia Curae; Vestibulum iaculis eros at orci dictum eget porttitor enim pulvinar. Sed bibendum metus nec purus eleifend vitae placerat sapien convallis.</xsl:text>
				</p>
				<div class="floatRight">
					<form enctype="multipart/form-data" action="{/root/meta/url}" method="POST">
					<a href="/assets/pdf/fw9.pdf" target="_blank" class="formButton floatLeft">Download PDF</a>
						<input name="csrf" type="hidden">
							<xsl:attribute name="value"><xsl:value-of select="/root/meta/csrf"/></xsl:attribute>
						</input>
						<input type="hidden" name="MAX_FILE_SIZE" value="25000000" />
						<div style="height: 30px; line-height: 30px; margin:10px 0; float: left; vertical-align: middle;">
							<input type="file" name="file"/>
						</div>
						<input type="submit" class="formButton floatLeft" value="Submit Form*" />
					</form>
					<div class="clearer"></div>
					<span style="margin-right: 80px; float: right;">*files cannot exceed 25MB. We accept jpg, png, and pdf.</span>
				</div>
				<div class="clearer"></div>
			</div>
		</div>
		<div class="clearer"></div>
		<div class="padding15All">
			<div class="largeSectionWhite">
				<div class="reportThankYou">
					<span class="iconCircleCheckmarkGreen floatLeft"></span>
					<p>Sales Flyers</p>
				</div>
				<p>
					<xsl:text>Lorem ipsum dolor sit amet, consectetur adipiscing elit. Donec urna velit, pellentesque quis tincidunt at, vehicula nec eros. Vestibulum ante ipsum primis in faucibus orci luctus et ultrices posuere cubilia Curae; Vestibulum iaculis eros at orci dictum eget porttitor enim pulvinar. Sed bibendum metus nec purus eleifend vitae placerat sapien convallis.</xsl:text>
				</p>
				<div class="floatRight">
					<a href="/profile/requestflyers" class="formButton">Request Flyers</a>
				</div>
				<div class="clearer"></div>
			</div>
		</div>
		<div class="clearer"></div>
		<xsl:choose>
			<xsl:when test="count(listings/listing)>0">
				<xsl:apply-templates select="listings"/>
			</xsl:when>
			<xsl:otherwise>
				<div class="padding15All">
					<div class="largeSectionWhite">
						<h4 style="padding:0; margin:0;">You do not have any referrals currently.</h4>
					</div>
				</div>
			</xsl:otherwise>
		</xsl:choose>
		<div class="threeColumn floatLeft">
			<div class="padding15All">
				<div class="largeSectionWhite">
					<iframe width="921" height="518" src="http://www.youtube-nocookie.com/embed/UUk47HhoOeA?rel=0" frameborder="0"  webkitAllowFullScreen="webkitAllowFullScreen" mozallowfullscreen="mozallowfullscreen" allowFullScreen="allowFullScreen"></iframe>
					<div class="clearer"></div>
					<h4 style="margin-top: 15px;">On the voyage of life when a health-related question arises, MedVoyager is the answer. Watch the video to see the opportunities MedVoyager has for you or your business.</h4>
				</div>
			</div>
		</div>
		<div class="clearer"></div>
	</div>
</xsl:template>

<xsl:template match="listings">
	<xsl:apply-templates select="listing"/>
</xsl:template>

<xsl:template match="listing">
	<div class="padding15All">
		<div class="largeSectionWhite">
			<div class="col50 floatLeft">
				<h4><xsl:value-of select="listing_name"/></h4>
				<h5>Created: <xsl:value-of select="substring(date:add('1970-01-01T00:00:00Z', date:duration(listing_date_modified)), 1, 10)"/></h5>
				<h5>Purchased By: <xsl:value-of select="'test'"/></h5>
				<h5>Transfered To: <xsl:value-of select="'test'"/></h5>
				<h5>Mailers: <xsl:value-of select="'test'"/></h5>
			</div>
			<div class="floatRight col50">
				<h5>Listing Completion:</h5>
				<div class="listingCompletion">50/100</div>
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
			</div>
			<div class="clearer"></div>
		</div>
	</div>
	<div class="clearRight"></div>
</xsl:template>

<xsl:template match="text()"/>

</xsl:stylesheet>