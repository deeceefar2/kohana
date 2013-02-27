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
				<div class="blueBar"></div>
			</div>
		</div>
		<div class="clearer"></div>
		<div class="twoColumn floatLeft">
			<div class="padding15All">
				<div style="background-color: #ffffff; padding: 20px; height: 495px; width: 100%;">
					<h3>Welcome</h3>
					<iframe width="620" height="349" src="http://www.youtube-nocookie.com/embed/7aefs2fDa7g?wmode=transparent&amp;rel=0&amp;theme=light&amp;showinfo=0&amp;modestbranding=1&amp;hd=1&amp;autohide=1&amp;color=white" frameborder="0"  webkitAllowFullScreen="webkitAllowFullScreen" mozallowfullscreen="mozallowfullscreen" allowFullScreen="allowFullScreen"></iframe>
					<div class="clearer"></div>
					<h4 style="margin-top: 15px;">On the voyage of life when a health-related question arises, MedVoyager is the answer.  Watch the video to see the solutions MedVoyager has for you or your company.</h4>
				</div>
			</div>
		</div>
		<div class="oneColumn floatLeft">
			<div class="padding15All">
				<div style="background-color: #1d76bb; color: #ffffff; padding: 20px; height: 495px;">
					<h3>Register Today!</h3>
					<p>Medvoyager offers comprehensive and immediate access to relevant healthcare resources based on your particular needs and location. MedVoyager assists you with medical care planning by providing you the information you need, when you need it, for everyday life. MedVoyager will provide an intuitive search feature tailored to your needs, customizable consumer information storage, important medical information and offers an advanced emergency contact system so medical professionals can securely access it to provide you care without delay. At MedVoyager you’ll always have a friendly and professional place that’s open 24 hours a day, seven days a week so you can find the answers to your medical resource questions. With MedVoyager you will never feel alone when trying to plan and locate medical care. Register today!</p>
					<a class="registerButton floatRight" href="/register">Register Now</a>
					<div class="clearer"></div>
				</div>
			</div>
		</div>
		<div class="clearer"></div>
		<xsl:if test="/root/meta/user/user_id">
			<div class="threeColumn floatRight">
				<div class="padding15All">
					<div class="blueBar">
						<h5>Featured</h5>
					</div>
				</div>
				<div class="clearer"></div>
				<div class="listingContainer">
					<xsl:apply-templates select="featured_listings"/>
				</div>
			</div>
			<div class="clearer"></div>
			<div class="threeColumn">
				<div class="padding15All">
					<div class="blueBar">
						<h5>Highest Rated Local Listings</h5>
					</div>
				</div>
				<div class="clearer"></div>
				<div class="listingContainer">
					<xsl:apply-templates select="local_listings"/>
				</div>
			</div>
			<div class="clearer"></div>
		</xsl:if>
	</div>
</xsl:template>

<xsl:template match="featured_listings">
	<div class="listingContainer">
		<xsl:apply-templates select="listing"/>
	</div>
</xsl:template>

<xsl:template match="local_listings">
	<div class="listingContainer">
		<xsl:apply-templates select="listing"/>
	</div>
</xsl:template>

<xsl:template match="text()"/>

</xsl:stylesheet>