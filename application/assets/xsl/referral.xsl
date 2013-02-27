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
		<div class="twoColumn floatLeft">
			<div class="padding15All">
				<div style="background-color: #ffffff; padding: 20px; height: 495px; width: 100%;">
					<h3>Welcome</h3>
					<iframe width="620" height="349" src="http://www.youtube-nocookie.com/embed/UUk47HhoOeA?wmode=transparent&amp;rel=0&amp;theme=light&amp;showinfo=0&amp;modestbranding=1&amp;hd=1&amp;autohide=1&amp;color=white" frameborder="0"  webkitAllowFullScreen="webkitAllowFullScreen" mozallowfullscreen="mozallowfullscreen" allowFullScreen="allowFullScreen"></iframe>
					<div class="clearer"></div>
					<h4 style="margin-top: 15px;">On the voyage of life when a health-related question arises, MedVoyager is the answer. Watch the video to see the opportunities MedVoyager has for you or your business.</h4>
				</div>
			</div>
		</div>
		<div class="oneColumn floatLeft">
			<div class="padding15All">
				<div style="background-color: #1d76bb; color: #ffffff; padding: 20px; height: 495px;">
					<h3>Register Today!</h3>
					<p>Medvoyager offers comprehensive and immediate access to relevant healthcare resources based on your particular needs and location. We have an opportunity for you to make more money.  We offer a referral program for any motivated individual to educate businesses about MedVoyager and our serivices.  We offer compensation for any business that you successfully refer to our premium listing services, and we offer many tools along the road to help you out.  Not only is this a great opportunity, but you'll be helping your community at the same time.  The button below will take you to the registration page, where your journey begins.  Immediately after registerign you can begin listing businesses and helping improve MedVoyager's wonderful health services tool for you community. Register today!</p>
					<a class="registerButton floatRight" href="/register">Register Now</a>
					<div class="clearer"></div>
				</div>
			</div>
		</div>
		<div class="clearer"></div>
		<div class="threeColumn">
			<div class="padding15All">
				<div class="largeSectionWhite">
					<form method="post">
						<xsl:attribute name="action">
							<xsl:value-of select="/root/meta/url"/>
						</xsl:attribute>
						<input name="csrf" type="hidden">
							<xsl:attribute name="value"><xsl:value-of select="/root/meta/csrf"/></xsl:attribute>
						</input>
						<dl class="formSection alignCenter">
							<!-- Email -->
							<xsl:if test="errors/newsletter_email">
								<span class="formError floatLeft">
									<xsl:value-of select="errors/newsletter_email" />
								</span>
								<div class="clearer"></div>
							</xsl:if>
							<dt class="floatLeft" style="width: 300px;">
								<label for="newsletterEmail">Sign Up For Our Newsletter</label>
							</dt>
							<dd class="halfPageTextbox floatLeft">
								<input class="newsletterEmail" id="newsletterEmail" type="text" name="newsletterEmail" placeholder="Email">
									<xsl:if test="errors != ''">
										<xsl:attribute name="value">
											<xsl:value-of select="validation/newsletter_email" />
										</xsl:attribute>
									</xsl:if>
								</input>
							</dd>
							<dd class="formSubmit floatRight">
								<input class="formButton" type="submit" value="Sign Up" />
							</dd>
						</dl>
					</form>
					<div class="clearer"></div>
				</div>
			</div>
		</div>
		<div class="clearer"></div>
	</div>
</xsl:template>

<xsl:template match="text()"/>

</xsl:stylesheet>