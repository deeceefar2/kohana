<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">

<xsl:output method="html" indent="yes" encoding="utf-8" omit-xml-declaration="yes" doctype-public="XSLT-compat"/>
<xsl:strip-space elements="*"/>

<xsl:include href="index.xsl"/>
<xsl:include href="snippets/recaptcha.xsl"/>
<xsl:include href="snippets/states.xsl" />

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
		<div class="threeColumn">
			<div class="padding15All">
				<div class="blueBar">
					<h5>Create Account</h5>
				</div>
			</div>
		</div>
		<div class="clearer"></div>
		<form class="registerForm" method="post">
			<xsl:attribute name="action">
				<xsl:value-of select="/root/meta/url"/>
			</xsl:attribute>
			<input name="csrf" type="hidden">
				<xsl:attribute name="value"><xsl:value-of select="/root/meta/csrf"/></xsl:attribute>
			</input>
			<div class="threeColumn">
				<div class="padding15All">
					<div class="changePassword largeSectionWhite">
						<h4>Username and Password</h4>
						<h6>Required elements are marked with *</h6>
						<xsl:if test="errors">
							<h5 class="formFailed">Submission failed, please fix the errors and try again</h5>
						</xsl:if>
						<xsl:if test="errors/_external/csrf">
							<span class="formError floatLeft">
								<xsl:value-of select="errors/_external/csrf" />
							</span>
							<div class="clearer"></div>
						</xsl:if>
						<div class="clearer"></div>
						<dl class="formSection halfPageForm floatLeft">

							<!-- Email -->
							<xsl:if test="errors/email">
								<span class="formError floatLeft">
									<xsl:value-of select="errors/email" />
								</span>
								<div class="clearer"></div>
							</xsl:if>
							<dt class="floatLeft">
								<label for="registerEmail">Email Address*</label>
							</dt>
							<dd class="halfPageTextbox floatLeft">
								<input class="registerEmail" id="registerEmail" type="text" name="email" tabindex="1" value="{/root/meta/post/email}" />
							</dd>
							<div class="clearer"></div>

							<!-- Username -->
							<xsl:if test="errors/username">
								<span class="formError floatLeft">
									<xsl:value-of select="errors/username" />
								</span>
								<div class="clearer"></div>
							</xsl:if>
							<dt class="floatLeft">
								<label for="registerUsername">Username*</label>
							</dt>
							<dd class="halfPageTextbox floatLeft">
								<input class="registerUsername" id="registerUsername" type="text" name="username" tabindex="2" value="{/root/meta/post/username}" />
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
								<label for="registerPassword">Password*</label>
							</dt>
							<dd class="halfPageTextbox floatLeft">
								<input class="registerPassword" id="registerPassword" type="password" name="password" tabindex="3" value="{/root/meta/post/password}" />
							</dd>
							<div class="clearer"></div>

							<!-- Confirm -->
							<xsl:if test="errors/_external/password_confirm">
								<span class="formError floatLeft">
									<xsl:value-of select="errors/_external/password_confirm" />
								</span>
								<div class="clearer"></div>
							</xsl:if>
							<dt class="floatLeft">
								<label for="registerPasswordConfirm">Password Confirm*</label>
							</dt>
							<dd class="halfPageTextbox floatLeft">
								<input class="registerConfirmPassword" id="registerPasswordConfirm" type="password" name="password_confirm" tabindex="4" value="{/root/meta/post/password_confirm}" />
							</dd>
							<div class="clearer"></div>
						</dl>
						<dl class="formSection halfPageForm floatLeft">

							<!-- ReCAPTCHA -->
							<xsl:apply-templates select="recaptcha">
								<xsl:with-param name="tabindex" select="6"/>
								<xsl:with-param name="theme" select="2"/>
							</xsl:apply-templates>
							<div class="clearer"></div>
						</dl>
						<div class="clearer"></div>
					</div>
					<div class="clearer"></div>
				</div>
			</div>
			<div class="clearer"></div>
			<div class="threeColumn">
				<div class="padding15All">
					<div class="address largeSectionWhite">
						<h4>Information</h4>
						<dl class="formSection halfPageForm floatLeft">
							<!-- First Name -->
							<xsl:if test="errors/user_first_name">
								<span class="formError floatLeft">
									<xsl:value-of select="errors/user_first_name" />
								</span>
								<div class="clearer"></div>
							</xsl:if>
							<dt class="floatLeft">
								<label for="registerFirstName">First Name</label>
							</dt>
							<dd class="halfPageTextbox floatLeft">
								<input class="registerFirstName" id="registerFirstName" type="text" name="user_first_name" tabindex="7" value="{/root/meta/post/user_first_name}" />
							</dd>
							<div class="clearer"></div>

							<!-- Address 1 -->
							<xsl:if test="errors/user_address_street_1">
								<span class="formError floatLeft">
									<xsl:value-of select="errors/user_address_street_1" />
								</span>
								<div class="clearer"></div>
							</xsl:if>
							<dt class="floatLeft">
								<label for="registerAddress1">Address 1</label>
							</dt>
							<dd class="halfPageTextbox floatLeft">
								<input class="registerAddress1" id="registerAddress1" type="text" name="user_address_street_1" tabindex="9" value="{/root/meta/post/user_address_street_1}" />
							</dd>
							<div class="clearer"></div>

							<!-- City -->
							<xsl:if test="errors/user_address_city">
								<span class="formError floatLeft">
									<xsl:value-of select="errors/user_address_city" />
								</span>
								<div class="clearer"></div>
							</xsl:if>
							<dt class="floatLeft">
								<label for="registerCity">City</label>
							</dt>
							<dd class="halfPageTextbox floatLeft">
								<input class="registerCity" id="registerCity" type="text" name="user_address_city" tabindex="11" value="{/root/meta/post/user_address_city}" />
							</dd>
							<div class="clearer"></div>

							<!-- Zipcode -->
							<xsl:if test="errors/user_address_zip">
								<span class="formError floatLeft">
									<xsl:value-of select="errors/user_address_zip" />
								</span>
								<div class="clearer"></div>
							</xsl:if>
							<dt class="floatLeft">
								<label for="registerZipcode">Zip Code</label>
							</dt>
							<dd class="halfPageTextbox floatLeft">
								<input class="registerZipcode" id="registerZipcode" type="text" name="user_address_zip" tabindex="13" value="{/root/meta/post/user_address_zip}" />
							</dd>
						</dl>
						<dl class="formSection halfPageForm floatLeft">

							<!-- Last Name -->
							<xsl:if test="errors/user_last_name">
								<span class="formError floatLeft">
									<xsl:value-of select="errors/user_last_name" />
								</span>
								<div class="clearer"></div>
							</xsl:if>
							<dt class="floatLeft">
								<label for="registerLastName">Last Name</label>
							</dt>
							<dd class="halfPageTextbox floatLeft">
								<input class="registerLastName" id="registerLastName" type="text" name="user_last_name" tabindex="8" value="{/root/meta/post/user_last_name}" />
							</dd>
							<div class="clearer"></div>

							<!-- Address 2 -->
							<xsl:if test="errors/user_address_street_2">
								<span class="formError floatLeft">
									<xsl:value-of select="errors/user_address_street_2" />
								</span>
								<div class="clearer"></div>
							</xsl:if>
							<dt class="floatLeft">
								<label for="registerAddress2">Address 2</label>
							</dt>
							<dd class="halfPageTextbox floatLeft">
								<input class="registerAddress2" id="registerAddress2" type="text" name="user_address_street_2" tabindex="10" value="{/root/meta/post/user_address_street_2}" />
							</dd>
							<div class="clearer"></div>

							<!-- State -->
							<xsl:if test="errors/user_address_state">
								<span class="formError floatLeft">
									<xsl:value-of select="errors/user_address_state" />
								</span>
								<div class="clearer"></div>
							</xsl:if>
							<dt class="floatLeft">
								<label for="registerState">State</label>
							</dt>
							<dd class="halfPageSelect floatLeft">
								<select id="registerState" class="registerState" name="user_address_state" tabindex="12">
									<xsl:call-template name="states">
										<xsl:with-param name="selected" select="/root/meta/post/user_address_state" />
									</xsl:call-template>
								</select>
							</dd>
							<div class="clearer"></div>

							<!-- Terms of Use -->
							<dt class="floatLeft"></dt>
							<dd class="halfPageCheckbox floatLeft">
								<a target="_blank" href="/terms" tabindex="14">Review and Accept Terms of Use</a>
							</dd>
							<div class="clearer"></div>

							<!-- Register -->
							<dt class="floatLeft"></dt>
							<dd class="formSubmit floatLeft">
								<input class="formButton floatRight" type="submit" value="I Accept, Register" tabindex="15"/>
							</dd>
							<div class="clearer"></div>
						</dl>
						<div class="clearer"></div>
					</div>
					<div class="clearer"></div>
				</div>
				<div class="clearer"></div>
			</div>
		</form>
		<div class="clearer"></div>
	</div>
</xsl:template>

<xsl:template match="text()"/>

</xsl:stylesheet>