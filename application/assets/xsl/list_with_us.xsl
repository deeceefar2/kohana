<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">

<xsl:output method="html" indent="yes" encoding="utf-8" omit-xml-declaration="yes" doctype-public="XSLT-compat"/>
<xsl:strip-space elements="*"/>

<xsl:include href="index.xsl"/>

<xsl:include href="snippets/listing_small.xsl" />

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
		<div class="threeColumn">
			<div class="padding15All">
				<div class="blueBar">
					<h5>List With Us</h5>
				</div>
			</div>
		</div>
		<div class="clearer"></div>
		<div class="threeColumn">
			<div class="padding15All">
				<div class="largeSectionWhite">
					<div class="twoColumn floatRight">
						<table class="tableListingBenefits">
							<tr>
								<td>
									<h5>Contact</h5>
								</td>
								<td>
									<h5>Location</h5>
								</td>
								<td>
									<h5>Google<br/>Maps</h5>
								</td>
								<td>
									<h5>Photo<br/>Gallery</h5>
								</td>
								<td>
									<h5>Reply To<br/>Reviews</h5>
								</td>
							</tr>
							<tr class="tableListingBenefitsRow tableListingBenefitsBorderRow">
								<td>
									<span class="checkMarkLarge"></span>
								</td>
								<td>
									<span class="checkMarkLarge"></span>
								</td>
								<td>
									<span class="checkMarkLarge"></span>
								</td>
								<td>
									<span class="checkMarkLarge"></span>
								</td>
								<td>
									<span class="checkMarkLarge"></span>
								</td>
							</tr>
							<tr class="tableListingBenefitsRow">
								<td>
									<span class="checkMarkLarge"></span>
								</td>
								<td>
									<span class="checkMarkLarge"></span>
								</td>
								<td></td>
								<td></td>
								<td></td>
							</tr>
						</table>
					</div>
					<div class="listingIconContainer floatLeft">
						<span class="iconPremiumListing"></span>
						<span class="iconFreeListing"></span>
						<div class="clearer"></div>
					</div>
					<div class="clearer"></div>
				</div>
			</div>
		</div>
		<div class="clearer"></div>
		<div class="threeColumn">
			<div class="padding15All">
				<div class="largeSectionWhite">
					<h4>Premium Listing</h4>
					<div style="margin: -20px;">
						<xsl:apply-templates select="premium_listing/listing"/>
					</div>
					<div class="floatRight" style="width: 600px;">
						<h5>Why Choose Premium?</h5>
						<p>Your company, as a Premium Listing, will be distinguished, recognized, and receive added advertising prominence on MedVoyager. Our featured Premium Listing has many perks that are not included with the free listing, such as: multiple pictures of your business, a detailed description of your company and services, customer reviews and star ratings that will encourage consumers to select your company, a detailed map showing directions to your location, your website and contact information, and the payer sources you accept.</p>
						<span class="purchaseContainer floatRight">
							<a class="formButton" href="/listings/new">Purchase Premium Listing</a>
							<span class="iconPremiumListing"></span>
						</span>
					</div>
					<div class="clearer"></div>
					<h4>Free Listing</h4>
					<div class="floatRight" style="width: 600px;">
						<p>Your company, as a Free Listing, will be able to promote your business and services while receiving free advertisement from MedVoyager. As a Free Listing, you will be able to display a picture of your company, a description of your company and services, your contact information and website, and the payer sources you accept.</p>
						<span class="purchaseContainer floatRight">
							<a class="formButton" href="/listings/new">Create Free Listing</a>
							<span class="iconFreeListing"></span>
						</span>
					</div>
					<div style="margin: -20px;">
						<xsl:apply-templates select="free_listing/listing"/>
					</div>
					<div class="clearer"></div>
				</div>
			</div>
		</div>
		<div class="clearer"></div>
	</div>
</xsl:template>

<xsl:template match="text()"/>

</xsl:stylesheet>