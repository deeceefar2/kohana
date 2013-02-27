<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">

<xsl:output method="html" indent="yes" encoding="utf-8" omit-xml-declaration="yes" doctype-public="XSLT-compat"/>
<xsl:strip-space elements="*"/>

<xsl:include href="index.xsl"/>
<xsl:include href="snippets/subnav_help.xsl"/>

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
		<xsl:call-template name="subnav_help" />
		<div class="clearer"></div>
		<div class="threeColumn">
			<div class="padding15All">
				<div class="largeSectionWhite">
					<h3>Advertise With Us</h3>
					<div class="imgFloatLeft"><img src="/assets/images/theme/content/fake_ad.png" /></div>
					<p>In the United States there are 35.6 million people who have a physical disability, 34.5 million hearing impaired 19.4 million who have vision difficulty, 22.1 million people who are age 65+ who have a physical limitation, 56.4% of veterans have a nonservice disability, and 42.6% of veterans have a service connected disability.</p>
					<p>Across the U.S. there are 34.4 million inpatient hospital discharges, 109.9 million outpatient visits, 123.8 million emergency department visits. 1.5 million people utilize home health care companies and there are 1.5 million nursing home residents (CDC 2009). You may be asking yourself, what do all these numbers mean to this business?</p>
					<p>These millions of people who are living with a disability, newly released from the hospital with a health problem, or anyone who is a caregiver, older individual, case manager, discharge planner, or a parent of a sick child all at some point in their lives wonder where to go, or look, to find a life saving or life enhancing service.</p>
					<p>MedVoyager is the first product in the world to offer comprehensive and immediate access to healthcare resources of this nature. Your company could be listed as a resource for these millions of people who are in need of your services. In return of signing up to advertise your company with us could help increase your profits and consumers. Your company would gain national and international exposure to millions of people looking for your services right now and our advertisement options are free and paid premium listing.</p>
					<p>We’d invite you to advertise with us and join in our cause to improve the quality of life for these individuals who deserve peace of mind and are in need of your services. </p>
					<div class="clearer"></div>
					<div class="advertiseContactUs oneColumn">
						<a href="/contact"><h4>Contact Us</h4></a>
						<p>
							Life Care Planning Solutions, LLC<br/>
							P.O. Box 1102<br/>
							Jenks, OK 74037-1102<br/>
							(555) 555-5555
						</p>
					</div>
				</div>
			</div>
		</div>
		<div class="clearer"></div>
		<xsl:apply-templates />
	</div>
</xsl:template>

<xsl:template match="text()"/>

</xsl:stylesheet>