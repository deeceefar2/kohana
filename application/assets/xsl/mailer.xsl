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
					<h5>Request Flyers</h5>
				</div>
			</div>
		</div>
		<div class="clearer"></div>
		<div class="threeColumn">
			<div class="padding15All">
				<div class="changePassword largeSectionWhite">
					<div class="halfPageForm floatLeft">
						<img src="/assets/images/theme/content/medvoyager_flyer_03_salesrep1.jpg" width="440"/>
						<br/>
						<img src="/assets/images/theme/content/medvoyager_flyer_03_salesrep2.jpg" width="440"/>
					</div>
					<div class="halfPageForm floatLeft">
						<form class="registerForm" method="post">
							<xsl:attribute name="action">
								<xsl:value-of select="/root/meta/url"/>
							</xsl:attribute>
							<input name="csrf" type="hidden">
								<xsl:attribute name="value"><xsl:value-of select="/root/meta/csrf"/></xsl:attribute>
							</input>
							<h4 class="sectionTitle">Shipping Address</h4>
							<xsl:if test="errors">
								<span class="formResult formFailed">Submission failed, please fix the errors and try again</span>
							</xsl:if>
							<xsl:if test="errors/_external/csrf">
								<span class="formError floatLeft">
									<xsl:value-of select="errors/_external/csrf" />
								</span>
								<div class="clearer"></div>
							</xsl:if>
							<div class="clearer"></div>
							<dl class="formSection">

								<!-- Same as Profile -->
								<dt class="floatLeft">
									<label for="registerFirstName">Same as Profile</label>
								</dt>
								<dd class="halfPageCheckbox floatLeft">
									<input id="registerNewsletter" type="checkbox" name="registerNewsletter" value="Car" tabindex="11" />
								</dd>
								<div class="clearer"></div>

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
									<input class="registerFirstName" id="registerFirstName" type="text" name="user_first_name" tabindex="5" value="{/root/meta/post/user_first_name}" />
								</dd>
								<div class="clearer"></div>

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
									<input class="registerLastName" id="registerLastName" type="text" name="user_last_name" tabindex="6" value="{/root/meta/post/user_last_name}" />
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
									<input class="registerAddress1" id="registerAddress1" type="text" name="user_address_street_1" tabindex="7" value="{/root/meta/post/user_address_street_1}" />
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
									<input class="registerAddress2" id="registerAddress2" type="text" name="user_address_street_2" tabindex="8" value="{/root/meta/post/user_address_street_2}" />
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
									<input class="registerCity" id="registerCity" type="text" name="user_address_city" tabindex="9" value="{/root/meta/post/user_address_city}" />
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
									<select id="registerState" class="registerState" name="user_address_state" tabindex="10">
										<xsl:call-template name="states"/>
									</select>
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
									<input class="registerZipcode" id="registerZipcode" type="text" name="user_address_zip" tabindex="11" value="{/root/meta/post/user_address_zip}" />
								</dd>
								<div class="clearer"></div>

								<!-- Register Button -->
								<dt class="floatLeft"></dt>
								<dd class="formSubmit floatLeft">
									<input class="formButton floatRight" type="submit" value="I Accept, Register" tabindex="12"/>
								</dd>
								<div class="clearer"></div>
							</dl>
						</form>
					</div>
					<div class="clearer"></div>
				</div>
				<div class="clearer"></div>
			</div>
			<div class="clearer"></div>
		</div>
		<div class="clearer"></div>
	</div>
</xsl:template>

<xsl:template match="text()"/>

</xsl:stylesheet>