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
					<h5>Log In</h5>
				</div>
			</div>
		</div>
		<div class="clearer"></div>
		<div class="twoColumn alignCenter">
			<div class="padding15All">
				<div class="largeSectionWhite">
					<h3>Forgot Password</h3>
					<div class="form halfPageForm">
						<xsl:if test="errors != ''">
							<span class="formResult formFailed">Submission failed, please fix the errors and try again</span>
						</xsl:if>
						<div class="clearer"></div>
						<form class="contactUsForm" method="post">
							<xsl:attribute name="action">
								<xsl:value-of select="/root/meta/url"/>
							</xsl:attribute>
							<input name="csrf" type="hidden">
								<xsl:attribute name="value"><xsl:value-of select="/root/meta/csrf"/></xsl:attribute>
							</input>
							<dl class="formSection">

								<!-- Username -->
								<xsl:if test="errors/login_or_email">
									<span class="formError floatLeft">
										<xsl:value-of select="errors/login_or_email" />
									</span>
									<div class="clearer"></div>
								</xsl:if>
								<dt class="floatLeft">
									<label for="login_or_email">Username - or - Email</label>
								</dt>
								<dd class="halfPageTextbox floatLeft">
									<input class="loginForgotUsername" id="login_or_email" type="text" name="login_or_email" value="{/root/meta/post/login_or_email}" tabindex="1"/>
								</dd>
								<div class="clearer"></div>

								<!-- ReCAPTCHA -->
								<xsl:apply-templates select="recaptcha">
									<xsl:with-param name="tabindex" select="1"/>
									<xsl:with-param name="theme" select="2"/>
								</xsl:apply-templates>
								<div class="clearer"></div>

								<!-- Retrieve -->
								<dt class="floatLeft"></dt>
								<dd class="formSubmit floatLeft">
									<input class="formButton floatRight" type="submit" value="Retrieve" tabindex="1"/>
								</dd>
								<div class="clearer"></div>
							</dl>
						</form>
					</div>
				</div>
			</div>
		</div>
		<div class="clearer"></div>
	</div>
</xsl:template>

<xsl:template match="text()"/>

</xsl:stylesheet>