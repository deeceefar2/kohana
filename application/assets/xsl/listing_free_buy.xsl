<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">

<xsl:output method="html" indent="yes" encoding="utf-8" omit-xml-declaration="yes" doctype-public="XSLT-compat"/>
<xsl:strip-space elements="*"/>

<xsl:include href="index.xsl"/>

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
					<h5>Create Listing</h5>
				</div>
			</div>
		</div>
		<div class="clearer"></div>
		<div class="threeColumn">
			<div class="padding15All">
				<div class="largeSectionWhite">
					<span class="iconPremiumListing floatRight"></span>
					<p>A listing for this address has already been created. However, you have the option to take ownership of this listing and purchase it as a premium listing.</p>
					<p>Premium listings have the added benefits defined below.</p>
					<a class="listingActions" href="/premium/buy">Purchase Premium</a><br/>
					<a class="listingActions">Listing FAQ</a><br/>
					<a class="listingActions">Contact Owner</a>
					<div class="clearer"></div>
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
					<div class="listingDescription floatRight">
						<h5>Why Choose Premium?</h5>
						<p>Lorem ipsum dolor sit amet, consectetur adipiscing elit. Donec purus quam, dignissim ac vulputate in, dapibus ac turpis. Aliquam erat volutpat. Quisque tempor, massa ac porta sodales, metus elit sagittis mauris, et dictum enim ipsum in mauris. Phasellus vel enim id neque placerat dictum. Integer euismod pulvinar magna, eget varius dui dapibus eget. Vestibulum sed lacus ac ante feugiat laoreet a at justo. Aliquam id arcu lobortis dolor consectetur elementum. Vestibulum risus lectus, tincidunt ac tempus nec, sagittis sed urna. Morbi feugiat quam quis lectus pellentesque id fringilla quam ultricies. Proin varius, mauris vel pretium consectetur, enim elit euismod justo, eu tristique nunc mi eu augue. Vivamus volutpat lobortis libero in mollis. Sed at est est. Aliquam ullamcorper tempor nibh in sagittis.</p>
						<p>Pellentesque adipiscing eros sit amet purus viverra fermentum. Vestibulum laoreet vehicula sapien, vitae pellentesque massa condimentum ac. Nullam ullamcorper porta sem, ac ultrices dolor sodales nec. Aliquam in nunc a libero tempor sagittis vel et nisl. Class aptent taciti sociosqu ad litora torquent per conubia nostra, per inceptos himenaeos. Praesent a lectus tellus, vel tristique tellus. Ut et nisl risus. Sed volutpat vestibulum lectus sed viverra. Pellentesque habitant morbi tristique senectus et netus et malesuada fames ac turpis egestas.</p>
						<h5>Featured Listing</h5>
						<p>Lorem ipsum dolor sit amet, consectetur adipiscing elit. Donec purus quam, dignissim ac vulputate in, dapibus ac turpis. Aliquam erat volutpat. Quisque tempor, massa ac porta sodales, metus elit sagittis mauris, et dictum enim ipsum in mauris. Phasellus vel enim id neque placerat dictum. Integer euismod pulvinar magna, eget varius dui dapibus eget. Vestibulum sed lacus ac ante feugiat laoreet a at justo. Aliquam id arcu lobortis dolor consectetur elementum. Vestibulum risus lectus, tincidunt ac tempus nec, sagittis sed urna. Morbi feugiat quam quis lectus pellentesque id fringilla quam ultricies.</p>
						<span class="purchaseContainer floatRight">
							<a class="formButton" href="/premium/buy">Purchase Premium Listing</a>
							<span class="iconPremiumListing"></span>
						</span>
					</div>
					<div class="exampleListing examplePremiumListing"></div>
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