<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">

<xsl:output method="html" indent="yes" encoding="utf-8" omit-xml-declaration="yes" doctype-public="XSLT-compat"/>
<xsl:strip-space elements="*"/>

<xsl:include href="index.xsl"/>
<xsl:include href="snippets/recaptcha.xsl"/>

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
					<h5>Contact Listing Owner</h5>
				</div>
			</div>
		</div>
		<div class="clearer"></div>
		<div class="twoColumn alignCenter">
			<div class="padding15All">
				<div class="largeSectionWhite">
					<p>Quisque pretium condimentum ligula, quis volutpat quam laoreet volutpat. Suspendisse faucibus orci sed orci mollis mattis. Morbi ullamcorper velit enim, eget tempus purus. Vivamus tincidunt ligula quis leo auctor dictum.</p>
					<xsl:if test="successful_submission">
						<xsl:choose>
							<xsl:when test="successful_submission = 1">
								<span class="formResult formSuccessful">Submission successful, thank you</span>
							</xsl:when>
							<xsl:otherwise>
								<span class="formResult formFailed">Submission failed, please fix the errors and try again</span>
							</xsl:otherwise>
						</xsl:choose>
					</xsl:if>
					<div class="clearer"></div>
					<form class="halfPageForm buyPremiumListingContactOwner" method="post">
						<xsl:attribute name="action">
							<xsl:value-of select="/root/meta/url"/>
						</xsl:attribute>
						<input name="csrf" type="hidden">
							<xsl:attribute name="value"><xsl:value-of select="/root/meta/csrf"/></xsl:attribute>
						</input>
						<dl class="formSection">

							<!-- Title -->
							<xsl:if test="errors/contact_title">
								<span class="halfPageFormError formError floatLeft">
									<xsl:value-of select="errors/contact_title" />
								</span>
								<div class="clearer"></div>
							</xsl:if>
							<dt class="floatLeft">
								<label for="contact_title">Title</label>
							</dt>
							<dd class="halfPageTextbox floatLeft">
								<input class="contactOwnerTitle title" id="contact_title" type="text" name="contact_title" value="{/root/meta/post/contact_title}" tabindex="1" />
							</dd>
							<div class="clearer"></div>

							<!-- Comments -->
							<xsl:if test="errors/contact_question">
								<span class="halfPageFormError formError floatLeft">
									<xsl:value-of select="errors/contact_question" />
								</span>
								<div class="clearer"></div>
							</xsl:if>
							<dt class="floatLeft">
								<label for="contact_question">Question</label>
							</dt>
							<dd class="halfPageTextarea floatLeft">
								<textarea id="contact_question" name="contact_question" tabindex="1">
									<xsl:value-of select="/root/meta/post/contact_question" />
								</textarea>
							</dd>
							<div class="clearer"></div>

							<!-- ReCAPTCHA -->
							<xsl:apply-templates select="recaptcha">
								<xsl:with-param name="tabindex" select="1"/>
								<xsl:with-param name="theme" select="2"/>
							</xsl:apply-templates>
							<div class="clearer"></div>

							<!-- Send -->
							<dt class="floatLeft"></dt>
							<dd class="formSubmit floatLeft">
								<input class="formButton floatRight" type="submit" value="Send" tabindex="1" />
							</dd>
							<div class="clearer"></div>
						</dl>
					</form>
				</div>
			</div>
		</div>
		<div class="clearer"></div>
	</div>
</xsl:template>

<xsl:template match="text()"/>

</xsl:stylesheet>