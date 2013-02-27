<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">

<xsl:output method="html" indent="yes" encoding="utf-8" omit-xml-declaration="yes" doctype-public="XSLT-compat"/>
<xsl:strip-space elements="*"/>

<xsl:include href="index.xsl"/>
<xsl:include href="snippets/recaptcha.xsl"/>

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
	<xsl:if test="/root/meta/redirect">
		<script type="text/javascript">
		<xsl:comment>
			$(document).ready(function() {
				window.location = '<xsl:value-of select="/root/meta/redirect"/>';
			});
		//</xsl:comment>
		</script>
	</xsl:if>
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
					<h5 class="floatRight"><a href="/register">register</a></h5>
					<h3>Log In</h3>
					<xsl:if test="errors">
						<span class="formResult formFailed">
							<xsl:text>Submission failed, please fix the errors and try again</xsl:text>
						</span>
					</xsl:if>
					<div class="form halfPageForm">
						<form class="contactUsForm" method="post">
							<xsl:attribute name="action">
								<xsl:value-of select="/root/meta/url"/>
							</xsl:attribute>
							<xsl:if test="errors/csrf">
								<span class="formError floatLeft">
									<xsl:value-of select="errors/csrf" />
								</span>
								<div class="clearer"></div>
							</xsl:if>
							<input name="csrf" type="hidden" value="{/root/meta/csrf}" />
							<dl class="formSection halfPage">

								<!-- Username -->
								<xsl:if test="errors/username">
									<span class="formError floatLeft">
										<xsl:value-of select="errors/username" />
									</span>
									<div class="clearer"></div>
								</xsl:if>
								<dt class="floatLeft">
									<label for="username">Username</label>
								</dt>
								<dd class="halfPageTextbox floatLeft">
									<input class="username" id="username" type="text" name="username" value="{/root/meta/post/username}" tabindex="1" />
								</dd>
								<div class="clearer"></div>

								<!-- Password -->
								<xsl:if test="errors/password">
									<span class="formError floatLeft">
										<xsl:value-of select="errors/password" />
									</span>
									<div class="clearer"></div>
								</xsl:if>
								<dt class="floatLeft">
									<label for="password">Password</label>
								</dt>
								<dd class="halfPageTextbox floatLeft">
									<input class="password" id="password" type="password" name="password" tabindex="1" />
								</dd>
								<div class="clearer"></div>

								<!-- ReCAPTCHA -->
								<xsl:if test="recaptcha">
									<input name="recaptcha" type="hidden">
										<xsl:attribute name="value">1</xsl:attribute>
									</input>
									<xsl:apply-templates select="recaptcha">
										<xsl:with-param name="tabindex" select="1"/>
										<xsl:with-param name="theme" select="2"/>
									</xsl:apply-templates>
									<div class="clearer"></div>
								</xsl:if>


								<!-- Stay Signed In -->
								<xsl:if test="errors/remember_me">
									<span class="formError floatLeft">
										<xsl:value-of select="errors/remember_me" />
									</span>
									<div class="clearer"></div>
								</xsl:if>
								<dt class="floatLeft"></dt>
								<dd class="halfPageCheckbox floatLeft">
									<xsl:if test="/root/meta/ajax != 1">
										<input id="remember_me" class="remember_me" type="checkbox" name="remember_me" value="1" tabindex="1">
											<xsl:if test="/root/meta/post/remember_me=1">
												<xsl:attribute name="checked">
													<xsl:text>checked</xsl:text>
												</xsl:attribute>
											</xsl:if>
										</input>
										<label for="remember_me">Remember Me | </label>
									</xsl:if>
									<a class="loginForgotPassword" href="/login/forgot">Forgot password?</a>
								</dd>
								<div class="clearer"></div>

								<dt class="floatLeft"></dt>
								<dd class="formSubmit floatLeft">
									<input class="formButton floatLeft" type="submit" value="Sign In" tabindex="1"/>
									<a class="formButton floatRight" href="/register">Register</a>
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