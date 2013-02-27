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
					<h5>Create Listing</h5>
				</div>
			</div>
		</div>
		<div class="clearer"></div>
		<form class="registerForm" method="post" action="/account">
			<input name="csrf" type="hidden">
				<xsl:attribute name="value"><xsl:value-of select="/root/meta/csrf"/></xsl:attribute>
			</input>
			<div class="threeColumn">
				<div class="padding15All">
					<div class="address largeSectionWhite">
						<h4 class="sectionTitle">Information</h4>
						<dl class="formSection">
							<!-- Address 1 -->
							<xsl:if test="errors/create_listing_address_1">
								<span class="formError floatLeft">
									<xsl:value-of select="errors/create_listing_address_1" />
								</span>
								<div class="clearer"></div>
							</xsl:if>
							<dt class="floatLeft">
								<label for="createListingAddress1">Address 1</label>
							</dt>
							<dd class="halfPageTextbox floatLeft">
								<input class="createListingAddress1" id="createListingAddress1" type="text" name="createListingAddress1" value="">
									<xsl:if test="errors != ''">
										<xsl:attribute name="value">
											<xsl:value-of select="validation/create_listing_address_1" />
										</xsl:attribute>
									</xsl:if>
								</input>
							</dd>
							<div class="clearer"></div>

							<!-- City -->
							<xsl:if test="errors/create_listing_city">
								<span class="formError floatLeft">
									<xsl:value-of select="errors/create_listing_city" />
								</span>
								<div class="clearer"></div>
							</xsl:if>
							<dt class="floatLeft">
								<label for="createListingCity">City</label>
							</dt>
							<dd class="halfPageTextbox floatLeft">
								<input class="createListingCity" id="createListingCity" type="text" name="createListingCity" value="">
									<xsl:if test="errors != ''">
										<xsl:attribute name="value">
											<xsl:value-of select="validation/create_listing_city" />
										</xsl:attribute>
									</xsl:if>
								</input>
							</dd>
							<div class="clearer"></div>

							<!-- Address 2 -->
							<xsl:if test="errors/create_listing_address_2">
								<span class="formError floatLeft">
									<xsl:value-of select="errors/create_listing_address_2" />
								</span>
								<div class="clearer"></div>
							</xsl:if>
							<dt class="floatLeft">
								<label for="createListingAddress2">Address 2</label>
							</dt>
							<dd class="halfPageTextbox floatLeft">
								<input class="createListingAddress2" id="createListingAddress2" type="text" name="createListingAddress2" value="">
									<xsl:if test="errors != ''">
										<xsl:attribute name="value">
											<xsl:value-of select="validation/create_listing_address_2" />
										</xsl:attribute>
									</xsl:if>
								</input>
							</dd>
							<div class="clearer"></div>

							<!-- State -->
							<xsl:if test="errors/create_listing_state">
								<span class="formError floatLeft">
									<xsl:value-of select="errors/create_listing_state" />
								</span>
								<div class="clearer"></div>
							</xsl:if>
							<dt class="floatLeft">
								<label for="createListingState">State</label>
							</dt>
							<dd class="halfPageSelect floatLeft">
								<select id="createListingState" class="createListingState" name="createListingState">
									<option value="default"></option>
									<option value="AL">Alabama</option>
									<option value="AK">Alaska</option>
									<option value="AZ">Arizona</option>
									<option value="AR">Arkansas</option>
									<option value="CA">California</option>
									<option value="CO">Colorado</option>
									<option value="CT">Connecticut</option>
									<option value="DE">Delaware</option>
									<option value="DC">District Of Columbia</option>
									<option value="FL">Florida</option>
									<option value="GA">Georgia</option>
									<option value="HI">Hawaii</option>
									<option value="ID">Idaho</option>
									<option value="IL">Illinois</option>
									<option value="IN">Indiana</option>
									<option value="IA">Iowa</option>
									<option value="KS">Kansas</option>
									<option value="KY">Kentucky</option>
									<option value="LA">Louisiana</option>
									<option value="ME">Maine</option>
									<option value="MD">Maryland</option>
									<option value="MA">Massachusetts</option>
									<option value="MI">Michigan</option>
									<option value="MN">Minnesota</option>
									<option value="MS">Mississippi</option>
									<option value="MO">Missouri</option>
									<option value="MT">Montana</option>
									<option value="NE">Nebraska</option>
									<option value="NV">Nevada</option>
									<option value="NH">New Hampshire</option>
									<option value="NJ">New Jersey</option>
									<option value="NM">New Mexico</option>
									<option value="NY">New York</option>
									<option value="NC">North Carolina</option>
									<option value="ND">North Dakota</option>
									<option value="OH">Ohio</option>
									<option value="OK">Oklahoma</option>
									<option value="OR">Oregon</option>
									<option value="PA">Pennsylvania</option>
									<option value="RI">Rhode Island</option>
									<option value="SC">South Carolina</option>
									<option value="SD">South Dakota</option>
									<option value="TN">Tennessee</option>
									<option value="TX">Texas</option>
									<option value="UT">Utah</option>
									<option value="VT">Vermont</option>
									<option value="VA">Virginia</option>
									<option value="WA">Washington</option>
									<option value="WV">West Virginia</option>
									<option value="WI">Wisconsin</option>
									<option value="WY">Wyoming</option>
								</select>
							</dd>
							<div class="clearer"></div>

							<!-- ReCAPTCHA -->
							<xsl:if test="errors/recaptcha">
								<span class="formError floatRight">
									<xsl:value-of select="errors/recaptcha" />
								</span>
								<div class="clearer"></div>
							</xsl:if>
							<dd class="floatRight">
								<span class="formCaptcha floatRight">
									<xsl:apply-templates select="recaptcha"/>
								</span>
							</dd>
							<div class="clearer"></div>

							<!-- Create -->
							<dt class="floatLeft"></dt>
							<dd class="formSubmit floatLeft">
								<input class="formButton floatRight" type="submit" value="Search" />
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